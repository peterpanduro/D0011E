--  BCDcheck
--  Indikerar egenskaper hos siffror i BCD-kod

library IEEE;
use IEEE.std_logic_1164.all;

entity ONE_BIT_FULL_ADDER IS
  port(A, B, Cin : in STD_LOGIC;
       R, Cout: out STD_LOGIC);
end entity ONE_BIT_FULL_ADDER;

architecture beteende OF ONE_BIT_FULL_ADDER IS
begin
  R <= A XOR B XOR Cin;
  Cout <= (A AND B) OR (Cin AND A) OR (Cin AND B);	
end architecture beteende;

