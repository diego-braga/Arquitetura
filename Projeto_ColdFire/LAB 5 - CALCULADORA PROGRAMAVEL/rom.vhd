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
	
	0 => "0010011000000101", 	-- MOVEQ #5, D3		  - 1
	
	1 => "0010100000001000",	-- MOVEQ #8, D4	      - 2
	
	2 => "0011101000000011", 	-- MOVE D3, D5		-|
								--					 |- 3
	3 => "0100101000000100", 	-- ADDX D4, D5		-|
	
	4 => "0010001000000001", 	-- MOVEQ #1,D1		-|
								--					 |- 4
	5 => "0110101000000001", 	-- SUBX D1, D5	    -|
	
	6 => "0010010000010100", 	-- MOVEQ #20, D2	-|
								--					 |- 5
	7 => "1111000000000010", 	-- JUMP D2		    -|
	
	20 => "0011011000000101", 	-- MOVE D5, D3		  - 6
	
	21 => "0010110000000010", 	-- MOVEQ #2, D6		-|
								--					 |- 7
	22 => "1111000000000110", 	-- JUMP D6			-|
	
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