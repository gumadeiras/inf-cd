library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
  port(
    A, B, Cin : in std_logic;
      S, Cout : out std_logic
  );
end full_adder;

architecture behav of full_adder is

signal sum1, carry1, carry2, BX : std_logic;

begin
  HA1 : entity work.half_adder port map(A, B, sum1, carry1);
  HA2 : entity work.half_adder port map(sum1, Cin, S, carry2);
  Cout <= carry1 or carry2;
end behav;