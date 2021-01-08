library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pixel_control is 
generic
(
	h_frame: integer :=640;
	v_frame:	integer :=480;
	numrow: integer :=20;
	talla: integer :=9
);
port(
	row: in integer range 0 to v_frame-1;
	column: in integer range 0 to h_frame-1;
	address: out std_logic_vector (talla-1 downto 0)
);
end entity;

architecture arqpixel_control of pixel_control is
	signal addr: integer range 0 to h_frame*v_frame-1:=0;
begin
	address<=std_logic_vector(to_unsigned(numrow*row+column,address'length));
end architecture arqpixel_control;