LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY not16 IS
	PORT(
			A			:IN std_logic_vector(15 downto 0);
			output	:OUT std_logic_vector(15 downto 0)
	);
END not16;

ARCHITECTURE behavior OF not16 IS
BEGIN
	output <= NOT A;
END behavior;