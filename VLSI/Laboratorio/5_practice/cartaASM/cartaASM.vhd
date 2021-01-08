library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
entity cartaASM is
port( 
clk, reset,x,y: in std_logic;
var1,var2,var3,var4: out std_logic
)
;
end  cartaASM;

architecture arqtopasm of cartaASM is
signal clk25: std_logic;
signal sal: std_logic_vector(3 downto 0);
begin

u1: entity work.relojlento(arqrelojlento) port map(clk,clk25);
u2: entity work.estados(arqestados) port map(clk25, reset,x,y,var1,var2, var3,var4,sal);

end arqtopasm;