library ieee;
use ieee.std_logic_1164.all;
entity crom is port(
	clk, reset, cs: std_logic;
	bus_datos: out std_logic_vector(6 downto 0)
);
end crom;

architecture arqcrom of crom is
	signal cb_bus_dir: std_logic_vector(1 downto 0);
	signal cb_clk: std_logic;
begin
	u1: entity work.relojlento(arqrelojlento) port map (clk, cb_clk);
	u2: entity work.conta(arqcont) port map (cb_clk, reset, cb_bus_dir);
	u3: entity work.rom_ext(arqrom) port map (cb_bus_dir, cs,bus_datos);
	
end arqcrom;