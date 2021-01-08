library ieee;
use ieee.std_logic_1164.all;
entity ALU is port (
	a, b: in std_logic_vector (2 downto 0 );
	sel: in std_logic_vector (2 downto 0);
	cin: in std_logic;
	disp0, disp1,disp2: out std_logic_vector(6 downto 0);
	salfinal: out std_logic_vector(3 downto 0)

);
end entity;

architecture arq_alu of ALU is
SIGNAL SAL_UA, SAL_UL: std_logic_vector(2 downto 0);
signal cout: std_logic;
begin

	arit: entity work.UA (arq_UA) port map (a,b,sel(1 downto 0),cin,SAL_UA,cout);
	log : entity work.UL (arq_UL) port map (a,b,sel(1 downto 0),SAL_UL);
	disp_sal: entity work.display(arq_disp) 
		port map (SAL_UA,SAL_UL,sel,cout,disp0,disp1,disp2,salfinal);
	


end architecture;