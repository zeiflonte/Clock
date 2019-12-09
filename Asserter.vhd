----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:04:15 12/09/2019 
-- Design Name: 
-- Module Name:    Asserter - Behavioral 
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

entity Asserter is
	Port ( minutes_reg : in std_logic_vector(4 downto 0);
			 result : out std_logic);
end Asserter;

architecture Behavioral of Asserter is
	signal res : std_logic;
	
begin
	CLK_generation : process(minutes_reg)
	begin
		if (minutes_reg = "00000") then
			res <= '0';
		else
			res <= '1';
		end if;
		--WITH minutes_reg SELECT res <=
		--	'0' WHEN "00000000000000000000", 
		--	'1' WHEN OTHERS;
	end process;
	
	result <= res;

end Behavioral;

