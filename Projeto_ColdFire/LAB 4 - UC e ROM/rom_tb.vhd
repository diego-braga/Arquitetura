library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end;

architecture a_rom_tb of rom_tb is
	component rom
		port(	clk : in std_logic;
				endereco : in unsigned(6 downto 0);
				dado : out unsigned(15 downto 0)
			);
	end component;
	signal clk : std_logic;
	signal endereco : unsigned(6 downto 0);
	signal dado : unsigned(15 downto 0);	
	
	begin
		uut : rom  port map(	clk => clk,
								endereco => endereco,
								dado => dado								
						   );
						   
	process -- sinal de clock
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;
	
	process
	begin
		endereco <= "0000000"; -- atribui a saída o dado 0000000000000101 contido no endereco 0
		wait for 100 ns;
		endereco <= "0000001"; -- atribui a saída o dado 1000000000000000 contido no endereco 1
		wait for 100 ns;
		endereco <= "0000010"; -- atribui a saída o dado 0000000000001111 contido no endereco 2
		wait for 100 ns;
		endereco <= "0000011"; -- atribui a saída o dado 0000000000100000 contido no endereco 3
		wait for 100 ns;
		endereco <= "0000100"; -- atribui a saída o dado 1100000000000000 contido no endereco 4
		wait for 100 ns;
		endereco <= "0000101"; -- atribui a saída o dado 0000000000000001 contido no endereco 5
		wait for 100 ns;
		endereco <= "0000110"; -- atribui a saída o dado 1110000000000111 contido no endereco 6
		wait for 100 ns;
		endereco <= "0000111"; -- atribui a saída o dado 1000000000000001 contido no endereco 7
		wait for 100 ns;
		endereco <= "0001000"; -- atribui a saída o dado 0000000000000110 contido no endereco 8
		wait for 100 ns;
		endereco <= "0001001"; -- atribui a saída o dado 0000000000000011 contido no endereco 9
		wait for 100 ns;
		endereco <= "0001010"; -- atribui a saída o dado 1111111111111111 contido no endereco 10
		wait for 100 ns;
		wait;		
	end process;
end architecture;