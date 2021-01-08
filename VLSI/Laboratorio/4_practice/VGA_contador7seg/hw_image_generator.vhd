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
	 
	 bus_unidad, bus_decena: in std_logic_vector(6 downto 0) -- Unidades del contador en 7 segmentos
	 
	 ); 
END hw_image_generator;

ARCHITECTURE behavior OF hw_image_generator IS
BEGIN

  PROCESS(disp_ena, row, column, bus_unidad, bus_decena)
  BEGIN
	  if (disp_ena ='1') then
			--Row: alto
			--Column: ancho
			--Display Unidades
			--0
			if ((row >120  and row<140 ) AND (column>360 and column <440)) then 
			
				if(bus_unidad(0)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				end if;
			--1
			elsif ((row >140  and row<220 ) AND (column>440 and column <460)) then
				if(bus_unidad(1)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				end if;
			--2
			elsif ((row >240  and row<320 ) AND (column>440 and column <460)) then
				if(bus_unidad(2)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				end if;
			--3
			elsif ((row >320  and row<340 ) AND (column>360 and column <440)) then
				if(bus_unidad(3)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				end if;
			--4
			elsif ((row >240  and row<320 ) AND (column>340 and column <360)) then
				if(bus_unidad(4)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				end if;
			--5
			elsif ((row >140  and row<220 ) AND (column>340 and column <360) ) then
				if(bus_unidad(5)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				end if;
			--6
			elsif ((row >220  and row<240 ) AND (column>360 and column <440)) then
				if(bus_unidad(6)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				end if;
			
			--Display Decenas
			--0
			elsif ((row >120  and row<140 ) AND (column>200 and column <280)) then 
			
				if(bus_decena(0)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				end if;
			--1
			elsif ((row >140  and row<220 ) AND (column>280 and column <300)) then
				if(bus_decena(1)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				end if;
			--2
			elsif ((row >240  and row<320 ) AND (column>280 and column <300)) then
				if(bus_decena(2)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				end if;
			--3
			elsif ((row >320  and row<340 ) AND (column>200 and column <280)) then
				if(bus_decena(3)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				end if;
			--4
			elsif ((row >240  and row<320 ) AND (column>180 and column <200)) then
				if(bus_decena(4)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				end if;
			--5
			elsif ((row >140  and row<220 ) AND (column>180 and column <200)) then
				if(bus_decena(5)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				end if;
			--6
			elsif ((row >220  and row<240 ) AND (column>200 and column <280)) then
				if(bus_decena(6)='0') then
					red <= (Others =>'1');
					green <= (Others =>'0');
					blue <= (Others =>'0');
				else
					red <= (Others =>'1');
					green <= (Others =>'1');
					blue <= (Others =>'1');
				end if;	
			
			else	
				red <= (Others =>'0');
				green <= (Others =>'0');
				blue <= (Others =>'0');
			end if;	
	  end if;
		
  END PROCESS;
  
  
END behavior;