library ieee;
use ieee.std_logic_1164.all;

entity fetch is
port(
	clk,reset,pausa,cs: in std_logic;
	bus_datos: out std_logic_vector(15 downto 0);
	ledfetch:out std_logic_vector(6 downto 0);
	saledo:out std_logic_vector(3 downto 0);
	led: out std_logic
);
end entity;

architecture arqfetch of fetch is

signal cable_bus_dir: std_logic_vector(3 downto 0);
signal cableclkl: std_logic;
begin

led<=cableclkl;
saledo<=cable_bus_dir;
			  
u1: entity work.reloj_lento(arqrelojlento) port map (clk,cableclkl);
u2: entity work.conta(arqconta) port map (cableclkl, reset,pausa,cable_bus_dir);
u3: entity work.miromNT(arqmiromNT) port map (cable_bus_dir,cs,bus_datos, ledfetch);

end arqfetch;