library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DDS is
    Port (
        clk      : in std_logic;
        rst      : in std_logic;
        rxd      : in std_logic;
		  txd		  : out std_logic;
        sel      : in std_logic_vector(2 downto 0);
        pwm_out  : out std_logic
    );
end DDS;

architecture fn of DDS is

    signal data_triangular : std_logic_vector(9 downto 0);
    signal data_senoidal : std_logic_vector(9 downto 0);
    signal data_diente : std_logic_vector(9 downto 0);
    signal fase_out : std_logic_vector(9 downto 0);
    signal mux_out : std_logic_vector(9 downto 0);
    signal fcw : std_logic_vector(9 downto 0);
    signal enable : std_logic;

    component UART is
        port (
            clk_clk       : in  std_logic;
            reset_reset_n : in  std_logic;
            uart_rxd      : in  std_logic;
				uart_txd		  : out std_logic;
            fcw_export    : out std_logic_vector(9 downto 0)
        );
    end component UART;

    component Acum_Fase
        Port (
            clk      : in std_logic;
            rst      : in std_logic;
            enable   : in std_logic;
				fcw      : in std_logic_vector (9 downto 0);
            fase_out : out std_logic_vector (9 downto 0)
        );
    end component;

    component DAC
        Port (
            clk     : in std_logic;
            rst     : in std_logic;
            duty    : in std_logic_vector(9 downto 0);
            pwm_out : out std_logic;
            enable  : out std_logic
        );
    end component;

    component Senoidal
        Port (
            address : in std_logic_vector(9 downto 0);
            clock   : in std_logic;
            q       : out std_logic_vector(9 downto 0)
        );
    end component;

    component Diente_de_Sierra
        Port (
            address : in std_logic_vector(9 downto 0);
            clock   : in std_logic;
            q       : out std_logic_vector(9 downto 0)
        );
    end component;

    component Triangular
        Port (
            address : in std_logic_vector(9 downto 0);
            clock   : in std_logic;
            q       : out std_logic_vector(9 downto 0)
        );
    end component;

    component MUX
        Port (
            sel     : in std_logic_vector(2 downto 0);
            data0   : in std_logic_vector(9 downto 0);
            data1   : in std_logic_vector(9 downto 0);
            data2   : in std_logic_vector(9 downto 0);
            mux_out : out std_logic_vector(9 downto 0)
        );
    end component;

begin

    U1: UART
        port map(
            clk_clk       => clk,
            reset_reset_n => rst,
            uart_rxd      => rxd,
				uart_txd		  => txd,
            fcw_export    => fcw
        );

    U2: Acum_Fase
        port map (
            clk      => clk,
            rst      => rst,
				fcw 		=> fcw,
            enable   => enable,
            fase_out => fase_out
        );

    U3: Senoidal
        port map (
            address => fase_out,
            clock   => clk,
            q       => data_senoidal
        );

    U4: Diente_de_Sierra
        port map (
            address => fase_out,
            clock   => clk,
            q       => data_diente
        );

    U5: Triangular
        port map (
            address => fase_out,
            clock   => clk,
            q       => data_triangular
        );

    U6: MUX
        port map (
            sel     => sel,
            data0   => data_senoidal,
            data1   => data_diente,
            data2   => data_triangular,
            mux_out => mux_out
        );

    U7: DAC
        port map (
            clk     => clk,
            rst     => rst,
            duty    => mux_out,
            pwm_out => pwm_out,
            enable  => enable
        );

end fn;