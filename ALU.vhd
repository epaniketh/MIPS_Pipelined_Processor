LIBRARY IEEE;
-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/22/2016 
-- Design Name: Pipelined_Processor
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
entity alu is
	PORT (
		Func_in : IN std_logic_vector (5 DOWNTO 0);
		A_in : IN std_logic_vector (31 DOWNTO 0);
		B_in : IN std_logic_vector (31 DOWNTO 0);
		O_out : OUT std_logic_vector (31 DOWNTO 0);
		Branch_out : OUT std_logic ;
		Jump_out : OUT std_logic );
end entity;

architecture behavioral of alu is
begin
	process (A_in, B_in, Func_in) is
	variable ain: signed(31 downto 0);
	variable bin: signed(31 downto 0);
	variable temp: std_logic_vector(31 downto 0);
	begin
	case Func_in is
		when "100000" =>
			temp := A_in + B_in;
		when "100001" =>
			temp := A_in + B_in;
		when "100010" =>
			temp := A_in - B_in;
		when "100011" =>
			temp := A_in - B_in;
		when "100100" =>
			temp := A_in and B_in;
		when "100101" =>
			temp := A_in or B_in;
		when "100110" =>
			temp := A_in xor B_in;
		when "110111" =>
			temp := A_in nor B_in;
		when "101000" =>
			ain := signed(A_in); bin := signed(B_in);
			if (ain) < (bin) then
			temp := "11111111111111111111111111111111";
			end if;
		when "101001" =>
			if A_in < B_in then
			temp := "11111111111111111111111111111111";
			end if;
		when others =>
			temp := "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
	end case;
	O_out <= temp;
	end process;
end architecture;

