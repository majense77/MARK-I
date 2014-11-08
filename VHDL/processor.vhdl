LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY processor IS
PORT(
instruction				:IN STD_LOGIC_VECTOR(23 DOWNTO 0);
reset, Clock, enable	:IN STD_LOGIC;
Output					:OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
END processor;

ARCHITECTURE behavior of processor IS
	COMPONENT register16x16
		PORT(
			RegD, RegT, RegS 					:IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			Data  								:IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			Clock, Reset, Enable 				:IN STD_LOGIC;
			DataS, DataT 						:OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT reg16
		PORT(
			data									:IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			enable, reset, Clock				:IN STD_LOGIC;
			output								:OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT mux2
		PORT(
			d0,d1		:IN std_logic_vector(15 downto 0);
			sel		:IN std_logic;
			f			:OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT mux4
		PORT(
			d0,d1,d2,d3		:IN std_logic_vector(15 downto 0);
			sel				:IN std_logic_vector(1 downto 0);
			f					:OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT alu
		PORT(
			B_Inv :  IN  STD_LOGIC;
			A_Inv :  IN  STD_LOGIC;
			A :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
			ALU_OP :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
			B :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
			N :  OUT  STD_LOGIC;
			Z :  OUT  STD_LOGIC;
			C :  OUT  STD_LOGIC;
			V :  OUT  STD_LOGIC;
			ALU_Out :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT controlUnit
		PORT(
			S,N,C,V,Z,mfc,clock,reset :IN STD_LOGIC;
			opCode, Cond			  :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			opx						  :IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			rf_write, b_select, a_inv, b_inv, ir_enable, ma_select, mem_read, mem_write, pc_select, pc_enable, inc_select 				 :OUT STD_LOGIC;
			alu_op, c_select, y_select, extend		:OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT immediate
		port(
			immed: in STD_LOGIC_VECTOR(6 DOWNTO 0);
			extend: in STD_LOGIC_VECTOR(1 DOWNTO 0);
			immedEx: out STD_LOGIC_VECTOR(15 DOWNTO 0)
		 );
	END COMPONENT;
	COMPONENT ir
		PORT(
			data									:IN STD_LOGIC_VECTOR(23 DOWNTO 0);
			enable, reset, Clock				:IN STD_LOGIC;
			output								:OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT ps
		PORT(
			data									:IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			enable, reset, Clock				:IN STD_LOGIC;
			output								:OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;
	SIGNAL psOut :STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL irOut		:STD_LOGIC_VECTOR(23 DOWNTO 0);
	SIGNAL rf_write, b_select, a_inv, b_inv, ir_enable, ma_select, mem_read, mem_write, pc_select, pc_enable, inc_select, N, C, V, Z :STD_LOGIC;
	SIGNAL alu_op, c_select, y_select, extend		:STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL DataD, DataS, DataT, InA, InB, aluOut, rbOut, muxbOut, rzOut, rmOut, muxyOut, immedOut, memData, retAddress :STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
	pStatus: ps PORT MAP(N & C & V & Z,enable,reset,Clock, psOut);
	instrReg: ir PORT MAP(instruction, enable, reset,Clock, irOut);
	control: controlUnit PORT MAP(irOut(8), psOut(3), psOut(2), psOut(1), psOut(0), enable, Clock, reset, irOut(3) & irOut(2) & irOut(1) & irOut(0), irOut(7) & irOut(6) & irOut(5) & irOut(4), irOut(11) & irOut(10) & irOut(9), rf_write, b_select, a_inv, b_inv, ir_enable, ma_select, mem_read, mem_write, pc_select, pc_enable, inc_select, alu_op, c_select, y_select, extend); 
	immediateBlock: immediate PORT MAP(irOut(15) & irOut(14) & irOut(13) & irOut(12) & irOut(11) & irOut(10) & irOut(9), extend, immedOut);
	regFile: register16x16 PORT MAP(irOut(15) & irOut(14) & irOut(13) & irOut(12), irOut(23) & irOut(22) & irOut(21) & irOut(20), irOut(19) & irOut(18) & irOut(17) & irOut(16), DataD, Clock, reset, enable, DataS, DataT);
	RA: reg16 PORT MAP(DataS, enable, reset, Clock, InA);
	RB: reg16 PORT MAP(DataT, enable, reset, Clock, rbOut);
	muxB: mux2 PORT MAP(rbOut, immedOut, b_select, InB);
	myAlu: alu PORT MAP(b_inv, a_inv, InA, alu_op, InB, N, Z, C, V, aluOut);
	RZ: reg16 PORT MAP(aluOut, enable, reset, Clock, rzOut);
	RM: reg16 PORT MAP(rbOut, enable, reset, Clock, rmOut);
	--muxY: mux4 PORT MAP(rzOut, memData, retAddress, extra, y_select, muxyOut);
	RY: reg16 PORT MAP(rzOut, enable, reset, Clock, DataD);
	Output<=DataD;
END behavior;