library ieee;
use ieee.std_logic_1164.all;
entity UL is port(
	a,b: in std_logic_vector (2 downto 0);
	sel: in std_logic_vector (1 downto 0);
	sallog: out std_logic_vector(2 downto 0)
);
end entity;

architecture arq_UL of UL is
signal cand,cor,cxor,cnot: std_logic_vector (2 downto 0);
begin
	cand<=a and b;
	cor <=a or b;
	cxor<=a xor b;
	cnot<=not a;
	
	with sel select 
	sallog <=
				cand when "00",
				cor  when "01",
				cxor when "10",
				cnot when "11";

end arq_UL;