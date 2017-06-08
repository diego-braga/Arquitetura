library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC_tb is
end;

architecture a_UC_tb_tb of UC_tb is

	component UC
		port( 
				clk 	 : 	in std_logic;
				rst 	 :  in std_logic
		);
	end component;
	
	signal clk      : std_logic;
	signal rst		: std_logic;
		
	begin

	uut : UC port map(	 
									clk=> clk,
									rst=> rst
								);
	
	process -- sinal de clock
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	 end process;
	 
	process -- sinal de reset
	begin
		rst <= '1';
		wait for 10 ns;
		rst <= '0';
		wait;
	end process;

	process
	
		-- executa as instrucoes presentes na ROM, executando as instrucoes contidas nos enderecos na seguinte ordem: 
		--  0 -> 1 -> 5 -> 3 -> 4 -> 8 -> 9 ->10 -> 8 -> 9... E permanece nesse loop (8 -> 9 -> 10 -> 8) ate o fim da execucao
		-- Como explicado no arquivo rom.vhd
	
	begin
		
		-- Serao executadas 8 instrucoes ate entrar no loop. Para executar estas 8 instrucoes iniciais serao gastos 16 clocks
		-- Ao total este teste executa 30 clocks, executando 15 instrucoes.
	
		wait for 3000 ns;
		wait;
	end process;
end architecture;