/*---------------------------------------------------------*/
/* ----------------   Práctica 7 --------------------------*/
/*-----------------    2021-1   ---------------------------*/
/*------------- Alumno:  Alfonso Murrieta Villegas---------*/
#include "esfera.h"
#include "camera.h"

Esfera my_sphere(1.0f);

void resize(GLFWwindow* window, int width, int height);
void my_input(GLFWwindow *window);
void mouse_callback(GLFWwindow *window, double xpos, double ypos);
void scroll_callback(GLFWwindow *window, double xoffset, double yoffset);

// settings
// Window size
int SCR_WIDTH = 800;
int SCR_HEIGHT = 600;

GLFWmonitor *monitors;
GLuint VBO, VAO, lightVAO;

//Camera
Camera camera(glm::vec3(0.0f, 0.0f, 3.0f));
/*double	lastX = 0.0f,
		lastY = 0.0f;*/
GLfloat lastX = SCR_WIDTH / 2.0f,
		lastY = SCR_HEIGHT / 2.0f;
bool firstMouse = true;

//Timing
const int FPS = 60;
const int LOOP_TIME = 1000 / FPS; // = 16 milisec // 1000 millisec == 1 sec
double	deltaTime = 0.0f,
		lastFrame = 0.0f;

//Lighting
glm::vec3 lightPos(0.0f, 0.0f, 0.0f); //En el centro donde está el sol

void myData(void);
void display(Shader, Shader);
void getResolution(void);
void animate(void);

//For Keyboard
float	movX = 0.0f,
		movY = 0.0f,
		movZ = -5.0f,
		rotX = 0.0f;

//For planets 
float
	sol = 0.0f,
	mercurio = 0.0f,

	year = 0.0f,
	day = 0.0f,
	moon = 0.0f,
	mars_year = 0.0f,
	jupiter_year = 0.0f,
	saturno = 0.0f;


void getResolution()
{
	const GLFWvidmode * mode = glfwGetVideoMode(glfwGetPrimaryMonitor());

	SCR_WIDTH = mode->width;
	SCR_HEIGHT = (mode->height) - 80;

	lastX = SCR_WIDTH / 2.0f;
	lastY = SCR_HEIGHT / 2.0f;

}

void myData()
{	
		GLfloat vertices[] = {
		//Position				//Normals
		-0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f,//Trasera
		 0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f,
		 0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f,
		 0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f,
		-0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f,
		-0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f,

		-0.5f, -0.5f,  0.5f,  0.0f,  0.0f,  1.0f,//Frontal
		 0.5f, -0.5f,  0.5f,  0.0f,  0.0f,  1.0f,
		 0.5f,  0.5f,  0.5f,  0.0f,  0.0f,  1.0f,
		 0.5f,  0.5f,  0.5f,  0.0f,  0.0f,  1.0f,
		-0.5f,  0.5f,  0.5f,  0.0f,  0.0f,  1.0f,
		-0.5f, -0.5f,  0.5f,  0.0f,  0.0f,  1.0f,

		-0.5f,  0.5f,  0.5f, -1.0f,  0.0f,  0.0f,//Izquierda
		-0.5f,  0.5f, -0.5f, -1.0f,  0.0f,  0.0f,
		-0.5f, -0.5f, -0.5f, -1.0f,  0.0f,  0.0f,
		-0.5f, -0.5f, -0.5f, -1.0f,  0.0f,  0.0f,
		-0.5f, -0.5f,  0.5f, -1.0f,  0.0f,  0.0f,
		-0.5f,  0.5f,  0.5f, -1.0f,  0.0f,  0.0f,

		 0.5f,  0.5f,  0.5f,  1.0f,  0.0f,  0.0f,//Derecha
		 0.5f,  0.5f, -0.5f,  1.0f,  0.0f,  0.0f,
		 0.5f, -0.5f, -0.5f,  1.0f,  0.0f,  0.0f,
		 0.5f, -0.5f, -0.5f,  1.0f,  0.0f,  0.0f,
		 0.5f, -0.5f,  0.5f,  1.0f,  0.0f,  0.0f,
		 0.5f,  0.5f,  0.5f,  1.0f,  0.0f,  0.0f,

		-0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,//Inferior
		 0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,
		 0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,
		 0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,
		-0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,
		-0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,

		-0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f,//Superior
		 0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f,
		 0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,
		 0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,
		-0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,
		-0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f
	};

	glGenVertexArrays(1, &VAO);
	glBindVertexArray(VAO);

	glGenBuffers(1, &VBO);

	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

	// position attribute
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)0);
	glEnableVertexAttribArray(0);

	// Normal attribute
	glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)(3 * sizeof(float)));
	glEnableVertexAttribArray(1);

	//To configure Second Object to represent Light
	glGenVertexArrays(1, &lightVAO);
	glBindVertexArray(lightVAO);

	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)0);
	glEnableVertexAttribArray(0);

}

void animate(void)
{
	sol += 1.0f;

	//Movements for each entity 
	mercurio += 0.4;

	year -= 0.9f;
	day += 0.7f;

	moon += 0.4f;
	mars_year -= 0.5f;

	jupiter_year += 0.4f;

	saturno += 0.35;
}

void display(Shader shaderProjection, Shader shaderLamp)
{
	
	//To Use Lighting
	shaderProjection.use();
	shaderProjection.setVec3("lightColor", 1.0f, 1.0f, 1.0f);
	shaderProjection.setVec3("lightPos", lightPos);

	// create transformations and Projection
	glm::mat4 model = glm::mat4(1.0f);		// initialize Matrix, Use this matrix for individual models
	glm::mat4 view = glm::mat4(1.0f);		//Use this matrix for ALL models
	glm::mat4 projection = glm::mat4(1.0f);	//This matrix is for Projection

	//Use "projection" to include Camera
	projection = glm::perspective(glm::radians(camera.Zoom), (float)SCR_WIDTH / (float)SCR_HEIGHT, 0.1f, 100.0f);
	view = camera.GetViewMatrix();

	// pass them to the shaders
	shaderProjection.setVec3("viewPos", camera.Position);
	shaderProjection.setMat4("model", model);
	shaderProjection.setMat4("view", view);
	// note: currently we set the projection matrix each frame, but since the projection matrix rarely changes it's often best practice to set it outside the main loop only once.
	shaderProjection.setMat4("projection", projection);


	glBindVertexArray(VAO);
	/*
	model = glm::rotate(model, glm::radians(sol), glm::vec3(1.0f, 0.0f, 0.0f));
	model = glm::scale(model, glm::vec3(0.9f, 0.7f, 0.5f));
	shaderProjection.setMat4("model", model);
	shaderProjection.setVec3("ambientColor", 0.4f, 0.4f, 0.4f);
	shaderProjection.setVec3("diffuseColor", 1.0f, 0.0f, 0.0f);
	shaderProjection.setVec3("specularColor", 1.0f, 1.0f, 0.0f);
	//my_sphere.render();	//Sphere
	glDrawArrays(GL_TRIANGLES, 0, 36);	//Light

	model = glm::translate(glm::mat4(1.0f), glm::vec3(3.0f, 0.0f, 0.0f));
	shaderProjection.setMat4("model", model);
	shaderProjection.setVec3("ambientColor", 0.3f, 0.3f, 0.3f);
	shaderProjection.setVec3("diffuseColor", 0.0f, 0.0f, 1.0f);
	shaderProjection.setVec3("specularColor", 1.0f, 1.0f, 1.0f);
	my_sphere.render();	//Sphere
	//glDrawArrays(GL_TRIANGLES, 0, 36);	//Light



	shaderLamp.use();
	shaderLamp.setMat4("projection", projection);
	shaderLamp.setMat4("view", view);
	//model = glm::mat4(1.0f);
	model = glm::translate(glm::mat4(1.0f), lightPos);
	model = glm::scale(model, glm::vec3(0.25f));
	shaderLamp.setMat4("model", model);

	glBindVertexArray(lightVAO);
	glDrawArrays(GL_TRIANGLES, 0, 36);	//Light
	*/


	//SISTEMA SOLAR
	//Usamos el shader de la lampara
	shaderLamp.use();
	shaderLamp.setMat4("projection", projection);
	shaderLamp.setMat4("view", view);

	model = glm::rotate(model, glm::radians(sol), glm::vec3(0.0f, 1.0f, 0.0f));
	model = glm::scale(model, glm::vec3(2.0f, 2.0f, 2.0f));
	shaderLamp.setMat4("model", model);
	//El lamp ya tiene valores previos
	//shaderLamp.setVec3("ambientColor", 1.0f, 1.0f, 0.0f);
	//shaderLamp.setVec3("diffuseColor", 1.0f, 1.0f, 0.0f);
	//shaderLamp.setVec3("specularColor", 1.0f, 1.0f, 0.0f);
	my_sphere.render();	//Sun

	//NO OLVIDAR => para activar el otro shader
	shaderProjection.use();

	//PLANETAS
	glm::mat4 temp = glm::mat4(1.0f);

	//MERCURIO
	model = glm::rotate(glm::mat4(1.0f), glm::radians(mercurio), glm::vec3(0.0f, 0.0f, 1.0f));
	model = glm::translate(model, glm::vec3(5.0f, 0.0f, 0.0f));
	model = glm::scale(model, glm::vec3(0.6f, 0.6f, 0.6f));
	shaderProjection.setMat4("model", model);
	shaderProjection.setVec3("ambientColor", 0.0f, 0.0f, 0.0f);
	shaderProjection.setVec3("diffuseColor", 0.0f, 1.0f, 0.0f);
	shaderProjection.setVec3("specularColor", 1.0f, 1.0f, 1.0f);
	my_sphere.render();


	//TIERRA
	model = glm::rotate(glm::mat4(1.0f), glm::radians(year), glm::vec3(0.0f, 1.0f, 0.0f));
	temp = model = glm::translate(model, glm::vec3(11.0f, 0.0f, 0.0f));
	model = glm::rotate(model, glm::radians(day), glm::vec3(0.0f, 1.0f, 0.0f));
	model = glm::scale(model, glm::vec3(1.1f, 1.1f, 1.1f));
	shaderProjection.setMat4("model", model);
	shaderProjection.setVec3("diffuseColor", 0.0f, 0.0f, 1.0f);
	shaderProjection.setVec3("specularColor", 1.0f, 1.0f, 1.0f);

	//la ambiental y especular tienen lo mismo que el anterior objeto
	my_sphere.render();

	//LUNA - TIERRA
	model = glm::rotate(model, glm::radians(moon), glm::vec3(1.0f, 0.0f, 0.0f));
	model = glm::translate(model, glm::vec3(0.0f, 2.7f, 0.0f));
	model = glm::scale(model, glm::vec3(0.6f, 0.6f, 0.6f));
	shaderProjection.setMat4("model", model);
	shaderProjection.setVec3("ambientColor", 0.0f, 0.0f, 0.0f);
	shaderProjection.setVec3("diffuseColor", 0.9f, 0.9f, 0.9f);
	shaderProjection.setVec3("specularColor", 1.0f, 1.0f, 1.0f);
	my_sphere.render();


	//MARTE 
	model = glm::rotate(glm::mat4(1.0f), glm::radians(mars_year), glm::vec3(0.0f, 0.0f, 1.0f));
	model = glm::translate(model, glm::vec3(15.0f, 0.0f, 0.0f));
	model = glm::rotate(model, glm::radians(day), glm::vec3(0.0f, 0.0f, 1.0f));
	model = glm::scale(model, glm::vec3(0.9f, 0.9f, 0.9f));

	shaderProjection.setMat4("model", model);
	shaderProjection.setVec3("ambientColor", 0.0f, 0.0f, 0.0f);
	shaderProjection.setVec3("diffuseColor", 1.0f, 0.0f, 0.9f);
	shaderProjection.setVec3("specularColor", 1.0f, 1.0f, 1.0f);
	my_sphere.render();


	//JUPITER
	//Desplazamiento respecto al plano
	model = glm::rotate(glm::mat4(1.0f), glm::radians(165.5f), glm::vec3(0.0f, 0.0f, 1.0f));

	model = glm::rotate(model, glm::radians(jupiter_year), glm::vec3(0.0f, 1.0f, 0.0f));
	model = glm::translate(model, glm::vec3(22.4f, 0.0f, 0.0f));
	model = glm::scale(model, glm::vec3(1.9f, 1.9f, 1.9f));

	shaderProjection.setMat4("model", model);
	shaderProjection.setVec3("ambientColor", 0.0f, 0.0f, 0.0f);
	shaderProjection.setVec3("diffuseColor", 1.0f, 0.5f, 0.9f);
	shaderProjection.setVec3("specularColor", 1.0f, 1.0f, 1.0f);
	my_sphere.render();


	//SATURNO 29.3 desfase en Y y 31.3 de distancia respecto al sol
	float desfase = 29.3;
	model = glm::rotate(glm::mat4(1.0f), glm::radians(180 - desfase), glm::vec3(0.0f, 1.0f, 0.0f));

	model = glm::rotate(model, glm::radians(saturno), glm::vec3(0.0f, 1.0f, 0.0f));
	model = glm::translate(model, glm::vec3(31.3f, 0.0f, 0.0f));
	model = glm::scale(model, glm::vec3(1.5f, 1.5f, 1.5f));

	shaderProjection.setMat4("model", model);
	shaderProjection.setVec3("ambientColor", 0.0f, 0.0f, 0.0f);
	shaderProjection.setVec3("diffuseColor", 0.9f, 0.4f, 0.2f);
	shaderProjection.setVec3("specularColor", 1.0f, 1.0f, 1.0f);
	my_sphere.render();





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

    GLFWwindow* window = glfwCreateWindow(SCR_WIDTH, SCR_HEIGHT, "Practica 7", NULL, NULL);
    if (window == NULL)
    {
        std::cout << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
        return -1;
    }
	glfwSetWindowPos(window, 0, 30);
    glfwMakeContextCurrent(window);
    glfwSetFramebufferSizeCallback(window, resize);
	glfwSetCursorPosCallback(window, mouse_callback);
	glfwSetScrollCallback(window, scroll_callback);

	//To Enable capture of our mouse
	glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_NORMAL);

	glewInit();

	//Mis funciones
	//Datos a utilizar
	myData();
	my_sphere.init();
	glEnable(GL_DEPTH_TEST);

	Shader projectionShader("shaders/shader_light.vs", "shaders/shader_light.fs");
	//Shader projectionShader("shaders/shader_light_Gouraud.vs", "shaders/shader_light_Gouraud.fs");
	Shader lampShader("shaders/shader_lamp.vs", "shaders/shader_lamp.fs");


    // render loop
    // While the windows is not closed
    while (!glfwWindowShouldClose(window))
    {
		// per-frame time logic
		// --------------------
		//double currentFrame = glfwGetTime(); 
		lastFrame = SDL_GetTicks();
		
		//std::cout <<"frame time = " << deltaTime << "sec"<< std::endl;
        // input
        // -----
		// render
		// Backgound color
		glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

		
		my_input(window);
		animate();
		//Mi función de dibujo
		display(projectionShader, lampShader);
		//lastFrame = currentFrame;
		deltaTime = SDL_GetTicks() - lastFrame;
		if (deltaTime < LOOP_TIME)
		{
			SDL_Delay((int)(LOOP_TIME - deltaTime));
		}
        // glfw: swap buffers and poll IO events (keys pressed/released, mouse moved etc.)
        // -------------------------------------------------------------------------------
        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    // glfw: terminate, clearing all previously allocated GLFW resources.
    // ------------------------------------------------------------------
	glDeleteVertexArrays(1, &VAO);
	glDeleteVertexArrays(1, &lightVAO);
	glDeleteBuffers(1, &VBO);

    glfwTerminate();
    return 0;
}

// process all input: query GLFW whether relevant keys are pressed/released this frame and react accordingly
// ---------------------------------------------------------------------------------------------------------
void my_input(GLFWwindow *window)
{
	if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
		glfwSetWindowShouldClose(window, true);

	if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS)
		camera.ProcessKeyboard(FORWARD, (float)deltaTime);
	if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS)
		camera.ProcessKeyboard(BACKWARD, (float)deltaTime);
	if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS)
		camera.ProcessKeyboard(LEFT, (float)deltaTime);
	if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS)
		camera.ProcessKeyboard(RIGHT, (float)deltaTime);
	

}

// glfw: whenever the window size changed (by OS or user resize) this callback function executes
// ---------------------------------------------------------------------------------------------
void resize(GLFWwindow* window, int width, int height)
{
    // Set the Viewport to the size of the created window
    glViewport(0, 0, width, height);
}

// glfw: whenever the mouse moves, this callback is called
// -------------------------------------------------------
void mouse_callback(GLFWwindow* window, double xpos, double ypos)
{
	if (firstMouse)
	{
		lastX = xpos;
		lastY = ypos;
		firstMouse = false;
	}

	double xoffset = xpos - lastX;
	double yoffset = lastY - ypos; // reversed since y-coordinates go from bottom to top

	lastX = xpos;
	lastY = ypos;

	camera.ProcessMouseMovement(xoffset, yoffset);
}

// glfw: whenever the mouse scroll wheel scrolls, this callback is called
// ----------------------------------------------------------------------
void scroll_callback(GLFWwindow* window, double xoffset, double yoffset)
{
	camera.ProcessMouseScroll(yoffset);
}