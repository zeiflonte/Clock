----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:11:06 12/02/2019 
-- Design Name: 
-- Module Name:    Clock - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Clock is
	PORT (  CLK : IN std_logic;	  

			  RST : IN STD_LOGIC;
			  SET_MODE : IN STD_LOGIC;
			  inc_minutes : IN std_logic;
			  inc_hours : IN std_logic;

           seven_segment_cathode : OUT  std_logic_vector (7 downto 0);
           seven_segment_anode : OUT  std_logic_vector (5 downto 0));
end Clock;

architecture Struct of Clock is

-- connecting wires
signal wire_display_clock : std_logic;
signal wire_time_clock : std_logic;
signal wire_reg_clock : std_logic;
signal wire_segment_value : std_logic_vector( 3 downto 0);

signal wire_SET_MODE_balanced : std_logic;
signal wire_inc_minutes : std_logic;
signal inc_minutes_asserted : std_logic;

signal wire_inc_hours : std_logic;
signal wire_RST : std_logic;

signal wire_minutes_reg : std_logic_vector(4 downto 0);


signal period_needed : std_logic;

-- data
signal hour1 : std_logic_vector( 3 downto 0);
signal hour : std_logic_vector( 3 downto 0);
signal minute : std_logic_vector( 3 downto 0);
signal minute1 : std_logic_vector( 3 downto 0);
signal second : std_logic_vector( 3 downto 0);
signal second1 : std_logic_vector( 3 downto 0);

begin

DebounceU1 : entity work.Debounce PORT MAP(
	clk => CLK,
	
	button => SET_MODE,
	result => wire_SET_MODE_balanced
);
--DebounceU2 : entity work.Debounce PORT MAP(
--	clk => CLK,
	
--	button => inc_minutes,
--	result => wire_inc_minutes
--);
DebounceU3 : entity work.Debounce PORT MAP(
	clk => CLK,
	
	button => inc_hours,
	result => wire_inc_hours
);
DebounceU4 : entity work.Debounce PORT MAP(
	clk => CLK,
	
	button => RST,
	result => wire_RST
);

-- generates CLK for time values updating
-- and seven segment display updating
Clk_generator : entity work.Clk_generator PORT MAP(
	CLK => CLK,
	
	CLK_display => wire_display_clock,
	CLK_time => wire_time_clock,
	CLK_reg => wire_reg_clock
);


ShiftRegistryMinutes : entity work.Registry PORT MAP(
	CLK => wire_reg_clock,
	Din => inc_minutes,
	SE => '1',
	Dout => wire_minutes_reg,
	RST => '0'
);
AsserterMinutes : entity work.Asserter PORT MAP(
	minutes_reg => wire_minutes_reg,
	result => inc_minutes_asserted
);


-- selects anode and value to display
-- for each CLK_display rising edge
Anode_display : entity work.Anode_display PORT MAP(
	hour1 => hour1,
	hour => hour, 
	minute1 => minute1,
	minute => minute,
	second1 => second1,
	second => second,
	CLK => wire_display_clock,
	 
	-- choose value to be displayed (among seconds, minutes, hours...)
	selected_value => wire_segment_value,
	-- which anode to be displayed -> exit
	selected_anode => seven_segment_anode,
	period_needed => period_needed
);

-- select cathode for specific value to display
Converter : entity work.Converter PORT MAP(
   -- value to be displayed
	value => wire_segment_value,
	period_needed => period_needed,
	-- cathodes (from value) -> exit
	cathode => seven_segment_cathode
);

-- responsible for real time values updating
Real_timer : entity work.Real_timer PORT MAP(
	CLK => wire_time_clock,
	Update_CLK => wire_display_clock,

	RST => wire_RST,
	
	SET_MODE => wire_SET_MODE_balanced,
	inc_minutes => inc_minutes_asserted,
	inc_hours => wire_inc_hours,

	digit_one => second,
	digit_two => second1,
	digit_three => minute,
	digit_four => minute1,
	digit_five => hour,
	digit_six => hour1
);

end Struct;

