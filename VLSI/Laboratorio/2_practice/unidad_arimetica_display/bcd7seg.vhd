library ieee;
use ieee.std_logic_1164.all;
entity bcd7seg is
port(
bcd: in std_logic_vector(2 downto 0);
led: out std_logic_vector(6 downto 0)
);
end bcd7seg;

architecture arcbcd7seg of bcd7seg is
begin
	with bcd select
	led <= 	"1000000" when "000",
				"1111001" when "001",
				"0100100" when "010",
				"0110000" when "011",
				"0011001" when "100",
				"0010010" when "101",
				"0000010" when "110",
				"1111000" when "111",
				"1111111" when others;
end architecture arcbcd7seg;
