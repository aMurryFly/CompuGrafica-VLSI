library ieee;
use ieee.std_logic_1164.all;

entity vga20 is
port(
  input_clk		:  in std_logic;  --for this example is 50MHz
 pixel_clk		: out std_logic;  --monitor del reloj a 25MHz

 red				: out std_logic_vector (3 downto 0);
 green			: out std_logic_vector (3 downto 0);
 blue				: out std_logic_vector (3 downto 0);

 h_sync			: out std_logic;
 v_sync			: out std_logic

 );
end;

architecture behavioral of vga20 is
signal pix_clock : STD_LOGIC;
signal disp_ena  : STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
signal column    : INTEGER;    --horizontal pixel coordinate
signal row       : INTEGER;    --vertical pixel coordinate
signal conectorpixel: std_logic_vector(3 downto 0);
signal conectorconta: std_logic_vector(11 downto 0);
signal reset,cs:std_logic;
begin

pixel_clk<=pix_clock;
reset<='1';
cs<='1';
u1: entity work.Gen25MHz(behavior)  port map(	input_clk,
																pix_clock);
												
u2: entity work.vga_controller (behavior) port map (	pix_clock,
																		'1',
																		h_sync,
																		v_sync,
																		disp_ena,
																		column,
																		row);
																		
u3: entity work.hw_image_generator (behavior) port map (	disp_ena,
																			row,
																			column,
																			red,
																			green,
																			blue, conectorpixel);

u4: entity work.mirom (arqmirom) port map (input_clk, conectorconta,cs, conectorpixel);

--u5: entity work.conta (arqconta) port map (input_clk,conectorconta);
																			
end;

	 