library ieee;
use ieee.std_logic_1164.all;
entity combinacional is port (
	E,Q0,Q1 : in std_logic;
	D0, D1,s: out stD_logic

);
end combinacional;
architecture arqcom of combinacional is
begin
	D1<=(Q0 and E) or (Q1 and (not E));
	s<=(Q0 and E) or (Q1 and (not E));
	D0<=Q0 xor E;
	
end arqcom;