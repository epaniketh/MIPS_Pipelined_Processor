-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/28/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

ENTITY processor IS
PORT (
ref_clk : IN std_logic ;
reset : IN std_logic );
END processor;

Architecture MIPS of processor is
	component pc is
		port (    d : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			  reset : IN STD_LOGIC;
			  StallF : IN std_logic;
			  clk : IN STD_LOGIC;
			  pc_out : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
	end component;
	
	
	component adder is
		port (   adder_in : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		         dataIO : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
	end component;

	component rom is
		port (    addr : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			  dataIO : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
	end component;

	component controller is
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
			
	end component;	

	component regfile is
		PORT ( clk : IN std_logic ;
                       rst_s : IN std_logic ; -- synchronous reset
                       we : IN std_logic ; -- write enable
                       raddr_1 : IN std_logic_vector (4 DOWNTO 0); -- read address 1
                       raddr_2 : IN std_logic_vector (4 DOWNTO 0); -- read address 2
                       waddr : IN std_logic_vector (4 DOWNTO 0); -- write address
                       rdata_1 : OUT std_logic_vector (31 DOWNTO 0); -- read data 1
                       rdata_2 : OUT std_logic_vector (31 DOWNTO 0); -- read data 2
                       wdata : IN std_logic_vector (31 DOWNTO 0));
	end component;
	
	component sign_extender is
		PORT ( imm : IN std_logic_vector ( 15 DOWNTO 0);
		       sign_ext_out : OUT std_logic_vector (31 DOWNTO 0));
	end component;
	 
        component mux is
		PORT (  a : IN std_logic_vector (31 DOWNTO 0);
		        b : IN std_logic_vector (31 DOWNTO 0);
			sel : IN std_logic;
			y : OUT std_logic_vector(31 DOWNTO 0));
	end component;

	 component mux5 is
		PORT (  a : IN std_logic_vector (4 DOWNTO 0);
		        b : IN std_logic_vector (4 DOWNTO 0);
			sel : IN std_logic;
			y : OUT std_logic_vector(4 DOWNTO 0));
	end component;

	component alu is
		PORT (
			Func_in : IN std_logic_vector (5 DOWNTO 0);
			A_in : IN std_logic_vector (31 DOWNTO 0);
			B_in : IN std_logic_vector (31 DOWNTO 0);
			O_out : OUT std_logic_vector (31 DOWNTO 0);
			Branch_out : OUT std_logic ;
			Jump_out : OUT std_logic );
	end component;
	
	component ram is
		port (
			clk : IN std_logic ;
			we : IN std_logic ;
			addr : IN std_logic_vector (31 DOWNTO 0);
			dataI : IN std_logic_vector (31 DOWNTO 0);
			dataO : OUT std_logic_vector (31 DOWNTO 0));
	end component;

	component Pipe_Reg_F_D is
		generic (NBIT : integer := 31);
		port (    RD : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		 	 StallD : IN STD_LOGIC;
		 	 PCPlus4F : IN STD_LOGIC_VECTOR( NBIT downto 0);
		 	 PCSrcD : IN std_logic;
	         	 clk : IN STD_LOGIC;
	         	 InstrD : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		 	 PCPlus4D : OUT std_logic_vector (NBIT downto 0));
	end component;

	component Left_Shift_2 is
	port (    a : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
	          q : OUT STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component Left_Shift_2_26 is
	port (    a : IN STD_LOGIC_VECTOR (25 DOWNTO 0);
	          q : OUT STD_LOGIC_VECTOR (27 downto 0));
	end component;

	component AdderBranch is
	port (   adder_in : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		PCPlus4D : IN std_logic_vector (31 downto 0);
		         dataIO : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
	end component;

	component comparator is
	port (
		value1 : IN std_logic_vector (31 DOWNTO 0);
		value2 : IN std_logic_vector (31 downto 0);
		sel : IN std_logic_vector(2 downto 0);
		EqualID : OUT std_logic);
	end component;

	component andgate is
	port (    a : IN STD_LOGIC;
		  b : IN STD_LOGIC;
		  PCSrcD : OUT STD_LOGIC);
	end component;

	component Pipe_Reg_D_E is
	generic (NBIT : integer := 5);
	port (    RD1, Sign_Extended : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  RD2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  RsD, RtD, RdD : IN STD_LOGIC_VECTOR(4 downto 0);
		  RegWriteD, MemtoRegD, MemWriteD, ALUSrcD, RegDstD, FlushE : IN STD_LOGIC;
	          clk : IN STD_LOGIC;
		  ALUControlD : IN std_logic_vector (NBIT downto 0);
	          RegWriteE, MemtoRegE, MemWriteE, ALUSrcE, RegDstE : OUT STD_LOGIC;
		  RsE, RtE, RdE : OUT std_logic_vector(4 downto 0);
		  RDOut1, RDOut2, Sign_Out : OUT std_logic_vector(31 downto 0);
		  ALUControlE : OUT std_logic_vector (NBIT downto 0));
	end component;

	component mux_2 is
	PORT (  a : IN std_logic_vector (31 DOWNTO 0);
		b : IN std_logic_vector (31 DOWNTO 0);
		c : IN std_logic_vector (31 DOWNTO 0);
		y : OUT std_logic_vector(31 DOWNTO 0);
		sel: IN std_logic_vector(1 downto 0));
	end component;

	
	component Pipe_Reg_E_M is
		generic (NBIT : integer := 5);
		port (    ALU_Out, WriteDataE : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			  WriteRegE : IN STD_LOGIC_VECTOR(4 downto 0);
			  RegWriteE, MemtoRegE, MemWriteE : IN STD_LOGIC;
		          clk : IN STD_LOGIC;
		          RegWriteM, MemtoRegM, MemWriteM : OUT STD_LOGIC;
			  WriteRegM : OUT STD_LOGIC_VECTOR(4 downto 0);
			  ALUOutM, WriteDataM : OUT std_logic_vector(31 downto 0));
	end component;

	component Pipe_Reg_M_W is
	generic (NBIT : integer := 5);
	port (    DataIn, ALUOutM : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  WriteRegM : IN STD_LOGIC_VECTOR(4 downto 0);
		  RegWriteM, MemtoRegM : IN STD_LOGIC;
	          clk : IN STD_LOGIC;
	          RegWriteW, MemtoRegW : OUT STD_LOGIC;
		  WriteRegW : OUT STD_LOGIC_VECTOR(4 downto 0);
		  ReadDataW, ALUOutW: OUT std_logic_vector(31 downto 0));
	end component;

	component HazardUnit is
	generic (NBIT : integer := 5);
	port (    RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW : IN STD_LOGIC_VECTOR(4 downto 0);
		  BranchD, MemtoRegE, RegWriteE, RegWriteM, RegWriteW, JumpD : IN STD_LOGIC;
	          StallF, StallD, ForwardAD, ForwardBD, FlushE  : OUT STD_LOGIC;
		  ForwardAE, ForwardBE : OUT std_logic_vector(1 downto 0));
	end component;

	component Orgate is
	port (    a : IN STD_LOGIC;
		  b : IN STD_LOGIC;
		  PCSrc_Jump : OUT STD_LOGIC);
	end component;

	component Concatenation is
	port (    a : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
		  b : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
	          PCJumpD : OUT STD_LOGIC_VECTOR (31 downto 0));
	end component;

	signal pcout, read_data1, read_data2, ResultW, RDE2, RDE1, SignImmD, SignImmE, opb, alu_res, mem_data, Branch_In, ALUOutM, EqualRd1, EqualRd2, WriteDataE,
	SrcBE, ALUOutE, SrcAE, WriteDataM, ReadDataM, ReadDataW, ALUOutW, PCOutJump, PCJumpD : std_logic_vector(31 downto 0);
	signal addout : std_logic_vector(31 downto 0);
	signal im_out : std_logic_vector(31 downto 0);
	signal selD : std_logic_vector(2 downto 0);
	signal rsD, rtD, rdD, RsE, RtE, RdE, WriteRegE, WriteRegM, WriteRegW : std_logic_vector(4 downto 0);
	signal ALUControlD, ALUControlE : std_logic_vector(5 downto 0);
	signal RegWriteD, alu_srcD, MemToRegD, bout, jout, mem_writeD, RegDstD, BranchD, JumpD, RegWriteW, ForwardAD, ForwardBD, EqualID, RegWriteE, MemtoRegE, MemWriteE, ALUSrcE, RegDstE    : std_logic;
	signal immD: std_logic_vector(15 downto 0);
	-- MIPS
	signal PCBranchD, P_C, PCF, RD, InstrD, PCPlus4F, PCPlus4D, addr, dataIO : std_logic_vector(31 downto 0);
	signal PCSrcD, StallF, StallD, FlushE, RegWriteM, MemtoRegM, MemWriteM , MemtoRegW,PCSrc_JumpD  : std_logic;
	signal ForwardAE, ForwardBE : std_logic_vector(1 downto 0);
	signal PC_ShiftD : std_logic_vector(27 downto 0);

begin
-- Fetch
mux_branch: mux port map( a => PCOutJump, b => PCPlus4F, y => P_C, sel => PCSrc_JumpD);
mux_jump: mux port map( a => PCJumpD, b => PCBranchD, y => PCOutJump , sel => JumpD);
program_counter: pc port map( clk => ref_clk, reset => reset, StallF => StallF, d => P_C , pc_out => PCF);
addr_4: adder port map( adder_in => PCF, dataIO => PCPlus4F);
inst_mem: rom port map(addr => PCF, dataIO => RD);
pipe_reg1: Pipe_Reg_F_D port map (RD => RD, StallD => StallF, PCPlus4F => PCPlus4F, PCSrcD => PCSrcD, clk => ref_clk, InstrD => InstrD, PCPlus4D => PCPlus4D);

-- Decode
cont: controller port map(sel => selD, Jump => JumpD ,addr => InstrD, MemToReg => MemToRegD, MemWrite => mem_writeD, ALUSrc => alu_srcD, RegWrite => RegWriteD, ALUControl => ALUControlD, rs => rsD, rt => rtD, rd => rdD, imm => immD, RegDst => RegDstD, Branch => BranchD);
reg: regfile port map(clk => ref_clk, rst_s => reset, raddr_1 => rsD, raddr_2 => rtD, waddr => rdD, rdata_1 => read_data1, rdata_2 => read_data2, we => RegWriteW, wdata => ResultW);
sign_ext: sign_extender port map(imm => immD, sign_ext_out => SignImmD);
L_Shift2: Left_Shift_2 port map(a => SignImmD, q => Branch_In);
Adder_Branch: AdderBranch port map(adder_in => Branch_In, PCPlus4D => PCPlus4D, dataIO => PCBranchD);
mux_rd1: mux port map( a => ALUOutM, b => read_data1, y => EqualRd1, sel => ForwardAD);
mux_rd2: mux port map( a => ALUOutM, b => read_data2, y => EqualRd2, sel => ForwardBD);
Equal: comparator port map( sel => selD, value1 => EqualRd1, value2 => EqualRd2, EqualID => EqualID);
and_op: andgate port map( a => BranchD, b => EqualID, PCSrcD => PCSrcD);
pipe_reg2: Pipe_Reg_D_E port map (RD1 => read_data1, RD2 => read_data2, Sign_Extended => SignImmD, RsD => rsD, RtD => rtD, RdD => rdD, RegWriteD => RegWriteD, MemtoRegD => MemToRegD, MemWriteD => mem_writeD, ALUSrcD => alu_srcD , RegDstD => RegDstD , FlushE => FlushE, clk => ref_clk,  
  ALUControlD => ALUControlD, RegWriteE => RegWriteE, MemtoRegE => MemtoRegE, MemWriteE => MemWriteE, ALUSrcE => ALUSrcE, RegDstE => RegDstE, RsE => RsE, RtE => RtE, RdE => RdE, RDOut1 => RDE1,
  RDOut2 => RDE2, Sign_Out => SignImmE, ALUControlE => ALUControlE );
Jump_Decision: Orgate port map (a => PCSrcD, b => JumpD, PCSrc_Jump => PCSrc_JumpD);
Shift_Jump: Left_Shift_2_26 port map( a => InstrD(25 downto 0), q => PC_ShiftD);
Concatenate: Concatenation port map(a => PC_ShiftD, b => PCPlus4D, PCJumpD => PCJumpD);
 

-- Execute
mux2_exe1: mux_2 port map(a => RDE1, b => resultW, c => ALUOutM, sel => ForwardAE, y => SrcAE);
mux2_exe2: mux_2 port map(a => RDE2, b => resultW, c => ALUOutM, sel => ForwardBE, y => WriteDataE);
mux_bit5_exe1 : mux5 port map(a => RdE, b => RtE, y => WriteRegE, sel => RegDstE);
mux_exe2 : mux port map(a => SignImmE, b => WriteDataE, y => SrcBE, sel => ALUSrcE);
alu_block: alu port map(Func_in => ALUControlE, A_in => SrcAE, B_in => SrcBE, O_out => ALUOutE);
pipe_reg3: Pipe_Reg_E_M port map (ALU_Out => ALUOutE,WriteDataE => WriteDataE, WriteRegE => WriteRegE, RegWriteE => RegWriteE, MemtoRegE => MemtoRegE, MemWriteE => MemWriteE, clk => ref_clk,
	 RegWriteM => RegWriteM, MemtoRegM => MemtoRegM, MemWriteM => MemWriteM, WriteRegM => WriteRegM, ALUOutM => ALUOutM, WriteDataM => WriteDataM);

-- Memory
ram_mem : ram port map(clk => ref_clk, we => MemWriteM, addr => ALUOutM, dataI => WriteDataM, dataO => ReadDataM);
pipe_reg4 : Pipe_Reg_M_W port map(DataIn => ReadDataM, ALUOutM => ALUOutM, WriteRegM => WriteRegM, RegWriteM => RegWriteM, MemtoRegM => MemtoRegM, clk => ref_clk, RegWriteW => RegWriteW,
	MemtoRegW => MemtoRegW, WriteRegW => WriteRegW, ReadDataW => ReadDataW, ALUOutW => ALUOutW);

-- WriteBack
mux_wback: mux port map( a => ReadDataW, b => ALUOutW, y => ResultW, sel => MemtoRegW);

-- Hazard Unit
hazard: HazardUnit port map(JumpD => JumpD,RsD => RsD, RtD => RtD,RsE => RsE,RtE => RtE,WriteRegE => WriteRegE, WriteRegM => WriteRegM, WriteRegW => WriteRegW, BranchD => BranchD,MemtoRegE => MemtoRegE,
	RegWriteE => RegWriteE,RegWriteM => RegWriteM, RegWriteW => RegWriteW, StallF => StallF, StallD => StallD, ForwardAD => ForwardAD,ForwardBD => ForwardBD, FlushE => FlushE,
	ForwardAE => ForwardAE, ForwardBE => ForwardBE);

			  

--mux5: mux port map(a => signextout, b => read_data2, sel => alu_src, y => opb);
--alu_block: alu port map(Func_in => alu_op, A_in => read_data1, B_in => opb, O_out => alu_res, Branch_out => bout, Jump_out => jout); 
--mux2: mux port map(a => mem_data, b => alu_res, sel => MemToReg, y => write_data);
--ram_mem: ram port map(clk => ref_clk, we => mem_write, addr => alu_res, dataI => read_data2, dataO => mem_data);


end architecture;
