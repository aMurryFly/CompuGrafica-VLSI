library ieee;
use ieee.std_logic_1164.all;
entity top_ram is port (
	AddrWr	: in std_logic_vector (1 downto 0);--Direccion de memoria
	AddrRd	: in std_logic_vector (1 downto 0);--Direccion de lectura
	clkWr		: in std_logic;
	clkRd		: in std_logic;
	wren		: in std_logic;
	dataIn	: in std_logic_vector(3 downto 0);--Registro de entrada
	ledcarga	:out std_logic:='0';
	disp1,disp0: out std_logic_vector(6 downto 0)
);
end top_ram;

architecture arqtop of top_ram is
	signal dataOut	: std_logic_vector(3 downto 0);--Registro de salida
	
begin
	u1: entity work.ram_mif_AMV(arqram) port map (AddrWr,AddrRd, clkWr,clkRd,wren,dataIn, dataOut,ledcarga);
	u2: entity work.display(arqdisplay) port map (dataOut,disp1,disp0);
end arqtop;