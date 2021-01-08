library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_UNSIGNED.all;

entity dec is
port(
	de_intruc: in std_logic_vector(15 downto 0);
	bus_datosA,bus_datosB: out std_logic_vector (2 downto 0);
	s: out std_logic_vector(1 downto 0);
	s2,cin: out std_logic;
	datosDIRC: out std_logic_vector (3 downto 0);
	cs: in std_logic;
	leddecode:out std_logic_vector (6 downto 0)
); --que operacion es Sum Rest, And, OR  Xor
end dec;

architecture arqdec of dec is
signal datosDIRA, datosDIRB: std_logic_vector (2 downto 0);
signal display: std_logic_vector(3 downto 0);
BEGIN

	datosDIRC<= de_intruc(3 downto 0);--DIRECCCIONES DE C
	datosDIRB<=  de_intruc(6 downto 4);--DIRECCCIONES DE B
	datosDIRA<= de_intruc(9 downto 7);--DIRECCCIONES DE A
	
	s<= de_intruc(11 downto 10);
	cin<= de_intruc(12);
	s2<= de_intruc(13);
	
	display<= de_intruc(13 downto 10);
with  display select
             --GFEDCBA DISPLAY 7 SEGMENTOS
leddecode<= "0001000" when "0000",  --A		A
				"0010010" when "0001",  --A+B    S
				"0111111" when "0110",  --A-1		-
				"0111001" when "0100",  --A+1		+
				"0101011" when "1000",  --AND 	N
				"1000000" when "1001",  --OR		0
				"0000110" when "1010",  --XOR		E
				"1111110" when "1011",  --NOT A 	-
				"0000000" when  others; 

						  
u1: entity work.miromA(arqmiromA) port map (datosDIRA,cs,bus_datosA);
u2: entity work.miromB(arqmiromB) port map (datosDIRB,cs,bus_datosB);

end architecture arqdec;