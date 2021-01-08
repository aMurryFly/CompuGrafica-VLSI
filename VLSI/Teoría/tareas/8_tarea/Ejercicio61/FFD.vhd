library ieee;
use ieee.std_logic_1164.all;
entity FFD is port (
	d, clk: in std_logic;
	Q: out std_logic
	
);
end FFD; 
architecture arqFFD of FFD is
signal conteo: integer range 0 to 25000000;
begin
	process(clk)
	begin
		if(clk' event and clk ='1') then
			conteo <= conteo+1;
				if(conteo=25000000) then
					conteo<=0;
					Q<=d;
				end if;
		end if;
	end process;
end arqFFD;