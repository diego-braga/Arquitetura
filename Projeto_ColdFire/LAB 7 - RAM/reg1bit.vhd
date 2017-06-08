library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg1bit is
	port( 	
			entrada : in std_logic;
			clk : in std_logic;
			rst : in std_logic;
			saida : out std_logic
			
	);
end entity;


architecture a_reg1bit of reg1bit is
	signal estado: std_logic;
begin
	process(clk,rst)
	begin
		if rst='1' then
			estado <= '0';
		elsif rising_edge(clk) then
			estado <= entrada;
		end if;
	end process;

	saida <= estado;
	
end architecture;
