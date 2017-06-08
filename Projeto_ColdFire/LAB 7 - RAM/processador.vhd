library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
	port( 	clk_p 	 	: in std_logic;
			rst_p		: in std_logic;
			
			estado_p	: out unsigned(1 downto 0);
			PC_p		: out unsigned(6 downto 0);
			instrucao_p	: out unsigned(15 downto 0);
			Reg1_p		: out unsigned(15 downto 0);
			Reg2_p		: out unsigned(15 downto 0);
			saida_ULA_p	: out unsigned(15 downto 0)
			
	);
end entity;

architecture a_processador of processador is
	
	component contador is
		port(	
			data_in_contador  : in unsigned(6 downto 0);
			data_out_contador : out unsigned(6 downto 0)
		);
	end component;	

	component PC is
		port(	
			clk 	 	: in std_logic;
			wr_en 	 	: in std_logic;
			rst		 	: in std_logic;
			data_in  	: in unsigned(6 downto 0);
			data_out 	: out unsigned(6 downto 0)
		);
	end component;
	
	component rom is
		port(	
			clk 		: in std_logic;
			endereco 	: in unsigned(6 downto 0);
			dado 		: out unsigned(15 downto 0)
		);
	end component;
	
	component banco is
		port( 
			readReg1 	: in unsigned(2 downto 0);
			readReg2 	: in unsigned(2 downto 0);
			writeData 	: in unsigned(15 downto 0); 
			writeReg 	: in unsigned(2 downto 0);
			clk 		: in std_logic;
			rst 		: in std_logic;
			wr_en 		: in std_logic;
			readData1 	: out unsigned(15 downto 0);
			readData2 	: out unsigned(15 downto 0)
		);
	end component;
	
	component ULA is
		port(	
			entr0		: in unsigned(15 downto 0);
			entr1		: in unsigned(15 downto 0);
			selec		: in unsigned(1 downto 0);
			saida		: out unsigned(15 downto 0);
			maior 		: out std_logic;
			carry		: out std_logic;
			borrow  	: out std_logic;
			zero		: out std_logic
		);
	end component;
	
	component decoder is
		port( 
			dado 		: in unsigned(15 downto 0);
			opcode 		: out unsigned(3 downto 0);
			reg1		: out unsigned(2 downto 0);
			reg2		: out unsigned(2 downto 0);
			wrData 		: out unsigned(15 downto 0)
		);
	end component;
	
	component UC is
		port( 	
			clk 		: in std_logic;
			rst			: in std_logic;
			opcode  	: in unsigned(3 downto 0);
			borrow		: in std_logic;
			zero 		: in std_logic;
			estadoUC	: out unsigned(1 downto 0);
			jump		: out unsigned(1 downto 0);
			wr_en_PC	: out std_logic;
			selec_wrData: out unsigned(1 downto 0);
			wr_en_b		: out std_logic;
			selec_ULA	: out unsigned(1 downto 0);
			cmp			: out std_logic;
			wr_en_ram	: out std_logic
		);
	end component;

	component reg1bit is
		port( 
			entrada 	: in std_logic;
			clk 		: in std_logic;
			rst 		: in std_logic;
			saida 		: out std_logic
			
		);
	end component;

	component ram is
	port(
			clk 		: in std_logic;
			endereco 	: in unsigned(15 downto 0);
			wr_en 		: in std_logic;
			dado_in 	: in unsigned(15 downto 0);
			dado_out 	: out unsigned(15 downto 0)
	);
	end component;
	
	
	signal readReg1_d_b				: unsigned(2 downto 0);
	signal readReg2_d_b				: unsigned(2 downto 0);
	signal wrData_d					: unsigned(15 downto 0);
	signal readData1_b_ULA			: unsigned(15 downto 0);
	signal readData2_b_ULA			: unsigned(15 downto 0);
	
	signal wrData_b					: unsigned(15 downto 0);
	
	signal saida_ULA				: unsigned(15 downto 0);
	
	signal dataIn_PC				: unsigned(6 downto 0);
	signal dataOut_PC_In_c			: unsigned(6 downto 0);
	signal dataOut_c				: unsigned(6 downto 0);
	
	signal dado_r_d					: unsigned(15 downto 0);
	
	signal opcode_d_UC				: unsigned(3 downto 0);
		
	signal jump						: unsigned(1 downto 0);
	signal wr_en_PC					: std_logic;
	signal selec_wrData				: std_logic;
	signal wr_en_b					: std_logic;
	signal selec_ULA				: unsigned(1 downto 0);
	signal cmp						: std_logic;
	
	signal maior_ULA				: std_logic;
	signal carry_ULA				: std_logic;
	signal borrow_ULA				: std_logic;
	signal zero_ULA					: std_logic;		
	
	signal borrow_UC				: std_logic;
	signal zero_UC					: std_logic;
	
	signal jumpCond					: unsigned(6 downto 0);
	
	signal clk_borrow_zero			: std_logic;

	signal end_ram					: unsigned(15 downto 0);
	signal wr_en_ram				: std_logic;
	signal data_out_ram				: unsigned(15 downto 0);


	
	
begin
	PC0 	  	: PC port map(
					data_in 	=> dataIn_PC, 
					data_out	=> dataOut_PC_In_c,
					clk			=> clk_p,
					wr_en		=> wr_en_PC,
					rst			=> rst_p
					);		
				
	contador0 	: contador port map(
					data_in_contador 	=> dataOut_PC_In_c,
					data_out_contador	=> dataOut_c
					);
				
	rom0	  	: rom port map(
					clk			=> clk_p,
					endereco	=> dataOut_PC_In_c,
					dado		=> dado_r_d
					);
					
	ULA0: ULA port map(	
					entr0	=> readData1_b_ULA,
					entr1	=> readData2_b_ULA,
					selec	=> selec_ULA,
					saida	=> saida_ULA,
					maior	=> maior_ULA,
					carry	=> carry_ULA,
					borrow	=> borrow_ULA,
					zero	=> zero_ULA
					);
	
	banco0: banco port map(	
					readReg1	=> readReg1_d_b, 
					readReg2	=> readReg2_d_b, 
					writeData	=> wrData_b, 
					writeReg	=> readReg2_d_b, 
					clk			=> clk_p, 
					rst			=> rst_p,
					wr_en		=> wr_en_b,
					readData1	=> readData1_b_ULA,
					readData2	=> readData2_b_ULA
					);
					
	decoder0: decoder port map( 
					dado 	=> dado_r_d,
					opcode 	=> opcode_d_UC,
					reg1	=> readReg1_d_b,
					reg2	=> readReg2_d_b,
					wrData 	=> wrData_d
					);
					
	UC0: UC port map(
					clk 		=> clk_p,
					rst 		=> rst_p,	
					opcode 		=> opcode_d_UC,
					borrow		=> borrow_UC,
					zero 		=> zero_UC,
					jump 		=> jump,
					wr_en_PC 	=> wr_en_PC,
					selec_wrData=> selec_wrData,
					wr_en_b		=> wr_en_b,
					selec_ULA 	=> selec_ULA,
					estadoUC	=> estado_p,
					cmp			=> cmp,
					wr_en_ram	=> wr_en_ram
					);
					
	reg_borrow: reg1bit port map(
					entrada => borrow_ULA,
					clk 	=> clk_borrow_zero,
					rst 	=> rst_p,
					saida 	=> borrow_UC
					);
					
	reg_zero: reg1bit port map(
					entrada => zero_ULA,
					clk 	=> clk_borrow_zero,
					rst 	=> rst_p,
					saida 	=> zero_UC
					);

	ram0: ram port map(
					clk 		=> clk_p,
					endereco 	=> end_ram,
					wr_en 		=> wr_en_ram,
					dado_in 	=> readData1_b_ULA,
					dado_out 	=> data_out_ram
					);

	
	
	wrData_b <= wrData_d when selec_wrData = '00' else
				saida_ULA when selec_wrData = '01' else
				data_out_ram when selec_wrData = '10' else
				"0000000000000000";
				
	jumpCond <= dataOut_PC_In_c + wrData_d(6 downto 0);
		
	dataIn_PC <= dataOut_c when jump = "00" else
				 readData1_b_ULA(6 downto 0) when jump = "01" else
				 jumpCond when jump = "10" else
				 "0000000";
	
	PC_p		<= dataOut_PC_In_c;
	instrucao_p	<= dado_r_d;
	Reg1_p		<= readData1_b_ULA;
	Reg2_p		<= readData2_b_ULA;
	saida_ULA_p	<= saida_ULA;
	
	clk_borrow_zero <=  clk_p and (not selec_ULA(1) or selec_ULA(0));

	end_ram <= 	readData1_b_ULA when wr_en_ram = '0' else
				readData2_b_ULA when wr_en_ram = '1' else
				'0';
	
	
end architecture;
