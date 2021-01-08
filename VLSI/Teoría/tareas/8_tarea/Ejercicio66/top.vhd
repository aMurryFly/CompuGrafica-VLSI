library ieee;
use ieee.std_logic_1164.all;
entity top is port(
	clk: in std_logic;
	sq1,sq0: out std_logic
); 
end top;
architecture arqtop of top is 
signal clk2: std_logic;
begin
	w1: entity work.relojlento(arqrelojlento) port map (clk,clk2);
	w2: entity work.ffjk1(arqffjk1) port map (clk2, sq1, sq0);
	

end architecture;