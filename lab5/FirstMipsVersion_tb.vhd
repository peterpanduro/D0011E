library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FirstMipsVersion_tb is
end FirstMipsVersion_tb;

architecture Behavioral of FirstMipsVersion_tb is
component FirstMipsVersion
    Port(Clk   : in STD_LOGIC;
         Reset : in STD_LOGIC);
end component;
signal Clk, Reset : std_logic;

begin
    FirstMipsVersion_instance: FirstMipsVersion port map(Clk=>Clk, Reset=>Reset);
    process
        constant PERIOD: time := 80 ns;
    begin
    -- Reset
    Reset <= '1';
    Clk <= '0';
    wait for PERIOD;
    Clk <= '1';
    wait for PERIOD;
    Reset <= '0';
    Clk <= '0';
    wait for PERIOD;
    for i in 0 to 15 loop
    -- for i in 0 to 150 loop
        Clk <= '1';
        wait for PERIOD;
        Clk <= '0';
        wait for PERIOD;
    end loop;
    wait for PERIOD;
    end process;
end Behavioral;
