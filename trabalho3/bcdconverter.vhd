library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bcdconverter is
   port (
      balance   : in  std_logic_vector (13 downto 0);
      ones, tens, hundreds, thousands: out std_logic_vector (3 downto 0) -- digits output in BCD
   );
end bcdconverter;

architecture behav of bcdconverter is

begin

   bin_to_bcd : process (balance)
      variable auxbalance : unsigned(29 downto 0); -- aux variable
      alias num is auxbalance(13 downto 0);  -- internal balance variable
      alias one is auxbalance(17 downto 14);
      alias ten is auxbalance(21 downto 18);
      alias hun is auxbalance(25 downto 22);
      alias thou is auxbalance(29 downto 26);
   begin
      num := unsigned(balance); -- copy balance and clear others
		one := X"0";
      ten := X"0";
      hun := X"0";
      thou := X"0";

      -- bcd conversion logic
      -- if X"block" >= 5 then +3
      -- shift left once
      -- repeat

      for i in 0 to 13 loop
         if one >= 5 then
            one := one + 3;
         end if;

         if ten >= 5 then
            ten := ten + 3;
         end if;

         if hun >= 5 then
            hun := hun + 3;
         end if;

         if thou >= 5 then
            thou := thou + 3;
         end if;

         auxbalance := shift_left(auxbalance, 1);
      end loop;

      thousands <= std_logic_vector(thou); -- BCD digits for output
      hundreds <= std_logic_vector(hun);
      tens     <= std_logic_vector(ten);
      ones     <= std_logic_vector(one);
   end process;

end behav;