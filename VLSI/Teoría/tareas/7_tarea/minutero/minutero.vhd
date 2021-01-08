library ieee;
use ieee.std_logic_1164.all;

entity minutero is
port(clk, reset: in std_logic;
	  dis7s1,dis7s0: out std_logic_vector(6 downto 0));
end entity;

architecture arq of minutero is 

signal clk1sec: std_logic;
signal bcd1,bcd0: std_logic_vector(3 downto 0);
signal sec10, sec60: std_logic;

begin

	divFre:entity work.Clk1Hz(arq) 
			 port map (clk, clk1sec);
			 
	cont0:entity work.count0to9(arq)
			 port map (clk1sec,reset,bcd0);
			 
	cont1:entity work.count0to9(arq)
			 port map (sec10,sec60 or reset,bcd1);
			 
	seg0:entity work.bcd7seg(arq)
		  port map (bcd0,dis7s0);
	
	seg1:entity work.bcd7seg(arq)
		  port map (bcd1,dis7s1);
	
	sec10 <= (not bcd0(3)) and (not bcd0(2)) and (not bcd0(1)) and (not bcd0(0)); 
	sec60 <= (not bcd1(3)) and (bcd1(2)) and (not bcd1(1)) and (bcd1(0)); 
	
end architecture;