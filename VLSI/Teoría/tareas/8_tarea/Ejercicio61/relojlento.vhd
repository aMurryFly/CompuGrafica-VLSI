library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
entity relojlento is port(
	clk: in std_logic;
	led: buffer std_logic:='0'
); end relojlento;
architecture arqrl of relojlento is
signal conteo: integer range 0 to 25000000;
begin
	process(clk)
	begin
		if(clk' event and clk ='1') then
			conteo <= conteo+1;
			if(conteo=25000000) then
				conteo<=0;
				led<= not (led);
			else
				conteo<=conteo+1;
			end if;
		end if;
	end process;
end arqrl;