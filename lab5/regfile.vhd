library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Regfile is
   port(
      clk: IN std_logic;
      reset: IN std_logic;
      A_data: OUT std_logic_vector(31 downto 0);
      B_data: OUT std_logic_vector(31 downto 0);
      A_addr: IN std_logic_vector(4 downto 0);
      B_addr: IN std_logic_vector(4 downto 0);
      W_data: IN std_logic_vector(31 downto 0);
      W_addr: IN std_logic_vector(4 downto 0);
      W_ena: IN std_logic);
end Regfile;

architecture behav of Regfile is
type registerfile_type is array(31 downto 0) of std_logic_vector(31 downto 0);
signal Myregisterfile:registerfile_type;
begin
       
   -- Register file
   -- Write into a register at rising clock edge and when enable (W_en) is high.
    process(clk,reset)
        begin
            if reset = '1' then
                Myregisterfile <= (others => (others => '0'));
            elsif clk'event and clk='1' then
            if W_ena='1' then
                Myregisterfile(conv_integer(W_addr))<=W_Data;
            end if;
        end if;
    end process;
   
	--Read any time two registers
    A_data<=Myregisterfile(conv_integer(A_addr));
    B_data<=Myregisterfile(conv_integer(B_addr)); 

end behav;

