library ieee;
use ieee.std_logic_1164.all;

entity display2 is 
port( 
 e: in std_logic_vector(2 downto 0);
 b1: out std_logic_vector (6 downto 0));
end entity display2;

architecture arqdis2 of display2 is 
begin 
with e select
	b1 <= "1000000" when "000",
		"1111001" when "001" ,
		"0100100" when "010",
		"0110000" when "011",
		"0011001" when "100",
		"0010010" when "101",
		"0000010" when "110",
		"1111000" when "111",
		--"0000000" when "1000",
		--"0011000" when "1001", --9
		"1111111" when others;
		
		
end architecture arqdis2;