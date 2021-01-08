library ieee;
use ieee.std_logic_1164.all;

entity ejerciciounion is 
port (
a,b: in std_logic;
f: out std_logic
);
end ejerciciounion;

architecture arqejeunion of ejerciciounion is
signal cable1,cable2: std_logic;
begin
	u1: entity work.cor(arqcor) port map (a,b,cable1);
	u2: entity work.cor(arqcor) port map (a,b,cable2);
	u3: entity work.cand(arqcand) port map (cable1,cable2,f);
end architecture arqejeunion;