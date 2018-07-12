library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity pc is
port(clk, rst, ena: in std_logic;
    ir_addr: in std_logic_vector(12 downto 0);
    pc_addr: out std_logic_vector(12 downto 0));
end pc;
architecture behave of pc is
signal pc_addr_latch: std_logic_vector(12 downto 0);
begin
process(clk)
begin
    if clk'event and clk='1'then
      if rst='1'then
        pc_addr_latch<=(others=>'0');
      elsif ena='1' then
        pc_addr_latch<=ir_addr;
      elsif ena='0' then
        pc_addr_latch<=pc_addr_latch+1;
      end if;
    end if;
end process;
   pc_addr<=pc_addr_latch;
end behave;
