LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ADDER_TB IS
END ENTITY ADDER_TB;

ARCHITECTURE BEHAVIORAL OF ADDER_TB IS
SIGNAL A,B,P,OUTPUT: STD_LOGIC_VECTOR(63 DOWNTO 0);

BEGIN
  UUT: ENTITY WORK.MODULO_ADDER PORT MAP 
    ( A => A, B => B, P => P, OUTPUT => OUTPUT);

  TEST_PROCESS: PROCESS
   BEGIN
     A <= std_logic_vector(to_signed(5, A'length));
     B <= std_logic_vector(to_signed(8, B'length));
     P <= std_logic_vector(to_signed(11, P'length));
     WAIT FOR 20 NS;
     A <= std_logic_vector(to_signed(8, A'length));
     B <= std_logic_vector(to_signed(8, B'length));
     P <= std_logic_vector(to_signed(11, P'length));
     WAIT FOR 20 NS;
     A <= std_logic_vector(to_signed(11, A'length));
     B <= std_logic_vector(to_signed(8, B'length));
     P <= std_logic_vector(to_signed(11, P'length));
     WAIT;
   END PROCESS TEST_PROCESS;

END BEHAVIORAL;
