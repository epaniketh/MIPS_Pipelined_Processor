-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/28/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity Left_Shift_2_26 is
	port (    a : IN STD_LOGIC_VECTOR (25 DOWNTO 0);
	          q : OUT STD_LOGIC_VECTOR (27 downto 0));
end Left_Shift_2_26;

architecture behavioral of Left_Shift_2_26 is
begin
q <= (a & "00");
end behavioral;
