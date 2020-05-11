library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PCPlus4_tb is
end PCPlus4_tb;

architecture Behavioral of PCPlus4_tb is
component PCPlus4 is
    Port ( Clk : in STD_LOGIC;
       Reset : in STD_LOGIC;
       Q : out STD_LOGIC_VECTOR(31 downto 0));
end component;

signal Clk : STD_LOGIC;
signal Reset   : STD_LOGIC;
signal Q   : STD_LOGIC_VECTOR(31 downto 0);

begin

PCPlus4_instance : PCPlus4 port map(
  Clk => Clk,
  Reset => Reset,
  Q => Q);

  process
    constant PERIOD: time := 40 ns;
  begin
  Reset <= '0';
  Clk <= '0';
  wait for PERIOD;
  Clk <= '1';
  wait for PERIOD;
  Clk <= '0';
  wait for PERIOD;
  
  Clk <= '1';
  Reset <= '1';
  wait for PERIOD;
  Clk <= '0';
  wait for PERIOD;
  Clk <= '1';
  wait for PERIOD;
  Clk <= '0';
  Reset <= '0';
  wait for PERIOD;
  Clk <= '1';
  wait for PERIOD;
  Clk <= '0';
  wait for PERIOD;
  Clk <= '1';
  wait for PERIOD;
  Clk <= '0';
  wait for PERIOD;
  Clk <= '1';
  wait for PERIOD;
  Clk <= '0';
  wait for PERIOD;
  Clk <= '1';
  wait for PERIOD;
  Clk <= '0';
  Reset <= '1';
  wait for PERIOD;
  Clk <= '1';
  wait for PERIOD;
  Clk <= '0';
  wait for PERIOD;
  Clk <= '1';
  wait for PERIOD;
  Clk <= '0';
  
  wait for PERIOD;
  wait for PERIOD;
  end process;

end Behavioral;
