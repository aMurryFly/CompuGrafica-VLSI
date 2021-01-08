library ieee;
use ieee.std_logic_1164.all;
entity top is port(
	clkl,E,reset: in std_logic;
	s,reloj: out std_logic
);end top;

architecture arqtop of top is
signal clk2:std_logic;
begin
	u1: entity work.relojlento(arqrelojlento) port map (clkl, clk2);
	reloj<=clk2;
	u2: entity work.par(arqpar) port map (clk2, E,reset,s);
end architecture;