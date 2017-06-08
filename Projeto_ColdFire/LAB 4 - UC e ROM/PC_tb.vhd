library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_tb is
end;

architecture a_PC_tb of PC_tb is
	component PC
		port(	clk 	 : 	in std_logic;
				wr_en 	 : 	in std_logic;
				rst		 :  in std_logic;
				data_in  : 	in unsigned(6 downto 0);
				data_out : 	out unsigned(6 downto 0)
			);			
	end component;
	
	signal clk 		: std_logic;
	signal wr_en 	: std_logic;
	signal rst 		: std_logic;
	signal data_in  : unsigned(6 downto 0);
	signal data_out : unsigned(6 downto 0);
	
	begin
		uut : PC  port map(	clk => clk,
							wr_en => wr_en,
							rst => rst,
							data_in => data_in,
							data_out => data_out
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
		wait for 1 ns;
		rst <= '0';
		wait;
	end process;

	
	process
	begin
		wr_en <= '1';
		data_in <= "1111111"; -- com wr_en = 1 sempre, a entrada é data_in = 1111111, quando ocorrer uma subida de clock deve ser atribuida a saída
							  -- data_out = 1111111
		wait for 100 ns;
		wr_en <= '1';
		data_in <= "0000000"; -- com wr_en = 1 sempre, a entrada é data_in = 0000000, quando ocorrer uma subida de clock deve ser atribuida a saída
							  -- data_out = 0000000
		wait for 100 ns;
		wr_en <= '1';
		data_in <= "0000001"; -- com wr_en = 1 sempre, a data_in = 0000001, quando ocorrer uma subida de clock deve ser atribuida a saída
							  -- data_out = 0000001
		wait for 100 ns;
		wr_en <= '1';
		data_in <= "0000010"; -- com wr_en = 1 sempre, a data_in = 0000010, quando ocorrer uma subida de clock deve ser atribuida a saída
							  -- data_out = 0000010
		wait for 100 ns;
		wr_en <= '1';
		data_in <= "0000011"; -- com wr_en = 1 sempre, a data_in = 0000011, quando ocorrer uma subida de clock deve ser atribuida a saída
							  -- data_out = 0000011
		wait for 100 ns;				
		wait;		
	end process;
end architecture;