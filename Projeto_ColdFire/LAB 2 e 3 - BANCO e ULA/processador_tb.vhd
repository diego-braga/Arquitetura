library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador_tb is
end;

architecture a_processador_tb of processador_tb is

	component processador
		port( 
			readReg1P : in unsigned(2 downto 0);
			readReg2P : in unsigned(2 downto 0);
			
			writeRegP : in unsigned(2 downto 0);
			
			jumpP : in unsigned(15 downto 0);
			
			selecULA: in unsigned(1 downto 0);
			
			selecMUX: in std_logic;
			
			clkP : in std_logic;
			rstP : in std_logic;
			wr_enP : in std_logic;
			
			saidaP : out unsigned(15 downto 0);
			
			maiorP 	: out std_logic;
			carryP	: out std_logic;
			zeroP	: out std_logic
		);
	end component;
	

		signal	readReg1P : unsigned(2 downto 0);
		signal	readReg2P : unsigned(2 downto 0);
			
		signal	writeRegP : unsigned(2 downto 0);
			
		signal	jumpP : unsigned(15 downto 0);
		
		signal	selecULA: unsigned(1 downto 0);
			
		signal	selecMUX: std_logic;
			
		signal	clkP : std_logic;
		signal	rstP : std_logic;
		signal	wr_enP : std_logic;
			
		signal	saidaP : unsigned(15 downto 0);
			
		signal	maiorP 	: std_logic;
		signal	carryP	: std_logic;
		signal	zeroP	: std_logic;
	
	begin

	uut : processador port map(	readReg1P=> readReg1P, 
						readReg2P=> readReg2P,
						writeRegP=> writeRegP, 
						jumpP=> jumpP,
						selecULA=> selecULA,
						selecMUX=>selecMUX,
						clkP=> clkP, 
						rstP=> rstP, 
						wr_enP=> wr_enP, 
						saidaP=> saidaP,
						maiorP=> maiorP,
						carryP=> carryP,
						zeroP=> zeroP
						);
	
	process -- sinal de clock
	begin
		clkP <= '0';
		wait for 50 ns;
		clkP <= '1';
		wait for 50 ns;
	 end process;
	 
	process -- sinal de reset
	begin
		rstP <= '1';
		wait for 100 ns;
		rstP <= '0';
		wait;
	end process;


	process
	begin
	
		readReg1P <= "000"; 			-- Le valor no reg0
		readReg2P <= "001"; 			-- Le valor no reg1
		
		writeRegP <= "000"; 			-- Quer escrever no reg0
		
		jumpP <= "0000000000000000"; 	-- Se pular, pulará para comando 0
		
		selecULA <= "00"; 				-- ULA vai fazer operacao "+"
		
		selecMUX <= '0'; 				-- ULA vai usar valor em readData2
		
		wr_enP <= '1'; 					-- Permite escrita!
		
										-- Saida esperada:	
										--			saidaP = 0
										--			maiorP = 0		
										--			carryP = 0
										--			zeroP = 1;

		wait for 100 ns;

		-- 
		readReg1P <= "000"; 			-- Le valor no reg0
		readReg2P <= "001"; 			-- Le valor no reg1
		
		writeRegP <= "001"; 			-- Quer escrever no reg1
		
		jumpP <= "0000000000000000";	-- Se pular, pulará para comando 0
		
		selecULA <= "11"; 				-- ULA vai fazer operacao "NAND"
		
		selecMUX <= '0'; 				-- ULA vai usar valor em readData2
		
		wr_enP <= '1'; 					-- Permite escrita!
		
										-- Saida esperada:	
										--			saidaP = 65535
										--			maiorP = 0		
										--			carryP = 0
										--			zeroP = 0;
		
		wait for 100 ns;
		
		readReg1P <= "001"; 			-- Le valor no reg1
		readReg2P <= "010"; 			-- Le valor no reg2
		
		writeRegP <= "010"; 			-- Quer escrever no reg2
		
		jumpP <= "0000000000000000";	-- Se pular, pulará para comando 0
		
		selecULA <= "01"; 				-- ULA vai fazer operacao "a-b"
		
		selecMUX <= '0'; 				-- ULA vai usar valor em readData2
		
		wr_enP <= '1'; 					-- Permite escrita!
		
										-- Saida esperada:	
										--			saidaP = 65535  //  0     => readReg2P se iguala a readReg1P após o clock
										--			maiorP = 1		//	0
										--			carryP = 0
										--			zeroP = 0;
		
		wait for 100 ns;
		
		
		readReg1P <= "001"; 			-- Le valor no reg1
		readReg2P <= "010"; 			-- Le valor no reg2
		
		writeRegP <= "011"; 			-- Quer escrever no reg3
		
		jumpP <= "0000000000000000";	-- Se pular, pulará para comando 0
		
		selecULA <= "00"; 				-- ULA vai fazer operacao "+"
		
		selecMUX <= '0'; 				-- ULA vai usar valor em readData2
		
		wr_enP <= '1'; 					-- Permite escrita!
		
										-- Saida esperada:	
										--			saidaP = 65534
										--			maiorP = 0		
										--			carryP = 1
										--			zeroP = 0;
		
		wait for 100 ns;
		
		
		readReg1P <= "011"; 			-- Le valor no reg3
		readReg2P <= "100"; 			-- Le valor no reg4
		
		writeRegP <= "011"; 			-- Quer escrever no reg3
		
		jumpP <= "0000000000100000";	-- Se pular, pulará para comando 32
		
		selecULA <= "01"; 				-- ULA vai fazer operacao "a-b"
		
		selecMUX <= '1'; 				-- ULA vai usar valor em readData2
		
		wr_enP <= '1'; 					-- Permite escrita!
		
										-- Saida esperada:	
										--			saidaP = 65502 // 65470
										--			maiorP = 1	
										--			carryP = 0
										--			zeroP = 0;
		
		wait for 100 ns;

		wait;
	end process;
end architecture;