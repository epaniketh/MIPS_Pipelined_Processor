LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity controller is
	port (
			addr : IN std_logic_vector (31 DOWNTO 0);
			MemToReg : OUT std_logic ;
			MemWrite : OUT std_logic ;
			Branch : OUT std_logic ;
			Jump : OUT std_logic;
			ALUControl : OUT std_logic_vector(5 downto 0) ;
			ALUSrc : OUT std_logic;
			RegDst : OUT std_logic;
			RegWrite : OUT std_logic;
                        rs, rd, rt : OUT std_logic_vector (4 DOWNTO 0);
		        imm : OUT std_logic_vector(15 downto 0);
			sel : OUT std_logic_vector(2 downto 0));
			
end entity;	

architecture behave of controller is
signal opcode : std_logic_vector(5 downto 0);
begin
process(addr) is
begin
opcode <= addr(31 downto 26);
imm <= addr(15 downto 0);
end process;

process(addr) is
begin
if(addr(31 downto 26) = "000000") then
	MemToReg <= '0';
	MemWrite <= 'Z';
	RegWrite <= '1';
	ALUControl <= addr(5 downto 0);
	rs <= addr(25 downto 21);
	rd <= addr(15 downto 11);
	rt <= addr(20 downto 16);
	RegDst <= '1';
	Jump <= '0';
	Branch <= '0';
	if(addr(0) = '1') then
	ALUSrc <= '1';
	else
	ALUSrc <= '0';
	end if;
elsif(addr(31 downto 26) = "100011") then
	MemToReg <= '1';
	MemWrite <= '0';
	RegWrite <= '1';
	rs <= addr(25 downto 21);
	rd <= addr(20 downto 16);
	rt <= addr(20 downto 16);
	ALUControl <= "100001";
	RegDst <= '0';
	ALUSrc <= '1';
	Branch <= '0';
	Jump <= '0';
elsif(addr(31 downto 26) = "101011") then
	MemToReg <= 'X';
	MemWrite <= '1';
	RegWrite <= '0';
	ALUControl <= "100001";
	ALUSrc <= '1';
	RegDst <= 'X';
	Branch <= '0';
	Jump <= '0';
	rd <= addr(20 downto 16);
	rs <= addr(25 downto 21);
elsif(addr(31 downto 26) = "000100") then
	MemToReg <= 'X';
	MemWrite <= '0';
	RegWrite <= '0';
	ALUControl <= "100010";
	ALUSrc <= '0';
	RegDst <= 'X';
	Branch <= '1';
	Jump <= '0';
	rd <= addr(20 downto 16);
	rs <= addr(25 downto 21);
elsif(addr(31 downto 26) = "000010") then
	MemToReg <= 'X';
	MemWrite <= '0';
	RegWrite <= '0';
	ALUControl <= "100010";
	ALUSrc <= '0';
	RegDst <= 'X';
	Branch <= '0';
	Jump <= '1';
	rd <= addr(20 downto 16);
	rs <= addr(25 downto 21);
end if;
end process;
end architecture;
	
	

