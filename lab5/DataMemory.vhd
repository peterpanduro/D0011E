library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataMemory is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           MemWE : in STD_LOGIC;
           Address : in STD_LOGIC_VECTOR (31 downto 0);
           DataIn : in STD_LOGIC_VECTOR (31 downto 0);
           DataOut : out STD_LOGIC_VECTOR (31 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is
type memory_type is array(31 downto 0) of std_logic_vector(31 downto 0);
signal MyMemory:memory_type;
begin
    process(Clk, Reset)
        begin
            if Reset = '1' then
                MyMemory <= (others => (others => '0'));
            elsif Clk'event and Clk='1' then
            if MemWE='1' then
                MyMemory(conv_integer(Address))<=DataIn;
            end if;
        end if;
    end process;
    process(Address)
        begin
            if Address(31 downto 5) = "000000000000000000000000000" then
                DataOut<=MyMemory(conv_integer(Address));
            end if;
    end process;
end Behavioral;
