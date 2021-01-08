--------------------------------------------------------------------------------
--
--   FileName:         hw_image_generator.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 05/10/2013 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY hw_image_generator IS
  GENERIC(
    pixels_y :  INTEGER := 640;   --row that first color will persist until
    pixels_x :  INTEGER := 480);  --column that first color will persist until
  PORT(
    disp_ena :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    row      :  IN   INTEGER;    --row pixel coordinate
    column   :  IN   INTEGER;    --column pixel coordinate
    red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --blue magnitude output to DAC
	 
	 --Datos obtenidos de ALU
	 sal: in std_logic_vector(3 downto 0);
	 a, b     :  in   std_logic_vector(2 downto 0);
	 bus_A, bus_b, disp0,disp1,disp2: in std_logic_vector(6 downto 0)
	 
	 
	-- Unidades del contador en 7 segmentos
	 
	 ); 
END hw_image_generator;

ARCHITECTURE behavior OF hw_image_generator IS
BEGIN

  PROCESS(disp_ena, row, column,sal,a,b,bus_A,bus_B,disp0,disp1,disp2)
  BEGIN
		if (disp_ena ='1') then	
			if(sal(2)='0') then
--===================================================================================================
-- UNIDAD ARITMÉTICA / DRAWING
--===================================================================================================



--===================================================================================================
-- DISPLAY ENTRADA A
--===================================================================================================			

				if ((row >120  and row<140 ) AND (column>70 and column <100)) then 
					if(bus_A(0)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--1
				elsif ((row >140  and row<220 ) AND (column>100 and column <115)) then
					if(bus_A(1)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--2
				elsif ((row >240  and row<320 ) AND (column>100 and column <115)) then
					if(bus_A(2)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--3
				elsif ((row >320  and row<340 ) AND (column>70 and column <100)) then
					if(bus_A(3)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--4
				elsif ((row >240  and row<320 ) AND (column>55 and column <70)) then
					if(bus_A(4)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--5
				elsif ((row >140  and row<220 ) AND (column>55 and column <70) ) then
					if(bus_A(5)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--6
				elsif ((row >220  and row<240 ) AND (column>70 and column <100)) then
					if(bus_A(6)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				
--===================================================================================================
-- DISPLAY ENTRADA B
--===================================================================================================			

--=================================================
-- AUXILIARES => COMILLAS en B (Casos ceros y unos)
--=================================================

-- Selectores o sal  00 y 11
	

				--Comas B
				elsif ((row >100  and row<110 ) AND (column>180 and column <185)) then
					if((sal(1 downto 0)="11" or sal(1 downto 0)="00") and sal(2)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				elsif ((row >100  and row<110 ) AND (column>265 and column <270)) then
					if((sal(1 downto 0)="11" or sal(1 downto 0)="00") and sal(2)='0')  then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
					
--=================================================
-- AUXILIARES =>  B NEGATIVO (Casos ceros y unos)
--=================================================

-- Selectores o sal  01					
					

				elsif ((row >80  and row<100 ) AND (column>200 and column <250)) then
					if(sal(1 downto 0)="01") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				
				
				
				--0
				elsif ((row >120  and row<140 ) AND (column>210 and column <240) ) then 
					if(sal(1 downto 0)="00") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					elsif(sal (1 downto 0)="11") then
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						if(bus_B(0)='0') then
							red <= (Others =>'1');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						else
							red <= (Others =>'0');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						end if;
					end if;
				--1
				elsif ((row >140  and row<220 ) AND (column>240 and column <255)) then
					if(sal(1 downto 0)="00") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					elsif(sal (1 downto 0)="11") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						if(bus_B(1)='0') then
							red <= (Others =>'1');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						else
							red <= (Others =>'0');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						end if;
					end if;
				--2
				elsif ((row >240  and row<320 ) AND (column>240 and column <255)) then
					if(sal(1 downto 0)="00") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					elsif(sal (1 downto 0)="11") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						if(bus_B(2)='0') then
							red <= (Others =>'1');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						else
							red <= (Others =>'0');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						end if;
					end if;
				--3
				elsif ((row >320  and row<340 ) AND (column>210 and column <240)) then
					if(sal(1 downto 0)="00") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					elsif(sal (1 downto 0)="11") then
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						if(bus_B(3)='0') then
							red <= (Others =>'1');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						else
							red <= (Others =>'0');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						end if;
					end if;
				--4
				elsif ((row >240  and row<320 ) AND (column>195 and column <210)) then
					if(sal(1 downto 0)="00") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					elsif(sal (1 downto 0)="11") then
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						if(bus_B(4)='0') then
							red <= (Others =>'1');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						else
							red <= (Others =>'0');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						end if;
					end if;
				--5
				elsif ((row >140  and row<220 ) AND (column>195 and column <210) ) then
					if(sal(1 downto 0)="00") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					elsif(sal (1 downto 0)="11") then
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						if(bus_B(5)='0') then
							red <= (Others =>'1');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						else
							red <= (Others =>'0');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						end if;
					end if;
				--6
				elsif ((row >220  and row<240 ) AND (column>210 and column <240)) then
					if(sal(1 downto 0)="00") then
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					elsif(sal (1 downto 0)="11") then
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						if(bus_B(6)='0') then
							red <= (Others =>'1');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						else
							red <= (Others =>'0');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						end if;
					end if;
--===================================================================================================
-- DISPLAY RESULTADOS / DISPLAY 2 no se utiliza en unidad arimética
--===================================================================================================	
					
					
--===================================================================================================
-- DISPLAY RESULTADOS / DISPLAY 1
--===================================================================================================			
	
				
				elsif ((row >120  and row<140 ) AND (column>420 and column <450)) then 
					if(disp1(0)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--1
				elsif ((row >140  and row<220 ) AND (column>450 and column <465)) then
					if(disp1(1)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--2
				elsif ((row >240  and row<320 ) AND (column>450 and column <465)) then
					if(disp1(2)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--3
				elsif ((row >320  and row<340 ) AND (column>420 and column <450)) then
					if(disp1(3)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--4
				elsif ((row >240  and row<320 ) AND (column>405 and column <420)) then
					if(disp1(4)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--5
				elsif ((row >140  and row<220 ) AND (column>405 and column <420) ) then
					if(disp1(5)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--6
				elsif ((row >220  and row<240 ) AND (column>420 and column <460)) then
					if(disp1(6)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
					
--===================================================================================================
-- DISPLAY RESULTADOS / DISPLAY 0
--===================================================================================================			

				elsif ((row >120  and row<140 ) AND (column>500 and column <530)) then 
					if(disp0(0)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--1
				elsif ((row >140  and row<220 ) AND (column>530 and column <545)) then
					if(disp0(1)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--2
				elsif ((row >240  and row<320 ) AND (column>530 and column <545)) then
					if(disp0(2)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--3
				elsif ((row >320  and row<340 ) AND (column>500 and column <530)) then
					if(disp0(3)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--4
				elsif ((row >240  and row<320 ) AND (column>485 and column <500)) then
					if(disp0(4)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--5
				elsif ((row >140  and row<220 ) AND (column>485 and column <500) ) then
					if(disp0(5)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--6
				elsif ((row >220  and row<240 ) AND (column>500 and column <530)) then
					if(disp0(6)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
					
					
--===================================================================================================
-- SIGNOS / OPERACIONES
--===================================================================================================						
					
					
				-- igual
				elsif ((row >200  and row<220 ) AND (column>290 and column <310)) then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				elsif ((row >240  and row<260 ) AND (column>290 and column <310)) then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
					
					
				--Linea horizontal para resta y suma
				elsif ((row >225  and row<235 ) AND (column>130 and column <160)) then
					
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
				
				-- Linea vertical para suma
				elsif ((row >215  and row<245 ) AND (column>140 and column <150)) then
						if(sal(3)='0') then
							red <= (Others =>'1');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						else
							red <= (Others =>'0');
							green <= (Others =>'0');
							blue <= (Others =>'0');

						end if;
				
				else	
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			
--===================================================================================================
-- UNIDAD LÓGICA / DRAWING
--===================================================================================================


--============================================================
-- LINEAS PARA LA ENTRADA EN A
--============================================================		

			elsif(sal(2)='1') then 
			
				if ((row >120  and row<340 ) AND (column>50 and column <65)) then-- linea 2
					if(a(2)='1') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'1');
						green <= (Others =>'1');
						blue <= (Others =>'1');
					end if;
					
				elsif ((row >120  and row<340 ) AND (column>75 and column <90)) then -- linea 1
					if(a(1)='1') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'1');
						green <= (Others =>'1');
						blue <= (Others =>'1');
					end if;
					
					
				elsif ((row >120  and row<340 ) AND (column>100 and column <115)) then -- linea 0
					if(a(0)='1') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'1');
						green <= (Others =>'1');
						blue <= (Others =>'1');
					end if;
					
--============================================================
-- OPERACIONES BOOLEANAS 
--============================================================						
					
				
				
--============================================================
-- NOT O NEGADO DE A (Sólo es una linea)
--============================================================					
				elsif ((row >80  and row<100 ) AND (column>50 and column <115)) then 
					if(sal(1 downto 0)="11") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
					
					
					
				
--============================================================
-- XOR => Sólo se agrega una linea arriba del + o OR
--============================================================					
				
				elsif ((row >200  and row<210 ) AND (column>130 and column <160)) then
					if (sal(1 downto 0)="10") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					else 
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					end if;
					
					
--============================================================
-- AND / XOR / OR
--============================================================					
				
				elsif ((row >215  and row<225 ) AND (column>130 and column <140)) then -- OR
					if (sal(1 downto 0)="01") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					else 
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					end if;
				
				
				elsif ((row >215  and row<225 ) AND (column>140 and column <150)) then -- AND y XOR
					if (sal(1 downto 0)="00" or sal(1 downto 0)="10") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					else 
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					end if;
				
				
				elsif ((row >215  and row<225 ) AND (column>150 and column <160)) then -- OR
					if (sal(1 downto 0)="01") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					else 
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					end if;
				
				
				elsif ((row >225  and row<235 ) AND (column>130 and column <140)) then -- AND y XOR
					if (sal(1 downto 0)="00" or sal(1 downto 0)="10") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					else 
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					end if;
				
				
				
				elsif ((row >225  and row<235 ) AND (column>140 and column <150)) then -- CUADRO CENTRAL (XOR/AND/OR)
					if (sal(1 downto 0)/="11") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					else 
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					end if;
				
				
				
				elsif ((row >225  and row<235 ) AND (column>150 and column <160)) then -- AND y XOR
					if (sal(1 downto 0)="00" or sal(1 downto 0)="10") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					else 
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					end if;
				
				
				
				elsif ((row >235  and row<245 ) AND (column>130 and column <140)) then -- OR
					if (sal(1 downto 0)="01") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					else 
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					end if;
				
				
				
				elsif ((row >235  and row<245 ) AND (column>140 and column <150)) then -- AND y XOR
					if (sal(1 downto 0)="00" or sal(1 downto 0)="10") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					else 
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					end if;
				
				
				 
				elsif ((row >235  and row<245 ) AND (column>150 and column <160)) then -- OR
					if (sal(1 downto 0)="01") then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					else 
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');	
					end if;
				
				
				
--============================================================
-- Lineas del signo de igual
--============================================================						

				elsif ((row >200  and row<220 ) AND (column>290 and column <310)) then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				elsif ((row >240  and row<260 ) AND (column>290 and column <310)) then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
					


--============================================================
-- LINEAS PARA LA ENTRADA EN B
--============================================================							
				
				
				elsif ((row >120  and row<340 ) AND (column>200 and column <215)) then -- Linea 2
					if(sal(1 downto 0)="11") then 
						red <= (Others =>'0');
							green <= (Others =>'0');
							blue <= (Others =>'0');
					else
						if(b(2)='1') then
							red <= (Others =>'1');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						else
							red <= (Others =>'1');
							green <= (Others =>'1');
							blue <= (Others =>'1');
						end if;
					end if;
					
				elsif ((row >120  and row<340 ) AND (column>230 and column <245)) then -- Linea 1
					if(sal(1 downto 0)="11") then 
						red <= (Others =>'0');
							green <= (Others =>'0');
							blue <= (Others =>'0');
					else
						if(b(1)='1') then
							red <= (Others =>'1');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						else
							red <= (Others =>'1');
							green <= (Others =>'1');
							blue <= (Others =>'1');
						end if;
					end if;
					
				elsif ((row >120  and row<340 ) AND (column>260 and column <275)) then -- Linea 0 
					if(sal(1 downto 0)="11") then 
						red <= (Others =>'0');
							green <= (Others =>'0');
							blue <= (Others =>'0');
					else
						if(b(0)='1') then
							red <= (Others =>'1');
							green <= (Others =>'0');
							blue <= (Others =>'0');
						else
							red <= (Others =>'1');
							green <= (Others =>'1');
							blue <= (Others =>'1');
						end if;
					end if;
				
				
				
				
--===================================================================================================
-- DISPLAY RESULTADOS / DISPLAY 2
--===================================================================================================			

				elsif ((row >120  and row<140 ) AND (column>350 and column <380)) then 
					if(disp2(0)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--1
				elsif ((row >140  and row<220 ) AND (column>380 and column <395)) then
					if(disp2(1)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--2
				elsif ((row >240  and row<320 ) AND (column>380 and column <395)) then
					if(disp2(2)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--3
				elsif ((row >320  and row<340 ) AND (column>350 and column <380)) then
					if(disp2(3)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--4
				elsif ((row >240  and row<320 ) AND (column>335 and column <350)) then
					if(disp2(4)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--5
				elsif ((row >140  and row<220 ) AND (column>335 and column <350) ) then
					if(disp2(5)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--6
				elsif ((row >220  and row<240 ) AND (column>350 and column <380)) then
					if(disp2(6)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
					
					
--===================================================================================================
-- DISPLAY RESULTADOS / DISPLAY 1
--===================================================================================================			

				
				elsif ((row >120  and row<140 ) AND (column>420 and column <450)) then 
					if(disp1(0)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--1
				elsif ((row >140  and row<220 ) AND (column>450 and column <465)) then
					if(disp1(1)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--2
				elsif ((row >240  and row<320 ) AND (column>450 and column <465)) then
					if(disp1(2)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--3
				elsif ((row >320  and row<340 ) AND (column>420 and column <450)) then
					if(disp1(3)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--4
				elsif ((row >240  and row<320 ) AND (column>405 and column <420)) then
					if(disp1(4)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--5
				elsif ((row >140  and row<220 ) AND (column>405 and column <420) ) then
					if(disp1(5)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--6
				elsif ((row >220  and row<240 ) AND (column>420 and column <460)) then
					if(disp1(6)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
					
					
--===================================================================================================
-- DISPLAY RESULTADOS / DISPLAY 0
--===================================================================================================			

				elsif ((row >120  and row<140 ) AND (column>500 and column <530)) then 
					if(disp0(0)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--1
				elsif ((row >140  and row<220 ) AND (column>530 and column <545)) then
					if(disp0(1)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--2
				elsif ((row >240  and row<320 ) AND (column>530 and column <545)) then
					if(disp0(2)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--3
				elsif ((row >320  and row<340 ) AND (column>500 and column <530)) then
					if(disp0(3)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--4
				elsif ((row >240  and row<320 ) AND (column>485 and column <500)) then
					if(disp0(4)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--5
				elsif ((row >140  and row<220 ) AND (column>485 and column <500) ) then
					if(disp0(5)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				--6
				elsif ((row >220  and row<240 ) AND (column>50 and column <530)) then
					if(disp0(6)='0') then
						red <= (Others =>'1');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					else
						red <= (Others =>'0');
						green <= (Others =>'0');
						blue <= (Others =>'0');
					end if;
				
					
				else	
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;

			end if;
			
			
	
			
		end if;
		
  END PROCESS;  
END behavior;
