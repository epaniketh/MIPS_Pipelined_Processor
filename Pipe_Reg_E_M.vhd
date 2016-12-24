-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/22/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity Pipe_Reg_E_M is
	generic (NBIT : integer := 5);
	port (    ALU_Out, WriteDataE : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  WriteRegE : IN STD_LOGIC_VECTOR(4 downto 0);
		  RegWriteE, MemtoRegE, MemWriteE : IN STD_LOGIC;
	          clk : IN STD_LOGIC;
	          RegWriteM, MemtoRegM, MemWriteM : OUT STD_LOGIC;
		  WriteRegM : OUT STD_LOGIC_VECTOR(4 downto 0);
		  ALUOutM, WriteDataM : OUT std_logic_vector(31 downto 0));
end Pipe_Reg_E_M;

architecture behavioral of Pipe_Reg_E_M is
begin
process(clk)
begin
if (rising_edge(clk) and clk = '1') then
ALUOutM <= ALU_Out;
WriteDataM <= WriteDataE; 
RegWriteM <= RegWriteE;
MemtoRegM <= MemtoRegE;
MemWriteM <= MemWriteE;
WriteRegM <= WriteRegE;
end if;
end process;
end behavioral;

