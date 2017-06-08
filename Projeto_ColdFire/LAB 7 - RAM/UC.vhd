library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is
	port( 	clk 			: in std_logic;
			rst				: in std_logic;
			opcode  		: in unsigned(3 downto 0);
			borrow			: in std_logic;
			zero			: in std_logic;
			
			estadoUC		: out unsigned(1 downto 0);
			jump			: out unsigned(1 downto 0);
			wr_en_PC		: out std_logic;
			selec_wrData	: out unsigned(1 downto 0);
			wr_en_b			: out std_logic;
			selec_ULA		: out unsigned(1 downto 0);
			cmp				: out std_logic;
			wr_en_ram		: out std_logic
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
	
	jump <= "01" when opcode = "1111" and estado = "10" else
			"10" when (opcode = "1010" and zero = '1') or ( opcode = "1011" and borrow = '1') else
			"00";
					
	selec_wrData <=	"00" when opcode = "0010" and estado = "10" else
					"01" when ( opcode = "0011"
							or opcode = "0100"
							or opcode = "0110"
							or opcode = "0111") and estado = "10" else
					"10" when opcode = "1100" else
					'0';
					
	wr_en_b <= 		'1' when ( opcode = "0010"
							or opcode = "0011"
							or opcode = "0100"
							or opcode = "0110"
							or opcode = "0111") and estado = "10" else
					'0';
	
	cmp <= 		'1' when opcode = "1001" and estado = "10" else
				'0';
	
	selec_ULA <= 	"00" when opcode = "0100" and estado = "10" else
					"01" when opcode = "0110" and estado = "10" else
					"11" when opcode = "0011" and estado = "10" else
					"01" when opcode = "1001" and estado = "10" else
					"10";

	wr_en_ram <= '1' when opcode = "1101" and estado = "10" else
				 '0';
		
	estadoUC <= estado;					
	
end architecture;
	