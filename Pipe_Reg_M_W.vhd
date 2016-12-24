-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/22/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity Pipe_Reg_M_W is
	generic (NBIT : integer := 5);
	port (    DataIn, ALUOutM : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  WriteRegM : IN STD_LOGIC_VECTOR(4 downto 0);
		  RegWriteM, MemtoRegM : IN STD_LOGIC;
	          clk : IN STD_LOGIC;
	          RegWriteW, MemtoRegW : OUT STD_LOGIC;
		  WriteRegW : OUT STD_LOGIC_VECTOR(4 downto 0);
		  ReadDataW, ALUOutW: OUT std_logic_vector(31 downto 0));
end Pipe_Reg_M_W;

architecture behavioral of Pipe_Reg_M_W is
begin
process(clk)
begin
if (rising_edge(clk) and clk = '1') then
ALUOutW <= ALUOutM;
ReadDataW <= DataIn;
RegWriteW <= RegWriteM;
MemtoRegW <= MemtoRegM;
WriteRegW <= WriteRegM;
end if;
end process;
end behavioral;

