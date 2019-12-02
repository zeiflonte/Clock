----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:38:37 12/02/2019 
-- Design Name: 
-- Module Name:    Anode_display - Behavioral 
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

entity Anode_display is
    PORT ( hour1 : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
           hour : IN  STD_LOGIC_vector (3 DOWNTO 0);
			  minute1 : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
			  minute : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
			  second1 : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
			  second : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
           CLK : IN  STD_LOGIC;
			  selected_value : OUT  STD_LOGIC_VECTOR (3 DOWNTO 0);
           selected_anode : OUT  STD_LOGIC_VECTOR (5 DOWNTO 0);
			  period_needed : OUT  STD_LOGIC
			  );
END Anode_display;

ARCHITECTURE BEHAVIORAL OF Anode_display IS

SIGNAL COUNTER : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";

BEGIN

PROCESS_CLK : PROCESS(CLK)
BEGIN
	IF(CLK'EVENT AND CLK = '1') THEN -- 
			counter <= counter + 1;
			IF (counter = "101") THEN -- was 111
			 counter <= "000";
			END IF;
	END IF;
END PROCESS;

-- choose value to be displayed (among seconds, minutes, hours...)
WITH counter SELECT selected_value <=
	hour1 WHEN "000",
	hour WHEN "001",
	minute1 WHEN "010",
	minute WHEN "011",
	second1 WHEN "100",
	second WHEN "101",
	"1001" WHEN OTHERS; 

-- choose which anode to be displayed -> exit
WITH counter SELECT selected_anode <=
	"011111" WHEN "000", 
	"101111" WHEN "001", 
	"110111" WHEN "010", 
	"111011" WHEN "011", 
	"111101" WHEN "100", 
	"111110" WHEN "101",
	"000011" WHEN OTHERS;

WITH counter SELECT period_needed <=
	'0' WHEN "000", 
	'1' WHEN "001", 
	'0' WHEN "010", 
	'1' WHEN "011", 
	'0' WHEN "100", 
	'0' WHEN "101",
	'0' WHEN OTHERS;

END BEHAVIORAL;