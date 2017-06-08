library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
	port( 
		readReg1P : in unsigned(2 downto 0);
		readReg2P : in unsigned(2 downto 0);
		
		writeRegP : in unsigned(2 downto 0);
		
		jumpP : in unsigned(15 downto 0);
		
		selecULA: in unsigned(1 downto 0);
		
		selecMUX: in std_logic;
		
		clkP : in std_logic;
		rstP : in std_logic;
		wr_enP : in std_logic;
		
		saidaP : out unsigned(15 downto 0);
		
		maiorP 	: out std_logic;
		carryP	: out std_logic;
		zeroP	: out std_logic
	);
end entity;


architecture a_processador of processador is

	component ULA is
		port(	entr0	: in unsigned(15 downto 0);
				entr1	: in unsigned(15 downto 0);
				selec	: in unsigned(1 downto 0);
				saida	: out unsigned(15 downto 0);
				maior 	: out std_logic;
				carry	: out std_logic;
				zero	: out std_logic
			);
	end component;
	
	component banco is
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
	end component;

	signal read1_to_entr0: unsigned(15 downto 0);
	signal read2_to_Mux: unsigned(15 downto 0);
	signal Mux_entr1: unsigned(15 downto 0);
	signal saida_to_wrData: unsigned(15 downto 0);
	
	
begin

	ULA0: ULA port map(	entr0=> read1_to_entr0, 
						entr1=> Mux_entr1, 
						selec=> selecULA, 
						saida=> saida_to_wrData, 
						maior=> maiorP, 
						carry=> carryP, 
						zero=> zeroP
						);
	
	banco0: banco port map(	readReg1=> readReg1P, 
							readReg2=> readReg2P, 
							writeData=>saida_to_wrData, 
							writeReg=> writeRegP, 
							clk=>clkP, 
							rst=>rstP, 
							wr_en=>wr_enP, 
							readData1=> read1_to_entr0, 
							readData2=> read2_to_Mux
							);
							

	Mux_entr1 <= 	read2_to_Mux when selecMUX = '0' else
					jumpP when selecMUX = '1'else
					"0000000000000000";
	
	saidaP <= saida_to_wrData;
	

end architecture;
