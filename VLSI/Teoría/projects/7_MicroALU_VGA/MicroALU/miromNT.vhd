library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_UNSIGNED.all;

entity miromNT is port(
	bus_dir: in std_logic_vector(3 downto 0);
	cs: in std_logic;
	bus_datos: out std_logic_vector(15 downto 0);
	ledfetch: out std_logic_vector(6 downto 0)
);
end miromNT;

architecture arqmiromNT of miromNT is

type memoria is array (15 downto 0) of std_logic_vector(15 downto 0);
signal mem_rom : memoria;
attribute ram_init_file: string;
attribute ram_init_file of mem_rom: signal is "instruct.mif";

signal dato: std_logic_vector(15 downto 0);

begin
	prom: process(bus_dir)
	begin
		dato<=mem_rom(conv_integer(bus_dir));
	end process prom;
	
	pbuf: process(dato,cs)
	begin 
		if(cs='1') then
			bus_datos<=dato;
		else
			bus_datos<=(others=>'Z');
		end if;
	end process pbuf;
	
	with bus_dir select
	ledfetch<= "1000000" when "0000", ----0
				  "1111001" when "0001", ---1
				  "0100100" when "0010", -- 2
				  "0110000" when "0011", --- 3
				  "0011001" when "0100", -- 4
				  "0010010" when "0101", -- 5
				  "0000010" when "0110", -- 6
				  "1111000" when "0111", -- 7
				  "0000000" when "1000",  -- 8
				  "0011000" when "1001",  -- 9
				  "0001000" when "1010",  -- A
				  "0000011" when "1011",  -- B
				  "1000110" when "1100",  -- C
				  "0100001" when "1101",  -- D
				  "0000110" when "1110",  -- E
				  "0001110" when "1111",  -- F  
				  "1111111" when others;
end arqmiromNT;