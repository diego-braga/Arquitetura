library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
	port(	entr0	: in unsigned(15 downto 0);
			entr1	: in unsigned(15 downto 0);
			selec	: in unsigned(1 downto 0);
			saida	: out unsigned(15 downto 0);
			maior 	: out std_logic;
			carry	: out std_logic;
			borrow	: out std_logic;
			zero	: out std_logic
		);
end entity;

architecture a_ULA of ULA is
signal soma, sub, nohSaida: unsigned(15 downto 0);
signal soma17 : unsigned(16 downto 0);

begin
	soma17 <= ('0' & entr0) + ('0' & entr1);
	soma <= soma17(15 downto 0);

	carry <= soma17(16);
	
	sub <= entr1 - entr0;
	
	borrow <= '1' when entr1 < entr0 else
			  '0';
			
	zero <=	'1' when nohSaida="0000000000000000" else
			'0';
			
	maior <= '1' when entr0 > entr1 else
		     '0';
	
	nohSaida <= soma when selec = "00" else
				sub when selec = "01" else
				entr0 when selec = "11" else
				"0000000000000000";
				
	saida <= nohSaida;

end architecture;
	
	