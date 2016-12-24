-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/24/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
Entity regfile is
generic (NBIT : INTEGER := 4);
port (  clk : IN std_logic;
	rst_s : IN std_logic;
        raddr_1 : IN std_logic_vector(NBIT downto 0);
	raddr_2 : IN std_logic_vector(NBIT downto 0);
	rdata_1 :  OUT std_logic_vector(31 downto 0);
	rdata_2 :  OUT std_logic_vector(31 downto 0);
	waddr : IN std_logic_vector(NBIT downto 0);
	wdata : IN std_logic_vector(31 downto 0);
	we : IN std_logic);
end entity;

architecture behav of regfile is
begin
process(clk,raddr_1,raddr_2,waddr) is
type reg is array (31 downto 0) of std_logic_vector (31 downto 0);
variable mem : reg := (others => (others => '0'));
begin
	if(rst_s = '1' and rising_edge (clk)) then
	mem := (others => (others => '0'));
	elsif(we = '1' and rising_edge (clk)) then
	mem(to_integer(unsigned(waddr))) := wdata ;
	end if;
rdata_1 <= mem(to_integer(unsigned(raddr_1)));
rdata_2 <= mem(to_integer(unsigned(raddr_2)));
end process;
end behav;

	

