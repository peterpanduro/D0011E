library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port(op             : in STD_LOGIC_VECTOR (5 downto 0);
         funct          : in STD_LOGIC_VECTOR (5 downto 0);
         ALUControl     : out STD_LOGIC_VECTOR (2 downto 0);
         RegDestination : out STD_LOGIC;
         ALUSource      : out STD_LOGIC);
end ControlUnit;

architecture Behavioral of ControlUnit is
signal is_r_type : std_logic;
signal f : std_logic_vector(5 downto 0);

begin
    is_r_type <= '1' when op = "000000" else '0';
    RegDestination <= is_r_type;
    ALUSource <= not is_r_type;
    f <= funct when is_r_type = '1' else op;
    ALUControl <= "010" when f = "100000" else                 -- ADD
                  "010" when f = "001000" else                 -- ADDI
                  "110" when f = "100010" else                 -- SUB
                  "111" when f = "101010" or f = "001010" else --SLT/SLTI
                  "000" when f = "100100" else                 -- AND
                  "001" when f = "100101";                     -- OR
end Behavioral;
