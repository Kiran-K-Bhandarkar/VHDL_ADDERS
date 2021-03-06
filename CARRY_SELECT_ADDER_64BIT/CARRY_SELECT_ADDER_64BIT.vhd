LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CSEL_ADDER IS 
GENERIC
(
  INPUT_WIDTH: INTEGER := 64
);

PORT 
(
  A,B : IN STD_LOGIC_VECTOR(INPUT_WIDTH-1 DOWNTO 0);
  CIN : IN STD_LOGIC;
  SUM : OUT STD_LOGIC_VECTOR(INPUT_WIDTH-1 DOWNTO 0);
  CO  : OUT STD_LOGIC
);
END ENTITY CSEL_ADDER;

ARCHITECTURE BEHAVIORAL OF CSEL_ADDER IS
SIGNAL CI_TEMP: STD_LOGIC;
SIGNAL A_TEMP, B_TEMP, CO_TEMP0, CO_TEMP1,
SUM_TEMP0, SUM_TEMP1: STD_LOGIC_VECTOR(INPUT_WIDTH-1 DOWNTO 0) := (OTHERS => '0');

COMPONENT FULL_ADDER PORT
(
  A,B,CI: IN STD_LOGIC;
  S, CO: OUT STD_LOGIC
);
END COMPONENT;

BEGIN
  A_TEMP  <= A;
  B_TEMP  <= B;
  CI_TEMP <= CIN;

  -- FULL ADDER LAYER 1
  FA_1_0: FULL_ADDER PORT MAP
	(A => A_TEMP(0), B => B_TEMP(0), CI => '0', S => SUM_TEMP0(0), CO => CO_TEMP0(0));

  FA_LAYER_1: FOR I IN 1 TO INPUT_WIDTH-1 GENERATE
   FA_1_I: FULL_ADDER PORT MAP
        (
	  A  => A_TEMP(I), 
	  B  => B_TEMP(I), 
	  CI => CO_TEMP0(I-1), 
  	  S  => SUM_TEMP0(I), 
	  CO => CO_TEMP0(I)
	);
   END GENERATE FA_LAYER_1;

  -- FULL ADDER LAYER 2
  FA_2_0: FULL_ADDER PORT MAP
	(A => A_TEMP(0), B => B_TEMP(0), CI => '1', S => SUM_TEMP1(0), CO => CO_TEMP1(0));

  FA_LAYER_2: FOR I IN 1 TO INPUT_WIDTH-1 GENERATE
   FA_2_I: FULL_ADDER PORT MAP
        (
	  A  => A_TEMP(I), 
	  B  => B_TEMP(I), 
	  CI => CO_TEMP1(I-1), 
  	  S  => SUM_TEMP1(I), 
	  CO => CO_TEMP1(I)
	);
   END GENERATE FA_LAYER_2;

  -- OUTPUT ASSIGNMENT
  OUTPUT_PROCESS: PROCESS(ALL)
    BEGIN
      CASE CIN IS
	WHEN '0' =>
	  SUM <= SUM_TEMP0;
 	  CO  <= CO_TEMP0(INPUT_WIDTH-1);
	WHEN '1' =>
 	  SUM <= SUM_TEMP1;
 	  CO  <= CO_TEMP1(INPUT_WIDTH-1);
        WHEN OTHERS =>
	  SUM <= (OTHERS => 'X');
	  CO  <= 'X';
      END CASE;
    END PROCESS OUTPUT_PROCESS;

END BEHAVIORAL;