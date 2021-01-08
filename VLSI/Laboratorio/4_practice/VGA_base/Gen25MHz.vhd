library ieee;
use ieee.std_logic_1164.all;

entity Gen25MHz is
port (clk50MHz : in std_logic;
		clk25MHz	: inout std_logic:='0'
);
end entity Gen25MHz;

architecture behavior of Gen25MHz is
begin
	process (clk50MHz)
	begin
		if clk50MHz'event and clk50MHz='1' then
			clk25MHz <= not clk25MHz;
		end if;
	end process;
end architecture behavior;