library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX is
    Port (
        sel     : in std_logic_vector(2 downto 0);
        data0   : in std_logic_vector(9 downto 0);
        data1   : in std_logic_vector(9 downto 0);
        data2   : in std_logic_vector(9 downto 0);
        mux_out : out std_logic_vector(9 downto 0)
    );
end MUX;

architecture Behavioral of MUX is
begin
    process(sel, data0, data1, data2)
    begin
        case sel is
            when "011" =>
                mux_out <= data0;
            when "101" =>
                mux_out <= data1;
            when "110" =>
                mux_out <= data2;
            when others =>
                mux_out <= (others => '0');
        end case;
    end process;
end Behavioral;