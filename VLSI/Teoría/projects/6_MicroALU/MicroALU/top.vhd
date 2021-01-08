library ieee;
use ieee.std_logic_1164.all;
entity top is port (
	clk,reset,pausa,cs: in std_logic;
	ledfetch: out std_logic_vector(6 downto 0);
	saledo: out std_logic_vector(3 downto 0);
	led: out std_logic;
	
	disp0, disp1,disp2,disA, disB: out std_logic_vector(6 downto 0);
	
	--Memoria RAM
	AddrRd : in std_logic_vector (3 downto 0); --Dirección de lectura
	WrEN : in std_logic;
	
	dataOut : out std_logic_vector(3 downto 0)
);
end entity;

architecture arqtop of top is
	signal bus_datos: std_logic_vector(15 downto 0);
	signal bus_datosA,bus_datosB: std_logic_vector (2 downto 0);
	signal s: std_logic_vector(1 downto 0);
	signal s2,cin:  std_logic;
	signal datosDIRC:  std_logic_vector (3 downto 0);
	signal leddecode:  std_logic_vector (6 downto 0);
	signal salfinal: std_logic_vector(3 downto 0);
	signal clk2 :  std_logic;

begin
	fetch: entity work.fetch(arqfetch) port map (clk,reset,pausa,cs,bus_datos,ledfetch,saledo, led);
	dec:   entity work.dec(arqdec) port map (bus_datos,bus_datosA,bus_datosB,s,s2,cin,datosDIRC,cs,leddecode);
	ALU: 	 entity work.ALU(arq_alu) port map (bus_datosA,bus_datosB,s2&s,cin,disp0,disp1,disp2,disA,disB,salfinal);
	reloj: entity work.reloj_lento(arqrelojlento) port map (clk,clk2);
	ram:   entity work.mem(arqmem) port map (datosDIRC,AddrRd,clk2,clk2,WrEN,salfinal,dataOut);
end architecture;