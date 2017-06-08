library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_tb is
end;

architecture a_ULA_tb of ULA_tb is
	component ULA
		port(	entr0 : in unsigned(15 downto 0);
				entr1 : in unsigned(15 downto 0);
				selec : in unsigned(1 downto 0);
				saida : out unsigned(15 downto 0);
				carry : out std_logic;
				zero : out std_logic;
				maior : out std_logic
			);
	end component;
	signal entr0,entr1,saida : unsigned(15 downto 0);
	signal selec : unsigned(1 downto 0);
	signal carry,zero, maior : std_logic;
	
	
	begin
		uut : ULA  port map(	entr0 => entr0,
								entr1 => entr1,
								selec => selec,
								saida => saida,							
								carry => carry,
								zero => zero,
								maior => maior
						   );
						   
	process
	begin
		entr0  <= "0000000000000001";	-- A entrada0 recebe um valor
		entr1  <= "0000000000000010";	-- A entrada1 recebe um valor
		selec  <= "00";					-- Eh selecionada a opção 00, soma 2 números de 16 bits
		wait for 60 ns;
										-- Saída esperada:
										--			saida = 0000000000000011
										--			carry = 0
										--			zero = 0
										-- 			maior = 0
										
		entr0  <= "1111111111111111";	-- A entrada0 recebe um valor
		entr1  <= "1000000000000000";	-- A entrada1 recebe um valor
		selec  <= "00";					-- Eh selecionada a opção 00, soma 2 números de 16 bits com carry
		wait for 60 ns;
										-- Saída esperada:
										--			saida = 0111111111111111
										--			carry = 1
										--			zero = 0
										-- 			maior = 1
										
		entr0  <= "1001110111111111";	-- A entrada0 recebe um valor      
		entr1  <= "0010000110101000";	-- A entrada1 recebe um valor
		selec  <= "01";					-- Eh selecionada a opção 01, subtração entr0-entr1 como entr0 maior que entr1
		wait for 60 ns;
										-- Saída esperada:
										--			saida = 111110001010111
										--			carry = 0
										--			zero = 0
										-- 			maior = 1
										
		entr0  <= "1000000000000111";	-- A entrada0 recebe um valor
		entr1  <= "1111111111111111";	-- A entrada1 recebe um valor
		selec  <= "01";					-- Eh selecionada a opção 01, subtração entr0-entr1 com entr1 maior que entr0
		wait for 60 ns;
										-- Saída esperada:
										--			saida = -111111111111000
										--			carry = 0
										--			zero = 0
										-- 			maior = 0
										
		entr0  <= "0101110001011111";	-- A entrada0 recebe um valor 
		entr1  <= "1010010101001000";	-- A entrada1 recebe um valor
		selec  <= "10";					-- Eh selecionada a opção 10, subtração entr1-entr0 com entr1 maior que entr0
		wait for 60 ns;
										-- Saída esperada:
										--			saida = -100100011101001
										--			carry = 0
										--			zero = 0
										-- 			maior = 0
										
		entr0  <= "0111111101011111";	-- A entrada0 recebe um valor  
		entr1  <= "0010010101001000";	-- A entrada1 recebe um valor
		selec  <= "10";					-- Eh selecionada a opção 10, subtração entr1-entr0 com entr0 maior que entr1
		wait for 60 ns;
										-- Saída esperada:
										--			saida = 101101000010111
										--			carry = 0
										--			zero = 0
										-- 			maior = 1
										
		entr0  <= "0101010101101001";	-- A entrada0 recebe um valor  --operação lógica NAND
		entr1  <= "0001100010101000";	-- A entrada1 recebe um valor
		selec  <= "11";					-- Eh selecionada a opção 11, operação NAND entr0 NAND entr1
		wait for 60 ns;
										-- Saída esperada:
										--			saida = 101101000010111
										--			carry = 0
										--			zero = 0
										-- 			maior = 1
		wait;
	end process;
end architecture;