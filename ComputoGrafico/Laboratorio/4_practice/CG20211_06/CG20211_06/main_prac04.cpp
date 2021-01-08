/*---------------------------------------------------------*/
/* ----------------   Práctica 4 --------------------------*/
/*-----------------    2021-1   ---------------------------*/
/*------------- Alumno  Alfonso Murrieta Villegas                    ---------------*/
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
		movZ = -5.0f,
		rotX = 0.0f,
		rotZ = 0.0f,
		rotY = 0.0f;

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

	// create transformations and Projection

	glm::mat4 model = glm::mat4(1.0f);		// initialize Matrix, Use this matrix for individual models
	glm::mat4 view = glm::mat4(1.0f);		//Use this matrix for ALL models
	glm::mat4 projection = glm::mat4(1.0f);	//This matrix is for Projection

	projection = glm::perspective(glm::radians(45.0f), (float)SCR_WIDTH / (float)SCR_HEIGHT, 0.1f, 100.0f);
	//projection = glm::ortho(-5.0f, 5.0f, -3.0f, 3.0f, 0.1f, 10.0f);

	//Use "view" in order to affect all models
	view = glm::translate(view, glm::vec3(movX, movY, movZ));
	
	//Rotación
	view = glm::rotate(view, glm::radians(rotX), glm::vec3(1.0f, 0.0f, 0.0f));
	view = glm::rotate(view, glm::radians(rotY), glm::vec3(0.0f, 1.0f, 0.0f));
	view = glm::rotate(view, glm::radians(rotZ), glm::vec3(0.0f, 0.0f, 1.0f));

	// El vector que mandamos en la última parte es en cierta forma el vertices en el que rotará 


	// pass them to the shaders
	shader.setMat4("model", model);
	shader.setMat4("view", view);
	// note: currently we set the projection matrix each frame, but since the projection matrix rarely changes it's often best practice to set it outside the main loop only once.
	shader.setMat4("projection", projection);

	glBindVertexArray(VAO);
	
	//Colocar código aquí
	//LO vamos a escalar (Modificar size)

	/*//Cuadritos de ejemplo
										//Factores de escala = final/inicial
	model = glm::scale(model, glm::vec3(3.5f,0.4f,1.6f));
	shader.setMat4("model",model);
	shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 0.0f));
	glDrawArrays(GL_QUADS, 0, 24); 

	model = glm::translate(glm::mat4(1.0f),glm::vec3(4.0f,2.0f,0.0f));//hacemos reset mediante la matriz
	model = glm::scale(model, glm::vec3(0.3f, 3.87f, 1.0f));
	shader.setMat4("model",model);
	shader.setVec3("aColor", glm::vec3(1.0f, 0.0f, 0.0f));
	glDrawArrays(GL_QUADS, 0, 24); 
	*/

	//Creando el humanoide: => MODELADO GEOMETRICO (No importa el orden) 


	//Pecho
	model = glm::scale(model, glm::vec3(4.0f, 5.0f, 1.0f));  //tama�o
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 0.0f));
	glDrawArrays(GL_QUADS, 0, 24); 

	//matriz temproal
	glm::mat4 temporal = glm::mat4(1.0f);

	//Cuello
	temporal = model = glm::translate(glm::mat4(1.0f), glm::vec3(0.0f, 2.75f, 0.0f));//Mitad = 2.5 más la otra mitad .25 = 2.75
	model = glm::scale(model, glm::vec3(0.5f, 0.5f, 1.0f)); 
	shader.setMat4("model", model); 
	shader.setVec3("aColor", glm::vec3(0.0f, 1.0f, 0.0f));
	glDrawArrays(GL_QUADS, 0, 24); 

	//Cabeza
	model = glm::translate(temporal, glm::vec3(0.0f, 1.5f, 0.0f)); //Recorrido partiendo del centro del cuerpo
	model = glm::scale(model, glm::vec3(1.5f, 2.5f, 1.0f)); 
	shader.setMat4("model", model); 
	shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 1.0f)); 
	glDrawArrays(GL_QUADS, 0, 24);

	//Cadera
	temporal= model = glm::translate(glm::mat4(1.0f), glm::vec3(0.0f, -3.0f, 0.0f)); 
	model = glm::scale(model, glm::vec3(4.0f, 1.0f, 1.0f)); 
	shader.setMat4("model", model); 
	shader.setVec3("aColor", glm::vec3(0.0f, 1.0f, 1.0f)); 
	glDrawArrays(GL_QUADS, 0, 24); 

	//Pierna y pie izquierdos
	temporal = model = glm::translate(temporal, glm::vec3(-1.25f, -2.5f, 0.0f)); 
	model = glm::scale(model, glm::vec3(1.5f, 4.0f, 1.0f)); 
	shader.setMat4("model", model); 
	shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 1.0f)); 
	glDrawArrays(GL_QUADS, 0, 24);

	model = glm::translate(temporal, glm::vec3(-0.5f, -2.5f, 0.0f)); 
	model = glm::scale(model, glm::vec3(2.5f, 1.0f, 1.0f)); 
	shader.setMat4("model", model); 
	shader.setVec3("aColor", glm::vec3(0.0f, 1.0f, 1.0f)); 
	glDrawArrays(GL_QUADS, 0, 24);

	//Pierna y pie derechos
	temporal = model = glm::translate(temporal, glm::vec3(2.5f, 0.0f, 0.0f)); 
	model = glm::scale(model, glm::vec3(1.5f, 4.0f, 1.0f)); 
	shader.setMat4("model", model); 
	shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 1.0f)); 
	glDrawArrays(GL_QUADS, 0, 24); 

	model = glm::translate(temporal, glm::vec3(0.5f, -2.5f, 0.0f)); 
	model = glm::scale(model, glm::vec3(2.5f, 1.0f, 1.0f));
	shader.setMat4("model", model); 
	shader.setVec3("aColor", glm::vec3(0.0f, 1.0f, 1.0f)); 
	glDrawArrays(GL_QUADS, 0, 24); 

	//Ante-brazo y brazo izquierdo
	temporal = model = glm::translate(glm::mat4(1.0f), glm::vec3(-2.75f, 2.25f, 0.0f)); 
	model = glm::scale(model, glm::vec3(1.5f, 0.5f, 1.0f)); 
	shader.setMat4("model", model); 
	shader.setVec3("aColor", glm::vec3(0.0f, 1.0f, 1.0f));
	glDrawArrays(GL_QUADS, 0, 24); 

	temporal = model = glm::translate(temporal, glm::vec3(-0.25f, -2.00f, 0.0f)); 
	model = glm::scale(model, glm::vec3(1.0f, 3.5f, 1.0f)); 
	shader.setMat4("model", model); 
	shader.setVec3("aColor", glm::vec3(1.0f, 0.0f, 1.0f)); 
	glDrawArrays(GL_QUADS, 0, 24); 


	//Ante-brazo y brazo derecho
	temporal = model = glm::translate(glm::mat4(1.0f), glm::vec3(2.75f, 2.25f, 0.0f));
	model = glm::scale(model, glm::vec3(1.5f, 0.5f, 1.0f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(0.0f, 1.0f, 1.0f));
	glDrawArrays(GL_QUADS, 0, 24); 

	model = glm::translate(temporal, glm::vec3(0.25f, -2.0f, 0.0f));
	model = glm::scale(model, glm::vec3(1.0f, 3.5f, 1.0f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 0.0f, 1.0f));
	glDrawArrays(GL_QUADS, 0, 24); 

	//Creación de la espada 
	temporal = glm::mat4(1.0f);

	temporal = model = glm::translate(temporal, glm::vec3(3.0f, -2.0f, 0.0f));
	model = glm::scale(model, glm::vec3(1.5f, 1.0f, 1.0f)); 
	shader.setMat4("model", model); 
	shader.setVec3("aColor", glm::vec3(0.7f, 0.0f, 0.8f)); 
	glDrawArrays(GL_QUADS, 0, 24); 

	temporal = model = glm::translate(temporal, glm::vec3(1.125f, 0.0f, 0.0f));
	model = glm::scale(model, glm::vec3(0.75f, 2.0f, 1.0f));
	shader.setMat4("model", model); 
	shader.setVec3("aColor", glm::vec3(0.7f, 0.5f, 0.8f)); 
	glDrawArrays(GL_QUADS, 0, 24); 

	temporal = model = glm::translate(temporal, glm::vec3(2.35f, 0.0f, 0.0f));
	model = glm::scale(model, glm::vec3(4.0f, 1.0f, 1.0f)); 
	shader.setMat4("model", model); 
	shader.setVec3("aColor", glm::vec3(0.7f, 0.0f, 0.8f)); 
	glDrawArrays(GL_QUADS, 0, 24); 

	//Dibujando a crossy roads 


	glm::mat4 temPollo = glm::mat4(1.0f);

	//Construyendo cabeza y ojos
	temPollo = model = glm::translate(glm::mat4(1.0f), glm::vec3(-15.0f, 0.0f, 0.0f));
	model = glm::scale(model, glm::vec3(4.0f, 4.0f, 4.0f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 1.0f));
	glDrawArrays(GL_QUADS, 0, 24);

	//Ojo izquierdo
	model = glm::translate(temPollo, glm::vec3(-2.1f, 0.5f, 0.5f));
	model = glm::scale(model, glm::vec3(0.1f, 0.5f, 0.5f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(0.0f, 0.0f, 0.0f));
	glDrawArrays(GL_QUADS, 0, 24);

	//Ojo derecho
	model = glm::translate(temPollo, glm::vec3(2.1f, 0.5f, 0.5f));
	model = glm::scale(model, glm::vec3(0.1f, 0.5f, 0.5f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(0.0f, 0.0f, 0.0f));
	glDrawArrays(GL_QUADS, 0, 24);


	//Detalles de la cabeza
	//Pico
	temporal = model = glm::translate(temPollo, glm::vec3(0.0f, 0.5f, 2.75f));
	model = glm::scale(model, glm::vec3(1.0f, 1.0f, 1.5f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 0.6f, 0.12f));
	glDrawArrays(GL_QUADS, 0, 24); 

	//Molleja
	model = glm::translate(temporal, glm::vec3(0.0f, -1.0f, -0.25f));
	model = glm::scale(model, glm::vec3(1.0f, 1.0f, 1.0f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(0.89f, 0.0f, 0.48f));
	glDrawArrays(GL_QUADS, 0, 24); 

	//Cresta
	model = glm::translate(temPollo, glm::vec3(0.0f, 2.5f, 0.0f));
	model = glm::scale(model, glm::vec3(1.0f, 1.0f, 1.5f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(0.89f, 0.0f, 0.48f));
	glDrawArrays(GL_QUADS, 0, 24); 


	//Colas y alas

	temporal = model = glm::translate(temPollo, glm::vec3(0.0f, -3.5f, -1.0f));
	model = glm::scale(model, glm::vec3(4.0f, 3.0f, 6.0f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 1.0f));
	glDrawArrays(GL_QUADS, 0, 24); 

	//Ala Derecha
	model = glm::translate(temporal, glm::vec3(2.5f, 0.0f, 0.5f));
	model = glm::scale(model, glm::vec3(1.0f, 2.0f, 3.0f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 1.0f));
	glDrawArrays(GL_QUADS, 0, 24);

	//Ala Izquierda
	model = glm::translate(temporal, glm::vec3(-2.5f, 0.0f, 0.50f));
	model = glm::scale(model, glm::vec3(1.0f, 2.0f, 3.0f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 1.0f, 1.0f));
	glDrawArrays(GL_QUADS, 0, 24); 



	//PARTE DE LAS PATAS 
	//La estructura es pierna - base pata y dedos de la pate

	//LADO IZQUIERDO

	//pierna
	temPollo = model = glm::translate(temporal, glm::vec3(-1.75f, -2.5f, -0.25f));
	model = glm::scale(model, glm::vec3(0.5f, 2.0f, 0.5f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 0.6f, 0.12f));
	glDrawArrays(GL_QUADS, 0, 24); 

	//Base de la pata
	model = glm::translate(temPollo, glm::vec3(0.0f, -1.25f, 0.25f));
	model = glm::scale(model, glm::vec3(1.5f, 0.5f, 1.5f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 0.6f, 0.12f));
	glDrawArrays(GL_QUADS, 0, 24);

	//Dedo 1 
	model = glm::translate(temPollo, glm::vec3(-0.5f, -1.25f, 1.25f));
	model = glm::scale(model, glm::vec3(0.5f, 0.5f, 1.5f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 0.6f, 0.12f));
	glDrawArrays(GL_QUADS, 0, 24); 

	//Dedo 2
	model = glm::translate(temPollo, glm::vec3(0.5f, -1.25f, 1.25f));
	model = glm::scale(model, glm::vec3(0.5f, 0.5f, 1.5f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 0.6f, 0.12f));
	glDrawArrays(GL_QUADS, 0, 24); 


	//LADO DERECHO

	//Pierna
	temPollo = model = glm::translate(temporal, glm::vec3(1.75f, -2.5f, -0.25f));
	model = glm::scale(model, glm::vec3(0.5f, 2.0f, 0.5f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 0.6f, 0.12f));
	glDrawArrays(GL_QUADS, 0, 24); 

	//Base de la pata
	model = glm::translate(temPollo, glm::vec3(0.0f, -1.25f, 0.25f));
	model = glm::scale(model, glm::vec3(1.5f, 0.5f, 1.5f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 0.6f, 0.12f));
	glDrawArrays(GL_QUADS, 0, 24);

	//dedo 1
	model = glm::translate(temPollo, glm::vec3(-0.5f, -1.25f, 1.25f));
	model = glm::scale(model, glm::vec3(0.5f, 0.5f, 1.5f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 0.6f, 0.12f));
	glDrawArrays(GL_QUADS, 0, 24);

	//dedo 2
	model = glm::translate(temPollo, glm::vec3(0.5f, -1.25f, 1.25f));
	model = glm::scale(model, glm::vec3(0.5f, 0.5f, 1.5f));
	shader.setMat4("model", model);
	shader.setVec3("aColor", glm::vec3(1.0f, 0.6f, 0.12f));
	glDrawArrays(GL_QUADS, 0, 24); 


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

    GLFWwindow* window = glfwCreateWindow(SCR_WIDTH, SCR_HEIGHT, "Practica 4", NULL, NULL);
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
	//rotación Y
	if (glfwGetKey(window, GLFW_KEY_LEFT) == GLFW_PRESS)
		rotY -= 0.05f;
	if (glfwGetKey(window, GLFW_KEY_RIGHT) == GLFW_PRESS)
		rotY += 0.05f;
	//rotación en X
	if (glfwGetKey(window, GLFW_KEY_UP) == GLFW_PRESS)
		rotX -= 0.05f;
	if (glfwGetKey(window, GLFW_KEY_DOWN) == GLFW_PRESS)
		rotX += 0.05f;
	//rotación en Z
	if (glfwGetKey(window, GLFW_KEY_U) == GLFW_PRESS)
		rotZ -= 0.05f;
	if (glfwGetKey(window, GLFW_KEY_J) == GLFW_PRESS)
		rotZ += 0.05f;

}

// glfw: whenever the window size changed (by OS or user resize) this callback function executes
// ---------------------------------------------------------------------------------------------
void resize(GLFWwindow* window, int width, int height)
{
    // Set the Viewport to the size of the created window
    glViewport(0, 0, width, height);
}