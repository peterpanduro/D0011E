library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignExtend is
    Port(Input : in STD_LOGIC_VECTOR (15 downto 0);
         Output : out STD_LOGIC_VECTOR (31 downto 0));
end SignExtend;

architecture Behavioral of SignExtend is

begin
     Output(15 downto 0) <= Input;
     Output(31 downto 16) <= x"0000" when Input(15) = '0' else x"ffff";
end Behavioral;
