LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY controlUnit IS
PORT(
S,N,C,V,Z,mfc,clock,reset :IN STD_LOGIC;
opCode, Cond			  :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
opx						  :IN STD_LOGIC_VECTOR(2 DOWNTO 0);
rf_write, b_select, a_inv, b_inv, ir_enable, ma_select, mem_read, mem_write, pc_select, pc_enable, inc_select 				 :OUT STD_LOGIC;
alu_op, c_select, y_select, extend		:OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
);
END controlUnit;

ARCHITECTURE behavior OF controlUnit IS
SIGNAL wmfc: std_logic;
shared variable stage: integer:=0;
BEGIN
	PROCESS(clock, reset)
	BEGIN
		IF (rising_edge(clock)) THEN
			IF (reset = '1') THEN 
				stage:=0;
			END IF;
			IF ((mfc = '1' OR wmfc = '0')) THEN
				stage:=stage mod 5+1;
			END IF;
			IF (stage = 1) THEN
				wmfc <= '1';
				alu_op <= "00";
				c_select <= "01";
				y_select <= "00";
				rf_write <= '0';
				b_select <= '0';
				a_inv <= '0';
				b_inv <= '0';
				extend <= "00";
				ir_enable <= '1';
				ma_select <= '1';
				mem_read <= '1';
				mem_write <= '0';
				pc_select <= '1';
				pc_enable <= mfc;
				inc_select <= '0';
			ELSIF (stage = 2) THEN
				wmfc <= '0';
				ir_enable <= '0';
				mem_read <= '0';
				pc_enable <= '0';
			ELSIF (stage = 3) THEN 
				IF(opCode(3) = '1' AND opCode(2) = '1') THEN
					IF(opCode(1) = '0' AND opCode(0) = '1') THEN
					ELSIF(opCode(1) = '0' AND opCode(0) = '0') THEN
						IF(opx = "000") THEN
							--AND instruction
							alu_op <= "00";
						ELSIF(opx = "001") THEN
							--OR instruction
							alu_op <= "01";
						ELSIF(opx = "010") THEN
							--XOR intstruction
							alu_op <= "10";
						ELSIF(opx = "011") THEN
							--ADD instruction
							alu_op <= "11";
						ELSIF(opx = "100") THEN
							--SUB instruction
							alu_op <= "11";
							b_inv <= '1';
						END IF;
					END IF;
				END IF;
			ELSIF (stage = 4) THEN 
				IF(opCode(3) = '1' AND opCode(2) = '1') THEN
					IF(opCode(1) = '0' AND opCode(0) = '1') THEN
					END IF;
				END IF;
			ELSIF (stage = 5) THEN 
				IF(opCode(3) = '1' AND opCode(2) = '1') THEN
					IF(opCode(1) = '0' AND opCode(0) = '1') THEN
					--for jr
					ELSIF(opCode(1) = '0' AND opCode(0) = '0') THEN
						rf_write <= '1';
					END IF;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END behavior;