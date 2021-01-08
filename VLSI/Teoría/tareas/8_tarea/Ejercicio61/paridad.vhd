library ieee;
use ieee.std_logic_1164.all;
entity paridad is port (
	E, clk: in std_logic;
	s: out std_logic
	
);
end paridad;
architecture arqparidad of paridad is
	signal D0,D1:std_logic;
	signal Q0,Q1:std_logic;
begin
	u1:entity work.combinacional(arqcom) port map (E,Q0,Q1,D0,D1,s);
	u2: entity work.FFD(arqFFD) port map (D0,clk,Q0);
	u3: entity work.FFD(arqFFD) port map (D1,clk,Q1);
	
end arqparidad;