LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ADDER_TB IS
END ENTITY ADDER_TB;

ARCHITECTURE BEHAVIORAL OF ADDER_TB IS
SIGNAL X,Y,Z: STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL S: STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL CO : STD_LOGIC;

BEGIN
  UUT: ENTITY WORK.CS_ADDER
    PORT MAP
      (
	X => X,
	Y => Y,
	Z => Z,
	S => S,
        CO => CO
      );

  TEST_PROCESS: PROCESS
    BEGIN
      X <= std_logic_vector(to_signed(-5, X'length));
      Y <= std_logic_vector(to_signed(-7, Y'length));
      Z <= std_logic_vector(to_signed(5, Z'length));
      WAIT FOR 20 NS;
      X <= std_logic_vector(to_signed(-255, X'length));
      Y <= std_logic_vector(to_signed(-259, Y'length));
      Z <= std_logic_vector(to_signed(-255, Z'length));
      WAIT FOR 20 NS;
      X <= std_logic_vector(to_signed(65535, X'length));
      Y <= std_logic_vector(to_signed(65353, Y'length));
      Z <= std_logic_vector(to_signed(65353, Z'length));
      WAIT FOR 20 NS;
      X <= std_logic_vector(to_signed(2147483647, X'length));
      Y <= std_logic_vector(to_signed(2147483647, Y'length));
      Z <= std_logic_vector(to_signed(2147483647, Z'length));
      WAIT FOR 20 NS;
      X <= "0000000000000000000000000000001000000000000000000000000000000000";
      Y <= std_logic_vector(to_signed(2147483647, Y'length));
      Z <= std_logic_vector(to_signed(2147483647, Z'length));
      WAIT;
  END PROCESS;
END BEHAVIORAL;

