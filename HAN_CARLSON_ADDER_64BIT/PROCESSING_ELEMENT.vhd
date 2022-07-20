LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY PROCESS_ELEMENT IS PORT
(
  Gi, Gj, Pi, Pj: IN STD_LOGIC;
  P, G: OUT STD_LOGIC
);
END ENTITY PROCESS_ELEMENT;

ARCHITECTURE BEHAVIORAL OF PROCESS_ELEMENT IS
BEGIN
  P <= Pi AND Pj;
  G <= Gi OR (Gj AND Pi);
END BEHAVIORAL;