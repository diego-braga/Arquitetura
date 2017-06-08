library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador_tb is
end;

architecture a_contador_tb of contador_tb is
	component contador
		port(	data_in_contador  : 	in unsigned(6 downto 0);
				data_out_contador : 	out unsigned(6 downto 0)
			);
	end component;
	
	signal data_in_contador  : unsigned(6 downto 0);	
	signal data_out_contador : unsigned(6 downto 0);
	
	begin
		uut : contador  port map(	data_in => data_in,
									data_out => data_out
						   );
	
	process
	begin
		data_in_contador <= "0000000"; -- vai receber data_in=0000000 a saida deve ser data_out = 0000001
		wait for 150 ns;
		data_in_contador <= "0000001"; -- vai receber data_in=0000001 a saida deve ser data_out = 0000010
		wait for 150 ns;
		data_in_contador <= "0000010"; -- vai receber data_in=0000010 a saida deve ser data_out = 0000011
		wait for 150 ns;
		data_in_contador <= "0000011"; -- vai receber data_in=0000011 a saida deve ser data_out = 0000100
		wait for 150 ns;
		data_in_contador <= "0000100"; -- vai receber data_in=0000100 a saida deve ser data_out = 0000101
		wait for 150 ns;		
		wait;		
	end process;
end architecture;