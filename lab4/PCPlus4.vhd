library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PCPlus4 is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (31 downto 0));
end PCPlus4;

architecture Behavioral of PCPlus4 is
component THIRTYTWO_BIT_FULL_ADDER IS
  port(A, B : in std_logic_vector(31 downto 0);
       Sub : in std_logic;
       R : out std_logic_vector(31 downto 0);
       V, C : out std_logic);
end component;
component STATE_REGISTER IS
  Port ( Clk, Reset : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (31 downto 0);
           Q : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal feedback : std_logic_vector(31 downto 0);
signal added    : std_logic_vector(31 downto 0);
begin
    reg : state_register port map(Clk => Clk, Reset => Reset, D => added, Q => feedback);
    adder : THIRTYTWO_BIT_FULL_ADDER port map(A => feedback, B => x"00000004", Sub => '0', R => added, V => open, C => open);
    Q <= feedback;
end Behavioral;
