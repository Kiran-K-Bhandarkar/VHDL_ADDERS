LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ADDER_TB IS
END ENTITY ADDER_TB;

ARCHITECTURE BEHAVIORAL OF ADDER_TB IS
SIGNAL Cin, Cout: STD_LOGIC;
SIGNAL V, W, X, Y      : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL SUM             : STD_LOGIC_VECTOR(64 DOWNTO 0);


BEGIN
  UUT: ENTITY WORK.COMPRESSOR_ADDER
    PORT MAP
      (
		Cin    => Cin,
		Cout   => Cout,
		V      => V,
		W      => W,
		X      => X,
		Y      => Y,
		SUM    => SUM
      );

  TEST_PROCESS: PROCESS
    BEGIN
	  Cin <= '0';
      V   <= std_logic_vector(to_signed(5, V'length));
      W   <= std_logic_vector(to_signed(5, W'length));
      X   <= std_logic_vector(to_signed(5, X'length));
	  Y   <= std_logic_vector(to_signed(5, Y'length));
      WAIT FOR 20 NS;
	  Cin <= '0';
      V   <= std_logic_vector(to_signed(5000, V'length));
      W   <= std_logic_vector(to_signed(15000, W'length));
      X   <= std_logic_vector(to_signed(65, X'length));
	  Y   <= std_logic_vector(to_signed(123456, Y'length));
      WAIT FOR 20 NS;
	  V   <= std_logic_vector(to_signed(2147483647, V'length));
      W   <= std_logic_vector(to_signed(2147483647, W'length));
      X   <= std_logic_vector(to_signed(2147483647, X'length));
	  Y   <= std_logic_vector(to_signed(2147483647, Y'length));
      WAIT FOR 20 NS;
	  V   <= std_logic_vector(to_signed(2147483647, V'length));
      W   <= std_logic_vector(to_signed(2147483647, W'length));
      X   <= std_logic_vector(to_signed(2147483647, X'length));
      Y <= "0000000000000000000000000000001000000000000000000000000000000000";
      WAIT;
  END PROCESS;
END BEHAVIORAL;


