library ieee;
use ieee.std_logic_1164.all;
entity top is port (
	clk, boton, reset: in std_logic;
	lampara: out std_logic;
	estado: out std_logic_vector(1 downto 0)

);
end entity;
architecture arqtop of top is 
signal clk2: std_logic;
begin
	u1: entity work.relojlento(arqrelojlento) port map( clk, clk2);
	u2: entity work.eje69(arqeje69) port map(clk2, boton, reset, lampara, estado);
	
end architecture;