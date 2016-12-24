-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/24/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity Pipe_Reg_D_E is
	generic (NBIT : integer := 5);
	port (    RD1, Sign_Extended : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  RD2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  RsD, RtD, RdD : IN STD_LOGIC_VECTOR(4 downto 0);
		  RegWriteD, MemtoRegD, MemWriteD, ALUSrcD, RegDstD, FlushE : IN STD_LOGIC;
	          clk : IN STD_LOGIC;
		  ALUControlD : IN std_logic_vector (NBIT downto 0);
	          RegWriteE, MemtoRegE, MemWriteE, ALUSrcE, RegDstE : OUT STD_LOGIC;
		  RsE, RtE, RdE : OUT std_logic_vector(4 downto 0);
		  RDOut1, RDOut2, Sign_Out : OUT std_logic_vector(31 downto 0);
		  ALUControlE : OUT std_logic_vector (NBIT downto 0));
end Pipe_Reg_D_E;

architecture behavioral of Pipe_Reg_D_E is
begin
process(clk)
begin
if (rising_edge(clk) and clk = '1' and FlushE = '1') then
RDOut1 <= "00000000000000000000000000000000";
RDOut2 <= "00000000000000000000000000000000"; 
Sign_Out <= "00000000000000000000000000000000";
RegWriteE <= '0';
MemtoRegE <= 'X';
MemWriteE <= '0';
ALUSrcE <= 'X';
RegDstE <= 'X';
RsE <= "00000";
RtE <= "00000";
RdE <= "00000";
ALUControlE <= "XXXXXX";
elsif (rising_edge(clk) and clk = '1' and FlushE = '0') then
RDOut1 <= RD1;
RDOut2 <= RD2; 
Sign_Out <= Sign_Extended;
RegWriteE <= RegWriteD;
MemtoRegE <= MemtoRegD;
MemWriteE <= MemWriteD;
ALUSrcE <= ALUSrcD;
RegDstE <= RegDstD;
ALUControlE <=  ALUControlD;
RsE <= RsD;
RtE <= RtD;
RdE <= RdD;
end if;
end process;
end behavioral;

