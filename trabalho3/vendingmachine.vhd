library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vendingmachine is
	port(
		in_switches : in  std_logic_vector(5 downto 0);
    	-- (5)COP : cancel operation
    	-- (4)CR : buy soda
    	-- (3)CS : buy juice
    	-- (2)C10 : $1 coin
    	-- (1)C50 : $0,5 coin
		-- (0)C25 : $0,25 coin
		clk, reset : in  std_logic;
		digit0, digit1, digit2, digit3 : out std_logic_vector(6 downto 0); -- display digits
		saldo : out std_logic_vector(13 downto 0);
		chaves : out std_logic_vector(5 downto 0);
		dp : out std_logic_vector(3 downto 0) -- decimal point
		);
end vendingmachine;

architecture behav of vendingmachine is

signal switches : std_logic_vector(5 downto 0);
signal auxbalance : std_logic_vector(13 downto 0);
signal d0, d1, d2, d3 : std_logic_vector(3 downto 0);

begin
Debouncer: entity work.debouncer port map(in_switches, clk, reset, switches);
chaves <= switches;
FSM: entity work.fsm port map(switches, clk, reset, auxbalance);
saldo <= auxbalance;
BinToBCD: entity work.bcdconverter port map(auxbalance, d0, d1, d2, d3);
Display0: entity work.segdisplay port map(reset, d0, digit0);
Display1: entity work.segdisplay port map(reset, d1, digit1);
Display2: entity work.segdisplay port map(reset, d2, digit2);
Display3: entity work.segdisplay port map(reset, d3, digit3);
dp <= "1011";
end behav;