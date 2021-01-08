library ieee;
use ieee.std_logic_1164.all;

entity topua is
port(
sel: in std_logic_vector(1 downto 0);
a,b: in std_logic_vector (2 downto 0);
cin: in std_logic;
sal: inout std_logic_vector(2 downto 0);
cout: inout std_logic;
ds1,ds2,ds3,ds4: out std_logic_vector(7 downto 0)
);
end topua;


architecture arqtopua of topua is
signal cableb: std_logic_vector(2 downto 0); 
BEGIN 
u1: entity work.mux4x1(arqmux41) port map(sel,b,cableb);
u2: entity work.sumbit(arqsb) port map(a,cableb,cin,sal,cout);

with sal(0) select
ds1 <= "11000000" when '0',
		 "11111001" when '1';

with sal(1) select
ds2 <= "11000000" when '0',
		 "11111001" when '1';		 
		 
with sal(2) select
ds3 <= "11000000" when '0',
		 "11111001" when '1';

with cout select
ds4 <= "11000000" when '0',
		 "11111001" when '1';		 
		 
end architecture arqtopua;