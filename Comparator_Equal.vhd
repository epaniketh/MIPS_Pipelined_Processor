-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/22/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity comparator is
	port (
		value1 : IN std_logic_vector (31 DOWNTO 0);
		value2 : IN std_logic_vector (31 downto 0);
		EqualID : OUT std_logic);
end comparator;

architecture behave of comparator is
--signal EqualID : std_logic;
begin
process(value1,value2) is
begin
if(value1 = value2) then
EqualID <= '1';
else
EqualID <= '0';
end if;
end process;
end behave;