library ieee;
use ieee.std_logic_1164.all;

entity mux4x1 is port(
	b: in std_logic_vector(2 downto 0);
	s: in std_logic_vector(1 downto 0);
	sal: out std_logic_vector(2 downto 0)
);
end mux4x1;

architecture arqmux of mux4x1 is 
begin
	with s select
	
	sal	<=	(others => '0') when "00",
					 b           when "01",
				NOT b		          when "10",
				(others => '1') when "11",
				(others => '0') when others;


end arqmux;