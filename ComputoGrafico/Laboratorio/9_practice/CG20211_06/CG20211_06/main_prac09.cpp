/*---------------------------------------------------------*/
/* ----------------   Práctica 9 --------------------------*/
/*-----------------    2021-1   ---------------------------*/
/*------------- Alumno: Alfonso Murrieta Villegas  --------*/
#include <Windows.h>

#include <glad/glad.h>
#include <glfw3.h>	//main
#include <stdlib.h>		
#include <glm/glm.hpp>	//camera y model
#include <glm/gtc/matrix_transform.hpp>	//camera y model
#include <glm/gtc/type_ptr.hpp>
#include<time.h>


#define STB_IMAGE_IMPLEMENTATION
#include <stb_image.h>	//Texture

#define SDL_MAIN_HANDLED
#include <SDL/SDL.h>

#include <shader_m.h>
#include <camera.h>
#include <modelAnim.h>
#include <model.h>
#include <Skybox.h>
#include <iostream>

//#pragma comment(lib, "winmm.lib")

void framebuffer_size_callback(GLFWwindow* window, int width, int height);
void mouse_callback(GLFWwindow* window, double xpos, double ypos);
void scroll_callback(GLFWwindow* window, double xoffset, double yoffset);
void my_input(GLFWwindow *window);
void animate(void);

// settings
const unsigned int SCR_WIDTH = 800;
const unsigned int SCR_HEIGHT = 600;

// camera
Camera camera(glm::vec3(0.0f, 0.0f, 3.0f));
float MovementSpeed = 0.1f;
float lastX = SCR_WIDTH / 2.0f;
float lastY = SCR_HEIGHT / 2.0f;
bool firstMouse = true;

// timing
const int FPS = 60;
const int LOOP_TIME = 1000 / FPS; // = 16 milisec // 1000 millisec == 1 sec
double	deltaTime = 0.0f,
		lastFrame = 0.0f;

// Light
//glm::vec3 lightDirection = glm::vec3(-0.2f, -1.0f, -0.3f);
//Lighting

//DIRECCIÓN DE LA ILUMINACIÓN !
glm::vec3 lightPosition(0.0f, 4.0f, -10.0f);
glm::vec3 lightDirection(0.0f, -1.0f, 0.0f);

// posiciones
float x = 0.0f;
float y = 0.0f;

//PARA LA ANIMACION
float movAuto_z = 0.0f;
float movAuto_y = -1.75f;

bool animacion = false;
int estadosAuto = 0;

void animate(void)
{
	//NO USAR FOR O WHILE 
	if (animacion)
	{
		/*
		//Hacia adelante con limite y considerando el reset
		if (movAuto_z >= 20.0f) {
			animacion = false;
		}
		else {
			movAuto_z += 0.3f;
		}
		*/
		/*

		// reversa y adelante 

		if (estado) {
			movAuto_z += 0.3f;
			if (movAuto_z >= 20.0f) {
				estado = false;
			}
		}
		else {
			movAuto_z -= 0.3f;
			if (movAuto_z <= 0.0f) {
				estado = true;
			}
		}
		*/

		switch (estadosAuto) {

			case 1: 
				if (movAuto_z >= -7.0)
					movAuto_z -= 0.3f;
				else 
					estadosAuto = 2;

				break;

			case 2: 
				if (movAuto_y <= 3.75)
					movAuto_y += 0.3f;

				else 
					estadosAuto = 3;

			break;


			case 3:
				if (movAuto_z <= 11.5) 
					movAuto_z += 0.3f;

				else 
					estadosAuto = 4;

			break;

			case 4: 
				if (movAuto_y >= -1.75)
					movAuto_y -= 0.3f;

				else 
					estadosAuto = 5;

			break;

			case 5: 
				if (movAuto_z <= 14.5) 
					movAuto_z += 0.3f;
				else 
					estadosAuto = 0;
			break;

			default:
				break;

		}
		

		//std::cout << "posicion = " << movAuto_z << " en Z" << std::endl;
	}
}

int main()
{
	// glfw: initialize and configure
	// ------------------------------
	glfwInit();
	/*glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);*/

#ifdef __APPLE__
	glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
#endif

	// glfw window creation
	// --------------------
	GLFWwindow* window = glfwCreateWindow(SCR_WIDTH, SCR_HEIGHT, "Practica 9", NULL, NULL);
	if (window == NULL)
	{
		std::cout << "Failed to create GLFW window" << std::endl;
		glfwTerminate();
		return -1;
	}
	glfwMakeContextCurrent(window);
	glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);
	glfwSetCursorPosCallback(window, mouse_callback);
	glfwSetScrollCallback(window, scroll_callback);

	// tell GLFW to capture our mouse
	glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_DISABLED);

	// glad: load all OpenGL function pointers
	// ---------------------------------------
	if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
	{
		std::cout << "Failed to initialize GLAD" << std::endl;
		return -1;
	}

	// configure global opengl state
	// -----------------------------
	glEnable(GL_DEPTH_TEST);

	// build and compile shaders
	// -------------------------
	//Shader staticShader("Shaders/lightVertex.vs", "Shaders/lightFragment.fs");
	Shader staticShader("Shaders/shader_Lights.vs", "Shaders/shader_Lights.fs");
	Shader skyboxShader("Shaders/skybox.vs", "Shaders/skybox.fs");

	vector<std::string> faces
	{
		"resources/skybox/right.jpg",
		"resources/skybox/left.jpg",
		"resources/skybox/top.jpg",
		"resources/skybox/bottom.jpg",
		"resources/skybox/front.jpg",
		"resources/skybox/back.jpg"
	};

	Skybox skybox = Skybox(faces);

	// Shader configuration
	// --------------------
	skyboxShader.use();
	skyboxShader.setInt("skybox", 0);

	// load models
	// -----------
	Model piso("resources/objects/piso/piso.obj");
	Model carro("resources/objects/lambo/carroceria.obj");
	Model llanta("resources/objects/lambo/wheel.obj");

	// draw in wireframe
	//glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

	// render loop
	// -----------
	while (!glfwWindowShouldClose(window))
	{
		skyboxShader.setInt("skybox", 0);
		
		// per-frame time logic
		// --------------------
		lastFrame = SDL_GetTicks();

		// input
		// -----
		my_input(window);
		animate();

		// render
		// ------
		glClearColor(0.3f, 0.3f, 0.3f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

		// -------------------------------------------------------------------------------------------------------------------------
		// Personaje 1
		// -------------------------------------------------------------------------------------------------------------------------
		// don't forget to enable shader before setting uniforms
		staticShader.use();
		//Setup Advanced Lights

		//DIreccional = Similar al sol (Sale la luz a todas direcciones)
		staticShader.setVec3("viewPos", camera.Position);
		staticShader.setVec3("dirLight.direction", lightDirection);
		staticShader.setVec3("dirLight.ambient", glm::vec3(0.3f, 0.3f, 0.3f)); //Hacia el negro 
		staticShader.setVec3("dirLight.diffuse",  glm::vec3(1.0f, 1.0f, 1.0f));
		staticShader.setVec3("dirLight.specular", glm::vec3(1.0f, 1.0f, 1.0f));//Para los "reflejos"

		//fuente de luz posicional = Es como un foco  
		staticShader.setVec3("pointLight[0].position", lightPosition);
		staticShader.setVec3("pointLight[0].ambient", glm::vec3(0.0f, 0.0f, 0.0f));// glm::vec3(0.0f, 0.0f, 0.0f));
		staticShader.setVec3("pointLight[0].diffuse", glm::vec3(0.0f, 0.0f, 0.0f));// glm::vec3(1.0f, 1.0f, 1.0f));
		staticShader.setVec3("pointLight[0].specular", glm::vec3(0.0f, 0.0f, 0.0f));// glm::vec3(0.0f, 0.0f, 0.0f));
		//Atenuacion de la luz 

		//more intensity light
		staticShader.setFloat("pointLight[0].constant", 0.8f);
		//respecto a la distancia => Más pequeño más cerca la luz e iluminamos more
		staticShader.setFloat("pointLight[0].linear", 0.00009f);
		staticShader.setFloat("pointLight[0].quadratic", 0.00032f);

		staticShader.setVec3("pointLight[1].position", glm::vec3(0.0, 0.0f, 0.0f));
		staticShader.setVec3("pointLight[1].ambient", glm::vec3(0.0f, 0.0f, 0.0f));
		staticShader.setVec3("pointLight[1].diffuse", glm::vec3(0.0f, 0.0f, 0.0f));
		staticShader.setVec3("pointLight[1].specular", glm::vec3(0.0f, 0.0f, 0.0f));
		staticShader.setFloat("pointLight[1].constant", 1.0f);
		staticShader.setFloat("pointLight[1].linear", 0.009f);
		staticShader.setFloat("pointLight[1].quadratic", 0.032f);

		staticShader.setFloat("material_shininess", 32.0f);



		glm::mat4 model = glm::mat4(1.0f);
		// view/projection transformations
		glm::mat4 projection = glm::perspective(glm::radians(camera.Zoom), (float)SCR_WIDTH / (float)SCR_HEIGHT, 0.1f, 1000.0f);
		glm::mat4 view = camera.GetViewMatrix();
		staticShader.setMat4("projection", projection);
		staticShader.setMat4("view", view);

		//// Light
		glm::vec3 lightColor = glm::vec3(1.0f);
		glm::vec3 diffuseColor = lightColor * glm::vec3(0.5f);
		glm::vec3 ambientColor = diffuseColor * glm::vec3(0.75f);
		
		// -------------------------------------------------------------------------------------------------------------------------
		// Escenario
		// -------------------------------------------------------------------------------------------------------------------------
		staticShader.setMat4("projection", projection);
		staticShader.setMat4("view", view);

		/*staticShader.setVec3("material.specular", glm::vec3(0.5f));
		staticShader.setFloat("material.shininess", 32.0f);
		staticShader.setVec3("light.ambient", ambientColor);
		staticShader.setVec3("light.diffuse", diffuseColor);
		staticShader.setVec3("light.specular", 1.0f, 1.0f, 1.0f);
		staticShader.setVec3("light.direction", lightDirection);
		staticShader.setVec3("viewPos", camera.Position);*/

		model = glm::mat4(1.0f);
		model = glm::translate(model, glm::vec3(0.0f, -1.75f, 0.0f));
		model = glm::scale(model, glm::vec3(0.2f));
		staticShader.setMat4("model", model);
		piso.Draw(staticShader);


		glm::mat4 temp = glm::mat4(1.0f);
		model = glm::rotate(glm::mat4(1.0f), glm::radians(90.0f), glm::vec3(0.0f, 1.0f, 0.0f));
		temp = model = glm::translate(model, glm::vec3(15.0f,movAuto_y, movAuto_z));
		model = glm::scale(model, glm::vec3(0.01f, 0.01f, 0.01f));
		//model = glm::scale(model, glm::vec3(0.3f, 0.3f, 0.3f));
		staticShader.setMat4("model", model);
		carro.Draw(staticShader);

		//Llantas
		model = glm::translate(temp, glm::vec3(0.85f, 0.25f, 1.29f));
		model = glm::scale(model, glm::vec3(0.01f, 0.01f, 0.01f));
		staticShader.setMat4("model", model);
		llanta.Draw(staticShader); //delantera derecha

		model = glm::translate(temp, glm::vec3(-0.85f, 0.25f, 1.29f));
		model = glm::scale(model, glm::vec3(0.01f, 0.01f, 0.01f));
		model = glm::rotate(model, glm::radians(180.0f), glm::vec3(0.0f, 1.0f, 0.0f));
		staticShader.setMat4("model", model);
		llanta.Draw(staticShader); //delantera izquierda

		model = glm::translate(temp, glm::vec3(0.85f, 0.25f, -1.45f));
		model = glm::scale(model, glm::vec3(0.01f, 0.01f, 0.01f));
		staticShader.setMat4("model", model);
		llanta.Draw(staticShader); //delantera izquierda


		model = glm::translate(temp, glm::vec3(-0.85f, 0.25f, -1.45f));
		model = glm::scale(model, glm::vec3(0.01f, 0.01f, 0.01f));
		model = glm::rotate(model, glm::radians(180.0f), glm::vec3(0.0f, 1.0f, 0.0f));
		staticShader.setMat4("model", model);
		llanta.Draw(staticShader); //delantera izquierda


		// -------------------------------------------------------------------------------------------------------------------------
		// Termina Escenario
		// -------------------------------------------------------------------------------------------------------------------------

		//-------------------------------------------------------------------------------------
		// draw skybox as last
		// -------------------
		skyboxShader.use();
		skybox.Draw(skyboxShader, view, projection, camera);

		// Creo que limitan el framerate a 60
		deltaTime = SDL_GetTicks() - lastFrame; // time for full 1 loop
		//std::cout <<"frame time = " << frameTime << " milli sec"<< std::endl;
		if (deltaTime < LOOP_TIME)
		{
			SDL_Delay((int)(LOOP_TIME - deltaTime));
		}

		// glfw: swap buffers and poll IO events (keys pressed/released, mouse moved etc.)
		// -------------------------------------------------------------------------------
		glfwSwapBuffers(window);
		glfwPollEvents();
	}

	skybox.Terminate();

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
		camera.ProcessKeyboard(FORWARD, deltaTime);
	if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS)
		camera.ProcessKeyboard(BACKWARD, deltaTime);
	if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS)
		camera.ProcessKeyboard(LEFT, deltaTime);
	if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS)
		camera.ProcessKeyboard(RIGHT, deltaTime);


	//SE MUEVE CARRO
	if (glfwGetKey(window, GLFW_KEY_SPACE) == GLFW_PRESS) {
		animacion = true;
		estadosAuto = 1;
	}
		
	
	//reset position
	if (glfwGetKey(window, GLFW_KEY_R) == GLFW_PRESS)
		movAuto_z = 0.0f;


	if (glfwGetKey(window, GLFW_KEY_LEFT_SHIFT) == GLFW_PRESS)
		camera.MovementSpeed = MovementSpeed * 2.5f;
	else
		camera.MovementSpeed = MovementSpeed;

	if (glfwGetKey(window, GLFW_KEY_J) == GLFW_PRESS)
		lightPosition.x -= 1.0f;
	if (glfwGetKey(window, GLFW_KEY_K) == GLFW_PRESS)
		lightPosition.x += 1.0f;
	
}

// glfw: whenever the window size changed (by OS or user resize) this callback function executes
// ---------------------------------------------------------------------------------------------
void framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
	// make sure the viewport matches the new window dimensions; note that width and 
	// height will be significantly larger than specified on retina displays.
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

	float xoffset = xpos - lastX;
	float yoffset = lastY - ypos; // reversed since y-coordinates go from bottom to top

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