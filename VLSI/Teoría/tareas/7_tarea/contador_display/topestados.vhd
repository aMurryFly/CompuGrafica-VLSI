library ieee;
use ieee.std_logic_1164.all;

entity topestados is
	port(
		clk,reset: in std_logic;
      SalMoore: buffer std_logic_vector(3 downto 0);
		dsp1, dsp2 : out std_logic_vector (6 downto 0)
	);
end entity;
	
architecture arqtopestados of topestados is
	signal clk_aux: std_logic;
	signal mbcd: std_logic_vector(3 downto 0);
	signal lbcd: std_logic_vector(3 downto 0);
	
	begin
		u0: entity work.relojlento (arqrelojlento) port map(clk,clk_aux);
		u1: entity work.estados (arq) port map(clk_aux,reset,salMoore);
		u2: entity work.bcd7seg(arcbcd7seg) port map (mbcd,dsp1);
		u3: entity work.bcd7seg(arcbcd7seg) port map (lbcd,dsp2);
		
  with salMoore select
	lbcd <= "0000" when "1010",
			  "0001" when "1011",
			  "0010" when "1100",
			  "0011" when "1101",
			  "0100" when "1110",
			  "0101" when "1111",
  salMoore when others;
  
  
  mbcd <= "000" & (SalMoore(3) and (SalMoore(1) or SalMoore(2)));

		  
end architecture;