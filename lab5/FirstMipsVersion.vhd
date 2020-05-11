library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FirstMipsVersion is
    Port(Clk   : in STD_LOGIC;
         Reset : in STD_LOGIC);
end FirstMipsVersion;

architecture Behavioral of FirstMipsVersion is
component Regfile is
  port(clk    : in std_logic;
       reset  : in std_logic;
       A_data : out std_logic_vector(31 downto 0);
       B_data : out std_logic_vector(31 downto 0);
       A_addr : in std_logic_vector(4 downto 0);
       B_addr : in std_logic_vector(4 downto 0);
       W_data : in std_logic_vector(31 downto 0);
       W_addr : in std_logic_vector(4 downto 0);
       W_ena  : in std_logic);
end component;

component THIRTYTWO_BIT_ALU is
    port(A, B : in std_logic_vector(31 downto 0);
         ALUC : in std_logic_vector(1 downto 0);
         SUB  : in std_logic;
         R    : out std_logic_vector(31 downto 0);
         Z    : out std_logic);
end component;

component programmemory is
    port(address     : in std_logic_vector(31 downto 0);
         instruction : out std_logic_vector(31 downto 0));
end component;

component PCPlus4 is
    Port ( Clk : in STD_LOGIC;
       Reset : in STD_LOGIC;
       Q : out STD_LOGIC_VECTOR (31 downto 0);
       beq_offset : in std_logic_vector(31 downto 0);
       j_addr : in std_logic_vector(25 downto 0);
       ZeroFlag, Branch, Jump : in std_logic);
end component;

component ControlUnit is
    Port(op             : in STD_LOGIC_VECTOR (5 downto 0);
     funct          : in STD_LOGIC_VECTOR (5 downto 0);
     ALUControl     : out STD_LOGIC_VECTOR (2 downto 0);
     RegDestination : out STD_LOGIC;
     ALUSource      : out STD_LOGIC;
     WriteEnable    : out STD_LOGIC;
     MemWE          : out STD_LOGIC;
     MemtoReg       : out STD_LOGIC;
     Branch         : out STD_LOGIC;
     Jump           : out STD_LOGIC);
end component;

component SignExtend is
    Port(Input : in STD_LOGIC_VECTOR (15 downto 0);
         Output : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component DataMemory is
    port(
      Clk : IN std_logic;
      Reset : IN std_logic;
      MemWE : in std_logic;
      Address : in std_logic_vector(31 downto 0);
      DataIn : in std_logic_vector(31 downto 0);
      DataOut : out std_logic_vector(31 downto 0));
end component;

signal instruction_address, instruction, sign_extend_output, RD1, RD2, ALU_B, WD, ALU_R, Data_Out : std_logic_vector(31 downto 0);
signal A1, A2, A3 : std_logic_vector(4 downto 0);
signal alu_control : std_logic_vector(2 downto 0);
signal reg_destination, alu_source, MemtoReg, MemWE, ZeroFlag, Jump, Branch, WriteEnable : std_logic;

begin
    program_counter : PCPlus4 port map(Clk => Clk,
                                       Reset => Reset,
                                       Q => instruction_address,
                                       beq_offset => sign_extend_output,
                                       j_addr => instruction(25 downto 0),
                                       ZeroFlag => ZeroFlag,
                                       Branch => Branch,
                                       Jump => Jump);    
    program_memory : programmemory port map(address => instruction_address,
                                            instruction => instruction);
    A1 <= instruction(25 downto 21);
    A2 <= instruction(20 downto 16);
    control_unit : ControlUnit port map(op => instruction(31 downto 26),
                                        funct => instruction(5 downto 0),
                                        ALUControl => alu_control,
                                        RegDestination => reg_destination,
                                        ALUSource => alu_source,
                                        WriteEnable => WriteEnable,
                                        MemWE => MemWE,
                                        MemtoReg => MemtoReg,
                                        Branch => Branch,
                                        Jump => Jump);
    A3 <= instruction(15 downto 11) when reg_destination = '1' else A2;
    sign_extend : SignExtend port map(Input => instruction(15 downto 0), Output => sign_extend_output);
    register_file : Regfile port map(clk => Clk,
                                     reset => Reset,
                                     A_data => RD1,
                                     B_data => RD2,
                                     A_addr => A1,
                                     B_addr => A2,
                                     W_data => WD,
                                     W_addr => A3,
                                     W_ena => WriteEnable);
    ALU_B <= RD2 when alu_source = '0' else sign_extend_output;
    alu : THIRTYTWO_BIT_ALU port map(A => RD1,
                                     B => ALU_B,
                                     ALUC => alu_control(1 downto 0),
                                     SUB => alu_control(2),
                                     R => ALU_R,
                                     Z => ZeroFlag);
    memory : DataMemory port map(Clk => Clk,
                                 Reset => Reset,
                                 MemWE => MemWE,
                                 Address => ALU_R,
                                 DataIn => RD2,
                                 DataOut => Data_Out);
    WD <= Data_Out when MemtoReg = '1' else ALU_R;
end Behavioral;
