----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:00:16 12/02/2019 
-- Design Name: 
-- Module Name:    Real_timer - Behavioral 
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

entity Real_timer is
	Port (CLK: IN std_logic;	
	
			digit_one : out std_logic_vector(3 downto 0) ;
			digit_two : out std_logic_vector(3 downto 0) ;
			digit_three : out std_logic_vector(3 downto 0);
			digit_four : out std_logic_vector(3 downto 0);
			digit_five: out std_logic_vector(3 downto 0);
			digit_six: out std_logic_vector(3 downto 0));
end Real_timer;
 
architecture Behavioral of Real_timer is

 --Clock Values
 signal s : std_logic_vector(3 downto 0) := "0000";
 signal s1 : std_logic_vector(3 downto 0) := "0101";
 signal m : std_logic_vector(3 downto 0) := "1001";
 signal m1 : std_logic_vector(3 downto 0) := "0101";
 signal h : std_logic_vector(3 downto 0) := "0011";
 signal h1 : std_logic_vector(3 downto 0) := "0010";

begin
 
Calculate_time : PROCESS(CLK)
BEGIN
	if(rising_edge(CLK))then
		s <= s + 1; -- s1 5 s 7
		if(s = "1001") then -- 9
			s<="0000"; 
			s1 <= s1 + 1;
			if(s1 = "0101") then -- 5
				m <= m + 1; -- 58: m1 5 m 8 -> 9
				s1 <= "0000";
				if(m = "1001") then -- 9
					m <= "0000";
					m1 <= m1 + 1;
					if(m1 =  "0101") then -- 5
						m1 <= "0000";
						h <= h + 1 ;
						if(h = "1001" ) then -- 9
							h <= "0000";
							h1 <= h1 + 1;
						elsif(h1 > "0001" and h > "0010" ) then -- 2 3
							h1 <= "0000";
							h <= "0000";										
						end if;
					end if;
				end if;
			end if;
		end if;
	end if;
END Process;

	digit_one <= s;
	digit_two <= s1;
	digit_three <= m;
	digit_four <= m1;
	digit_five <= h;
	digit_six <= h1;

end Behavioral;
 

