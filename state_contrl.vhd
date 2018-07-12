library ieee;
use ieee.std_logic_1164.all;
package mypack1 is
  component mach_ctr 
  port(fetch,rst: in std_logic;
      ena: out std_logic);
  end component;
  component state_machine 
  port(clk1, ena, zero: in std_logic;
    opcode: in std_logic_vector(2 downto 0);
    pc_clk,acc_ena,pc_ena,rd,wr,ir_ena,halt,datactl_ena:out std_logic);
  end component;
end mypack1;
library ieee;
use ieee.std_logic_1164.all;
use work.mypack1.all;
entity state_contrl is
port(clk1,zero,fetch,rst: in std_logic;
    opcode: in std_logic_vector(2 downto 0);
    pc_clk,acc_ena,pc_ena,rd,wr,ir_ena,halt,datactl_ena:out std_logic);
end state_contrl;
architecture rt1 of state_contrl is
signal ena_b: std_logic;
begin
Ul:mach_ctr port map(fetch,rst,ena_b);
U2:state_machine port map (clk1,ena_b, zero, opcode, pc_clk, acc_ena,
pc_ena, rd, wr, ir_ena, halt, datactl_ena);
end rt1;
