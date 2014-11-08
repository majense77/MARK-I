LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY or16 IS
	PORT(
			A,B		:IN std_logic_vector(15 downto 0);
			output	:OUT std_logic_vector(15 downto 0)
	);
END or16;

ARCHITECTURE behavior OF or16 IS
BEGIN
	output <= A OR B;
END behavior;