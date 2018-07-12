library ieee;
use ieee.std_logic_1164.all;
entity state_machine is
port(clk1, ena, zero: in std_logic;
    opcode: in std_logic_vector(2 downto 0);
    pc_clk, acc_ena, pc_ena, rd, wr, ir_ena, halt, datactl_ena: out std_logic);
end state_machine;
architecture behave of state_machine is
type state_type is (s0, s1,s2, s3, s4, s5, s6, s7);
signal state: state_type;
constant HLT: std_logic_vector(2 downto 0):="000";
constant SKZ: std_logic_vector(2 downto 0):="001";
constant ADD: std_logic_vector(2 downto 0):="010";
constant AN_D: std_logic_vector(2 downto 0):="011";
constant XO_R: std_logic_vector(2 downto 0):="100";
constant LDA: std_logic_vector(2 downto 0):="101";
constant STO: std_logic_vector(2 downto 0):="110";
constant JMP: std_logic_vector(2 downto 0):="111";
begin
process(clk1)
begin
  if clk1'event and clk1='1'then
      if ena='0' then
        state<=s0;
pc_clk<='0'; acc_ena<='0'; pc_ena<='0'; rd<='0'; wr<='0'; ir_ena<='0'; halt<='0'; datactl_ena<='0';
      elsif ena='1'then
        case state is
when s0=>pc_clk<='0'; acc_ena<='0'; pc_ena<='0'; rd<='1'; wr<='0'; ir_ena<='1'; datactl_ena<='0'; halt<='0';
     state<=s1;
when s1=>pc_clk<='1'; acc_ena<='0'; pc_ena<='0'; rd<='1'; wr<='0'; ir_ena<='1'; datactl_ena<='0'; halt<='0';
     state<=s2;
when s2=>pc_clk<='0'; acc_ena<='0'; pc_ena<='0'; rd<='0'; wr<='0'; ir_ena<='0'; datactl_ena<='0'; halt<='0';
     state<=s3;
when s3=>if (opcode=HLT) then
           pc_clk<='1'; acc_ena<='0'; pc_ena<='0'; rd<='0'; wr<='0'; ir_ena<='0'; datactl_ena<='0'; halt<='1';
           else pc_clk<='1'; acc_ena<='0'; pc_ena<='0'; rd<='0'; wr<='0'; ir_ena<='0'; datactl_ena<='0'; halt<='0';
         end if;
     state<=s4;
when s4=>if (opcode=JMP) then
             pc_clk<='1'; acc_ena<='0'; pc_ena<='1'; rd<='0'; wr<='0'; ir_ena<='0'; datactl_ena<='0'; halt<='0';
           elsif (opcode=ADD or opcode=AN_D or opcode=XO_R or opcode=LDA) then
             pc_clk<='0'; acc_ena<='0'; pc_ena<='0'; rd<='1'; wr<='0'; ir_ena<='0'; datactl_ena<='0'; halt<='0';
           elsif opcode=STO then
             pc_clk<='0'; acc_ena<='0'; pc_ena<='0'; rd<='0'; wr<='0'; ir_ena<='0'; datactl_ena<='1';halt<='0';
           else pc_clk<='0'; acc_ena<='0'; pc_ena<='0'; rd<='0'; wr<='0'; ir_ena<='0'; datactl_ena<='0'; halt<='0';
         end if;
     state<=s5;
when s5 =>if (opcode=ADD or opcode=AN_D or opcode=XO_R or opcode=LDA) then
              pc_clk<='0'; acc_ena<='1';pc_ena<='0'; rd<='1'; wr<='0'; ir_ena<='0'; datactl_ena<='0'; halt<='0';
            elsif(opcode=SKZ and zero='1') then
              pc_clk<='1'; acc_ena<='0'; pc_ena<='0'; rd<='0'; wr<='0'; ir_ena<='0'; datactl_ena<='0'; halt<='0';
            elsif opcode=JMP then
              pc_clk<='1'; acc_ena<='0'; pc_ena<='1';rd<='0'; wr<='0'; ir_ena<='0'; datactl_ena<='0'; halt<='0';
            elsif opcode=STO then
              pc_clk<='0'; acc_ena<='0'; pc_ena<='0'; rd<='0'; wr<='1';ir_ena<='0'; datactl_ena<='1'; halt<='0';
            else pc_clk<='0'; acc_ena<='0'; pc_ena<='0'; rd<='0'; wr<='0';ir_ena<='0'; datactl_ena<='0'; halt<='0';
            end if;
     state<=s6;
when s6=>pc_clk<='0'; acc_ena<='0'; pc_ena<='0'; rd<='0';
                wr<='0'; ir_ena<='0'; datactl_ena<='0'; halt<='0';
                    state<=s7;
when s7=>if (opcode=SKZ and zero='1') then
               pc_clk<='1';acc_ena<='0'; pc_ena<='0'; rd<='0'; wr<='0'; ir_ena<='0'; datactl_ena<='0'; halt<='0';
           else pc_clk<='0'; acc_ena<='0'; pc_ena<='0'; rd<='0'; wr<='0'; ir_ena<='0'; datactl_ena<='0'; halt<='0';
         end if;
     state<=s0;
        end case;
      end if;
    end if;
end process;
end behave;
