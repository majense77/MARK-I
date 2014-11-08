LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY xor16 IS
	PORT(
			A,B		:IN std_logic_vector(15 downto 0);
			output	:OUT std_logic_vector(15 downto 0)
	);
END xor16;

ARCHITECTURE behavior OF xor16 IS
BEGIN
	output <= A XOR B;
END behavior;