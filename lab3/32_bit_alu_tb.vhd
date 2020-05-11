library ieee;              -- Load the ieee 1164 library
use ieee.std_logic_1164.all;  -- Make the package 'visible'

-- The top level entity of the test bench has no ports...
entity THIRTYTWO_BIT_ALU_tb is
end THIRTYTWO_BIT_ALU_tb;
 
architecture stimulus of THIRTYTWO_BIT_ALU_tb is
  -- First, declare the lower-level entity...
  component THIRTYTWO_BIT_ALU
    port(A, B : in std_logic_vector(31 downto 0);
         ALUC : in std_logic_vector(1 downto 0);
         SUB  : in std_logic;
         R : out std_logic_vector(31 downto 0);
         Z : out std_logic);
  end component;
  
  -- Next, declare some local signals to assign values to and observe...
  signal A, B, R : std_logic_vector(31 downto 0);
  signal ALUC : std_logic_vector(1 downto 0);
  signal SUB, Z : std_logic;
 
begin
  -- Create an instance of the component under test
  THIRTYTWO_BIT_ALU_instance: THIRTYTWO_BIT_ALU port map(
  A=>A,
  B=>B,
  R=>R,
  SUB=>SUB,
  ALUC=>ALUC,
  Z=>Z);
 
  process
    constant PERIOD: time := 40 ns;
  begin
    SUB <= '0';
    ALUC <= "00";
    A <= "00000000000000000000000000000101";
    B <= "00000000000000000000000000000011";
    wait for PERIOD;
    SUB <= '1';
    wait for PERIOD;
    B <= not A;
    wait for PERIOD;
    B <= "00000000000000000000000000000011";
    SUB <= '0';
    ALUC <= "01";
    wait for PERIOD;
    SUB <= '1';
    wait for PERIOD;
    B <= x"00000000";
    A <= x"00000000";
    wait for PERIOD;
    A <= "00000000000000000000000000000101";
    B <= "00000000000000000000000000000011";
    SUB <= '0';
    ALUC <= "10";
    wait for PERIOD;
    B <= x"fffffffb";
    wait for PERIOD;
    B <= "00000000000000000000000000000011";
    SUB <= '1';
    wait for PERIOD;
    B <= A;
    wait for PERIOD;
    B <= "00000000000000000000000000000011";
    SUB <= '0';
    ALUC <= "11";
    wait for PERIOD;
    SUB <= '1';
    wait for PERIOD;
    B <= "00000000000000000000000000000111";
    
    wait for PERIOD;
    wait for PERIOD;
  end process;
end stimulus;





