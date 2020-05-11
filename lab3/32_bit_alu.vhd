library IEEE;
use IEEE.std_logic_1164.all;

entity THIRTYTWO_BIT_ALU is
  port(
       A, B : in std_logic_vector(31 downto 0);
       ALUC : in std_logic_vector(1 downto 0);
       SUB  : in std_logic;
       R : out std_logic_vector(31 downto 0);
       Z : out std_logic);
end entity THIRTYTWO_BIT_ALU;

architecture beteende of THIRTYTWO_BIT_ALU is
component THIRTYTWO_BIT_FULL_ADDER IS
  port(
       A, B : in std_logic_vector(31 downto 0);
       Sub : in std_logic;
       R : out std_logic_vector(31 downto 0);
       V, C : out std_logic);
end component;
component THIRTYTWO_BIT_LOGIC_UNIT IS
  port(A, B : in std_logic_vector(31 downto 0);
       Op : in std_logic;
       R : out std_logic_vector(31 downto 0));
end component;
component ZERO_EXTENDER is
    Port (MSB : in STD_LOGIC;
          R : out STD_LOGIC_VECTOR(31 downto 0));
end component;

signal AB_and, AB_or, addsub, SLT, R_int : std_logic_vector(31 downto 0);
begin
  logic_and : THIRTYTWO_BIT_LOGIC_UNIT port map(A => A, B => B, Op => '0', R => AB_and);
  logic_or : THIRTYTWO_BIT_LOGIC_UNIT port map(A => A, B => B, Op => '1', R => AB_or);  
  adder : THIRTYTWO_BIT_FULL_ADDER port map(A => A, B => B, Sub => SUB, R => addsub, V => open, C => open);
  ze : ZERO_EXTENDER port map(MSB => addsub(31), R => SLT);
  R_int <= AB_and when ALUC = "00" else
           AB_or  when ALUC = "01" else
           addsub when ALUC = "10" else
           SLT    when ALUC = "11";
  R <= R_int;
  Z <= '1' when (R_int = "00000000000000000000000000000000") else '0'; 
end architecture beteende;

