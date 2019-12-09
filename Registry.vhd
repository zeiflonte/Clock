----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:36:16 12/09/2019 
-- Design Name: 
-- Module Name:    Registry - Behavioral 
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

entity Registry is
	generic (N: integer:= 5);
   Port (  Din : in  STD_LOGIC;
           SE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR(N-1 downto 0));
end Registry;

architecture Behavioral of Registry is
	signal sdat: STD_LOGIC_VECTOR(N-1 downto 0);
	signal sreg: STD_LOGIC_VECTOR(N-1 downto 0);
begin
	Main: process(CLK, RST, sdat)
	begin
		if RST = '1' then 
			sreg <= (others => '1');
		elsif rising_edge(CLK) then
			sreg <= sdat;
		end if;
	end process;
	
	Data: process (sreg, SE)
	begin
		if (SE = '1') then
			sdat <= Din & sreg(N-1 downto 1);
		end if;
	end process;
	
	Dout <= sreg;

end Behavioral;

