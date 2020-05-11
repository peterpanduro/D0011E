library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity state_register is
    Port ( Clk, Reset : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (31 downto 0);
           Q : out STD_LOGIC_VECTOR (31 downto 0));
end state_register;

architecture beteende of state_register is
begin
    process(Clk) begin
        if rising_edge(clk) then
            if Reset = '1' then Q <= x"00000000";
            else Q <= D;
            end if;
        end if;
    end process;
end beteende;
