library ieee;
use ieee.std_logic_1164.all;
entity datactrl is
port(data_ena: in std_logic;
    alu_out: in std_logic_vector(7 downto 0);
    data: out std_logic_vector(7 downto 0));
end datactrl;
architecture behave of datactrl is
begin
    data<=alu_out when data_ena='1' else "ZZZZZZZZ";
end behave;
