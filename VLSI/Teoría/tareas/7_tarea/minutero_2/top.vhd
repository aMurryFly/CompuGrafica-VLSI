library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
entity top is
port( 
clk, reset: in std_logic;
--led: buffer std_logic:= '0';
dis1,dis2: out std_logic_vector(6 downto 0)
);
end top;

architecture arqtop of top is
signal Cyout,clk25: std_logic;
signal SalMoore, salMoore2:std_logic_vector(3 downto 0);
begin

u1: entity work.relojlento(arqrelojlento) port map(clk,clk25);
u2: entity work.estados(arq) port map(clk25, reset,salMoore,Cyout);
u3: entity work.estados(arq) port map(Cyout, reset,salMoore2);
u4: entity work.bcd7seg(arq) port map (salMoore,dis1);
u5: entity work.bcd7seg(arq) port map (salMoore2,dis2);

end arqtop;