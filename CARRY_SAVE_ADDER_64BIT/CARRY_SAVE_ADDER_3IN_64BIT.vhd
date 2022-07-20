LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CSA_ADDER IS
GENERIC
(
  INPUT_WIDTH : INTEGER := 64
);

PORT
(
  A, B, C : IN STD_LOGIC_VECTOR(INPUT_WIDTH-1 DOWNTO 0);
  CO      : OUT STD_LOGIC;
  S       : OUT STD_LOGIC_VECTOR(INPUT_WIDTH-1 DOWNTO 0)
);
END ENTITY CSA_ADDER;

ARCHITECTURE BEHAVIORAL OF CSA_ADDER IS
SIGNAL A_TEMP, B_TEMP, C_TEMP: STD_LOGIC_VECTOR(INPUT_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
SIGNAL C0_TEMP, S0_TEMP, C1_TEMP, S1_TEMP: STD_LOGIC_VECTOR(INPUT_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
SIGNAL CO_TEMP, SO_TEMP: STD_LOGIC := '0';

COMPONENT FULL_ADDER PORT
(
  A,B,CI: IN STD_LOGIC;
  S, CO: OUT STD_LOGIC
);
END COMPONENT;

BEGIN
  A_TEMP <= A;
  B_TEMP <= B;
  C_TEMP <= C;

  -- PREPROCESSING LAYER
  PRE_PROCESS: FOR I IN 0 TO INPUT_WIDTH-1 GENERATE
    FA_I: FULL_ADDER PORT MAP
      (
	A   => A_TEMP(I),
        B   => B_TEMP(I),
        CI  => C_TEMP(I),
        S   => S0_TEMP(I),
        CO  => C0_TEMP(I)
      );
    END GENERATE PRE_PROCESS;

  -- RIPPLE CARRY ADDER LAYER
  S1_TEMP(0) <= S0_TEMP(0);
  C1_TEMP(0) <= C0_TEMP(0);

  FA_RC_1: FULL_ADDER PORT MAP
      (
	A   => C0_TEMP(0),
        B   => S0_TEMP(1),
        CI  => '0',
        S   => S1_TEMP(1),
        CO  => C1_TEMP(1)
      );
  RIPPLE_CARRY_PROCESS: FOR I IN 2 TO INPUT_WIDTH-1 GENERATE
    FA_RC_I: FULL_ADDER PORT MAP
      (
	A   => C0_TEMP(I-1),
        B   => S0_TEMP(I),
        CI  => C1_TEMP(I-1),
        S   => S1_TEMP(I),
        CO  => C1_TEMP(I)
      );
    END GENERATE RIPPLE_CARRY_PROCESS;    
  
  -- OUTPUT
  S  <= S1_TEMP;
  CO <= C1_TEMP(INPUT_WIDTH-1);
END BEHAVIORAL;

  
  
