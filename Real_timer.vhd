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
			Update_CLK: IN std_logic;
	
			RST : IN STD_LOGIC;		
			SET_MODE : IN STD_LOGIC;
			inc_minutes : IN STD_LOGIC;
	      inc_hours : IN STD_LOGIC;

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

 --Temporary Digits for displaying
 signal r1 : std_logic_vector(3 downto 0):= "0000";
 SIGNAL r2 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL r3 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL r4 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 signal r5 : std_logic_vector(3 downto 0):= "0000";
 SIGNAL r6 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 
 --SIGNAL mode_select : integer := 0;
 SIGNAL mode : STD_LOGIC := '0';

begin
 
Calculate_time : PROCESS(CLK, Update_CLK, RST)
BEGIN
	IF RST = '1' THEN
		h1 <= "0000";
		h <= "0000";
		m1 <= "0000";
		m <= "0000";
		s1 <= "0000";
		s <= "0000";
	elsif (rising_edge(CLK)) then
		if (mode = '0') then 
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
			
		r1<=s;
		r2<=s1;
		r3<=m;
		r4<=m1;
		r5<=h;
		r6<=h1;
			
		elsif (mode = '1') then
			m <= r3 ;
			m1 <= r4 ;
			h <= r5 ;
			h1 <= r6 ;
		end if;
	end if;
	
	--Clock Mode
	--if (mode = '0') then
	--	r1<=s;
	--	r2<=s1;
	--	r3<=m;
	--	r4<=m1;
	--	r5<=h;
	--	r6<=h1;
	--end if;
	
	if (rising_edge(Update_CLK)) then
		if (SET_MODE = '1') then
			if (mode = '0') then
				mode <= '1';
			else
				mode <= '0';
			end if;
		end if;

		-- Set the Digit that will change in CLOCK SET Mode
		if (mode = '1') then
			if (inc_minutes = '1') then
			   r3 <= r3 + 1;
			   if r3 = 9 then
			      r3 <= "0000";
			      r4 <= r4 + 1 ;
			      if r4 = 5 then
                  r4 <= "0000";
			      end if;
			   end if;
			end if;
			if (inc_hours = '1') then
			   r5 <= r5 + 1 ;
			   if r5 = 9 OR (r6 = 2 and r5 = 3) then -- 24
			      r5 <= "0000";
					r6 <= r6 + 1 ;
					if r6 = 2 then
						r6 <= "0000";
					end if;
			   end if;
			end if;
	  end if;
	end if;
	
END Process;

	digit_one <= r1;
	digit_two <= r2;
	digit_three <= r3;
	digit_four <= r4;
	digit_five <= r5;
	digit_six <= r6;

end Behavioral;
 

