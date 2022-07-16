LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ADDER_TB IS
END ENTITY ADDER_TB;

ARCHITECTURE BEHAVIORAL OF ADDER_TB IS
SIGNAL A, B : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL CI   : STD_LOGIC;
signal SUM  : STD_LOGIC_VECTOR(63 DOWNTO 0);

BEGIN
  UUT: ENTITY WORK.CLA_64BIT
    PORT MAP
      ( A => A, B => B, CI => CI, SUM => SUM);

  TEST_PROCESS: PROCESS

    BEGIN
      A <= std_logic_vector(to_signed(5, A'length));
      B <= std_logic_vector(to_signed(7, B'length));
      CI <= '0';

      WAIT FOR 20 NS;
      A <= std_logic_vector(to_signed(15, A'length));
      B <= std_logic_vector(to_signed(15, B'length));
      CI <= '0';

      WAIT FOR 20 NS;
      A <= std_logic_vector(to_signed(-5, A'length));
      B <= std_logic_vector(to_signed(9, B'length));
      CI <= '0';

      WAIT FOR 20 NS;
      A <= std_logic_vector(to_signed(-5, A'length));
      B <= std_logic_vector(to_signed(-9, B'length));
      CI <= '0';

      WAIT FOR 20 NS;
      A <= std_logic_vector(to_signed(2147483647, A'length));
      B <= std_logic_vector(to_signed(2147483647, B'length));
      CI <= '0';

      WAIT FOR 20 NS;
      A <= "0000000000000000000000000000001000000000000000000000000000000000";
      B <= std_logic_vector(to_signed(2147483647, B'length));
      CI <= '0';

      WAIT;
   END PROCESS;
END BEHAVIORAL;
