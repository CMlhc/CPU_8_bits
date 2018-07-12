library ieee;
use ieee.std_logic_1164.all;
entity acc is
port(clk1,rst,ena:in std_logic;
    data:in std_logic_vector(7 downto 0);
    accum:out std_logic_vector(7 downto 0));
end acc;
architecture art of acc is
begin
process(clk1, ena)
begin
if clk1'event and clk1='1'then
  if rst='1'then
   accum<="00000000";
  elsif ena='1'then
   accum<=data;
  end if;
end if;
end process;
end art;
