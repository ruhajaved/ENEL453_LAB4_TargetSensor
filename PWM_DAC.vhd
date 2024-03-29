library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity PWM_DAC is
   Generic ( width : integer := 9);
   Port    ( reset_n    : in  STD_LOGIC;
             clk        : in  STD_LOGIC;
             duty_cycle : in  STD_LOGIC_VECTOR (width-1 downto 0);
             pwm_out    : out STD_LOGIC
           );
end PWM_DAC;

architecture Behavioral of PWM_DAC is
   signal counter : unsigned (width-1 downto 0);
       
begin
   count : process(clk,reset_n)
   begin
       if( reset_n = '0') then
           counter <= (others => '0');
       elsif (rising_edge(clk)) then 
			if (counter = 4094) then
				counter <= (others => '0');
           else
				counter <= counter + 1;
			end if;
       end if;
   end process;
 
   compare : process(counter, duty_cycle)
   begin    
       if (counter <= unsigned(duty_cycle)) then
           pwm_out <= '0'; 
       else 
           pwm_out <= '1';
       end if;
   end process;
  
end Behavioral;

