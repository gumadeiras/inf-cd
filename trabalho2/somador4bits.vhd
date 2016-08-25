library ieee;
use ieee.std_logic_1164.all;

entity somador4bits is
  port(
    clock, reset, Cin : in std_logic;
                 A, B : in std_logic_vector(3 downto 0);
                    F : out std_logic_vector(3 downto 0);
             Overflow : out std_logic
  );
end somador4bits;

architecture behav of somador4bits is

  signal QA, QB, QS : std_logic_vector(3 downto 0);
  signal Carry : std_logic_vector(4 downto 0);
  signal Overaux : std_logic;

begin

  Carry(0) <= Cin;

  gen_ffd : for I in 0 to 3 generate -- instancia 4x cada componente
     DFA : entity work.ffd port map(A(I), clock, reset, QA(I)); -- bits A de entrada
     DFB : entity work.ffd port map(B(I), clock, reset, QB(I)); -- bits B de entrada
     DFS : entity work.ffd port map(QS(I), clock, reset, F(I)); -- bits de saida
     FA0 : entity work.full_adder port map(QA(I), QB(I), Carry(I), QS(I), Carry(I+1)); -- full adders
  end generate gen_ffd;

   Overaux <= Carry(4) xor Carry(3);
   DFO: entity work.ffd port map(Overaux, clock, reset, Overflow);
end behav;