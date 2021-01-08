library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_UNSIGNED.all;

entity mirom is
port(
clk: in std_logic;
bus_dir: in std_logic_vector(11 downto 0);
cs: in std_logic;
bus_datos: out std_logic_vector (3 downto 0)); --3 era 11
end mirom;

architecture arqmirom of mirom is

type memoria is array (16383 downto 0) of std_logic_vector(3 downto 0);--3 era 11
signal mem_rom:memoria;
attribute ram_init_file: string;
attribute ram_init_file of mem_rom: signal is "brom3.mif";
signal dato: std_logic_vector(3 downto 0);----3 era 11

begin

--  prom: process(bus_dir)
--     begin
--       dato <= mem_rom(conv_integer(bus_dir));
--		 end process prom;
--  pbuf: process (dato,cs)
--    begin
--       if(cs='1') then
--          bus_datos<=dato;
--       else
--          bus_datos <= (others=>'Z');
--       end if;
--   end process pbuf;
	
  process(clk)
	begin
	    if rising_edge(clk) then
		    if (cs='1') then
			    dato <= mem_rom(conv_integer(bus_dir));
			 end if;
		 end if;	 
  end process;
	
 end arqmirom;
