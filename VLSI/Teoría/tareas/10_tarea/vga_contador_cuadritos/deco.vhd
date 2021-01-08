library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_UNSIGNED.all;

entity deco is
port(
i: in std_logic_vector (31 downto 0);--instruccion de 32 bits

bus_datos: out std_logic_vector (6 downto 0));
end deco;

architecture arqdeco of deco is
signal opcode:  std_logic_vector(6 downto 0):="000" & "000"
signal rs:      std_logic_vector(5 downto 0):="000" & "00";
signal rt:      std_logic_vector(5 downto 0):="000" & "00";
signal rd:      std_logic_vector(5 downto 0):="000" & "00";
signal offset:   std_logic_vector(5 downto 0):="000" & "00";
signal funtion:   std_logic_vector(5 downto 0):="000" & "00";


begin
 
 --separados
opcode<= i(31 downto 26);
rs <= i(25 downto 21);
rt <= i(20 downto 16);
rd <= i(15 downto 11);
offset <= i(10 downto 6);
funcion <= i(5 downto 0);
 
if opcode="00&00&00" then  --es tipo R
   if funcion = "10&00&00" then  --es suma
   if funcion = "10&01&00" then  --es and
   if funcion = "10&01&11" then  -- es nor
   if funcion = "10&01&01" then  -- es or
   if funcion = "10&10&00" then  -- slt

if offset= "00&000"	then --no hay salto
else    --hay un salto

--almacenar en registro  los operandos rs y rt
	
 end arqdeco;
