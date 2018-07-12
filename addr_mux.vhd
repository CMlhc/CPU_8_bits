library ieee;
use ieee.std_logic_1164.all;
entity addr_mux is
port(fetch:in std_logic;
    pc_addr, ir_addr: in std_logic_vector(12 downto 0);
    addr: out std_logic_vector(12 downto 0));
end addr_mux;
architecture behave of addr_mux is
begin
  addr<=pc_addr when fetch='1' else
        ir_addr;
end behave;
