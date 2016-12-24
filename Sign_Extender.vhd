-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/22/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity sign_extender is
PORT ( imm : IN std_logic_vector ( 15 DOWNTO 0);
       sign_ext_out : OUT std_logic_vector (31 DOWNTO 0));
end entity;

architecture behav of sign_extender is
begin
process(imm) is
begin
if(imm(15) = '1') then
sign_ext_out <= (("1111111111111111") & imm(15 downto 0));
else
sign_ext_out <= (("0000000000000000") & imm(15 downto 0));
end if;
end process;
end behav;
