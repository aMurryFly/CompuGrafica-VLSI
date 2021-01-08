library ieee;
use ieee.std_logic_1164.all;

ENTITY TOP IS
PORT(
	 --a, b     :  in   std_logic_vector(2 downto 0);
	 reset	 :  in   std_logic;
    input_clk:  in   STD_LOGIC; 
	 pararContador: in STD_LOGIC;--SE AGREGA VARIABLE
	 red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	 h_sync   :  OUT  STD_LOGIC;  --horiztonal sync pulse
    v_sync   :  OUT  STD_LOGIC;--vertical sync pulse
	 salfinal :  OUT  std_logic_vector(3 downto 0)
);
END TOP;

ARCHITECTURE arqTOP OF TOP IS
signal pix_clock: std_logic;
signal reloj: std_logic;
signal disp_ena: std_logic;
signal column:  INTEGER;
signal row:  INTEGER;
------
signal a,b : std_logic_vector(2 downto 0);
signal bus_A,bus_B: std_logic_vector(6 downto 0);

------
signal sal: std_logic_vector(3 downto 0);
signal disp0, disp1, disp2: std_logic_vector(6 downto 0);



BEGIN
	u1: entity work.genMhz(arqgenMhz) port map(input_clk,pix_clock);
	--ALU	
	r: entity work.relojlento(arqrelojlento) port map (input_clk,pararContador, reloj);--SE AGREGA VARIABLE
	cont: entity work.contador(arqcont) port map(reloj, reset,sal);
	romData: entity work.romDatos(arqromDatos) port map ("111",'1',a);
	romDatb: entity work.romDatos(arqromDatos) port map ("011",'1',b);
	ALU: entity work.TOP_ALU(arq_alu) port map(a,b,sal(2 downto 0),sal(3),disp0,disp1,disp2,salfinal);-- sal 3 es el cin
	
	valorA: entity work.rom(arqrom) port map(a,'1',bus_A);
	
	valorB: entity work.rom(arqrom) port map(b,'1',bus_B);
	--DISPLAY
	
	u2: entity work.vga_controller(behavior) port map(pix_clock, '1', h_sync, v_sync, disp_ena, column, row);
	u3: entity work.hw_image_generator(behavior) port map(disp_ena, row, column, red, green, blue, 
																	sal,a,b,bus_A, bus_b,disp0,disp1,disp2);
END ARCHITECTURE arqTOP;