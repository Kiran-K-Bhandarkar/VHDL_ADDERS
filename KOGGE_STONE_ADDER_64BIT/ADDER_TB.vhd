LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ADDER_TB IS
END ENTITY ADDER_TB;

ARCHITECTURE BEHAVIORAL OF ADDER_TB IS
SIGNAL NEG_B: STD_LOGIC;
SIGNAL A, B: STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL S: STD_LOGIC_VECTOR(63 DOWNTO 0);

BEGIN
  UUT: ENTITY WORK.KS_ADDER
    PORT MAP
      (
	NEG_B => NEG_B,
	A => A,
	B => B,
	S => S
      );

  TEST_PROCESS: PROCESS
    BEGIN
      A <= std_logic_vector(to_signed(5, A'length));
      B <= std_logic_vector(to_signed(-7, B'length));
      NEG_B <= '0';
      WAIT FOR 20 NS;
      A <= std_logic_vector(to_signed(-5, A'length));
      B <= std_logic_vector(to_signed(-7, B'length));
      NEG_B <= '0';
      WAIT FOR 20 NS;
      A <= std_logic_vector(to_signed(255, A'length));
      B <= std_logic_vector(to_signed(259, B'length));
      NEG_B <= '0';
      WAIT FOR 20 NS;
      A <= std_logic_vector(to_signed(65535, A'length));
      B <= std_logic_vector(to_signed(65353, B'length));
      NEG_B <= '0';
      WAIT FOR 20 NS;
      A <= std_logic_vector(to_signed(2147483647, A'length));
      B <= std_logic_vector(to_signed(2147483647, B'length));
      NEG_B <= '0';
      WAIT FOR 20 NS;
      A <= "0000000000000000000000000000001000000000000000000000000000000000";
      B <= std_logic_vector(to_signed(2147483647, B'length));
      NEG_B <= '0';
      WAIT;
  END PROCESS;
END BEHAVIORAL;

