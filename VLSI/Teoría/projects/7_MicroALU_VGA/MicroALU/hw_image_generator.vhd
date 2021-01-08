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
   pixels_y :  INTEGER := 478;   --row that first color will persist until
   pixels_x :  INTEGER := 600);  --column that first color will persist until
  PORT(
    disp_ena :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    row      :  IN   INTEGER;    --row pixel coordinate
    column   :  IN   INTEGER;    --column pixel coordinate
	 
    red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	 
	 disp0, disp1,disp2,disA, disB,leddecode,ledfetch: in std_logic_vector(6 downto 0)
	 );
    
	 END hw_image_generator;

ARCHITECTURE behavior OF hw_image_generator IS

signal b,d0,d1,d2: integer range 0 to 600;
BEGIN
b<=120;
d2<=280;
d1<=360;
d0<=440;

	PROCESS(disp_ena, row, column, disp0, disp1,disp2,disA, disB,ledfetch,leddecode)
		BEGIN
		IF(disp_ena = '1') THEN 
-- ======================================================	
-- ENTRADA A
-- ======================================================	
			if ((row >120  and row<140 ) AND (column>70 and column <100)) then 
				if(disA(0)='0') then
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
				if(disA(1)='0') then
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
				if(disA(2)='0') then
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
				if(disA(3)='0') then
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
				if(disA(4)='0') then
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
				if(disA(5)='0') then
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
				if(disA(6)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
				
-- ======================================================	
-- ENTRADA OPERACIONES
--======================================================	
			--0
			elsif ((row >410 and row<420 ) AND (column>40 and column <50)) then 
				if(ledfetch(0)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
				
			--1
			elsif ((row >420  and row<430 ) AND (column>50 and column <60)) then
				if(ledfetch(1)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--2
			elsif ((row >440  and row<450 ) AND (column>50 and column <60)) then
				if(ledfetch(2)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--3
			elsif ((row >450  and row<460 ) AND (column>40 and column <50)) then
				if(ledfetch(3)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--4
			elsif ((row >440  and row<450 )  AND (column>30 and column <40)) then
				if(ledfetch(4)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--5
			elsif ((row >420  and row<430 ) AND (column>30 and column <40) ) then
				if(ledfetch(5)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--6
			elsif ((row >430  and row<440 ) AND (column>40 and column <50)) then
				if(ledfetch(6)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
				
-- ======================================================	
-- ENTRADA B
-- ======================================================	
			elsif ((row >120  and row<140 ) AND (column>70+b and column <100+b)) then 
				if(disB(0)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--1
			elsif ((row >140  and row<220 ) AND (column>100+b and column <115+b)) then
				if(disB(1)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--2
			elsif ((row >240  and row<320 ) AND (column>100+b and column <115+b)) then
				if(disB(2)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--3
			elsif ((row >320  and row<340 ) AND (column>70+b and column <100+b)) then
				if(disB(3)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--4
			elsif ((row >240  and row<320 ) AND (column>55+b and column <70+b)) then
				if(disB(4)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--5
			elsif ((row >140  and row<220 ) AND (column>55+b and column <70+b) ) then
				if(disB(5)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--6
			elsif ((row >220  and row<240 ) AND (column>70+b and column <100+b)) then
				if(disB(6)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
				

-- ======================================================	
-- IGUAL
-- ======================================================	
			
			elsif ((row >210  and row<220 ) AND (column>270 and column <300)) then
				if(disB(6)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
				
			elsif ((row >240  and row<250 ) AND (column>270 and column <300)) then
				if(disB(6)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
				
-- ======================================================	
-- Display 0
-- ======================================================	
			elsif ((row >120  and row<140 ) AND (column>70+d0 and column <100+d0)) then 
				if(disp0(0)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--1
			elsif ((row >140  and row<220 ) AND (column>100+d0 and column <115+d0)) then
				if(disp0(1)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--2
			elsif ((row >240  and row<320 ) AND (column>100+d0 and column <115+d0)) then
				if(disp0(2)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--3
			elsif ((row >320  and row<340 ) AND (column>70+d0 and column <100+d0)) then
				if(disp0(3)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--4
			elsif ((row >240  and row<320 ) AND (column>55+d0 and column <70+d0)) then
				if(disp0(4)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--5
			elsif ((row >140  and row<220 ) AND (column>55+d0 and column <70+d0)) then
				if(disp0(5)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--6
			elsif ((row >220  and row<240 ) AND (column>70+d0 and column <100+d0)) then
				if(disp0(6)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;

				
-- ======================================================	
-- DISPLAY 1
-- ======================================================					
			--0
			elsif ((row >120  and row<140 ) AND (column>70+d1 and column <100+d1)) then 
				if(disp1(0)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--1
			elsif ((row >140  and row<220 ) AND (column>100+d1 and column <115+d1)) then
				if(disp1(1)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--2
			elsif ((row >240  and row<320 ) AND (column>100+d1 and column <115+d1)) then
				if(disp1(2)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--3
			elsif ((row >320  and row<340 ) AND (column>70+d1 and column <100+d1)) then
				if(disp1(3)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--4
			elsif ((row >240  and row<320 ) AND (column>55+d1 and column <70+d1)) then
				if(disp1(4)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--5
			elsif ((row >140  and row<220 ) AND (column>55+d1 and column <70+d1)) then
				if(disp1(5)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--6
			elsif ((row >220  and row<240 ) AND (column>70+d1 and column <100+d1)) then
				if(disp1(6)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;


				
-- ======================================================	
-- DISPLAY 2
-- ======================================================					
				
			--0
			elsif ((row >120  and row<140 ) AND (column>70+d2 and column <100+d2)) then 
				if(disp2(0)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--1
			elsif ((row >140  and row<220 ) AND (column>100+d2 and column <115+d2)) then
				if(disp2(1)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--2
			elsif ((row >240  and row<320 ) AND (column>100+d2 and column <115+d2)) then
				if(disp2(2)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--3
			elsif ((row >320  and row<340 ) AND (column>70+d2 and column <100+d2)) then
				if(disp2(3)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--4
			elsif ((row >240  and row<320 ) AND (column>55+d2 and column <70+d2)) then
				if(disp2(4)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--5
			elsif ((row >140  and row<220 ) AND (column>55+d2 and column <70+d2)) then
				if(disp2(5)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;
			--6
			elsif ((row >220  and row<240 ) AND (column>70+d2 and column <100+d2)) then
				if(disp2(6)='0') then
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				else
					red <= (Others =>'0');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				end if;		
			
	
-- ======================================================	
-- DONT TOUCH
-- ======================================================	
			
			else		
					red <= (OTHERS => '0');  --es el fondo
					green	<= (OTHERS => '0');
					blue <= (OTHERS => '0');
			end if;
			
			
			
		else		
				red <= (OTHERS => '0');  --es el fondo
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
		end if;
		


	END PROCESS;
END behavior;