library ieee;
use ieee.std_logic_1164.all;

entity top_par is port(
	x,reset,clk: in std_logic;
	count:out std_logic
);

end top_par;

architecture arqpar of top_par is
signal clk2: std_logic;

begin
	u1: entity work.relojLento(arqrelojlento) port map(clk,clk2);
	u2: entity work.parEjer65(arqPar) port map(clk2,reset,x,count);
end arqpar;

