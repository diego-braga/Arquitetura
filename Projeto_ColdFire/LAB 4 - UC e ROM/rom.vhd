library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port(	clk : in std_logic;
			endereco : in unsigned(6 downto 0);
			dado : out unsigned(15 downto 0)
		);
end entity;

architecture a_rom of rom is
	type mem is array (0 to 127) of unsigned(15 downto 0);
	constant conteudo_rom : mem :=(
	
	0 => "0000000000000111", -- Opcode 0000 => NAO PULA, acessa próxima instrução
	
	1 => "1111000000000101", -- Opcode 1111 => PULA para o endereço 5
	
	2 => "0000000000000000", -- Pulado
	
	3 => "0000000000100000", -- Opcode 0000 => NAO PULA, acessa próxima instrução
	
	4 => "1111000000001000", -- Opcode 1111 => PULA para o endereço 8
	
	5 => "0000000000000001", -- Opcode 0000 => NAO PULA, acessa próxima instrução
	
	6 => "1111000000000011", -- Opcode 1111 => PULA para o endereço 3
	
	7 => "1000000000000001", -- Pulado
	
	8 => "0000000000000110", -- Opcode 0000 => NAO PULA, acessa próxima instrução
	
	9 => "0000000000000011", -- Opcode 0000 => NAO PULA, acessa próxima instrução
	
	10 => "1111000000001000", -- Opcode 1111 => PULA para o endereco 8, e inicializa um LOOP
	
	others => (others=> '0')
	);
	
	begin
		process(clk)
		begin
			if(rising_edge(clk)) then
				dado <= conteudo_rom(to_integer(endereco));
			end if;
		end process;
end architecture;