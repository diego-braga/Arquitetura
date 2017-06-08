library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_tb is
end;

architecture a_banco_tb of banco_tb is

	component banco
		port( 
		readReg1 : in unsigned(2 downto 0);
		readReg2 : in unsigned(2 downto 0);
		
		writeData : in unsigned(15 downto 0); 
		writeReg : in unsigned(2 downto 0);
		
		clk : in std_logic;
		rst : in std_logic;
		wr_en : in std_logic;
		
		readData1 : out unsigned(15 downto 0);
		readData2 : out unsigned(15 downto 0)
		);
	end component;
	

	signal readReg1 : unsigned(2 downto 0);
	signal readReg2 : unsigned(2 downto 0);
	
	signal writeData : unsigned(15 downto 0); 
	signal writeReg : unsigned(2 downto 0);
	
	signal clk : std_logic;
	signal rst : std_logic;
	signal wr_en : std_logic;
	
	signal readData1 : unsigned(15 downto 0);
	signal readData2 : unsigned(15 downto 0);
	
	begin

	uut : banco port map(	readReg1=> readReg1, 
						readReg2=> readReg2, 
						writeData=> writeData, 
						writeReg=> writeReg, 
						clk=> clk, 
						rst=> rst, 
						wr_en=> wr_en, 
						readData1=> readData1, 
						readData2=> readData2
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
		wait for 100 ns;
		rst <= '0';
		wait;
	end process;


	process
	begin
	
		readReg1 <= "000"; 					-- Le valor no reg0
		readReg2 <= "001"; 					-- Le valor no reg1
		
		writeData <= "0000000000000001"; 	-- Le valor para escrita = 1
		writeReg <= "000"; 					-- Quer escrever no reg0
		
		wr_en <= '1'; 						-- Permite escrita!
		
											-- Saida esperada:	
											--			readData1 = 0
											--			readData2 =  0				

		wait for 100 ns;

		readReg1 <= "000"; 					-- Le valor no reg0
		readReg2 <= "001"; 					-- Le valor no reg2
		
		writeData <= "0000000000000001"; 	-- Le valor para escrita = 1
		writeReg <= "001"; 					-- Quer escrever no reg0
		
			wr_en <= '1'; 					-- Permite escrita!
			
											-- Saida esperada:	
											--			readData1 = 0
											--			readData2 = 0
		
		wait for 100 ns;

		readReg1 <= "001"; 					-- Le valor no 1
		readReg2 <= "010"; 					-- Le valor no reg2
		
		writeData <= "0000000000000010"; 	-- Le valor para escrita = 2
		writeReg <= "010" ;					-- Quer escrever no reg2
		
		wr_en <= '0'; 						-- NAO permite escrita!
		
											-- Saida esperada:	
											--			readData1 = 1
											--			readData2 = 0
		
		wait for 100 ns;

		readReg1 <= "001"; 					-- Le valor no reg1
		readReg2 <= "010"; 					-- Le valor no reg2
		
		writeData <= "0000000000100000"; 	-- Le valor para escrita = 32
		writeReg <= "010"; 					-- Quer escrever no reg2
		
		wr_en <= '1'; 						-- Permite escrita!
		
											-- Saida esperada:	
											--			readData1 = 1
											--			readData2 = 0
				
				
		wait for 100 ns;
		
											-- Saida esperada:	
											--			readData1 = 1
											--			readData2 = 32
		
		wait;
	end process;
end architecture;