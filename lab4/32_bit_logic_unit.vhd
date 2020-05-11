library IEEE;
use IEEE.std_logic_1164.all;

entity THIRTYTWO_BIT_LOGIC_UNIT is
  port(A, B : in std_logic_vector(31 downto 0);
       Op : in std_logic;
       R : out std_logic_vector(31 downto 0));
end entity THIRTYTWO_BIT_LOGIC_UNIT;

architecture beteende of THIRTYTWO_BIT_LOGIC_UNIT is
signal AB_and : std_logic_vector(31 downto 0);
signal AB_or  : std_logic_vector(31 downto 0);
begin
  AB_and <= A and B;
  AB_or <= A or B;
  R <= AB_and when Op = '0' else AB_or;
end architecture beteende;


