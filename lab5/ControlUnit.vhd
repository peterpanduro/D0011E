library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port(op             : in STD_LOGIC_VECTOR (5 downto 0);
         funct          : in STD_LOGIC_VECTOR (5 downto 0);
         ALUControl     : out STD_LOGIC_VECTOR (2 downto 0);
         RegDestination : out STD_LOGIC;
         ALUSource      : out STD_LOGIC;
         WriteEnable    : out STD_LOGIC;
         MemWE          : out STD_LOGIC;
         MemtoReg       : out STD_LOGIC;
         Branch         : out STD_LOGIC;
         Jump           : out STD_LOGIC);
end ControlUnit;

architecture Behavioral of ControlUnit is
signal is_r_type : std_logic;
signal f : std_logic_vector(5 downto 0);

begin
    is_r_type <= '1' when op = "000000" else '0';
    RegDestination <= is_r_type;
    ALUSource <= '1' when is_r_type = '1' nor op = "000100" else '0';
    WriteEnable <= '0' when op = "101011" or op = "000100" or op = "000010" else '1';
    MemWE <= '1' when op = "101011" else '0';
    MemtoReg <= '1' when op = "100011" else '0';
    Branch <= '1' when op = "000100" else '0';
    Jump <= '1' when op = "000010" else '0';
    f <= funct when is_r_type = '1' else op;
    ALUControl <= "010" when f = "100000" else                 -- ADD
                  "010" when f = "001000" else                 -- ADDI
                  "110" when f = "100010" else                 -- SUB
                  "111" when f = "101010" or f = "001010" else --SLT/SLTI
                  "000" when f = "100100" else                 -- AND
                  "001" when f = "100101" else                 -- OR
                  "010" when f = "100011" or f = "101011" else -- lw/sw
                  "110"; -- when f = "000100" -- beq 
end Behavioral;
