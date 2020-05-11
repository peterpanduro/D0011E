library IEEE;
use IEEE.std_logic_1164.all;

entity THIRTYTWO_BIT_FULL_ADDER is
  port(A, B : in std_logic_vector(31 downto 0);
       Sub : in std_logic;
       R : out std_logic_vector(31 downto 0);
       V, C : out std_logic);
end entity THIRTYTWO_BIT_FULL_ADDER;

architecture beteende of THIRTYTWO_BIT_FULL_ADDER is
component ONE_BIT_FULL_ADDER IS
  port(A, B, Cin : in STD_LOGIC;
       R, Cout: out STD_LOGIC);
end component;

signal bcompifsub : std_logic_vector(31 downto 0);
signal inter_r    : std_logic_vector(31 downto 0);
signal carries    : std_logic_vector(32 downto 0);
begin
  bcompifsub <= not B when Sub = '1' else B;
  carries(0) <= Sub;
  adders: for i in 0 to 31 generate
    adder_instance: ONE_BIT_FULL_ADDER port map(A => A(i), B => bcompifsub(i), Cin => carries(i), R => inter_r(i), Cout => carries(i+1));
  end generate;
  R <= inter_r;
  C <= carries(32);
  V <= carries(32) XOR carries (31);
end architecture beteende;

