LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY variousLogic IS
	PORT(
		F						: IN STD_LOGIC_VECTOR(15 DOWNTO 0);	
		Carry14,Carry15 		: IN STD_LOGIC;
		N,C,Z,V					: OUT STD_LOGIC
	);
END variousLogic;

ARCHITECTURE behavior OF variousLogic IS
BEGIN
N<= F(15);
C<= Carry15;
Z<= NOT(F(0) OR F(1) OR F(2) OR F(3) OR F(4) OR F(5) OR F(6) OR F(7) OR F(8) OR F(9) OR F(10) OR F(11) OR F(12) OR F(13) OR F(14) OR F(15));
V<= Carry14 XOR Carry15;
END behavior;