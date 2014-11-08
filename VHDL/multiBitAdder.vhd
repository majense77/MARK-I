LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY multiBitAdder IS
	PORT(
		A,B				: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		Cin				: IN STD_LOGIC;
		F				: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		C14,C15			: OUT STD_LOGIC
	);
END multiBitAdder;

ARCHITECTURE behavior OF multiBitAdder IS
	COMPONENT adder
		PORT(
			A,B,Cin		: IN STD_LOGIC;
			S,Cout		: OUT STD_LOGIC
		);
	END COMPONENT;
	SIGNAL carry0,carry1,carry2,carry3,carry4,carry5,carry6,carry7,carry8,carry9,carry10,carry11,carry12,carry13,carry14	: STD_LOGIC;
BEGIN
	add0: adder PORT MAP(A(0), B(0), Cin, F(0), carry0);
	add1: adder PORT MAP(A(1), B(1), carry0, F(1), carry1);
	add2: adder PORT MAP(A(2), B(2), carry1, F(2), carry2);
	add3: adder PORT MAP(A(3), B(3), carry2, F(3), carry3);
	add4: adder PORT MAP(A(4), B(4), carry3, F(4), carry4);
	add5: adder PORT MAP(A(5), B(5), carry4, F(5), carry5);
	add6: adder PORT MAP(A(6), B(6), carry5, F(6), carry6);
	add7: adder PORT MAP(A(7), B(7), carry6, F(7), carry7);
	add8: adder PORT MAP(A(8), B(8), carry7, F(8), carry8);
	add9: adder PORT MAP(A(9), B(9), carry8, F(9), carry9);
	add10: adder PORT MAP(A(10), B(10), carry9, F(10), carry10);
	add11: adder PORT MAP(A(11), B(11), carry10, F(11), carry11);
	add12: adder PORT MAP(A(12), B(12), carry11, F(12), carry12);
	add13: adder PORT MAP(A(13), B(13), carry12, F(13), carry13);
	add14: adder PORT MAP(A(14), B(14), carry13, F(14), carry14);
	C14<=carry14;
	add15: adder PORT MAP(A(15), B(15), carry14, F(15), C15);
END behavior;