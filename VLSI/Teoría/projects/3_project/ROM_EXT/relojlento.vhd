library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
entity relojlento is port (
	clk1: in std_logic;
	led: buffer std_logic:='0'
);
end relojlento;

architecture arqrelojlento of relojlento is
	signal conteo: integer range 0 to 25000000;
begin
	process (clk1)
		begin 
		if (clk1' event and clk1='1') then
			conteo <=conteo+1;
			if (conteo=25000000) then
				conteo<=0;
				led<=not(led);
			end if;
		end if;
	end process;

end arqrelojlento;