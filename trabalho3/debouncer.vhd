library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debouncer is
	port(
		in_switches : in std_logic_vector(5 downto 0);
		-- COP, CR, CS, C10, C50, C25
		clk, reset : in std_logic;
		out_switches : out std_logic_vector(5 downto 0)
		);
end debouncer;

architecture behav of debouncer is
signal delay1, delay2, delay3, delay_out, delayed_signal : std_logic_vector (5 downto 0);
begin


	three_stage_delay : process(clk,reset)
	begin
		if reset = '0' then
			delay1 <= "000000";
			delay2 <= "000000";
			delay3 <= "000000";
		elsif rising_edge(clk) then
			delay1 <= in_switches;
			delay2 <= delay1;
			delay3 <= delay2;
		end if;
	end process;

	delay_out <= delay1 and delay2 and delay3; -- stable signal

	delay_signal : process(clk, reset)
	begin
		if reset = '0' then
			delayed_signal <= "000000";
		elsif rising_edge(clk) then
			delayed_signal <= delay_out;
		end if;
	end process;

	out_switches <= delay_out and not delayed_signal; -- single pulse

end behav;
