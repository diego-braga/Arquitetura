library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco is
	port( 
		readReg1 : in unsigned(2 downto 0);
		readReg2 : in unsigned(2 downto 0);
		
		writeData : in unsigned(15 downto 0); 
		writeReg : in unsigned(2 downto 0);
		
		clk : in std_logic;
		rst : in std_logic;
		wr_en : in std_logic;
		
		readData1 : out unsigned(15 downto 0);
		readData2 : out unsigned(15 downto 0)
	);
end entity;


architecture a_banco of banco is

	component reg16bits is
		port( clk : in std_logic;
			rst : in std_logic;
			wr_en : in std_logic;
			data_in : in unsigned(15 downto 0);
			data_out : out unsigned(15 downto 0)
		);
	end component;

	signal wr_en0: std_logic;
	signal wr_en1: std_logic;
	signal wr_en2: std_logic;
	signal wr_en3: std_logic;
	signal wr_en4: std_logic;
	signal wr_en5: std_logic;
	signal wr_en6: std_logic;
	signal wr_en7: std_logic;
	
	signal out0: unsigned(15 downto 0);
	signal out1: unsigned(15 downto 0);
	signal out2: unsigned(15 downto 0);
	signal out3: unsigned(15 downto 0);
	signal out4: unsigned(15 downto 0);
	signal out5: unsigned(15 downto 0);
	signal out6: unsigned(15 downto 0);
	signal out7: unsigned(15 downto 0);
	
	signal in0: unsigned(15 downto 0);
	
	
	
begin

	reg0: reg16bits port map(data_in=>in0, data_out=>out0, clk=>clk, rst=>rst, wr_en=>wr_en0);
	reg1: reg16bits port map(data_in=>writeData, data_out=>out1, clk=>clk, rst=>rst, wr_en=>wr_en1);
	reg2: reg16bits port map(data_in=>writeData, data_out=>out2, clk=>clk, rst=>rst, wr_en=>wr_en2);
	reg3: reg16bits port map(data_in=>writeData, data_out=>out3, clk=>clk, rst=>rst, wr_en=>wr_en3);
	reg4: reg16bits port map(data_in=>writeData, data_out=>out4, clk=>clk, rst=>rst, wr_en=>wr_en4);
	reg5: reg16bits port map(data_in=>writeData, data_out=>out5, clk=>clk, rst=>rst, wr_en=>wr_en5);
	reg6: reg16bits port map(data_in=>writeData, data_out=>out6, clk=>clk, rst=>rst, wr_en=>wr_en6);
	reg7: reg16bits port map(data_in=>writeData, data_out=>out7, clk=>clk, rst=>rst, wr_en=>wr_en7);

	
	in0 <= "0000000000000000";
	
	wr_en0 <= '1'; -- PERGUNTAR!!!! Assim ele sempre está escrevendo "0000000000000000" no reg0;
					-- Faço assim ou atribuo "0000000000000000" direto ao readData1 quando readReg1 = "000"
	
	readData1 <=    out0 when readReg1 = "000" else
					out1 when readReg1 = "001" else
					out2 when readReg1 = "010" else
					out3 when readReg1 = "011" else
					out4 when readReg1 = "100" else
					out5 when readReg1 = "101" else
					out6 when readReg1 = "110" else
					out7 when readReg1 = "111" else
					"0000000000000000";
	
	readData2 <=    out0 when readReg2 = "000" else
					out1 when readReg2 = "001" else
					out2 when readReg2 = "010" else
					out3 when readReg2 = "011" else
					out4 when readReg2 = "100" else
					out5 when readReg2 = "101" else
					out6 when readReg2 = "110" else
					out7 when readReg2 = "111" else
					"0000000000000000";
					
					
	wr_en1 <= wr_en when writeReg ="001" else
			'0';
	
	wr_en2 <= wr_en when writeReg ="010" else
			'0';
			
	wr_en3 <= wr_en when writeReg ="011" else
			'0';
			
	wr_en4 <= wr_en when writeReg ="100" else
			'0';
			
	wr_en5 <= wr_en when writeReg ="101" else
			'0';
			
	wr_en6 <= wr_en when writeReg ="110" else
			'0';
			
	wr_en7 <= wr_en when writeReg ="111" else
			'0';


end architecture;
