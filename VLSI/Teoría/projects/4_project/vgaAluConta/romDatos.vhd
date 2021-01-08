library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_UNSIGNED.all;
entity romDatos is port
(
	bus_dir: in std_logic_vector(2 downto 0);
	cs: in std_logic;
	bus_datos: out std_logic_vector(2 downto 0)	
);
end romDatos;
architecture arqromDatos of romDatos is
	constant L0: std_logic_vector(2 downto 0):="000";
	constant L1: std_logic_vector(2 downto 0):="001";
	constant L2: std_logic_vector(2 downto 0):="010";
	constant L3: std_logic_vector(2 downto 0):="011";
	constant L4: std_logic_vector(2 downto 0):="100";
	constant L5: std_logic_vector(2 downto 0):="101";
	constant L6: std_logic_vector(2 downto 0):="110";
	constant L7: std_logic_vector(2 downto 0):="111";
	type memoria is array (7 downto 0) of std_logic_vector(2 downto 0);
	constant mem_rom:memoria:=(L7,L6,L5,L4,L3,L2,L1,L0);
	signal dato: std_logic_vector(2 downto 0);
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
end arqromDatos;