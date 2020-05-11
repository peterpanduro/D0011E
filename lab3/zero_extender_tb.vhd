library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity zero_extender_tb is
end zero_extender_tb;
architecture stimulus of zero_extender_tb is

  component zero_extender
  Port (MSB : in STD_LOGIC;
        R : out STD_LOGIC_VECTOR(31 downto 0));
  end component;

  signal MSB : std_logic;
  signal R : std_logic_vector(31 downto 0);
begin
  zero_extender_instance: zero_extender port map(
  MSB=>MSB,
  R => R
  );
  process
    constant PERIOD: time := 40 ns;
  begin
    MSB <= '0';
    wait for PERIOD;
    MSB <= '1';
    wait for PERIOD;
    wait for PERIOD;
  end process;
end stimulus;
