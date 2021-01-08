library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ram is port(
	AddrWr	: in std_logic_vector (1 downto 0);--Direccion de memoria
	AddrRd	: in std_logic_vector (1 downto 0);--Direccion de lectura
	clkWr		: in std_logic;
	clkRd		: in std_logic;
	wren		: in std_logic;
	dataIn	: in std_logic_vector(2 downto 0);--Registro de entrada
	dataOut	: out std_logic_vector(2 downto 0);--Registro de salida
	ledcarga	:out std_logic:='0'
);
end ram;
architecture arqram of ram is
	type matrix is array (0 to 3) of std_logic_vector (2 downto 0);
	signal memory: matrix;
	signal dataInBuff:std_logic_vector(2 downto 0);
	signal AddressWrite: std_logic_vector(1 downto 0);
	signal AddressRead : std_logic_vector(1 downto 0);
begin	
	process(clkWr)
	begin 
		if(clkWr' event and clkWr ='1' and wren='1') then
			dataInBuff<=dataIn;
			AddressWrite<=AddrWr;
			memory(to_integer(unsigned(AddressWrite)))<=dataInBuff;
			ledcarga<='1'; --led de aviso de cargado
		end if;
	end process;
	process(clkRd)
	begin
		if(clkRd' event and clkRd='1') then
			AddressRead <= AddrRd;
			dataOut<=memory(to_integer(unsigned(AddressRead)));
		end if;
	end process;
end architecture;