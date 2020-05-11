library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PCPlus4 is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (31 downto 0);
           beq_offset : in std_logic_vector(31 downto 0);
           j_addr : in std_logic_vector(25 downto 0);
           ZeroFlag, Branch, Jump : in std_logic);
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
signal nextState: std_logic_vector(31 downto 0);
signal b_state, j_state, beq_leftshift, j_leftshift: STD_LOGIC_VECTOR (31 downto 0);
signal branch_and : std_logic;
begin
    nextState <= added when (Jump = '0' AND branch_and = '0') else
                 b_state when (Jump = '0' AND branch_and = '1') else
                 j_state when (Jump = '1' AND branch_and = '0');
    
    branch_and <= Branch AND ZeroFlag;
    
    beq_leftshift(31 downto 2) <= beq_offset(29 downto 0);
    beq_leftshift(1 downto 0) <= "00";    
    beq_adder : THIRTYTWO_BIT_FULL_ADDER port map(A => beq_leftshift, B => added, Sub => '0', R => b_state, V => open, C => open);
    
    j_leftshift(27 downto 2) <= j_addr;
    j_leftshift(31 downto 28) <= "0000";
    j_leftshift(1 downto 0) <= "00";
    j_state <= (added AND x"f0000000") OR (j_leftshift);

    reg : state_register port map(Clk => Clk, Reset => Reset, D => nextState, Q => feedback);
    adder : THIRTYTWO_BIT_FULL_ADDER port map(A => feedback, B => x"00000004", Sub => '0', R => added, V => open, C => open);
    Q <= feedback;
end Behavioral;
