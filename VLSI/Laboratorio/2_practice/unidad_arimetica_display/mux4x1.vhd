library ieee;
use ieee.std_logic_1164.all;

entity mux4x1 is
port(
SEL: in std_logic_vector(1 downto 0);
b: in std_logic_vector(2 downto 0);
sal: out std_logic_vector(2 downto 0));
end mux4x1;


architecture arqmux41 of mux4x1 is
BEGIN 	
with sel select 
sal<= "000" when "00",
		b when "01",
		not b when "10",
		"111" when "11";
 
end architecture arqmux41;




