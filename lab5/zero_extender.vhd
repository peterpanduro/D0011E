library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ZERO_EXTENDER is
    Port (MSB : in STD_LOGIC;
          R : out STD_LOGIC_VECTOR(31 downto 0));
end ZERO_EXTENDER;
architecture beteende of ZERO_EXTENDER is

begin
  R <= (0 => MSB, others=> '0');
end beteende;
