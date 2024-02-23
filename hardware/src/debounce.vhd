library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce is
  Generic( 
    counter_size : integer := 21
  );
  Port (  
    clk : in std_logic;
    rst : in std_logic;
    sig_in : in std_logic;
    sig_out: out std_logic
  );
end debounce;

architecture Behavioral of debounce is

signal flipflop : std_logic_vector(1 downto 0);

signal counter_sclr: std_logic;
signal counter_out : unsigned(counter_size - 1 downto 0);
signal result_reg : std_logic;

begin

counter_sclr <= flipflop(1) xor flipflop(0);

process(clk, rst)
begin
    if (rst = '1') then
        result_reg <= '0';
    elsif rising_edge(clk) then
        flipflop(0) <= sig_in;
        flipflop(1) <= flipflop(0);
        
        if (counter_sclr = '1') then
            counter_out <= (others => '0');
        elsif (counter_out(counter_size - 1) = '0') then
            counter_out <= counter_out + 1;
        else
            result_reg <= flipflop(1);
        end if;
    end if;
end process;

sig_out <= result_reg;
end Behavioral;
