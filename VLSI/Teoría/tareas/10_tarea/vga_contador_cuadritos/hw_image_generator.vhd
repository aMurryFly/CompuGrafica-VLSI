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
	 num		 :  IN   std_logic_vector(1 downto 0);
    red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0') );
    
	 END hw_image_generator;

ARCHITECTURE behavior OF hw_image_generator IS

BEGIN
  PROCESS(disp_ena, row, column)
   
 BEGIN
 

 IF(disp_ena = '1') THEN        --display time
     
	  
	case num is
   when "00" =>
     if ((row > 10 and row <40) and (column>100 and column<140)) THEN
			   red <= (OTHERS => '1');
				green<=(OTHERS => '0');
				blue<=(OTHERS => '0');
		else		
				red <= (OTHERS => '0');  --es el fondo
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
		end if;	
   when "01" =>
      if ((row > 210 and row <240) and (column>200 and column<240)) THEN
			   red <= (OTHERS => '0');
				green<=(OTHERS => '1');
				blue<=(OTHERS => '0');
		else		
				red <= (OTHERS => '0'); 
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
		end if;	
	when "10" =>
      if ((row > 310 and row <340) and (column>300 and column<340)) THEN 
			   red <= (OTHERS => '0');
				green<=(OTHERS => '0');
				blue<=(OTHERS => '1');
		else		
				red <= (OTHERS => '0');
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
		end if;	
	when "11" =>
      if ((row > 110 and row <140) and (column>380 and column<420)) THEN
			   red <= (OTHERS => '1');
				green<=(OTHERS => '1');
				blue<=(OTHERS => '1');
		else		
				red <= (OTHERS => '0'); 
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
		end if;	
	when others =>
		red <= (OTHERS => '0');  
		green	<= (OTHERS => '0');
		blue <= (OTHERS => '0');
	end case;

END IF;  --del enable
  
  END PROCESS;
END behavior;