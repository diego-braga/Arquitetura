library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port(	clk : in std_logic;
			endereco : in unsigned(6 downto 0);
			dado : out unsigned(15 downto 0)
		);
end entity;

architecture a_rom of rom is
	type mem is array (0 to 127) of unsigned(15 downto 0);
	constant conteudo_rom : mem :=(
	
		-- INSTRUCOES			    ASSEMBLY		 PASSO
	
	0 => "0010011000000000", 	-- MOVEQ #0, D3		  - 1
	
	1 => "0010100000000000",	-- MOVEQ #0, D4	      - 2
	
	2 => "0100100000000011", 	-- MOVE D3, D4		  - 3
								--					 
	3 => "0010001000000001", 	-- MOVEQ #1, D1		-|		
								--					 |- 4
	4 => "0100011000000001", 	-- ADD D1, D3		-|
								--					 
	5 => "0010010000011110", 	-- MOVEQ #30, D2    -|
								--					 |
	6 => "1001011000000010", 	-- CMP D2, D3		-|- 5
								--					 |
	7 => "1011000011111100", 	-- BGT -4		    -|
	
	8 => "0011101000000100", 	-- MOVE D4, D5		  - 6
	
	others => (others=> '0')
	);
	
	begin
		process(clk)
		begin
			if(rising_edge(clk)) then
				dado <= conteudo_rom(to_integer(endereco));
			end if;
		end process;
end architecture;