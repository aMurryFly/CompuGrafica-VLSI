/*---------------------------------------------------------*/
/* ----------------   Práctica 3 --------------------------*/
/*-----------------    2021-1   ---------------------------*/
/*-------Alumno: Alfonso Murrieta			 ---------------*/
#include <glew.h>
#include <glfw3.h>

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

#include <shader_m.h>

#include <iostream>

void resize(GLFWwindow* window, int width, int height);
void my_input(GLFWwindow *window);

float movX = 0.0f;
float movY = 0.0f;
float movZ = 0.0f;

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
	glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)(3 * sizeof(float)));
	glEnableVertexAttribArray(1);

	//Para trabajar con indices (Element Buffer Object)
	glGenBuffers(1, &EBO);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

	glBindBuffer(GL_ARRAY_BUFFER, 0);

	glBindVertexArray(0);

}

void display(Shader shader)
{
	shader.use();

	// create transformations and Projection
	glm::mat4 model = glm::mat4(1.0f);		// initialize Matrix, Use this matrix for individual models
	glm::mat4 view = glm::mat4(1.0f);		//Use this matrix for ALL models
	glm::mat4 projection = glm::mat4(1.0f);	//This matrix is for Projection

	// PROJECTIONS 
	
	//Use "projection" in order to change how we see the information
	projection = glm::perspective(glm::radians(45.0f), (float)SCR_WIDTH / (float)SCR_HEIGHT, 0.1f, 100.0f);
	
	//Solo la proyeccion no los vertices y también modifica origen del sistema de referencia
	//No muestra la profundidad del objeto
	//projection = glm::ortho(-5.0f, 5.0f, -3.0f, 3.0f, 0.1f, 10.0f);


	
	//Use "view" in order to affect all models
	//Lo desplazamos en el sistema de referencia 
	view = glm::translate(view, glm::vec3(movX, movY, movZ));//El movimiento está en la vista


	// pass them to the shaders
	shader.setMat4("model", model);
	shader.setMat4("view", view);
	// note: currently we set the projection matrix each frame, but since the projection matrix rarely changes it's often best practice to set it outside the main loop only once.
	shader.setMat4("projection", projection);

	glBindVertexArray(VAO);

	//Para crear el cubo con los vertices previos
	// Una vez modificado el shader podemos modificar el color de esta forma TODOS  estarán de esta forma
	//shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
	//glDrawArrays(GL_QUADS, 0, 24); //A lonely cube :(

	/*
	//CUBO B
	model = glm::translate(model,glm::vec3(3.0f,0.0f, 0.0f));//Aplicamos la matriz de modelo una transformacion
	shader.setMat4("model", model);//Se la aplicamos al shader 
	glDrawArrays(GL_QUADS, 0, 24); //B 


	//CUBO C Se crea respecto a la figura anterior 
	model = glm::translate(model, glm::vec3(0.0f, 3.5f, 0.0f));
	shader.setMat4("model", model);
	glDrawArrays(GL_QUADS, 0, 24); 

	//CUBO C
	model = glm::translate(glm::mat4(1.0f), glm::vec3(0.0f, 4.6f, 0.0f));//con el mat4 regresamos al origen para resetear la posicion C
	shader.setMat4("model", model);
	glDrawArrays(GL_QUADS, 0, 24); 
	*/

	/**/
	//glDrawArrays(GL_QUADS, 0, 24); //A lonely cube :(

	shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
	for (int i = 1; i < 12; i++) { // Desplazamos 1 respecto al mínimo en x
		shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
		model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 0.0f, 0.0f));
		shader.setMat4("model", model);
		glDrawArrays(GL_QUADS, 0, 24);
	}

	for (int i = 0; i < 13; i++) { // Desplazamos 1 respecto al mínimo en x
		if (i > 4 and i < 8) {
			shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 1.0f));//Blanco
			model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 1.0f, 0.0f));
			shader.setMat4("model", model);
			glDrawArrays(GL_QUADS, 0, 24);
		}
		else {
			shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
			model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 1.0f, 0.0f));
			shader.setMat4("model", model);
			glDrawArrays(GL_QUADS, 0, 24);
		}	
	}

	for (int i = 0; i < 13; i++) { // Desplazamos 1 respecto al mínimo en x
		if (i > 3 and i < 9) {
			shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 1.0f));//Blanco
			model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 2.0f, 0.0f));
			shader.setMat4("model", model);
			glDrawArrays(GL_QUADS, 0, 24);
		}
		else {
			shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
			model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 2.0f, 0.0f));
			shader.setMat4("model", model);
			glDrawArrays(GL_QUADS, 0, 24);
		}
	}

	for (int i = 1; i < 12; i++) { // Desplazamos 1 respecto al mínimo en x
			shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
			model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 3.0f, 0.0f));
			shader.setMat4("model", model);
			glDrawArrays(GL_QUADS, 0, 24);
	}

	//Ojos de la caquita 
	for (int i = 1; i < 12; i++) { // Desplazamos 1 respecto al mínimo en x
		if (i > 2 and i < 10) {
			if (i==6){
				shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
				model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 4.0f, 0.0f));
				shader.setMat4("model", model);
				glDrawArrays(GL_QUADS, 0, 24);
			}
			else{
				shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 1.0f));//Blanco
				model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 4.0f, 0.0f));
				shader.setMat4("model", model);
				glDrawArrays(GL_QUADS, 0, 24);
			}
		}
		else {
			shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
			model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 4.0f, 0.0f));
			shader.setMat4("model", model);
			glDrawArrays(GL_QUADS, 0, 24);
		}
	}

	for (int i = 2; i < 11; i++) { // Desplazamos 1 respecto al mínimo en x
		if (i > 2 and i < 10) {
			if (i == 6) {
				shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
				model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 5.0f, 0.0f));
				shader.setMat4("model", model);
				glDrawArrays(GL_QUADS, 0, 24);
			}
			else if(i == 4 or i == 8){
				shader.setVec3("aColor", glm::vec3(0.0f, 0.0f, 0.0f));//Negro
				model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 5.0f, 0.0f));
				shader.setMat4("model", model);
				glDrawArrays(GL_QUADS, 0, 24);
			}
			else {
				shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 1.0f));//Blanco
				model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 5.0f, 0.0f));
				shader.setMat4("model", model);
				glDrawArrays(GL_QUADS, 0, 24);
			}
		}
		else {
			shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
			model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 5.0f, 0.0f));
			shader.setMat4("model", model);
			glDrawArrays(GL_QUADS, 0, 24);
		}
	}

	for (int i = 2; i < 11; i++) { // Desplazamos 1 respecto al mínimo en x
		if (i > 2 and i < 10) {
			if (i == 6) {
				shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
				model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 6.0f, 0.0f));
				shader.setMat4("model", model);
				glDrawArrays(GL_QUADS, 0, 24);
			}
			else if (i == 4 or i == 8) {
				shader.setVec3("aColor", glm::vec3(0.0f, 0.0f, 0.0f));//Negro
				model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 6.0f, 0.0f));
				shader.setMat4("model", model);
				glDrawArrays(GL_QUADS, 0, 24);
			}
			else {
				shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 1.0f));//Blanco
				model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 6.0f, 0.0f));
				shader.setMat4("model", model);
				glDrawArrays(GL_QUADS, 0, 24);
			}
		}
		else {
			shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
			model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 6.0f, 0.0f));
			shader.setMat4("model", model);
			glDrawArrays(GL_QUADS, 0, 24);
		}
	}

	for (int i = 2; i < 11; i++) { // Desplazamos 1 respecto al mínimo en x
		if (i > 2 and i < 10) {
			if (i == 6) {
				shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
				model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 7.0f, 0.0f));
				shader.setMat4("model", model);
				glDrawArrays(GL_QUADS, 0, 24);
			}
			else {
				shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 1.0f));//Blanco
				model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 7.0f, 0.0f));
				shader.setMat4("model", model);
				glDrawArrays(GL_QUADS, 0, 24);
			}
		}
		else {
			shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
			model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 7.0f, 0.0f));
			shader.setMat4("model", model);
			glDrawArrays(GL_QUADS, 0, 24);
		}
	}


	//Cabeza = Solo color cafe
	for (int i = 3; i < 10; i++) { // Desplazamos 1 respecto al mínimo en x
		shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
		model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 8.0f, 0.0f));
		shader.setMat4("model", model);
		glDrawArrays(GL_QUADS, 0, 24);
	}

	for (int i = 4; i < 9; i++) { // Desplazamos 1 respecto al mínimo en x
		shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
		model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 9.0f, 0.0f));
		shader.setMat4("model", model);
		glDrawArrays(GL_QUADS, 0, 24);
	}

	for (int i = 4; i < 9; i++) { // Desplazamos 1 respecto al mínimo en x
		shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
		model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 10.0f, 0.0f));
		shader.setMat4("model", model);
		glDrawArrays(GL_QUADS, 0, 24);
	}

	for (int i = 5; i < 8; i++) { // Desplazamos 1 respecto al mínimo en x
		shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
		model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 11.0f, 0.0f));
		shader.setMat4("model", model);
		glDrawArrays(GL_QUADS, 0, 24);
	}

	for (int i = 4; i < 7; i++) { // Desplazamos 1 respecto al mínimo en x
		shader.setVec3("aColor", glm::vec3(0.74f, 0.55f, 0.4f));
		model = glm::translate(glm::mat4(1.0f), glm::vec3((float)i, 12.0f, 0.0f));
		shader.setMat4("model", model);
		glDrawArrays(GL_QUADS, 0, 24);
	}

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

    GLFWwindow* window = glfwCreateWindow(SCR_WIDTH, SCR_HEIGHT, "Practica 3", NULL, NULL);
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

	//Shader myShader("shaders/shader.vs", "shaders/shader.fs");
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

	//Agregando comportamiento en X
	if(glfwGetKey(window, GLFW_KEY_D)  == GLFW_PRESS){
		movX += 0.03f;
	}

	if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS) {
		movX -= 0.03f;
	}

	//Agregando comportamiento en Y
	if (glfwGetKey(window, GLFW_KEY_PAGE_UP) == GLFW_PRESS) {
		movY += 0.03f;
	}

	if (glfwGetKey(window, GLFW_KEY_PAGE_DOWN) == GLFW_PRESS) {
		movY -= 0.03f;
	}

	//Agregando comportamiento en Z
	if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS) {
		movZ += 0.03f;
	}

	if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS) {
		movZ -= 0.03f;
	}



}

// glfw: whenever the window size changed (by OS or user resize) this callback function executes
// ---------------------------------------------------------------------------------------------
void resize(GLFWwindow* window, int width, int height)
{
    // Set the Viewport to the size of the created window
    glViewport(0, 0, width, height);
}