LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux16 IS
	PORT(
		d0,d1,d2,d3,d4,d5,d6,d7		:IN std_logic_vector(15 downto 0);
		d8,d9,dA,dB,dC,dD,dE,dF		:IN std_logic_vector(15 downto 0);
		sel								:IN std_logic_vector(3 downto 0);
		f									:OUT std_logic_vector(15 downto 0)
	);
END mux16;

ARCHITECTURE behavior OF mux16 IS
BEGIN
	WITH sel SELECT
		f <= d0 WHEN "0000",
			  d1 WHEN "0001",
			  d2 WHEN "0010",
			  d3 WHEN "0011",
			  d4 WHEN "0100",
			  d5 WHEN "0101",
			  d6 WHEN "0110",
			  d7 WHEN "0111",
			  d8 WHEN "1000",
			  d9 WHEN "1001",
			  dA WHEN "1010",
			  dB WHEN "1011",
			  dC WHEN "1100",
			  dD WHEN "1101",
			  dE WHEN "1110",
			  dF WHEN "1111";
END behavior;