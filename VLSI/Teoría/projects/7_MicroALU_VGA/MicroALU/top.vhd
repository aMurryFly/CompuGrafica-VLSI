library ieee;
use ieee.std_logic_1164.all;
entity top is port (
	clk,reset,pausa,cs: in std_logic;
	
	saledo: out std_logic_vector(3 downto 0);
	led: out std_logic;
	
	--Memoria RAM
	AddrRd : in std_logic_vector (3 downto 0); --Dirección de lectura
	WrEN : in std_logic;
	
	dataOut : out std_logic_vector(3 downto 0);
	
	--VGA
	 red				: out std_logic_vector (3 downto 0);
	 green			: out std_logic_vector (3 downto 0);
	 blue				: out std_logic_vector (3 downto 0);

	 h_sync			: out std_logic;
	 v_sync			: out std_logic
);
end entity;

architecture arqtop of top is
	signal bus_datos: std_logic_vector(15 downto 0);
	signal bus_datosA,bus_datosB: std_logic_vector (2 downto 0);
	signal s: std_logic_vector(1 downto 0);
	signal s2,cin:  std_logic;
	signal datosDIRC:  std_logic_vector (3 downto 0);
	signal ledfetch:  std_logic_vector (6 downto 0);
	signal salfinal: std_logic_vector(3 downto 0);
	signal clk2 :  std_logic;
	--VGA
	signal clk25: std_logic;
	signal disp_ena  : STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
	signal column    : INTEGER;    --horizontal pixel coordinate
	signal row       : INTEGER;    --vertical pixel coordinate
	--Salidas
	signal disp0, disp1,disp2,disA, disB,leddecode:  std_logic_vector(6 downto 0);
	
begin
	genMHz: entity work.genMhz(arqgenMhz) port map (clk,clk25);
	vga_contr: entity work.vga_controller(behavior) port map(clk25,'1',h_sync,v_sync,disp_ena,column,row);


	
	fetch: entity work.fetch(arqfetch) port map (clk,reset,pausa,cs,bus_datos,ledfetch,saledo, led);
	dec:   entity work.dec(arqdec) port map (bus_datos,bus_datosA,bus_datosB,s,s2,cin,datosDIRC,cs,leddecode);
	ALU: 	 entity work.ALU(arq_alu) port map (bus_datosA,bus_datosB,s2&s,cin,disp0,disp1,disp2,salfinal);
	dispA: entity work.disp(arqdis) port map (bus_datosA, disA);
	dispB: entity work.disp(arqdis) port map (bus_datosB, disB);
	reloj: entity work.reloj_lento(arqrelojlento) port map (clk,clk2);
	cache:   entity work.mem(arqmem) port map (datosDIRC,AddrRd,clk2,clk2,WrEN,salfinal,dataOut);

	-- Para los datos en VGA
	generator_vga:	entity work.hw_image_generator(behavior) port map (disp_ena,row,column,red,green,blue,disp0,disp1,disp2,disA,disB,leddecode,ledfetch);
end architecture;