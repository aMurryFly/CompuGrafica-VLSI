library ieee;
use ieee.std_logic_1164.all;
entity top is port(
	E, clk: in std_logic;
	s: out std_logic;
	led: out std_logic
);
end top;
architecture arqtop of top is
signal clk2: std_logic;
begin
	
	u4: entity work.relojlento(arqrl) port map (clk,clk2,led);
	u5: entity work.paridad(arqparidad) port map (E,clk2,s);
end architecture;