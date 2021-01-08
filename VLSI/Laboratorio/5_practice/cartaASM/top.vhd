
library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
entity topASM is
port( 
clk, reset,x,y: in std_logic;
var1,var2,var3,var4: out std_logic;
dis1: out std_logic_vector(6 downto 0)
)
;
end topASM;

architecture arqtopasm of topASM is
signal clk25: std_logic;
signal sal: std_logic_vector(3 downto 0);
begin

u1: entity work.relojlento(arqrelojlento) port map(clk,clk25);
u2: entity work.asm(arqasm) port map(clk25, reset,x,y,var1,var2, var3,var4,sal);

end arqtopasm;