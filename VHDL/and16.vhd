LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY and16 IS
	PORT(
			A,B		:IN std_logic_vector(15 downto 0);
			output	:OUT std_logic_vector(15 downto 0)
	);
END and16;

ARCHITECTURE behavior OF and16 IS
BEGIN
	output <= A AND B;
END behavior;