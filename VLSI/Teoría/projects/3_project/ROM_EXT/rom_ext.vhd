library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_UNSIGNED.all;

entity rom_ext is port(
	bus_dir: in std_logic_vector(1 downto 0);
	cs: in std_logic;
	bus_data: out std_logic_vector (6 downto 0)
);
end rom_ext;

architecture arqrom of rom_ext is 
type memoria is array (3 downto 0) of std_logic_vector(6 downto 0);
signal mem_rom : memoria;
attribute ram_init_file : string;
attribute ram_init_file of mem_rom : signal is "datos.mif";

signal dato: std_logic_vector (6 downto 0);

begin
	prom: process (bus_dir)
	begin
		dato <= mem_rom( conv_integer (bus_dir));
			end process prom;
	
	pbuf: process (dato, cs)
	begin
		if (cs='1') then
			bus_data<=dato;
		else
			bus_data<= (others=>'Z');
		end if;
	end process pbuf;
end arqrom;