library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is
	port( 	clk 	 : 	in std_logic;
			rst		 :  in std_logic
	);
end entity;

architecture a_UC of UC is
	
	component contador is
		port(	data_in_contador  : 	in unsigned(6 downto 0);
				data_out_contador : 	out unsigned(6 downto 0)
			);
	end component;	

	component PC is
		port(	clk 	 : 	in std_logic;
				wr_en 	 : 	in std_logic;
				rst		 :  in std_logic;
				data_in  : 	in unsigned(6 downto 0);
				data_out : 	out unsigned(6 downto 0)
			);
	end component;
	
	component rom is
	port(	clk : in std_logic;
			endereco : in unsigned(6 downto 0);
			dado : out unsigned(15 downto 0)
		);
	end component;
	
	component MaqEstados is
	port( 	clk : in std_logic;
			rst : in std_logic;
			saida : out std_logic
			
	);
	end component;
	
	signal enderecoOutPC_InContador	: unsigned(6 downto 0);
	signal enderecoInPC				: unsigned(6 downto 0);
	signal enderecoOutContador		: unsigned(6 downto 0);
	signal saidaROM					: unsigned(15 downto 0);
	signal estado					: std_logic;
	signal opcode					: unsigned(3 downto 0);
	signal jump						: std_logic;
	signal wr_en					: std_logic;


	
	
begin
	PC1 	  	: PC port map(
					data_in 	=> enderecoInPC, 
					data_out	=> enderecoOutPC_InContador, 
					clk			=> clk, 
					wr_en		=> wr_en, 
					rst			=> rst
					);		
				
	contador1 	: contador port map(
					data_in_contador 	=> enderecoOutPC_InContador, 
					data_out_contador	=> enderecoOutContador
					);
				
	rom1	  	: rom port map(
					clk			=> clk, 
					endereco	=> enderecoOutPC_InContador, 
					dado		=> saidaROM
					);
					
	MaqEstados1 : MaqEstados port map(
					clk		=> clk,
					rst		=> rst,
					saida	=> estado
					);

	wr_en <= estado;
	
	opcode <= saidaROM(15 downto 12);
	
	jump <= '1' when opcode="1111" else
			'0';
	
	enderecoInPC <= enderecoOutContador when jump = '0' else
					saidaROM(6 downto 0) when jump = '1' else
					"0000000";
	

	
end architecture;
