library ieee;
use ieee.std_logic_1164.all;

entity Mux4x1 is
	port(
		sel : in std_logic_vector (1 downto 0);
		b : in std_logic_vector (2 downto 0);
		sal : out std_logic_vector (2 downto 0)
	);
end entity;


architecture ArqMux4x1 of Mux4x1 is
begin	
	with sel select sal <=
		"000" when "00",
		b when "01",
		not b when "10",
		"111" when "11";
end architecture;