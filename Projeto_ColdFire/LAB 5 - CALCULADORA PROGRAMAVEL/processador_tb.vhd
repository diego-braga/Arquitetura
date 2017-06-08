library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador_tb is
end;

architecture a_processador_tb of processador_tb is

	component processador
		port( 
				clk_p 	 : 	in std_logic;
				rst_p 	 :  in std_logic;
				estado_p	: out unsigned(1 downto 0);
				PC_p		: out unsigned(6 downto 0);
				instrucao_p	: out unsigned(15 downto 0);
				Reg1_p		: out unsigned(15 downto 0);
				Reg2_p		: out unsigned(15 downto 0);
				saida_ULA_p	: out unsigned(15 downto 0)
		);
	end component;
	
	signal clk	    	: std_logic;
	signal rst			: std_logic;
	signal estado  		: unsigned(1 downto 0);
	signal PC  			: unsigned(6 downto 0);
	signal instrucao	: unsigned(15 downto 0);
	signal Reg1			: unsigned(15 downto 0);
	signal Reg2			: unsigned(15 downto 0);
	signal saida_ULA  	: unsigned(15 downto 0);
		
	begin

	uut : processador port map(	 
								clk_p 		=> clk,
								rst_p 		=> rst,
								estado_p 	=> estado,
								PC_p 		=> PC,
								instrucao_p	=> instrucao,
								Reg1_p		=> Reg1,
								Reg2_p		=> Reg2,
								saida_ULA_p	=> saida_ULA
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
	
	
	begin
	
		wait for 4500 ns;
		wait;
		
	end process;
	
end architecture;