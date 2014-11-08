LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY adder IS
	PORT(
		A,B,Cin			: IN STD_LOGIC;
		S,Cout			: OUT STD_LOGIC
		);
END adder;

ARCHITECTURE behavior OF adder IS
	SIGNAL aXorB, CoutAXorBCin, CoutAB		: STD_LOGIC;
BEGIN
aXorB <= A XOR B;
CoutAB <= A AND B;
CoutAXorBCin <= aXorB AND Cin;
S <= aXorB XOR Cin;
Cout <= CoutAB OR CoutAXorBCin;
END behavior;