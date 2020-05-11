library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DataMemory_tb is
end DataMemory_tb;

architecture Behavioral of DataMemory_tb is
component DataMemory
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           MemWE : in STD_LOGIC;
           Address : in STD_LOGIC_VECTOR (31 downto 0);
           DataIn : in STD_LOGIC_VECTOR (31 downto 0);
           DataOut : out STD_LOGIC_VECTOR (31 downto 0));
end component;
signal Clk, Reset, MemWE : STD_LOGIC;
signal Address, DataIn, DataOut : STD_LOGIC_VECTOR(31 downto 0);

begin
    DataMemory_instance: DataMemory port map(Clk=>Clk, Reset=>Reset, MemWE=>MemWE, Address=>Address, DataIn=>DataIn, DataOut=>DataOut);
    process
        constant PERIOD: time := 40 ns;
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
        -- Begin test
        -- Write to Address 0 without MemWE (read)
        MemWE <= '0';
        Address <= x"00000000";
        DataIn <= x"00000001";
        Clk <= '1';
        wait for PERIOD;
        Clk <= '0';
        wait for PERIOD;
        -- Write with MemWE
        MemWE <= '1';
        Clk <= '1';
        wait for PERIOD;
        Clk <= '0';
        wait for PERIOD;
        -- Write to Address 4
        MemWE <= '1';
        Address <= x"00000004";
        DataIn <= x"00000004";
        Clk <= '1';
        wait for PERIOD;
        Clk <= '0';
        wait for PERIOD;
        -- Read from Address 0
        MemWE <= '0';
        Address <= x"00000000";
        Clk <= '1';
        wait for PERIOD;
        Clk <= '0';
        wait for PERIOD;
        -- Wait
        wait;
    end process;
end Behavioral;
