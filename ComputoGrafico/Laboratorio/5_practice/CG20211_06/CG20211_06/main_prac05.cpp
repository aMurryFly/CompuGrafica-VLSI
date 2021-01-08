/*---------------------------------------------------------*/
/* ----------------   Práctica 5 --------------------------*/
/*-----------------    2021-1   ---------------------------*/
/*------------- Alumno:	Alfonso Murrieta Villegas					---------------*/
#include <glew.h>
#include <glfw3.h>

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

#include <shader_m.h>

#include <iostream>

void resize(GLFWwindow* window, int width, int height);
void my_input(GLFWwindow *window);

// settings
// Window size
int SCR_WIDTH = 3800;
int SCR_HEIGHT = 7600;

GLFWmonitor *monitors;
GLuint VBO, VAO, EBO;

void myData(void);
void display(Shader);
void getResolution(void);

//For Keyboard
float	movX = 0.0f,
		movY = 0.0f,
		movZ = -5.0f;

//Rotación
float rotX = 0;

//Partes del cuerpo
float hombro = 0.0f,
codo = 0.0f,
dedo_part1 = 0.0f,
dedo_part2 = 0.0f;

void getResolution()
{
	const GLFWvidmode * mode = glfwGetVideoMode(glfwGetPrimaryMonitor());

	SCR_WIDTH = mode->width;
	SCR_HEIGHT = (mode->height) - 80;
}

void myData()
{	
		GLfloat vertices[] = {
		//Position				//Color
		-0.5f, -0.5f, 0.5f,		1.0f, 0.0f, 0.0f,	//V0 - Frontal
		0.5f, -0.5f, 0.5f,		1.0f, 0.0f, 0.0f,	//V1
		0.5f, 0.5f, 0.5f,		1.0f, 0.0f, 0.0f,	//V5
		-0.5f, 0.5f, 0.5f,		1.0f, 0.0f, 0.0f,	//V4

		0.5f, -0.5f, -0.5f,		1.0f, 1.0f, 0.0f,	//V2 - Trasera
		-0.5f, -0.5f, -0.5f,	1.0f, 1.0f, 0.0f,	//V3
		-0.5f, 0.5f, -0.5f,		1.0f, 1.0f, 0.0f,	//V7
		0.5f, 0.5f, -0.5f,		1.0f, 1.0f, 0.0f,	//V6

		-0.5f, 0.5f, 0.5f,		0.0f, 0.0f, 1.0f,	//V4 - Izq
		-0.5f, 0.5f, -0.5f,		0.0f, 0.0f, 1.0f,	//V7
		-0.5f, -0.5f, -0.5f,	0.0f, 0.0f, 1.0f,	//V3
		-0.5f, -0.5f, 0.5f,		0.0f, 0.0f, 1.0f,	//V0

		0.5f, 0.5f, 0.5f,		0.0f, 1.0f, 0.0f,	//V5 - Der
		0.5f, -0.5f, 0.5f,		0.0f, 1.0f, 0.0f,	//V1
		0.5f, -0.5f, -0.5f,		0.0f, 1.0f, 0.0f,	//V2
		0.5f, 0.5f, -0.5f,		0.0f, 1.0f, 0.0f,	//V6

		-0.5f, 0.5f, 0.5f,		1.0f, 0.0f, 1.0f,	//V4 - Sup
		0.5f, 0.5f, 0.5f,		1.0f, 0.0f, 1.0f,	//V5
		0.5f, 0.5f, -0.5f,		1.0f, 0.0f, 1.0f,	//V6
		-0.5f, 0.5f, -0.5f,		1.0f, 0.0f, 1.0f,	//V7

		-0.5f, -0.5f, 0.5f,		1.0f, 1.0f, 1.0f,	//V0 - Inf
		-0.5f, -0.5f, -0.5f,	1.0f, 1.0f, 1.0f,	//V3
		0.5f, -0.5f, -0.5f,		1.0f, 1.0f, 1.0f,	//V2
		0.5f, -0.5f, 0.5f,		1.0f, 1.0f, 1.0f,	//V1
	};

	unsigned int indices[] =	//I am not using index for this session
	{
		0
	};

	glGenVertexArrays(1, &VAO);
	glBindVertexArray(VAO);

	glGenBuffers(1, &VBO);

	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

	// position attribute
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)0);
	glEnableVertexAttribArray(0);
	// color attribute
	//glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)(3 * sizeof(float)));
	//glEnableVertexAttribArray(1);

	//Para trabajar con indices (Element Buffer Object)
	glGenBuffers(1, &EBO);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

	glBindBuffer(GL_ARRAY_BUFFER, 0);

	glBindVertexArray(0);

}

void display(Shader shader)
{
	//Shader myShader("shaders/shader.vs", "shaders/shader.fs");
	

	shader.use();

	//Para la traslación y rotación de objetos 
	glm::mat4 temp01 = glm::mat4(1.0f);
	glm::mat4 temp02 = glm::mat4(1.0f);

	// create transformations and Projection
	glm::mat4 model = glm::mat4(1.0f);		// initialize Matrix, Use this matrix for individual models
	glm::mat4 view = glm::mat4(1.0f);		//Use this matrix for ALL models
	glm::mat4 projection = glm::mat4(1.0f);	//This matrix is for Projection

	projection = glm::perspective(glm::radians(45.0f), (float)SCR_WIDTH / (float)SCR_HEIGHT, 0.1f, 100.0f);
	//projection = glm::ortho(-5.0f, 5.0f, -3.0f, 3.0f, 0.1f, 10.0f);

	//Use "view" in order to affect all models
	view = glm::translate(view, glm::vec3(movX, movY, movZ));
	view = glm::rotate(view, glm::radians(rotX),glm::vec3(1.0f,0.0f,0.0f));
	// pass them to the shaders
	shader.setMat4("model", model);
	shader.setMat4("view", view);
	// note: currently we set the projection matrix each frame, but since the projection matrix rarely changes it's often best practice to set it outside the main loop only once.
	shader.setMat4("projection", projection);
	glBindVertexArray(VAO);




	// Dibujando el Hombro o articulacion A
	model = glm::translate(model, glm::vec3(-1.0f, 0.0f, 0.0f));    

	model = glm::rotate(model, glm::radians(hombro), glm::vec3(0.0f, 0.0f, 1.0f));

	//LINEA MORTAL <- será el punto de referencia o articulación
	temp01 = model = glm::translate(model, glm::vec3(1.0f, 0.0f, 0.0f));
	model = glm::scale(model, glm::vec3(2.5f, 1.0f, 1.0f));

	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 0.0f));
	glDrawArrays(GL_QUADS, 0, 24); 

	// brazo y articulación B 
	model = glm::translate(temp01, glm::vec3(1.25f, 0.0f, 0.0f));     
	model = glm::rotate(model, glm::radians(codo), glm::vec3(0.0f, 1.0f, 0.0f));
	temp01 = model = glm::translate(model, glm::vec3(1.25f, 0.0f, 0.0f));     
	model = glm::scale(model, glm::vec3(2.5f, 1.0f, 1.0f));

	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 1.0f));
	glDrawArrays(GL_QUADS, 0, 24); 
	
	//DEDO 1 | Plano X,Y

	model = glm::translate(temp01, glm::vec3(1.25f, -0.35f, 0.375f));     
	model = glm::rotate(model, glm::radians(dedo_part1), glm::vec3(0.0f, 0.0f, 1.0f));
	temp02 = model = glm::translate(model, glm::vec3(0.25f, 0.0f, 0.0f));     
	model = glm::scale(model, glm::vec3(0.5f, 0.3f, 0.25f));//C

	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(0.7f, 0.5f, 1.0f));
	glDrawArrays(GL_QUADS, 0, 24);//E

	
	model = glm::translate(temp02, glm::vec3(0.25f, 0.0f, 0.0f));     
	model = glm::rotate(model, glm::radians(dedo_part2), glm::vec3(0.0f, 0.0f, 1.0f));
	model = glm::translate(model, glm::vec3(0.25f, 0.0f, 0.0f));     
	model = glm::scale(model, glm::vec3(0.5f, 0.3f, 0.25f));

	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(0.7f, 0.1f, 0.0f));
	glDrawArrays(GL_QUADS, 0, 24); //F

	//DEDO 2, ARRIBA  2

	model = glm::translate(temp01, glm::vec3(1.25f, 0.35f, 0.35f));
	model = glm::rotate(model, glm::radians(dedo_part1), glm::vec3(0.0f, 1.0f, 0.0f));
	temp02 = model = glm::translate(model, glm::vec3(0.25f, 0.0f, 0.0f));
	model = glm::scale(model, glm::vec3(0.5f, 0.3f, 0.25f));

	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(0.7f, 0.5f, 1.0f));
	glDrawArrays(GL_QUADS, 0, 24);//E


	model = glm::translate(temp02, glm::vec3(0.25f, 0.0f, 0.0f));
	model = glm::rotate(model, glm::radians(dedo_part2), glm::vec3(0.0f, 1.0f, 0.0f));
	model = glm::translate(model, glm::vec3(0.25f, 0.0f, 0.0f));
	model = glm::scale(model, glm::vec3(0.5f, 0.3f, 0.25f));

	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(0.7f, 0.1f, 0.0f));
	glDrawArrays(GL_QUADS, 0, 24); //F


	//DEDO intermedio 
	model = glm::translate(temp01, glm::vec3(1.25f, -0.35f, 0.0f));    
	model = glm::rotate(model, glm::radians(dedo_part1), glm::vec3(0.0f, 0.0f, 1.0f));
	temp02 = model = glm::translate(model, glm::vec3(0.375f, 0.0f, 0.0f));    
	model = glm::scale(model, glm::vec3(0.75f, 0.3f, 0.25f));

	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(0.7f, 0.5f, 1.0f));
	glDrawArrays(GL_QUADS, 0, 24); //G


	model = glm::translate(temp02, glm::vec3(0.375f, 0.0f, 0.0f));     
	model = glm::rotate(model, glm::radians(dedo_part2), glm::vec3(0.0f, 0.0f, 1.0f));
	temp02 = model = glm::translate(model, glm::vec3(0.5f, 0.0f, 0.0f));     
	model = glm::scale(model, glm::vec3(1.0f, 0.3f, 0.25f));

	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(0.7f, 0.1f, 0.0f));
	glDrawArrays(GL_QUADS, 0, 24); //H




	//DEDO 4 | Plano z / x

	model = glm::translate(temp01, glm::vec3(1.25f, -0.35f, -0.375f));    
	model = glm::rotate(model, glm::radians(dedo_part1), glm::vec3(0.0f, 0.0f, 1.0f));
	temp02 = model = glm::translate(model, glm::vec3(0.375f, 0.0f, 0.0f));     
	model = glm::scale(model, glm::vec3(0.75f, 0.3f, 0.25f));

	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(0.7f, 0.5f, 1.0f));
	glDrawArrays(GL_QUADS, 0, 24); //I

	
	model = glm::translate(temp02, glm::vec3(0.375f, 0.0f, 0.0f));     
	model = glm::rotate(model, glm::radians(dedo_part2), glm::vec3(0.0f, 0.0f, 1.0f));
	temp02 = model = glm::translate(model, glm::vec3(0.375f, 0.0f, 0.0f));     
	model = glm::scale(model, glm::vec3(0.75f, 0.3f, 0.25f));

	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(0.7f, 0.1f, 0.0f));
	glDrawArrays(GL_QUADS, 0, 24); //J

	///FIN ARTICULACIONES
	glBindVertexArray(0);
}

int main()
{
    // glfw: initialize and configure
    // ------------------------------
    glfwInit();
    /*glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);*/

#ifdef __APPLE__
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE); // uncomment this statement to fix compilation on OS X
#endif

    // glfw window creation
    // --------------------
	monitors = glfwGetPrimaryMonitor();
	getResolution();

    GLFWwindow* window = glfwCreateWindow(SCR_WIDTH, SCR_HEIGHT, "Practica 5 20211", NULL, NULL);
    if (window == NULL)
    {
        std::cout << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
        return -1;
    }
	glfwSetWindowPos(window, 0, 30);
    glfwMakeContextCurrent(window);
    glfwSetFramebufferSizeCallback(window, resize);

	glewInit();


	//Mis funciones
	//Datos a utilizar
	myData();
	glEnable(GL_DEPTH_TEST);

	Shader projectionShader("shaders/shader_projection.vs", "shaders/shader_projection.fs");

    // render loop
    // While the windows is not closed
    while (!glfwWindowShouldClose(window))
    {
        // input
        // -----
        my_input(window);

        // render
        // Backgound color
        glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

		//Mi función de dibujo
		display(projectionShader);

        // glfw: swap buffers and poll IO events (keys pressed/released, mouse moved etc.)
        // -------------------------------------------------------------------------------
        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    // glfw: terminate, clearing all previously allocated GLFW resources.
    // ------------------------------------------------------------------
    glfwTerminate();
    return 0;
}

// process all input: query GLFW whether relevant keys are pressed/released this frame and react accordingly
// ---------------------------------------------------------------------------------------------------------
void my_input(GLFWwindow *window)
{
    if(glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)  //GLFW_RELEASE
        glfwSetWindowShouldClose(window, true);
	if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS)
		movX += 0.08f;
	if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS)
		movX -= 0.08f;
	if (glfwGetKey(window, GLFW_KEY_PAGE_UP) == GLFW_PRESS)
		movY += 0.08f;
	if (glfwGetKey(window, GLFW_KEY_PAGE_DOWN) == GLFW_PRESS)
		movY -= 0.08f;
	if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS)
		movZ -= 0.08f;
	if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS)
		movZ += 0.08f;

	//Rotación
	if (glfwGetKey(window, GLFW_KEY_UP) == GLFW_PRESS) {
		rotX -= 0.15f;
	}
		
	if (glfwGetKey(window, GLFW_KEY_DOWN) == GLFW_PRESS){
		rotX += 0.15f;
	}
		

	//MOVIMIENTOS BRAZO y grados de libertad

	//HOMBROS
	if (glfwGetKey(window, GLFW_KEY_F) == GLFW_PRESS) {
		if (hombro <= 90.0f) {
			hombro += 0.5f;
		}
			
	}

	if (glfwGetKey(window, GLFW_KEY_R) == GLFW_PRESS) {
		if (hombro >= -110.0f) {
			hombro -= 0.5f;
		}
			
	}


	//CODOS
	if (glfwGetKey(window, GLFW_KEY_G) == GLFW_PRESS) {
		if (codo <= 45.0f) {
			codo += 0.5f;
		}
	}
		

	if (glfwGetKey(window, GLFW_KEY_T) == GLFW_PRESS) {
		if (codo >= -0.05f) {
			codo -= 0.5f;
		}
	}
		
	//DEDO  parte 1
	if (glfwGetKey(window, GLFW_KEY_H) == GLFW_PRESS) {
		if (dedo_part1 <= 50.5f) {
			dedo_part1 += 0.5f;
		}
	}

	if (glfwGetKey(window, GLFW_KEY_Y) == GLFW_PRESS) {
		if (dedo_part1 >= -60.0f) {
			dedo_part1 -= 0.5f;
		}
	}
	
	//DEDO  parte 2
	if (glfwGetKey(window, GLFW_KEY_J) == GLFW_PRESS) {
		if (dedo_part2 <= 45.5f) {
			dedo_part2 += 0.5f;
		}
	}

	if (glfwGetKey(window, GLFW_KEY_U) == GLFW_PRESS) {	
		if (dedo_part2 >= -0.05f) {
			dedo_part2 -= 0.5f;
		}
	}
	
	
		

}

// glfw: whenever the window size changed (by OS or user resize) this callback function executes
// ---------------------------------------------------------------------------------------------
void resize(GLFWwindow* window, int width, int height)
{
    // Set the Viewport to the size of the created window
    glViewport(0, 0, width, height);
}