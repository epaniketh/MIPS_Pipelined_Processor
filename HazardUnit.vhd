-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/29/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity HazardUnit is
	generic (NBIT : integer := 5);
	port (    
		  RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW : IN STD_LOGIC_VECTOR(4 downto 0);
		  BranchD, MemtoRegE, RegWriteE, RegWriteM, RegWriteW, JumpD : IN STD_LOGIC;
	          StallF, StallD, ForwardAD, ForwardBD, FlushE  : OUT STD_LOGIC;
		  ForwardAE, ForwardBE : OUT std_logic_vector(1 downto 0));
end HazardUnit;

architecture behavioral of HazardUnit is
begin
process (rsE,WriteRegM,RegWriteM) is
--constant a : std_logic_vector(4 downto 0) := "00000";
begin
	if((not(rsE = "00000")) and (rsE = WriteRegM) and RegWriteM = '1') then
		ForwardAE <= "10";
	elsif((not(rsE = "00000")) and (rsE = WriteRegW) and RegWriteW = '1') then
		ForwardAE <= "01";
	else
		ForwardAE <= "00";
	end if;	
end process;

process (rsE,WriteRegM,RegWriteM) is
--constant a : std_logic_vector(4 downto 0) := "00000";
begin
	if((not(rtE = "00000")) and (rtE = WriteRegM) and RegWriteM = '1') then
		ForwardBE <= "10";
	elsif((not(rtE = "00000")) and (rtE = WriteRegW) and RegWriteW = '1') then
		ForwardBE <= "01";
	else
		ForwardBE <= "00";
	end if;	
end process;

process (MemtoRegE, JumpD) is
begin
	if(((rsD = rtE) or (rtD = rtE)) and MemToRegE = '1') then
	StallF <= '1';
	StallD <= '1';
	FlushE <= '1';
	elsif(JumpD = '1') then
	FlushE <= '1';
	else
	StallF <= '0';
	StallD <= '0';
	FlushE <= '0';
	end if;	
end process;	
end behavioral;

