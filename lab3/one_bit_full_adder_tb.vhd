library ieee;              		-- Load the ieee 1164 library
use ieee.std_logic_1164.all;  	-- Make the package 'visible'


-- The top level entity of the test bench has no ports...
entity one_bit_full_adder_tb is
end one_bit_full_adder_tb;

architecture stimulus of one_bit_full_adder_tb is
  -- First, declare the lower-level entity...
  component one_bit_full_adder
    port  (A, B, Cin : in STD_LOGIC;
           R, Cout : out STD_LOGIC);
  end component;
  
  -- Next, declare some local signals to assign values to and observe...
  signal A_test, B_test, Cin_test : STD_LOGIC;
  signal R_test, Cout_test : STD_LOGIC;
  
begin
  -- Create an instance of the component under test
  one_bit_full_adder_instance: one_bit_full_adder port map( 
	A => A_test, 
	B => B_test, 
	Cin => Cin_test, 
	R => R_test, 
	Cout => Cout_test);
  
  -- Now define a process to apply some stimulus over time...
  process
    constant PERIOD: time := 40 ns;
  begin
    -- Write test

    -- put breakpoint to line below
    wait for PERIOD;    
  end process;  
end stimulus;





