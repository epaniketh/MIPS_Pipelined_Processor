-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/22/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity AdderBranch is
	port (   adder_in : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		PCPlus4D : IN std_logic_vector (31 downto 0);
		         dataIO : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
end AdderBranch;

architecture behavioral of AdderBranch is
begin
dataIO <= adder_in + PCPlus4D;
end behavioral;

