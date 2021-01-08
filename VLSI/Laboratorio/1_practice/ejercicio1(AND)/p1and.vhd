library ieee;
use ieee.std_logic_1164.all;

entity p1and is
port(
a,b: in std_logic;
c: out std_logic
);
end p1and;

architecture arqp1and of p1and is
begin
c<=a and b;
end architecture arqp1and;