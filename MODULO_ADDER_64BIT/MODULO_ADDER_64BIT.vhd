LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY MODULO_ADDER IS PORT
(
  A, B, P: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
  OUTPUT : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
);
END ENTITY MODULO_ADDER;

ARCHITECTURE BEHAVIORAL OF MODULO_ADDER IS
SIGNAL A1_TEMP, B1_TEMP, P_TEMP, 
OP1_TEMP, OP2_TEMP: STD_LOGIC_VECTOR(63 DOWNTO 0) := (OTHERS => '0');

SIGNAL PC_TEMP, A2_TEMP, B2_TEMP, 
C_CSA_TEMP, S_CSA_TEMP, SUM2_TEMP: STD_LOGIC_VECTOR(64 DOWNTO 0);

COMPONENT TWO_COMP PORT
(
  A : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
  A_COMP: OUT STD_LOGIC_VECTOR(64 DOWNTO 0)
);
END COMPONENT;

COMPONENT RC_ADDER_64 PORT
(
  A,B: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
  S  : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
);
END COMPONENT;

COMPONENT CS_ADDER PORT
(
  X,Y,Z : IN STD_LOGIC_VECTOR(64 DOWNTO 0);
  S     : OUT STD_LOGIC_VECTOR(64 DOWNTO 0)
);
END COMPONENT;

BEGIN
  -- ASSIGN INPUTS
  A1_TEMP <= A;
  A2_TEMP <= STD_LOGIC_VECTOR(RESIZE(SIGNED(A), A2_TEMP'LENGTH));

  B1_TEMP <= B;
  B2_TEMP <= STD_LOGIC_VECTOR(RESIZE(SIGNED(B), B2_TEMP'LENGTH));

  P_TEMP <= P;
  
  -- CALCULATING TWOS COMPLIMENT OF P (-P)
  P_2_COMP: TWO_COMP PORT MAP
     (A => P_TEMP, A_COMP => PC_TEMP);

  -- 64 BIT ADDITION USING RIPPLE CARRY ADDER
  RCA_64: RC_ADDER_64 PORT MAP 
     (A => A1_TEMP, B => B1_TEMP, S => OP1_TEMP);

  -- 65 BIT ADDITION USING CSA + RIPPLE CARRY ADDER
  CSA_65: CS_ADDER PORT MAP 
     (X => A2_TEMP, Y => B2_TEMP, Z => PC_TEMP, S => S_CSA_TEMP);

  -- OUTPUT ASSIGNMENT
  OUTPUT_PROCESS: PROCESS(ALL)
    BEGIN
      CASE S_CSA_TEMP(64) IS
	WHEN '1' =>
	   OUTPUT <= OP1_TEMP;
        WHEN '0' => 
	   OUTPUT <= S_CSA_TEMP(63 DOWNTO 0);
        WHEN OTHERS =>
	   OUTPUT <= (OTHERS => 'X');
      END CASE;
   END PROCESS OUTPUT_PROCESS;
END BEHAVIORAL;
