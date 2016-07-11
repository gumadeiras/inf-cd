library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity fsm is
	port (
		in_switches : in  std_logic_vector(5 downto 0);
		-- (5)COP : cancel operation
		-- (4) CR : buy soda
		-- (3) CS : buy juice
		-- (2)C10 : $1 coin
		-- (1)C50 : $0,5 coin
		-- (0)C25 : $0,25 coin
		clk, reset : in  std_logic;
		   balance : out  std_logic_vector(13 downto 0)
		);
end fsm;

architecture behav of fsm is
	type type_state is (idle, coin, buy, release, cancel);
	signal state : type_state;
	signal auxbalance : integer;
	signal prev_switch: std_logic_vector(5 downto 0);
	-- all switches generate a single clock pulse. when a state changes based on input, the next state
	-- won't have information about which switch made it change. prev_switch has that information.
begin

state_register : process(clk, reset)
				begin
					if reset = '0' then
						auxbalance <= 0;
						state <= idle;
					elsif rising_edge(clk) then
						case state is
							when idle =>
								if (in_switches(0) or in_switches(1) or in_switches (2)) = '1' then
									prev_switch <= in_switches;
									state <= coin;
								elsif (in_switches(3) or in_switches(4)) = '1' then
									prev_switch <= in_switches;
									state <= buy;
								elsif in_switches(5) = '1' then
									prev_switch <= in_switches;
									state <= cancel;
								else
									state <= idle;
								end if;

							when coin =>
								if prev_switch(0) = '1' then
									auxbalance <= auxbalance + 25;
									prev_switch <= (others => '0');
								elsif prev_switch(1) = '1' then
									auxbalance <= auxbalance + 50;
									prev_switch <= (others => '0');
								elsif prev_switch(2) = '1' then
									auxbalance <= auxbalance + 100;
									prev_switch <= (others => '0');
								else
									auxbalance <= auxbalance; -- prevents quartus from generating latches
								end if;
								state <= idle;

							when buy =>
								if (prev_switch(3) = '1') and (auxbalance >= 75) then
									auxbalance <= auxbalance - 75;
									prev_switch <= (others => '0');
									state <= release;
								elsif (prev_switch(4) = '1') and (auxbalance >= 150) then
									auxbalance <= auxbalance - 150;
									prev_switch <= (others => '0');
									state <= release;
								else
									auxbalance <= auxbalance;
									state <= idle;
								end if;

							when release =>
								state <= idle;

							when cancel =>
								auxbalance <= 0;
								state <= idle;

							when others => state <= idle;

						end case;
					end if;
				end process;
balance <= conv_std_logic_vector(auxbalance, 14); -- converts integer to std_logic
end behav;