library ieee;
use ieee.std_logic_1164.all;
entity clkgen is
port(clk: in std_logic;
      clk1: buffer std_logic;
      fetch: buffer std_logic:='0';
      alu_clk: out std_logic);
end clkgen;
architecture behave of clkgen is
signal clk2: std_logic:='0';
signal clk4: std_logic:='1';
begin
  alu_clk<=clk2 and clk4 and (not fetch);
process(clk1)
begin
clk1<=not clk;
  if clk1'event and clk1='1'then
    clk2<=not clk2;
  end if;
end process;
process(clk2)
begin
  if clk2'event and clk2='0' then
    clk4<=not clk4;
  end if;
end process;
process(clk4)
begin
  if clk4'event and clk4='1' then
    fetch<=not fetch;
  end if;
end process;
end behave;
