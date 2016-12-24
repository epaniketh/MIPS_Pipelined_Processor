-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/24/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity Pipe_Reg_F_D is
	generic (NBIT : integer := 31);
	port (    RD : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  StallD : IN STD_LOGIC;
		  PCPlus4F : IN STD_LOGIC_VECTOR( NBIT downto 0);
		  PCSrcD : IN std_logic;
	          clk : IN STD_LOGIC;
	          InstrD : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		  PCPlus4D : OUT std_logic_vector (NBIT downto 0));
end Pipe_Reg_F_D;

architecture behavioral of Pipe_Reg_F_D is
begin
process(clk)
variable Ins, PCPlus: std_logic_vector(31 Downto 0); 
begin
if (rising_edge(clk) and PCSrcD = '1') then
InstrD <= "00000000000000000000000000000000";
Ins := "00000000000000000000000000000000";
PCPlus4D <= "00000000000000000000000000000000";
PCPlus := "00000000000000000000000000000000";
elsif (rising_edge(clk) and clk = '1' and StallD = '0' ) then
InstrD <= RD;
Ins := RD;
PCPlus4D <= PCPlus4F;
PCPlus := PCPlus4F;
elsif (rising_edge(clk) and StallD = '1') then
InstrD <= Ins;
PCPlus4D <= PCPlus;
end if;
end process;
end behavioral;

