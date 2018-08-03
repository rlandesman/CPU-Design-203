library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_MUX is
    Port(
        A       : in STD_LOGIC_VECTOR(7 downto 0);
        B       : in STD_LOGIC_VECTOR(7 downto 0);
        SEL     : in STD_LOGIC;
        MUX_OUT : out STD_LOGIC_VECTOR(7 downto 0));
end ALU_MUX;

architecture Behavioral of ALU_MUX is

    signal TEMP_OUT : std_logic_vector(7 downto 0);

begin

    process (A, B, SEL)
    begin
        case SEL is
            when '0' => TEMP_OUT <= A;
            when '1' => TEMP_OUT <= B;
            when others => TEMP_OUT <= "00000000";
        end case;
    end process;
    MUX_OUT <= TEMP_OUT;

end Behavioral;
