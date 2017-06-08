library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador is
	port( 	data_in_contador  : 	in unsigned(6 downto 0);
			data_out_contador : 	out unsigned(6 downto 0)
	);
end entity;

architecture a_contador of contador is
begin
		data_out_contador <= data_in_contador + "0000001";
end architecture;
