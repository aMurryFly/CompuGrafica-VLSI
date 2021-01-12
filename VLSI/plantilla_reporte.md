# Universidad Nacional Autónoma de México 

## Proyecto Final - A Basic Asteroids Arcade Game

**Alumno:** Afonso Murrieta Villegas

**Profesora**: Elizabeth Fonseca C.

## Objetivos 



1.  Desarrollar un nuevo controlador y generador de imagen para archivos cargados en memoria tipo miff
2.  Emplear el puerto VGA para poder desplegar los datos cargados en archivos externos 
3.  Emplear todo lo visto en Diseño VLSI para poder desarrollar un videojuego

## Introducción 

La Asteroids es uno de los videojuego de tipo arcade más populares que es muy conocido por ser uno de los pioneros dentro del desarrollo y creatividad de videojuegos. A la versión del juego a la que se le atribuye el nombre, fue desarrollada en 1979 por Atari y su principal objetivo y lógica de juego es destruir la mayor cantidad de asteroides evitando por un lado chocar con los asteroides y por otro, evitar los fragmentos de los asteroides una vez colisionados con los proyectiles de la nave.

## Desarrollo 

De manera general este proyecto comprende varias tecnologías o entidades en código VHDL para poder hacer posible por un lado el guardado de las imágenes en formato mif, posteriormente ser precargadas en memoria de tipo ROM y de esa forma poder ser visualizadas a través de un generador de imagen conectado con un controlador del puerto VGA.

Dicho lo anterior, el código  y forma en que se pudo realizar cada una de las entidades previas, será explicado a detalle en el apartado del anexo.

## Conclusión 

Como resultado final se obtuvo una representación sencilla pero llamativa de *asteroids*, a pesar de que el juego tiene algunos bugs visuales debido a lo poco optimizado que es el renderizar la imagen de la ROM al mismo tiempo que se está cargando visualmente, cabe destacar que es bastante jugable.

Una muy buena práctica a futuro para el desarrollo de videojuegos arcades mediante el lenguajes de descripción de hardware es el considerar un procesador de imagen que haga el despliegue de cada uno de los pixeles empleando el paralelismo.

## Referencias  

1. De10-lite manual. Recuperado el 6 de enero de 2021, de https://www.intel.com/content/dam/www/programmable/us/en/portal/dsn/42/doc-us-dsnbk-42-2912030810549-de10-lite-user-manual.pdf
2. Fonseca E. (2020) VGA 3. Recuperado el 6 de enero de 2021, de
   https://youtu.be/dDPRDm7rY7Y

## ANEXO   

#### NOTA :

Uno de los detalles que previamente se tuvo al momento de emplear archivos miff para el despliegue de imágenes, fue que la forma en que se hacía el barrido de la información dentro del generador de imagen se hacia en forma absoluta y no relativa, es decir que la imagen realmente se pintaba en toda la pantalla solo que se hacía visualizar una pequeña fracción de esta información, en cambio al remover el controlador-adaptador de mif a VGA se replanteó el emplear directamente la información de la direcciones de memoria en cada una de las variables relativas que se hicieron para cada una de las entidades que se dibujaron (Tanto la nave espacial como los asteroides)

#### Lógica del juego y Cartas ASM :

1. **Lógica del juego y limitaciones del proyecto**

Para el desarrollo del juego no se consideraron algunas características que son parte de cualquier asteroids, que a continuación se mencionarán:

- Los movimientos de los asteroides son en una sola dirección
- La nave no se mueve sobre el eje de las x
- la cantidad de asteroides está fijada además de que una vez que se han eliminado todos los asteroides se gana el juego, lo cual no es parte de los tradicionales asteroids que lo que realmente sucede en estos es que mientras más asteroides se destruyen se crean más asteroides pequeños.

Como parte de las reglas del juego, solo se cuenta con una vida debido a que una vez que un asteroide choca con la nave esta directamente es destruida (Desaparece del juego), por otro lado, una vez que se destruyen todos los asteroides, estos directamente se destruyen (Desaparecen) y al no haber ningún asteroide se muestra un pequeño mensaje diciendo "win"

2. **Cartas ASM de la lógica**

Para poder desarrollar el juego fue necesario emplear distintos diagramas y herramientas visuales para poder llevar acabo la abstracción de la lógica del juego en componentes de vhdl:

A continuación la lógica del juego representada mediante una Carta ASM donde se observa la interacción entre las variables de los asteroides y de la nave:

![Untitled Diagram(1)](C:\Users\alfon\Downloads\Untitled Diagram(1).png)

Por último y como parte fundamental de cualquier proyecto, a continuación se muestra un diagrama de componentes que hace uso de la lógica Orientada a Objetos:

#### Proyecto en Quartus y descripción del código:

Para poder comprender todo el proyecto es necesario dividir el proyecto en 3 partes principales, por un lado la parte conocida y que previamente se ha usado en otros proyectos que está consituida por 3 archivos principales, un reloj lento, un divisor de frecuencia y el controlador vga, por otro lado la segunda parte es la constituida por un solo archivo que esl el generador de imagen que además de dibujar cada entidad a través de sus 5 procesos realiza varias tareas que posteriormente serán descritas y por último, tenemos nuestro archivo TOP que meramente se encargará de instanciar y llamar cada una de las partes previas.



1. **Códigos Genéricos**  *(genMhz, vga_controler,relojLento)*

Para este apartado, debido a que previamente se han usado estos códigos, explicaré cómo es que funcionan y están integrados dentro del proyecto:

*1.1 genMhz*

Esta entidad sirve para sincronizar las entidades del proyecto a través del valor modificado del reloj de nuestra FPGA, a conti uación el código de la entidad:

```vhdl
library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;

entity genMhz is port(
	clk50mhz: in std_logic;
	clk25mhz: buffer std_logic:= '0' 
);
end genMhz;

architecture arqgenMhz of genMhz is
begin

	process(clk50mhz)
		begin
			if(clk50mhz' event and clk50mhz='1') then
				clk25mhz<= not clk25mhz;
			end if;
	end process;
	
end arqgenMhz;
```

*1.2 vga_controller*

En el caso de este archivo de VHDl, el úncio uso que tiene es ser la conexión entre nuestro generador de imagen respecto a nuestra pantalla o display que mostrará todo lo dibujado. Cabe destacar que este controlador fue diseñado por digi-key y es de uso libre, además no fue modificado para el desarrollo de este proyecto:

```vhdl

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY vga_controller IS
  GENERIC(
    h_pulse  :  INTEGER   := 96;   --horiztonal sync pulse width in pixels
    h_bp     :  INTEGER   := 48;   --horiztonal back porch width in pixels
    h_pixels :  INTEGER   := 640;  --horiztonal display width in pixels
    h_fp     :  INTEGER   := 16;   --horiztonal front porch width in pixels
    h_pol    :  STD_LOGIC := '0';   --horizontal sync pulse polarity (1 = positive, 0 = negative)
    v_pulse  :  INTEGER   := 2;     --vertical sync pulse width in rows
    v_bp     :  INTEGER   := 33;    --vertical back porch width in rows
    v_pixels :  INTEGER   := 480;  --vertical display width in rows
    v_fp     :  INTEGER   := 10;     --vertical front porch width in rows
    v_pol    :  STD_LOGIC := '0');  --vertical sync pulse polarity (1 = positive, 0 = negative)
  
  PORT(
    pixel_clk :  IN   STD_LOGIC;  --pixel clock at frequency of VGA mode being used
    reset_n   :  IN   STD_LOGIC;  --active low asycnchronous reset
    h_sync    :  OUT  STD_LOGIC;  --horiztonal sync pulse
    v_sync    :  OUT  STD_LOGIC;  --vertical sync pulse
    disp_ena  :  OUT  STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    column    :  OUT  INTEGER;    --horizontal pixel coordinate
    row       :  OUT  INTEGER);--;    --vertical pixel coordinate
    --n_blank   :  OUT  STD_LOGIC;  --direct blacking output to DAC
    --n_sync    :  OUT  STD_LOGIC); --sync-on-green output to DAC
END vga_controller;

ARCHITECTURE behavior OF vga_controller IS
  CONSTANT  h_period  :  INTEGER := h_pulse + h_bp + h_pixels + h_fp;  --total number of pixel clocks in a row
  CONSTANT  v_period  :  INTEGER := v_pulse + v_bp + v_pixels + v_fp;  --total number of rows in column
BEGIN

  --n_blank <= '1';  --no direct blanking
  --n_sync <= '0';   --no sync on green
  
  PROCESS(pixel_clk, reset_n)
    VARIABLE h_count  :  INTEGER RANGE 0 TO h_period - 1 := 0;  --horizontal counter (counts the columns)
    VARIABLE v_count  :  INTEGER RANGE 0 TO v_period - 1 := 0;  --vertical counter (counts the rows)
  BEGIN
  
    IF(reset_n = '0') THEN  --reset asserted
      h_count := 0;         --reset horizontal counter
      v_count := 0;         --reset vertical counter
      h_sync <= NOT h_pol;  --deassert horizontal sync
      v_sync <= NOT v_pol;  --deassert vertical sync
      disp_ena <= '0';      --disable display
      column <= 0;          --reset column pixel coordinate
      row <= 0;             --reset row pixel coordinate
      
    ELSIF(pixel_clk'EVENT AND pixel_clk = '1') THEN

      --counters
      IF(h_count < h_period - 1) THEN    --horizontal counter (pixels)
        h_count := h_count + 1;
      ELSE
        h_count := 0;
        IF(v_count < v_period - 1) THEN  --veritcal counter (rows)
          v_count := v_count + 1;
        ELSE
          v_count := 0;
        END IF;
      END IF;

      --horizontal sync signal
      IF(h_count < h_pixels + h_fp OR h_count > h_pixels + h_fp + h_pulse) THEN
        h_sync <= NOT h_pol;    --deassert horiztonal sync pulse
      ELSE
        h_sync <= h_pol;        --assert horiztonal sync pulse
      END IF;
      
      --vertical sync signal
      IF(v_count < v_pixels + v_fp OR v_count > v_pixels + v_fp + v_pulse) THEN
        v_sync <= NOT v_pol;    --deassert vertical sync pulse
      ELSE
        v_sync <= v_pol;        --assert vertical sync pulse
      END IF;
      
      --set pixel coordinates
      IF(h_count < h_pixels) THEN  --horiztonal display time
        column <= h_count;         --set horiztonal pixel coordinate
      END IF;
      IF(v_count < v_pixels) THEN  --vertical display time
        row <= v_count;            --set vertical pixel coordinate
      END IF;

      --set display enable output
      IF(h_count < h_pixels AND v_count < v_pixels) THEN  --display time
        disp_ena <= '1';                                  --enable display
      ELSE                                                --blanking time
        disp_ena <= '0';                                  --disable display
      END IF;

    END IF;
  END PROCESS;

END behavior;
```

*1.3 relojLento*

Al igual que la entidad del divisor de frecuencia, hace uso del reloj interno de nuestra FPGA, solo con la diferencia que en este caso se usa para hacer conteos dentro de nuestra entidad hw_image_generator, específicamente para contar las vidas de nuestra nave o para saber si están o no destruidos los asteroides:

```vhdl
library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;


entity relojlento is port(
	clkl: in std_logic;
	led: buffer std_logic:= '0' 
);
end relojlento;

architecture arqrelojlento of relojlento is

signal conteo: integer range 0 to 1000000;

begin
	process(clkl)
	 begin
	  if(clkl' event and clkl='1') then
		  conteo<=conteo+1;
			 if(conteo=1000000) then
				 conteo<=0;
				 led<=not(led);
			 end if;
		end if;
	 end process;
end arqrelojlento;
```



2. **Generador de imagen y lógica principal del juego** *(hw_image_generator)*

Como bien se menciona en la nota superior de este documento, uno de los mayores retos del proyecto fue el poder realizar  una correcta visualización de la imagen en formato mif mediante el generador de imagen, por lo que a pesar de que esta entidad se encarga de realizar las siguientes tareas:

1. Manejar un reloj interno para el movimiento de la nave
2.  Un contador interno para la vida tanto de los asteroides como de la nave
3. Un deslizador o entidad de desplazamiento ciclico de los asteroides
4. El dibujado de todas las entidades en nuestro monitor

No está mal realizar en el sentido de hacer un código secuencial sino todo en paralelo mediante procedimientos, por ello a continuación se muestran cada uno de los procedimientos además del puerto, variables y señales de nuestra entidad:

**2.1 Puerto del generador de imagen:**

Para el manejo de esta entidad de forma general podemos separar todos los puertos en 3 apartados principales:

1. Los genéricos que son meramente las dimensiones de la pantalla
2. Las características y datos necesarios para el controlador del VGA
3. Y los datos de entrada  que necesita  la lógica del juego 

```vhdl
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY hw_image_generator IS

  GENERIC(
    pixels_y :  INTEGER := 640; 
    pixels_x :  INTEGER := 480
	 );
	 
  PORT(
    disp_ena :  IN   STD_LOGIC;  
    row      :  IN   INTEGER;   
    column   :  IN   INTEGER;    
    red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  
    green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0'); 
    blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	 
	 --Entradas para la lógica del juego
	 dipsw    :  in std_logic_vector (1 downto 0);
	 button   :  in std_logic;
	 reloj    :  in std_logic
	); 
	 
END hw_image_generator;
```



**2.2 Proceso de movimiento de la nave**

Para este apartado se hace uso del reloj de la FPGA además de verificar los estados en los que se encuentran los datos de entrada:

```vhdl

-- MOVIMIENTO SPACESHIP
PROCESS(reloj, dipsw)
  BEGIN
  
  		--MOVIMIENTO HACIO ABAJO		
		IF( reloj'EVENT AND reloj='1') THEN
			IF(dipsw(1)='0' AND dipsw(0)='1') THEN
					IF(x>10 and x<420) THEN
						x<=x-2;
						y<=y;
					ELSE
						x<=x+2;
					END IF;
			
			--MOVIMIENTO HACIO ABAJO		
			ELSIF ( dipsw(1)='0' AND dipsw(0)='0') THEN 
					IF(x>10 and x<420) THEN
						y<=y;
						x<=x+2;
					ELSE
						x<=x-2;
					END IF;
			END IF;
		END IF;
		
END PROCESS;
```

**2.3 Proceso para el "Daño y disparos de la nave"**

Este proceso es el encargado de llevar a cabo la lógica detrás de los disparos además del desaparecer ya sea la nave o los asteroides una vez que sean destruidos,, cabe destacar que para que la nave sea destruida basta con chocar con los asteroides mientras que en el caso de los asteroides necesitan ser destruidos por un disparo de la nave.

```vhdl

PROCESS(reloj,button)
  BEGIN
		IF( reloj'EVENT AND reloj='1') THEN	
			
			-- SHPACE SHIP SHOT LOGIC
				IF(boxCol='1' AND button = '0' and lives>0) THEN
					dx<=x+25;
					dy<=y+28;
					boxCol<='0';
					
				ELSIF(boxCol='0') THEN
					IF(dy>10) THEN
						dy<=dy+10;
				END IF;
				
			--ASTEROIDES LOGIC
				--1
				IF((dx>=dx1 AND dx<=dx1+50) AND (dy>=dy1 AND dy<=dy1+50) AND flagLive1='1') THEN
					boxCol <='1';
					flagLive1 <='0';
					asteroid<=asteroid-1;
					
				--2
				ELSIF((dx>=dx2 AND dx<=dx2+50) AND (dy>=y2 AND dy<=y2+50) AND flagLive2='1') THEN
					boxCol <='1';
					flagLive2 <='0';
					asteroid<=asteroid-1;
					
				--3
				ELSIF((dx>=dx3 AND dx<=dx3+50) AND (dy>=y3 AND dy<=y3+50) AND flagLive3='1') THEN
					boxCol <='1';
					flagLive3 <='0';
					asteroid<=asteroid-1;
					
				--4
				ELSIF((dx>=dx4 AND dx<=dx4+50) AND (dy>=y4 AND dy<=y4+50) AND flagLive4='1') THEN
					boxCol <='1';
					flagLive4 <='0';
					asteroid<=asteroid-1;
					
					
				ELSIF (dy>=670 ) THEN
					boxCol <='1';

				END IF;
			END IF;
		END IF;
  END PROCESS;
```



**2.4 Proceso para el movimiento de los asteroides**

En este proceso se definen las siguientes características del movimiento de los asteroides:

1. La velocidad con la que se desplazaran en el display 
2. La posición inicial y final en la que se dibujarán para posteriormente ser desplazados
3. La dirección en la que serán desplazados los asteroides

Partiendo de lo anterior, a continuación se muestra el proceso encargado de toda esta lógica de juego:

```vhdl
-- MOVIMIENTO ASTEROIDS 
PROCESS(reloj)
  BEGIN
		IF( reloj'EVENT AND reloj='1') THEN	
			
		--Asteroide 1
			--Initial pos
			IF(boxCol1='1' and flagLive1='1') THEN
				dx1<=10;
				dy1<=630;
				boxCol1<='0';
			ELSIF(boxCol1='0') THEN
			-- Velocidad
				IF(dy1>10) THEN
					dy1<=dy1-3;
				END IF;
			--Colision Box
				IF((dx1+25>=x+5 AND dx1+25<=X+50) AND (dy1+25>=y+5 AND dy1+25<=y+45)) THEN
						boxCol1 <='1';
						lives <=lives-1;
				ELSIF (dy1<20 AND flagLive1='1' ) THEN
						boxCol1 <='1';
				END IF;
			END IF;
			
			... -- Misma lógica para cada asteroide
			

		END IF;
  END PROCESS;						
```



**2.5 Proceso para el dibujado de cada entidad**

Por último y como parte final de esta entidad, se realiza el trazado o mapeado de cada entidad a través de lo que previamente conociamos como el generador de imagen, este procedimiento solo se encarga del dibujado a través de las coordenadas relativas que de se tiene de cada entidad:

```vhdl

--DRAW MIF 
 PROCESS(disp_ena, row, column)

  BEGIN
	IF(disp_ena = '1') THEN 
	

		--SPACE SHIP ROOM TO IMAGE REFERENCE
		IF((row >=x  and row <=x+50) AND (column >=y and column <= y+50) AND lives>0) THEN
			direccion<= ((row-x)*50)+(column-y);	
			pixel3<= mem_n(direccion) (7 downto 4);
			
			red <= pixel3;
			green <= pixel3;
			blue <= pixel3;
		
		
		-- disparo nave 
		ELSIF((row >=dx-2  and row <=dx+2) AND (column >=dy-2 and column <=dy+2) AND (boxCol='0')) THEN
			red <= (OTHERS => '1');
			green <= (OTHERS => '1');
			blue <= (OTHERS => '1');
		
		
	
		-- ASTEROIDE 1
		ELSIF((row >=dx1  and row <=dx1+50) AND (column >=dy1 and column <=dy1+50) AND (boxCol1='0') AND flagLive1='1') THEN
			direccion<= ((row-dx1)*50)+(column-dy1);	
			pixel<= mem_sp(direccion) (7 downto 4);
			red <= pixel;
			green <= pixel;
			blue <= pixel;

	-- ... Se repite lo mismo para cada entidad del videojuego
	
	--blanking time
	 ELSE 
		red <= (OTHERS => '0');
		green <= (OTHERS => '0');
		blue <= (OTHERS => '0');
	 END IF;
END IF;

END PROCESS;       
```

Cabe destacar que la gran diferencia respecto a lo que se había realizado previamente fue el directamente asignar la información traida de memoria ROM  a coordenadas relativas para el trazado de la imagen.



3. **Top del proyecto**

Al igual que todos los proyectos previamente realizados, la entidad TOp tiene la única funcionalidad de poder relacionar entidades a través de la modularidad de código, a continuación se muestra la entidad Top de este proyecto, que además es relevante debido a que es en esta entidad donde se puede apreciar todas las variables y puertos empelados para el funcionamiento total:

```vhdl
library ieee;
use ieee.std_logic_1164.all;

ENTITY TOP IS
PORT(
	--salida a VGA
    input_clk:  in   STD_LOGIC; 
	 pixel_clk:  buffer   STD_LOGIC;
	 red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0'); 
    green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  
    blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	 h_sync   :  OUT  STD_LOGIC;  
    v_sync   :  OUT  STD_LOGIC; 
	 
	 -- Para el juego 
    dipsw    :  in std_logic_vector (1 downto 0); -- movimiento
	 button   : in std_logic --disparo
	 );

END TOP;

ARCHITECTURE arqTOP OF TOP IS
signal pix_clock: std_logic;
signal disp_ena: std_logic;
signal column:  INTEGER;
signal row:  INTEGER;
signal reloj    :  std_logic;


BEGIN
	
	relojLento: entity work.relojlento(arqrelojlento) port map(input_clk,reloj);
	divFrec: entity work.genMhz(arqgenMhz) port map(input_clk,pixel_clk);
	
	vgaControl: entity work.vga_controller(behavior) port map(pixel_clk,
																		'1',
																		h_sync,
																		v_sync,
																		disp_ena,
																		column,
																		row);--,
																		--n_blank,
																		--n_sync);
	
	gameLogic: entity work.hw_image_generator(behavior) port map(disp_ena,
																			row,
																			column,
																			red,
																			green,
																			blue,
																			dipsw,
																			button,
																			reloj
																			);

END ARCHITECTURE arqTOP;
```



#### Diagrama RTL :

Como previamente se explicó en cada una de las entidades en VHDL, realmente el proyecto está conformado de muy pocas conexiones, y esto se debe a que realmente la entidad encargada de generar la imagen (hw_imgae_generator) realiza bastantes tareas a través de todos sus procesos, por un lado, el mapeo de cada uno de los  archivos mif como imágenes, por otro lado la lógica del juego (Desde las cajas de colición hasta la limitación de los movimientos) y por último, el dibujo en la pantalla mediante el controlador VGA. A continuación se muestra las relaciones o conexiones entre entidades mediante el diagrama RTL obtenido mediante Quartus:

![image-20210105234245488](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20210105234245488.png)



Por último, a continuación se muestra unavista general de la entidad hw_image_generator, la cual al contar de varios procesos realmente hace compleja la visibilidad de esta entidad mediante el RTL:

![image-20210105234736417](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20210105234736417.png)



Cabe destacar que recordemos que cada procedimiento como bien se describió previamente se encarga de realizar varias tareas en paralelo como son el cargado de imagen, la lógica del juego y el despliegue y dibujado en la pantalla mediante el puerto VGA

#### Funcionamiento en FPGA:

A continuación se muestran las imágenes utilizadas en el proyecto , además de alguans capturas de pantalla del funcionamiento y de las acciones dentro del videojuego :

| Estado en el que se encuentra el juego                       | Captura de pantalla (Evidencia en Display)                   |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Resultado obtenido una vez que se han destruido todos los asteroides (*Fin del juego, una vez que se ha ganado*) | ![image-20210106124850044](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20210106124850044.png) |
| Resultado obtenido una vez que la nave fue destruida  por algún asteroide (*Fin del juego una vez que se ha perdido*) | ![image-20210106125308863](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20210106125308863.png) |
| Jugador empezando el juego, se aprecia el movimiento de los asteroides y el desplazamiento de la nave para ya sea evadirlos o empezar a disparar a los asteroides | ![image-20210106125358785](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20210106125358785.png) |
| Disparo de la nave y destrucción del asteroide               | ![image-20210106125642972](C:\Users\alfon\AppData\Roaming\Typora\typora-user-images\image-20210106125642972.png) |

**NOTA**: Como forma complementaria para el funcionamiento de este proyecto, se recomienda ver el video de explicación y evidencia del proyecto.
