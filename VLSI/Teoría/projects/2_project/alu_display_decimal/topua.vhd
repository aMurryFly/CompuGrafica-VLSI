library ieee;
use ieee.std_logic_1164.all;

entity topua is
port(
sel: in std_logic_vector(1 downto 0);
a,b: in std_logic_vector (2 downto 0);
cin: in std_logic;
sal: inout std_logic_vector(2 downto 0);
cout: inout std_logic;
led1,led2: out std_logic_vector(6 downto 0)

);
end topua;


architecture arqtopua of topua is
signal cableb: std_logic_vector(2 downto 0);
signal resulbcd : std_logic_vector(3 downto 0); 
BEGIN 
u1: entity work.mux4x1(arqmux41) port map(sel,b,cableb);
u2: entity work.sumbit(arqsb) port map(a,cableb,cin,sal,cout);

with sel select
	resulbcd <= (cout & sal) when "01",
					('0' & sal) when "10",
					(cout & sal) when others;

u3: entity work.bcd7seg(arcbcd7seg) port map(resulbcd,led1,led2);
		 
end architecture arqtopua;