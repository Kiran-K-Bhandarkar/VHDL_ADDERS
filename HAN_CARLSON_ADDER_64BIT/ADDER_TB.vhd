LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ADDER_TB IS
END ENTITY ADDER_TB;

ARCHITECTURE BEHAVIORAL OF ADDER_TB IS
SIGNAL A, B: STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL S: STD_LOGIC_VECTOR(63 DOWNTO 0);

BEGIN
  UUT: ENTITY WORK.HC_ADDER
    PORT MAP
      (
	A => A,
	B => B,
	S => S
      );

  TEST_PROCESS: PROCESS
    BEGIN
      A <= std_logic_vector(to_signed(5, A'length));
      B <= std_logic_vector(to_signed(-7, B'length));
      WAIT FOR 20 NS;
      A <= std_logic_vector(to_signed(-5, A'length));
      B <= std_logic_vector(to_signed(-7, B'length));
      WAIT FOR 20 NS;
      A <= std_logic_vector(to_signed(255, A'length));
      B <= std_logic_vector(to_signed(259, B'length));
      WAIT FOR 20 NS;
      A <= std_logic_vector(to_signed(65535, A'length));
      B <= std_logic_vector(to_signed(65353, B'length));
      WAIT FOR 20 NS;
      A <= std_logic_vector(to_signed(2147483647, A'length));
      B <= std_logic_vector(to_signed(2147483647, B'length));
      WAIT FOR 20 NS;
      A <= "0000000000000000000000000000001000000000000000000000000000000000";
      B <= std_logic_vector(to_signed(2147483647, B'length));
      WAIT;
  END PROCESS;
END BEHAVIORAL;

