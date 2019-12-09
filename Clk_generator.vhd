----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:23:39 12/02/2019 
-- Design Name: 
-- Module Name:    Clk_generator - Behavioral 
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


USE IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Clk_generator is
    Port ( CLK : in  STD_LOGIC;
			  
			  CLK_time : out STD_LOGIC;
           CLK_display : out  STD_LOGIC;
			  CLK_reg : out std_logic);
			  
end Clk_generator;

architecture Behavioral of Clk_generator is
signal counter_display : integer := 0;
signal counter_time : integer := 0;
signal counter_reg : integer := 0;
signal CLK_display_tmp : std_logic := '0';
signal CLK_time_tmp: std_logic := '0';
signal CLK_reg_tmp: std_logic := '0';
begin

CLK_generation : process(CLK)

begin

-- clk generation. For 50 MHz clock this generates 1 Hz clock.
-- Spartan-6 FPGA AX309 provides with 50 MHz oscillator.
if rising_edge(CLK) then 
	counter_display <= counter_display + 1;
	if counter_display < 33461 then
		CLK_display_tmp <= '1';
	else 
		CLK_display_tmp <= '0';
		counter_display <= 0; 
	end if ;
end if;

if rising_edge(CLK) then
	counter_time <= counter_time + 1;
	if counter_time < 50000000 then
		CLK_time_tmp <= '1';
	else 
		CLK_time_tmp <= '0';
		counter_time <= 0; 
	end if; 
end if;

if rising_edge(CLK) then
	counter_reg <= counter_reg + 1;
	if counter_reg < 2437500 then -- 2.000.000 2.875.000
		CLK_reg_tmp <= '1';
	else 
		CLK_reg_tmp <= '0';
		counter_reg <= 0; 
	end if; 
end if;
	
end process;

CLK_display <= CLK_display_tmp;
CLK_time <= CLK_time_tmp;
CLK_reg <= CLK_reg_tmp;

end Behavioral;