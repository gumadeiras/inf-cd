library ieee;
use ieee.std_logic_1164.all;

entity ffd is
  port(
    D, clk, rst : in  std_logic;
              Q : out std_logic
  );
end entity;

architecture behav of ffd is
begin
    process (clk, rst) begin
        if (rst = '0') then
            Q <= '0';
        elsif (rising_edge(clk)) then
            Q <= D;
        end if;
    end process;
end behav;