----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:53:36 12/02/2019 
-- Design Name: 
-- Module Name:    Converter - Behavioral 
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

entity Converter is
    PORT ( value : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			  period_needed : in std_logic;
           cathode : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0));
END Converter;

ARCHITECTURE BEHAVIORAL OF Converter IS

signal period : std_logic;

BEGIN

period <= not period_needed;

WITH value SELECT cathode <=
	period & "1000000" when "0000", --0
	period & "1111001" when "0001", --1
	period & "0100100" when "0010", --2
	period & "0110000" when "0011", --3
	period & "0011001" when "0100", --4
	period & "0010010" when "0101", --5
	period & "0000010" when "0110", --6
	period & "1111000" when "0111", --7
	period & "0000000" when "1000", --8
	period & "0010000" when "1001", --9

	"11111111" WHEN OTHERS;
END BEHAVIORAL;
