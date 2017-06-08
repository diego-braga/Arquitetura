library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MaqEstados_tb is
end;

architecture a_MaqEstados_tb of MaqEstados_tb is
	component MaqEstados
		port(	clk : in std_logic;
				rst : in std_logic;
				wr_en : in std_logic;
				saida : out std_logic
			);			
	end component;
	
	signal clk : std_logic;
	signal rst : std_logic;
	signal wr_en : std_logic;
	signal saida : std_logic;
	
	begin
		uut : MaqEstados  port map(	clk => clk,
									rst => rst,
									wr_en => wr_en,
									saida => saida
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
		rst <= '1';			-- o rst fica em 1 por 700 ns para ver que a saída fica em 0 enquanto rst = 1
		wait for 700 ns; 	-- 700 ns para que esteja ativo o wr_en e verificar que independente do wr_en e da subida do clock, a saida permanece 0
		rst <= '0';			-- devido ao rst = 1
		wait;
	end process;

	process
	begin
		wr_en <= '1'; 		-- não tenho certeza se precisa do wr_en, caso precisar: aqui o wr_en ta ativo permitindo a mudança de estado quando
							--ocorrer uma subida do clock
		wait for 2200 ns;
		wr_en <= '0';		-- quando wr_en = 0 a saida permancesse inalterada com a subida de clock
		wait for 800 ns;				
		wait;		
	end process;
end architecture;