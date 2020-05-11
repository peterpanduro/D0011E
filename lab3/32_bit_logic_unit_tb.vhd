library ieee;              -- Load the ieee 1164 library
use ieee.std_logic_1164.all;  -- Make the package 'visible'

-- The top level entity of the test bench has no ports...
entity thirtytwo_bit_logic_unit_tb is
end thirtytwo_bit_logic_unit_tb;
 
architecture stimulus of thirtytwo_bit_logic_unit_tb is
  -- First, declare the lower-level entity...
  component thirtytwo_bit_logic_unit
    port(A, B : in std_logic_vector(31 downto 0);
         Op : in std_logic;
         R : out std_logic_vector(31 downto 0));
  end component;
  
  -- Next, declare some local signals to assign values to and observe...
  signal A, B, R : std_logic_vector(31 downto 0);
  signal Op : std_logic;
 
begin
  -- Create an instance of the component under test
  thirtytwo_bit_logic_unit_instance: thirtytwo_bit_logic_unit port map(A=>A, B=>B, Op=>Op, R=>R);
 
  process
    constant PERIOD: time := 40 ns;
  begin
    A <= "00000000000000000000000000000101";
    B <= "00000000000000000000000000000011";
    Op <= '0';
    wait for PERIOD;
    Op <= '1';
    wait for PERIOD;
    wait for PERIOD;        
  end process;
end stimulus;





