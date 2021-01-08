# Universidad Nacional Autónoma de México

## Prototipos de Interfaces Primer Etapa



**Alumno**: Alfonso Murrieta Villegas



## **Marco de referencia**

1. **Odometría**: Es el estudio de la estimación de la posición de vehículos con ruedas durante la navegación

2. **Teleoperación**: Es el área de la robótica concerniente al control de robots desde la distancia, principalmente a través conexiones de tipo wireless
3. **Mapping generation o SLAM**: Por sus siglas en inglés *simultaneous localization and mapping*, es una de las técnicas más comúnmente utilizadas en robots para construir o recrear mapas de un ambiente o entorno desconocido.
4. **LIDAR**: Por sus siglas en inglés "Light Detection and Ranging", es un sensor comúnmente empleado para poder medir distancias a través del uso del rebote de rayos de luz emitidos por el mismo.



## **Descripción General** 

Uno de los mayores retos dentro de la robótica es el poder manipular o "teleoperar" un robot de forma que resulte fácil para el operador, sin embargo, además de plantear una forma cómoda de mapear los botones o forma de interactuar con un robot, también hay retos muy complejos y relacionados con la teleoperación como es el caso principal de la visión.

El presente trabajo consiste en el planteamiento de un prototipo con el objetivo de facilitar la visión y teleoperación de robots de tipo rescue o rescate además de plantear una nueva forma de interactuar con la generación de ambiente recreada mediante SLAM, específicamente a través de un lidar.



## **Funcionalidad** 

Uno de los muchos objetivos de la robótica es el poder facilitar el acceso a entornos donde el ser humano no es capaz de acceder o que resultan peligrosos para la seguridad e integridad de los mismos. El objetivo de este prototipo de interfaz es el facilitar y juntar las principales tecnologías relacionadas con la robótica de tipo recate:

1. *Odometría* 
2. *Teleoperación*
3. *Mapping Generation o SLAM* 
4. *Realidad mixta*

Para posteriormente poder conjuntarlas y facilitar las diferentes acciones que hasta  hoy en día resultan complejas de realizar y que en los mejores casos siguen en desarrollo dentro de la industria de la robótica.



## **Componente y descripción general del proyecto**

Para poder describir a mayor detalle la propuesta de este modelo a continuación se explica sus dos principales componentes o fases  y cómo es que ambos se piensan integrar.



#### **1. Fase de Mapping Generation y SLAM** 

La primera parte que debemos entender es que al teleoperar un robot debemos de una u otra forma relacionarnos con el ambiente donde se encuentra, para ello existen muchas formas de poder conocer los objetos o las caracteristicas del ambiente que rodea a nuestro robot es el caso de:

- Streaming de video mediante el uso de cámaras:

![image-20201208221325370](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20201208221325370.png)

*Imagen 1: Minuto 9:05 del video 1 de las referencias*



- Uso de ténicas como el SLAM a través de sensores como LIDARs para la recreación del ambiente desconocido o con poca luz:

![image-20201208221520834](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20201208221520834.png)

*Imagen 2: Minuto 7:45 del video 2 de las referencias*



**NOTA**: El generar un mapa incluso aunque haya buena visión mediante streaming no sólo tiene el objetivo de conocer nuestro entorno sino también de poder tenerlo almacenado como una forma de futura interacción



#### **2. Fase  de "Realidad Mixta a través de SLAM y visión mediante streaming de cámaras"**

En el punto anterior se plantea el cómo hay distintas formas de ver o de relacionarnos con el entorno en el que se encuentra o explora un robot pero de una u otra forma tenemos ambas propuesta de forma aislada y con muy poca interacción, la propuesta de este proyecto es que mediante el uso de Realidad Mixta se pueda:



1. Poder plantear una nueva forma de poder mover las cámaras del robot a través de la interacción de gafas de realidad virtual conectadas directamente con los servomotores de las cámaras de los robots

![image-20201208222945301](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20201208222945301.png)

*Imagen 3: Minuto 0:10 del video 3 de las referencias*

NOTA: Revisar el video para poder entender la relación "movimiento cabeza" respecto a "Movimiento de las cámaras del robot"



2. En caso de no disponer con suficiente luz, tener un mucho ruido o simplemente no disponer del streaming de video , disponer de los datos generados mediante el SLAM para poder recrear el ambiente a través de realidad aumentada con las mismas gafas  (En este caso, se plantea un boceto debido a que no he encontrado alguna referencia de la unión del SLAM )

| Realidad Virtual - Mediante Streaming                        | Realidad Virtual- Mediante SLAM (Ambiente sin luz)           |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![image-20201208232518126](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20201208232518126.png) | ![image-20201208233923996](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20201208233923996.png) |

*Imagen 4 y 5*: Bocetos de realidad virtual integrados con Mapping Generation (SLAM), tanto en en ambientes iluminados (Imagen izquierda) empleando a su vez streaming de video, como en ambientes no iluminados empleando solamente el mapa generado mediante el SLAM pero integrando a su vez realidad aumentada para pseudo generar objetos en los entornos



**NOTA**: La generación de objetos en la realidad virtual es sólo una propuesta extra debido a que todo lo demás si existe y es meramente el integrarlo en una misma entidad



**Referencias**

1. Virtual Reality Robot. Synthiam. Recuperado el 8 de diciembre de 2020, de https://youtu.be/Aw85LbP2dds

2. Final Mission at Robocup German Open 2013 Rescue Robot League competition.Team Hector Darmstadt. Recuperado el 8 de diciembre de 2020, de https://youtu.be/PKI378kadp8
3. Virtual Reality Robot Plugin. Synthiam. Recuperado el 8 de diciembre de 2020, dehttps://youtu.be/qm-tv0TkKjg

3. TU Darmstadt's Computer Science and Mechanical Engineering Departments. hector_slam. ROS.org. Recuperado el 12 de diciembre de 2020, de http://wiki.ros.org/hector_slam



