library ieee;
use ieee.std_logic_1164.all;
entity ffjk1 is port(
	clk: in std_logic;
	sq1,sq0: out std_logic
);
end ffjk1;
architecture arqffjk1 of ffjk1 is
signal k0,j0,k1,j1,q0,q1:std_logic;
begin
	j0<='1';
	k0<='1';
	j1<=q0;
	k1<=q0;
	u1: entity work.FFJK(arqFFJK) port map (clk, j0, k0, q0, '0');
	u2: entity work.FFJK(arqFFJK) port map (clk, j1, k1, q1, '0');
	sq1<=q1;
	sq0<=q0;
end architecture;