library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is
	port( 	clk 			: in std_logic;
			rst				: in std_logic;
			opcode  		: in unsigned(3 downto 0);
			
			estadoUC		: out unsigned(1 downto 0);
			jump			: out std_logic;
			wr_en_PC		: out std_logic;
			selec_wrData	: out std_logic;
			wr_en_b			: out std_logic;
			selec_ULA		: out unsigned(1 downto 0)
	);
end entity;

architecture a_UC of UC is
	
	component MaqEstados is
		port( 	
			clk : in std_logic;
			rst : in std_logic;
			estado : out unsigned(1 downto 0)
				
		);
	end component;
	
	
	signal estado : unsigned(1 downto 0);	
	
	
	begin
	
		
	MaqEstados0 : MaqEstados port map(
					clk		=> clk,
					rst		=> rst,
					estado	=> estado
					);
	
	

	wr_en_PC <= '1' when estado = "10" else
				'0';
	
	jump <= '1' when opcode = "1111" and estado = "10" else
			'0';
					
	selec_wrData <=	'0' when opcode = "0010" and estado = "10" else
					'1' when ( opcode = "0011"
							or opcode = "0100"
							or opcode = "0110"
							or opcode = "0111") and estado = "10" else
					'0';
					
	wr_en_b <= 		'1' when ( opcode = "0010"
							or opcode = "0011"
							or opcode = "0100"
							or opcode = "0110"
							or opcode = "0111") and estado = "10" else
					'0';
	
	selec_ULA <= 	"00" when opcode = "0100" and estado = "10" else
					"01" when opcode = "0110" and estado = "10" else
					"10" when opcode = "0111" and estado = "10" else
					"11" when opcode = "0011" and estado = "10" else
					"00";
		
	estadoUC <= estado;					
	
end architecture;
	