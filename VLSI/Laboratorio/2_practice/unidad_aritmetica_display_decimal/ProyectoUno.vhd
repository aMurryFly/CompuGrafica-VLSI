library ieee;
use ieee.std_logic_1164.all;

entity ProyectoUno is
	port (
		a , b : in std_logic_vector (2 downto 0);
		s : in std_logic_vector (1 downto 0);
		cin : in std_logic;
		sal : out std_logic_vector (3 downto 0);
		dsp1 , dsp2 : out std_logic_vector (6 downto 0)
	);
end entity;

architecture ArqProyectoUno of ProyectoUno is
	signal caux1, caux2, cdisp : std_logic_vector (3 downto 0);
	signal cable, csal : std_logic_vector (2 downto 0);
	signal ccout : std_logic;
begin
	U1 : entity work.Mux4x1 (ArqMux4x1) port map (s, b, cable);
	U2 : entity work.Sum (ArqSum) port map (a, cable, cin, csal, ccout);
	
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

end architecture;