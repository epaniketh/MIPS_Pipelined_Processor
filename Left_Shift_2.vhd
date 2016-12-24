-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/22/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity Left_Shift_2 is
	port (    a : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
	          q : OUT STD_LOGIC_VECTOR (31 downto 0));
end Left_Shift_2;

architecture behavioral of Left_Shift_2 is
begin
q <= (a(29 downto 0) & "00");
end behavioral;

