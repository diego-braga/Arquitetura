library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
	port( 
		dado : in unsigned(15 downto 0);

		opcode 		: out unsigned(3 downto 0);
		
		reg1		: out unsigned(2 downto 0);
		reg2		: out unsigned(2 downto 0);
		
		wrData 	:out unsigned(15 downto 0)
	);
end entity;

architecture a_decoder of decoder is

	
begin

	opcode <= dado(15 downto 12);
	
	reg1 <= dado(2 downto 0);
	reg2 <= dado(11 downto 9);
	
	wrData <= "00000000" & dado(7 downto 0);

end architecture;