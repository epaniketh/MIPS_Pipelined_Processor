-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/22/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity adder is
	port (   adder_in : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		         dataIO : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
end adder;

architecture behavioral of adder is
signal four : integer := 4;
begin
process(adder_in)
begin
dataIO <= adder_in + four;
end process;
end behavioral;

