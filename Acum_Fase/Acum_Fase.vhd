library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Acum_Fase is
    Port (
        clk      : in std_logic;
        rst      : in std_logic;
        enable   : in std_logic;
		  fcw		  : in std_logic_vector (9 downto 0);
        fase_out : out std_logic_vector (9 downto 0)
    );
end Acum_Fase;

architecture fn of Acum_Fase is
    signal r_reg : unsigned (9 downto 0) := (others => '0');
    signal r_next : unsigned (9 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '0' then
            r_reg <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                r_reg <= r_next;
            end if;
        end if;
    end process;

    r_next <= r_reg + unsigned(fcw);
    fase_out <= std_logic_vector(r_reg);
end fn;