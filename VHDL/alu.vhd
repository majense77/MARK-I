-- Copyright (C) 1991-2011 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II"
-- VERSION		"Version 11.0 Build 208 07/03/2011 Service Pack 1 SJ Full Version"
-- CREATED		"Tue Nov 04 16:52:52 2014"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY alu IS 
	PORT
	(
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
END ALU;

ARCHITECTURE bdf_type OF ALU IS 

COMPONENT mux2
	PORT(sel : IN STD_LOGIC;
		 d0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 d1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 f : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT multibitadder
	PORT(Cin : IN STD_LOGIC;
		 A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 C14 : OUT STD_LOGIC;
		 C15 : OUT STD_LOGIC;
		 F : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT and16
	PORT(A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT not16
	PORT(A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT variouslogic
	PORT(Carry14 : IN STD_LOGIC;
		 Carry15 : IN STD_LOGIC;
		 F : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 N : OUT STD_LOGIC;
		 C : OUT STD_LOGIC;
		 Z : OUT STD_LOGIC;
		 V : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mux4
	PORT(d0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 d1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 d2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 d3 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 f : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT or16
	PORT(A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT xor16
	PORT(A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_18 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC_VECTOR(15 DOWNTO 0);


BEGIN 



b2v_A_MUX : mux2
PORT MAP(sel => A_Inv,
		 d0 => A,
		 d1 => SYNTHESIZED_WIRE_0,
		 f => SYNTHESIZED_WIRE_18);


b2v_ADDER_16 : multibitadder
PORT MAP(Cin => SYNTHESIZED_WIRE_1,
		 A => SYNTHESIZED_WIRE_18,
		 B => SYNTHESIZED_WIRE_19,
		 C14 => SYNTHESIZED_WIRE_7,
		 C15 => SYNTHESIZED_WIRE_8,
		 F => SYNTHESIZED_WIRE_20);


b2v_AND_16 : and16
PORT MAP(A => SYNTHESIZED_WIRE_18,
		 B => SYNTHESIZED_WIRE_19,
		 output => SYNTHESIZED_WIRE_10);


b2v_B_MUX : mux2
PORT MAP(sel => B_Inv,
		 d0 => B,
		 d1 => SYNTHESIZED_WIRE_6,
		 f => SYNTHESIZED_WIRE_19);


SYNTHESIZED_WIRE_1 <= B_Inv OR A_Inv;


b2v_inst10 : not16
PORT MAP(A => A,
		 output => SYNTHESIZED_WIRE_0);


b2v_inst14 : variouslogic
PORT MAP(Carry14 => SYNTHESIZED_WIRE_7,
		 Carry15 => SYNTHESIZED_WIRE_8,
		 F => SYNTHESIZED_WIRE_20,
		 N => N,
		 C => C,
		 Z => Z,
		 V => V);


b2v_inst3 : not16
PORT MAP(A => B,
		 output => SYNTHESIZED_WIRE_6);


b2v_inst6 : mux4
PORT MAP(d0 => SYNTHESIZED_WIRE_10,
		 d1 => SYNTHESIZED_WIRE_11,
		 d2 => SYNTHESIZED_WIRE_12,
		 d3 => SYNTHESIZED_WIRE_20,
		 sel => ALU_OP,
		 f => ALU_Out);


b2v_OR_16 : or16
PORT MAP(A => SYNTHESIZED_WIRE_18,
		 B => SYNTHESIZED_WIRE_19,
		 output => SYNTHESIZED_WIRE_11);


b2v_XOR_16 : xor16
PORT MAP(A => SYNTHESIZED_WIRE_18,
		 B => SYNTHESIZED_WIRE_19,
		 output => SYNTHESIZED_WIRE_12);


END bdf_type;