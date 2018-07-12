library ieee;
use ieee.std_logic_1164.all;
entity mach_ctr is
port(fetch,rst: in std_logic;
    ena: out std_logic);
end mach_ctr;
architecture behave of mach_ctr is
begin
process(fetch)
begin
  if fetch'event and fetch='1' then
    if rst='1'then
     ena<='0';
    else
     ena<='1';
    end if;
  end if;
end process;
end behave;
