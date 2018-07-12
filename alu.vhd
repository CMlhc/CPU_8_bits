library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity alu is
port(alu_clk: in std_logic;
    opcode: in std_logic_vector(2 downto 0);
    data,accum: in std_logic_vector(7 downto 0);
    zero: out std_logic;
    alu_out: out std_logic_vector(7 downto 0));
end alu;
architecture behave of alu is
signal alu_out_latch: std_logic_vector(7 downto 0);
constant HLT: std_logic_vector(2 downto 0):="000";
constant SKZ: std_logic_vector(2 downto 0):="001";
constant ADD: std_logic_vector(2 downto 0):="010";
constant AN_D: std_logic_vector(2 downto 0):="011";
constant XO_R: std_logic_vector(2 downto 0):="100";
constant LDA: std_logic_vector(2 downto 0):="101";
constant STO: std_logic_vector(2 downto 0):="110";
constant JMP: std_logic_vector(2 downto 0):="111";
begin
    zero<='1'when accum="00000000" else '0';
process(alu_clk)
variable temp:std_logic_vector(2 downto 0);
begin
      temp:=opcode;
  if alu_clk'event and alu_clk='1'then
    case temp is
    when HLT=>alu_out_latch<=accum;
    when SKZ=>alu_out_latch<=accum;
    when ADD=>alu_out_latch<=data+accum;
    when AN_D=>alu_out_latch<=data and accum;
    when XO_R=>alu_out_latch<=data xor accum;
    when LDA=>alu_out_latch<=data;
    when STO=>alu_out_latch<=accum;
    when JMP=>alu_out_latch<=accum;
    when others=>alu_out_latch<="XXXXXXXX";
  end case;
end if;
end process;
    alu_out<=alu_out_latch;
end behave;
