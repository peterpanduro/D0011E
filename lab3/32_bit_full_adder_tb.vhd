library ieee;              -- Load the ieee 1164 library
use ieee.std_logic_1164.all;  -- Make the package 'visible'

-- The top level entity of the test bench has no ports...
entity thirtytwo_bit_full_adder_tb is
end thirtytwo_bit_full_adder_tb;
 
architecture stimulus of thirtytwo_bit_full_adder_tb is
  -- First, declare the lower-level entity...
  component thirtytwo_bit_full_adder
    port(A, B : in std_logic_vector(31 downto 0);
         Sub : in std_logic;
         R : out std_logic_vector(31 downto 0);
         V, C : out std_logic);
  end component;
  
  -- Next, declare some local signals to assign values to and observe...
  signal A, B, R : std_logic_vector(31 downto 0);
  signal SUB, V, C : std_logic;
 
begin
  -- Create an instance of the component under test
  thirtytwo_bit_full_adder_instance: thirtytwo_bit_full_adder port map(
  A=>A,
  B=>B,
  R=>R,
  SUB=>SUB,
  V=>V,
  C=>C);
 
  process
    constant PERIOD: time := 40 ns;
  begin
    A <= "00000000000000000000000000000101";
    B <= "00000000000000000000000000000011";
    SUB <= '0';
    wait for PERIOD;
    SUB <= '1';
    wait for PERIOD;
    A <= "00000000000000000000000000000101";
    B <= "10000000000000000000000000000011";
    SUB <= '0';
    wait for PERIOD;
    SUB <= '1';
    wait for PERIOD;
    wait for PERIOD;
  end process;
end stimulus;





