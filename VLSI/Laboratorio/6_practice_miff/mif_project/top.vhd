LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity top is port(
	input_clk	:	in std_logic;
--	reset			:	in std_logic;
	pixel_clk	:	out std_logic;
	red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
   green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
   blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	h_sync    :  OUT  STD_LOGIC;  
   v_sync    :  OUT  STD_LOGIC
);
end top;

architecture arqtop of top is
signal pix_clock	:	std_logic;
signal disp_ena	:	std_logic;
signal column, row: integer;
signal connector_pixel: std_logic_vector(3 downto 0);
signal connector_conta: std_logic_vector(8 downto 0);
signal datos_pixel: std_logic_vector(7 downto 0);
signal cs:	std_logic;
begin
pixel_clk<=pix_clock;
cs<='1';
connector_pixel<=datos_pixel(7 downto 4);

genMhz: 			entity work.genMhz(arqgenMhz) port map( input_clk,pix_clock);
vga_control:	entity work.vga_controller(behavior) port map (pix_clock, '1',h_sync,v_sync,disp_ena, column,row);
hw_image:		entity work.hw_image_generator(behavior) port map(disp_ena,row, column, red, green, blue, connector_pixel);

pixelcontrol: 	entity work.pixel_control(arqpixel_control) port map (row, column,connector_conta);
rom:				entity work.rom_ext(arqrom) port map(connector_conta, cs, datos_pixel);


end arqtop;