# How to compile (Manual Técnico)



Alumno: Alfonso Murrieta Villegas 



Existen 2 formas de compilar este proyecto, las cuales se plantean a continuación:



**1) Compilar directamente el proyecto de Github**

El proyecto subido en github está pensado en que simplemente se ejecute dando directamente en el botón de compilar de Visual Studio:

1.1 Descargar el proyecto directamente del repositorio compartido, ya sea mediante un zip o usando el comando 

```shell
git clone <repoURL>
```

![image-20201218013442464](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20201218013442464.png)



1.2 Acceder dentro de la carpeta de **casaPersonaje** y ejecutar el archivo **\*.sln** o directamente abrir el proyecto desde Visual Studio

![image-20201218020407230](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20201218020407230.png)



1.3 Una vez dentro del proyecto asegurarse que no marque errores respecto a las bibliotecas de glew y glfw3, también asegurarse que los shader se encuentran en Resources Files, y que las 4 bibliotecas (cube.h, cone.h, cylinder.h) se encuentren incluidos en el proyecto * , y por último, asegure que en source FIles se encuentre solamente main.cpp [Ver imagen inferior]

![image-20201218020033030](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20201218020033030.png)

NOTA: En caso de marcar error respecto a las bibliotecas (Es decir que no se encuentren incluidas en el proyecto, ve directamente al **Configurar dentro del  proyecto**, paso 2.4 de este manual)



1.4 Si todo lo anterior está bien, simplemente dar click en el botón de Local windows debugger, a continuación se mostrará el dibujo obtenido tras compilar el código exitosamente (Ver el video de funcionamiento para algunas notas importantes)

![Screenshot (22)](C:\Users\alfon\OneDrive\Imágenes\Capturas de pantalla\Screenshot (22).png)



**NOTA**: Para mover la cámara dentro del entorno emplea las siguientes teclas:

'A' = movimiento a la izquierda

'D' = movimiento a la derecha

'S' = movimiento a la arriba

'W' = movimiento a la abajo





**2) Crear y compilar el proyecto**

2.1Crear un proyecto desde ceros en Visual Studio Code, de tipo "empty Project"

2.2 Mover todos los recursos del proyecto (Se incluye en el archivo *resources.rar* de el repositorio) dentro de la carpeta raíz del proyecto , de la siguiente forma

![image-20201218013943565](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20201218013943565.png)

**NOTA:** El rar incluye los shaders usados, las texturas usadas, las bibliotecas de las primitivas, además de las bibliotecas de OpenGL empleadas.



2.3 Posteriormente agregar los recursos dentro de la configuración del proyecto, el resultado debería quedar de la siguiente forma :

1. Agregar las bibliotecas en header files
2. Agregar los shader 
3. Agregar el main.cpp

Ver imagen para mayor detalle

![image-20201218014359341](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20201218014359341.png)

**NOTA**: En este paso todavía no se agregan las bibliotecas en el proyecto, por ello el IDE marca de color rojo que faltan entidades por agregar



**Configurar dentro del  proyecto**

*2.4 Agregar **include***:

![image-20201218014712683](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20201218014712683.png)



2.4 Agregar **lib:**

![image-20201118165432636](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20201118165432636.png)



*2.5 Agregar al input **SDL2.lib;SDL2main.lib;opengl32.lib;glew32.lib;glfw3.lib;*** 

![image-20201218014900629](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20201218014900629.png)



2.6 Compilar el proyecto y como resultado se observará lo siguiente:

![Screenshot (22)](C:\Users\alfon\OneDrive\Imágenes\Capturas de pantalla\Screenshot (22).png)



**NOTA**: Para mover la cámara dentro del entorno emplea las siguientes teclas:

'A' = movimiento a la izquierda

'D' = movimiento a la derecha

'S' = movimiento a la arriba

'W' = movimiento a la abajo