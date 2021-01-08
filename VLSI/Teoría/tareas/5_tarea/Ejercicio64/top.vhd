library ieee;
use ieee.std_logic_1164.all;
entity top is port(
clk, reset: in std_logic;
salMoore: out std_logic_vector(1 downto 0)
);
end top;
architecture arqtop of top is
signal clk2: std_logic;
begin
	u1: entity work.relojlento(arqrelojlento) port map (clk, clk2);
	u2: entity work.eje64(arq64) port map (clk2, reset, salMoore);
end arqtop;
