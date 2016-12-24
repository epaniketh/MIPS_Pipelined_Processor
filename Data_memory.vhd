-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/24/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity ram is
	port (
		clk : IN std_logic ;
		we : IN std_logic ;
		addr : IN std_logic_vector (31 DOWNTO 0);
		dataI : IN std_logic_vector (31 DOWNTO 0);
		dataO : OUT std_logic_vector (31 DOWNTO 0));
end entity;

architecture dm of ram is
--signal int : integer range 0 to 21;
begin
process(clk, addr)
type mem is array (511 downto 0) of std_logic_vector( 31 downto 0);
variable data_mem : mem := (0 => "00000000000000000000000000000011",1 => "00000000000000000000000000001111", 2 => "11111111111111111111111111111111",others => (others => '0'));
begin
if (we = '0') then
dataO <= data_mem(to_integer(unsigned(addr)));
elsif (we ='1' and rising_edge(clk)) then
data_mem(to_integer(unsigned(addr))) := dataI;
end if;
end process;
end dm;
