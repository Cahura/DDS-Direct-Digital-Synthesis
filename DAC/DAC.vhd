library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DAC is
    Port (
        clk     : in std_logic;
        rst     : in std_logic;
        duty    : in std_logic_vector(9 downto 0);
        pwm_out : out std_logic;
        enable  : out std_logic
    );
end DAC;

architecture fn of DAC is
    signal r_reg : unsigned(9 downto 0);
    signal r_next : unsigned(9 downto 0);
    signal buf_reg : std_logic;
    signal buf_next : std_logic;
	 
begin
    process(clk, rst)
    begin
        if rst = '0' then
            r_reg <= (others => '0');
            buf_reg <= '0';
        elsif rising_edge(clk) then
            r_reg <= r_next;
            buf_reg <= buf_next;
        end if;
    end process;

    r_next <= r_reg + 1;

    buf_next <= '1' when (r_reg < unsigned(duty)) else '0';
    pwm_out <= buf_reg;
	 
    enable <= '1' when r_reg = "1111111111" else '0';

end fn;