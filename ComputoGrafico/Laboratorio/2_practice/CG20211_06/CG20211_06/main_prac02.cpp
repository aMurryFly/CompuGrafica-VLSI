/*---------------------------------------------------------*/
/* ----------------   Práctica 2 --------------------------*/
/*-----------------    2021-1   ---------------------------*/
/*------------- Alfonso Murrieta Villegas ---------------*/
#include <glew.h>
#include <glfw3.h>

#include <iostream>

void resize(GLFWwindow* window, int width, int height);
void my_input(GLFWwindow *window);

// settings
// Window size
int SCR_WIDTH = 800;
int SCR_HEIGHT = 600;

GLFWmonitor *monitors;
GLuint VBO, VAO, EBO;
GLuint shaderProgramRed, shaderProgramColor;

static const char* myVertexShader = "										\n\
#version 330 core															\n\
																			\n\
layout (location = 0) in vec3 aPos;											\n\
																			\n\
void main()																	\n\
{																			\n\
    gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);							\n\
}";

//Otra entidad de shader
static const char* myVertexShaderColor = "									\n\
#version 330 core															\n\
																			\n\
layout (location = 0) in vec3 aPos;											\n\
layout (location = 1) in vec3 aColor;										\n\
out vec3 ourColor;															\n\
void main()																	\n\
{																			\n\
    gl_Position = vec4(aPos, 1.0);											\n\
	ourColor = aColor;														\n\
}";

// Fragment Shader
static const char* myFragmentShaderRed = "									\n\
#version 330																\n\
																			\n\
out vec3 finalColor;														\n\
																			\n\
void main()																	\n\
{																			\n\
    finalColor = vec3(1.0f, 0.0f, 0.0f);									\n\
}";

static const char* myFragmentShaderColor = "								\n\
#version 330 core															\n\
out vec4 FragColor;															\n\
in vec3 ourColor;															\n\
																			\n\
void main()																	\n\
{																			\n\
	FragColor = vec4(ourColor, 1.0f);										\n\
}";

void myData(void);
void setupShaders(void);
void display(void);
void getResolution(void);


void getResolution()
{
	const GLFWvidmode * mode = glfwGetVideoMode(glfwGetPrimaryMonitor());

	SCR_WIDTH = mode->width;
	SCR_HEIGHT = (mode->height) - 80;
}

void myData()
{
	float vertices[] = 
	{
		// positions         //color
		/*
		0.5f,  0.5f, 0.0f,  1.0f, 1.0f, 1.0f, // top right - V0
		0.5f, -0.5f, 0.0f,  0.0f, 1.0f, 0.0f, // bottom right - V1
		-0.5f, -0.5f, 0.0f, 1.0f, 1.0f, 0.0f, // bottom left - V2
		-0.5f,  0.5f, 0.0f, 1.0f, 0.0f, 0.0f,   // top left -V3
		-0.8f,  0.0f, 0.0f, 0.0f, 0.0f, 1.0f,   // middle left
		*/

		// LETRA C -> Es concavo debido a que tiene grados internos mayores a 180 grados							
		-0.9f,0.9f,0.0f,  1.0f,1.0f,0.5f, //V0
		-0.8f,0.9f,0.0f,   1.0f,0.0f,1.0f, //V1
		-0.8f,0.87f,0.0f,  0.0f,0.0f,1.0f, //V2
		-0.87f,0.87f,0.0f,  0.0f,1.0f,0.0f, //V3
		-0.87f,0.6f,0.0f, 0.0f,1.0f,0.0f, //V4
		-0.8f,0.6f,0.0f,  0.0f,0.0f,1.0f, //V5
		-0.8f,0.57f,0.0f,  1.0f,0.0f,1.0f, //V6
		-0.9f,0.57f,0.0f, 1.0f,1.0f,0.5f, //V7


		//LETRA M ->
		0.2f,0.9f,0.0f,  1.0f,1.0f,0.5f, //V0 -8
		0.25f,0.8f,0.0f,   1.0f,0.0f,1.0f, //V1 -9 
		0.3f,0.9f,0.0f,  0.0f,0.0f,1.0f, //V2 - 10 

		0.3f,0.57f,0.0f,  1.0f,1.0f,0.5f, //V3 - 11
		0.28f,0.57f,0.0f,   1.0f,0.0f,1.0f, //V4 - 12
		0.28f,0.73f,0.0f,  0.0f,0.0f,1.0f, //V5 - 13

		
		0.25f,0.7f,0.0f,  0.0f,1.0f,0.0f, //V6 - 14
		
		0.22f,0.73f,0.0f, 0.0f,1.0f,0.0f, //V7 - 15
		0.22f,0.57f,0.0f,  0.0f,0.0f,1.0f, //V8 - 16
		0.2f,0.57f,0.0f,  1.0f,0.0f,1.0f, //V9 - 17



		//LETRA A ->
		-0.45f,0.9f,0.0f,  1.0f,1.0f,0.5f, //V18
		-0.5f,0.57f,0.0f,   1.0f,0.0f,1.0f, //V19 
		-0.48f,0.57f,0.0f,  0.0f,0.0f,1.0f, //V20 

			//Second part
		-0.45f,0.9f,0.0f,  1.0f,1.0f,0.5f, //V21
		-0.4f,0.57f,0.0f,   1.0f,0.0f,1.0f, //V22
		-0.42f,0.57f,0.0f,  0.0f,0.0f,1.0f, //V23
		-0.43f,0.75f,0.0f,  0.0f,1.0f,0.0f, //V24
		-0.47f,0.75f,0.0f, 0.0f,1.0f,0.0f, //V25
		-0.46f,0.8f,0.0f,  0.0f,0.0f,1.0f, //V26
		-0.44f,0.8f,0.0f,  1.0f,0.0f,1.0f, //V27
		-0.45f,0.85f,0.0f,  1.0f,0.0f,1.0f, //V28

		//ESTRELLA
		0.0f,0.0f,0.0f,	 0.0f,1.0f,0.0f,//V0  29 CENTRO
		0.0f,0.1f,0.0f,	1.0f,0.0f,0.5f,	//V1  30
		0.03f,0.05f,0.0f,	0.0f,0.5f,0.5f,	//V2  31
		0.1f,0.05f,0.0f,	1.0f,1.0f,0.0f,	//V3  32
		0.05f,-0.03f,0.0f,	0.0f,0.5f,0.5f,	//V4  33
		0.07f,-0.1f,0.0f,	1.0f,0.0f,0.5f,	//V5  34
		0.0f,-0.05f,0.0f,	 0.0f,1.0f,0.0f,//V6  35
	   -0.07f,-0.1f,0.0f,	1.0f,0.0f,0.5f,	//V7  36
	   -0.05f,-0.03f,0.0f,	 0.0f,1.0f,0.0f, //V8  37
		-0.1f,0.05f,0.0f,	1.0f,1.0f,0.0f,	//V9  38
		-0.03f,0.05f,0.0f,	1.0f,0.0f,0.5f,	//V10  39

	};

	unsigned int indices[] =
	{
		//Sólo con triangles
		/*1,2,3,
		0,1,3,
		0,3,7,
		3,4,7,
		7,4,6,
		6,5,4*/

		//LETRA C -> Con fan vamos a utilizar como pivote el 3
		3,2,1,0,7,4,
		4,7,6,5,

		//LETRA M -> 
		15,16,17,8,9,
		13,12,11,10,9,
		14,13,9,15,

		//LETRA A -> La hice después sobre todo por la complejidad de la letra
		18,19,20,
		26,25,24,27,
		21,28,22,23,

		//ESTRELLA
		29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 30,

	};

	//Se manda el vector de vertices al buffer 

	glGenVertexArrays(1, &VAO);
	glBindVertexArray(VAO);

	glGenBuffers(1, &VBO);

	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

	// position attribute
	//GL_false es porque no están en 0 y 1 o sea no están normalizados, 0 significa cada cuanto saltaba si es que hay más atributos, (void*)0
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)0);// Le pasa al buffer las entradas aPos y aColor
	glEnableVertexAttribArray(0);


	// color attribute
	//1 es el número de la entrada, cantidad de datos, tipo de datos, GL_false es porque no están en 0 y 1 o sea no están normalizados,
	//6 * sizeof(float) significa cada cuanto va a estar leyendo -> o sea cada cuanto saltará, este menciona donde empieza
	glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)(3 * sizeof(float)));
	glEnableVertexAttribArray(1);

	//Para trabajar con indices (Element Buffer Object)
	glGenBuffers(1, &EBO);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

	glBindBuffer(GL_ARRAY_BUFFER, 0);

	glBindVertexArray(0);

}

void setupShaders()
{
	unsigned int vertexShader = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(vertexShader, 1, &myVertexShader, NULL);
	glCompileShader(vertexShader);

	unsigned int vertexShaderColor = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(vertexShaderColor, 1, &myVertexShaderColor, NULL);
	glCompileShader(vertexShaderColor);

	unsigned int fragmentShaderRed = glCreateShader(GL_FRAGMENT_SHADER);
	glShaderSource(fragmentShaderRed, 1, &myFragmentShaderRed, NULL);
	glCompileShader(fragmentShaderRed);

	unsigned int fragmentShaderColor = glCreateShader(GL_FRAGMENT_SHADER);
	glShaderSource(fragmentShaderColor, 1, &myFragmentShaderColor, NULL);
	glCompileShader(fragmentShaderColor);


	//Crear el Programa que combina Geometría con Color
	shaderProgramRed = glCreateProgram();
	glAttachShader(shaderProgramRed, vertexShader);
	glAttachShader(shaderProgramRed, fragmentShaderRed);
	glLinkProgram(shaderProgramRed);

	shaderProgramColor = glCreateProgram();
	glAttachShader(shaderProgramColor, vertexShaderColor);
	glAttachShader(shaderProgramColor, fragmentShaderColor);
	glLinkProgram(shaderProgramColor);
	//Check for errors 

	//ya con el Programa, el Shader no es necesario
	glDeleteShader(vertexShader);
	glDeleteShader(vertexShaderColor);
	glDeleteShader(fragmentShaderRed);
	glDeleteShader(fragmentShaderColor);

}

void display(void)
{
	//glUseProgram(shaderProgramRed); // Si lo omitimos se muestra en color blanco los puntos, debido a que es el default
	glUseProgram(shaderProgramColor);

	glBindVertexArray(VAO);
	//glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);

	glPointSize(5.0);
	//Este va a trabajar con un arreglo intermedio -> el cual referirá a otro arreglo con los indices de los arreglos
	//glDrawElements(GL_TRIANGLES, 18, GL_UNSIGNED_INT, 0);


	/*
	DIBUJO DE LAS ENTIDADES 
	*/

	// Letra C
	glDrawElements(GL_TRIANGLE_FAN, 6, GL_UNSIGNED_INT, 0);
	glDrawElements(GL_TRIANGLE_FAN, 4, GL_UNSIGNED_INT, (void*)(6* sizeof(float)) );	//Importante el indice del vertice

	// Letra M
	glDrawElements(GL_TRIANGLE_FAN, 5, GL_UNSIGNED_INT, (void*)(10 * sizeof(float)));
	glDrawElements(GL_TRIANGLE_FAN, 5, GL_UNSIGNED_INT, (void*)(15 * sizeof(float)));
	glDrawElements(GL_TRIANGLE_FAN, 4, GL_UNSIGNED_INT, (void*)(20 * sizeof(float)));

	// Letra A
	glDrawElements(GL_TRIANGLE_FAN, 3, GL_UNSIGNED_INT, (void*)(24 * sizeof(float)));
	glDrawElements(GL_TRIANGLE_FAN, 4, GL_UNSIGNED_INT, (void*)(27 * sizeof(float)));
	glDrawElements(GL_TRIANGLE_FAN, 4, GL_UNSIGNED_INT, (void*)(31 * sizeof(float)));

	//ESTRELLA
	glDrawElements(GL_TRIANGLE_FAN, 12, GL_UNSIGNED_INT, (void*)(35 * sizeof(float)));


	//Esta función trabaja directamente con los vertices
	//glDrawArrays(GL_LINE_LOOP, 0, 5);
	//GL_TRIANGLE_FAN a diferencia de GL_TRIANGLE_STRIP, fan coinciede todos los elementos a un mismo punto inicial
	glBindVertexArray(0);
	glUseProgram(0);
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
	
	//PREVIO
	getResolution();

    GLFWwindow* window = glfwCreateWindow(SCR_WIDTH, SCR_HEIGHT, "Practica 2", NULL, NULL);
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
	//Configurar Shaders
	setupShaders();
    

    // render loop
    // While the windows is not closed
    while (!glfwWindowShouldClose(window))
    {
        // input
        // -----
        my_input(window);

        // render
        // Backgound color
        glClearColor(0.3f, 0.3f, 0.3f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);

		//Mi función de dibujo
		display();

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
}

// glfw: whenever the window size changed (by OS or user resize) this callback function executes
// ---------------------------------------------------------------------------------------------
void resize(GLFWwindow* window, int width, int height)
{
    // Set the Viewport to the size of the created window
    glViewport(0, 0, width, height);
}