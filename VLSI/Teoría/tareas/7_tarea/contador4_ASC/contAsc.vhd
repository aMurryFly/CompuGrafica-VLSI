library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity contAsc is
port(
	clk:		in		STD_LOGIC;
	reset:	in		STD_LOGIC;
	count:	out	STD_LOGIC_VECTOR(3 downto 0);
	s : in std_logic_vector (1 downto 0);
	sal : out std_logic_vector (3 downto 0);
	dsp1 , dsp2 : out std_logic_vector (6 downto 0)
);
end contAsc;

architecture arqcontAsc of contAsc is

signal conector: std_logic;

signal caux1, caux2, cdisp : std_logic_vector (3 downto 0);
signal csal : std_logic_vector (2 downto 0);
signal ccout : std_logic;

begin

	u1: entity work.relojlento(arcrelojlento) port map(clk, conector);
	u2: entity work.cont(behaviour) port map(conector, reset, count);
		
	caux1 <= ccout & csal;
	caux2 <= '0' & csal;
	
	with s select sal <=
		caux1 when "01",
		caux2 when "10",
		ccout & csal when others;
		
	with s select cdisp <=
		caux1 when "01",
		caux2 when "10",
		ccout & csal when others;
		
	with cdisp select dsp1 <=
		"0000001" when "0000",
		"1001111" when "0001",
		"0010010" when "0010",
		"0000110" when "0011",
		"1001100" when "0100",
		"0100100" when "0101",
		"0100000" when "0110",
		"0001111" when "0111",
		"0000000" when "1000",
		"0000100" when "1001",
		"0000001" when "1010",
		"1001111" when "1011",
		"0010010" when "1100",
		"0000110" when "1101",
		"1001100" when "1110",
		"0100100" when "1111";
	
	with cdisp select dsp2 <=
		"0000001" when "0000",
		"0000001" when "0001",
		"0000001" when "0010",
		"0000001" when "0011",
		"0000001" when "0100",
		"0000001" when "0101",
		"0000001" when "0110",
		"0000001" when "0111",
		"0000001" when "1000",
		"0000001" when "1001",
		"1001111" when "1010",
		"1001111" when "1011",
		"1001111" when "1100",
		"1001111" when "1101",
		"1001111" when "1110",
		"1001111" when "1111";


end arqcontAsc;