library ieee;
use ieee.std_logic_1164.all;

entity top is port(
	 pixel_clk :  IN   STD_LOGIC;  
    reset_n   :  IN   STD_LOGIC;  
    h_sync    :  OUT  STD_LOGIC;  
    v_sync    :  OUT  STD_LOGIC;  
    
    n_blank   :  OUT  STD_LOGIC;  
    n_sync    :  OUT  STD_LOGIC; 
	 red      :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  
    green    :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  
    blue     :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0') 

	 
);
end entity top;

architecture arqtop of top is
signal cabledisp_ena: std_logic;
signal cablerow: integer;
signal cablecolumn: integer;
begin
	u1:entity work.vga_controller(behavior) port map (pixel_clk, reset_n, h_sync, v_sync, cabledisp_ena, cablecolumn,cablerow,n_blank,n_sync );
	u2:entity work.hw_image_generator(behavior) port map (cabledisp_ena,cablerow,cablecolumn,red,green,blue);

end arqtop;