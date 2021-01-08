library ieee;
use ieee.std_logic_1164.all;
entity FFJK is port(
	clk, j, k: in std_logic;
	q, notq: inout std_logic
);
end FFJK;
architecture arqFFJK of FFJK is
begin
	process(clk)
	begin
		if rising_edge (clk) then 
			q<= (q and (not k)) or (not q and j);
			notq<=not q;
		end if;
	end process;
end architecture;