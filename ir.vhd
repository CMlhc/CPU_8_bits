library ieee;
use ieee.std_logic_1164.all;
entity ir is
port(clk1, rst, ena: in std_logic;
    data: in std_logic_vector(7 downto 0);
    opcode: out std_logic_vector(2 downto 0);
    ir_addr: out std_logic_vector(12 downto 0));
end ir;
architecture behave of ir is
signal opc_iraddrs: std_logic_vector(15 downto 0);
begin
process(clk1)
variable state: std_logic:='0';
begin
  if(clk1'event and clk1='1')then
    if rst='1'then
      opc_iraddrs<=(others=>'0');
    elsif ena='1' then
      case state is
      when '0' =>opc_iraddrs(15 downto 8)<=data;
          state:='1';
      when '1'=>opc_iraddrs(7 downto 0)<=data;
          state:='0';
      when others=>null;
      end case;
  else
    state:='0';
  end if;
end if;
end process;
  opcode<=opc_iraddrs(15 downto 13);
  ir_addr<=opc_iraddrs(12 downto 0);
end behave;
