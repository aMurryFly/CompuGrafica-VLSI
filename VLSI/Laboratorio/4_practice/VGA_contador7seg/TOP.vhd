library ieee;
use ieee.std_logic_1164.all;

ENTITY TOP IS
PORT(
    input_clk:  in   STD_LOGIC; 
	 reset	 :  in 	std_logic;
	 --pixel_clk:  buffer   STD_LOGIC;  --pixel clock at frequency of VGA mode being used
    
	 --reset_n   :  IN   STD_LOGIC;  --active low asycnchronous reset
    
	 --n_blank   :  OUT  STD_LOGIC;  --direct blacking output to DAC
    --n_sync    :  OUT  STD_LOGIC; --sync-on-green output to DAC
	 
	 red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	 h_sync   :  OUT  STD_LOGIC;  --horiztonal sync pulse
    v_sync   :  OUT  STD_LOGIC --vertical sync pulse
	 );

END TOP;

ARCHITECTURE arqTOP OF TOP IS
signal pix_clock: std_logic;
signal reloj: std_logic;
signal disp_ena: std_logic;
signal column:  INTEGER;
signal row:  INTEGER;
signal unidad, decena: std_logic_vector (3 downto 0);
signal Cyout: std_logic;
signal bus_unidad, bus_decena: std_logic_vector(6 downto 0);

BEGIN
	u1: entity work.genMhz(arqgenMhz) port map(input_clk,pix_clock);
	--Reloj lento del contador
	r: entity work.relojlento(arqrelojlento) port map (input_clk, reloj);
	
	countUnidad: entity work.estados_contador(arqstate) port map (reloj, reset,unidad, Cyout);
	countDecena: entity work.estados_contador(arqstate) port map (Cyout, reset,decena);
	
	UnidadDisp: entity work.rom(arqrom) port map (unidad,'1',bus_unidad);
	DecenaDisp: entity work.rom(arqrom) port map (decena,'1',bus_decena);
	
	u2: entity work.vga_controller(behavior) port map(pix_clock, '1', h_sync, v_sync, disp_ena, column, row);
	u3: entity work.hw_image_generator(behavior) port map(disp_ena, row, column, red, green, blue, bus_unidad, bus_decena);
END ARCHITECTURE arqTOP;