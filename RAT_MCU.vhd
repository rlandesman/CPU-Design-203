----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/16/2018 02:11:10 PM
-- Design Name: 
-- Module Name: RAT_MCU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAT_MCU is
    Port(
        IN_PORT         : in STD_LOGIC_VECTOR(7 downto 0);
        RESET           : in STD_LOGIC;
        INT             : in STD_LOGIC;
        CLK             : in STD_LOGIC;
        OUT_PORT        : out STD_LOGIC_VECTOR(7 downto 0);
        PORT_ID         : out STD_LOGIC_VECTOR(7 downto 0);
        IO_STRB         : out STD_LOGIC);
end RAT_MCU;

architecture Behavioral of RAT_MCU is

    component CONTROL_UNIT
        port(
            CLK         : in std_logic;
            C           : in std_logic;
            Z           : in std_logic;
            INT         : in std_logic;
            RESET       : in std_logic;
            OPCODE_HI_5 : in std_logic_vector(4 downto 0);
            OPCODE_LO_2 : in std_logic_vector(1 downto 0);
            RST         : out std_logic;
            PC_LD       : out std_logic;
            PC_INC      : out std_logic;
            PC_MUX_SEL  : out std_logic_vector(1 downto 0);
            SP_LD       : out std_logic;
            SP_INCR     : out std_logic;
            SP_DECR     : out std_logic;
            SCR_DATA_SEL: out std_logic;
            SCR_WE      : out std_logic;
            SCR_ADDR_SEL: out std_logic_vector(1 downto 0);
            RF_WR       : out std_logic;
            RF_WR_SEL   : out std_logic_vector(1 downto 0);
            ALU_SEL     : out std_logic_vector(3 downto 0);
            ALU_OPY_SEL : out std_logic;
            FLG_C_LD    : out std_logic;
            FLG_C_SET   : out std_logic;
            FLG_C_CLR   : out std_logic;
            FLG_Z_LD    : out std_logic;
            FLG_SHAD_LD : out std_logic;
            FLG_LD_SEL  : out std_logic;
            I_SET       : out std_logic;
            I_CLR       : out std_logic;         
            IO_STRB     : out std_logic);
    end component;

    signal RST          : std_logic := '0';
    signal PC_LD        : std_logic := '0';
    signal PC_INC       : std_logic := '0';
    signal PC_MUX_SEL   : std_logic_vector(1 downto 0) := "00";
    signal SP_LD        : std_logic := '0';
    signal SP_INCR      : std_logic := '0';
    signal SP_DECR      : std_logic := '0';
    signal SCR_DATA_SEL : std_logic := '0';
    signal SCR_WE       : std_logic := '0';
    signal SCR_ADDR_SEL : std_logic_vector(1 downto 0) := "00";
    signal RF_WR        : std_logic := '0';
    signal RF_WR_SEL    : std_logic_vector(1 downto 0) := "00";
    signal ALU_SEL      : std_logic_vector(3 downto 0) := "0000";
    signal ALU_OPY_SEL  : std_logic := '0';
    signal FLG_C_LD     : std_logic := '0';
    signal FLG_C_SET    : std_logic := '0';
    signal FLG_C_CLR    : std_logic := '0';
    signal FLG_Z_LD     : std_logic := '0';
    signal FLG_SHAD_LD  : std_logic := '0';
    signal FLG_LD_SEL   : std_logic := '0';
    signal I_SET        : std_logic := '0';
    signal I_CLR        : std_logic := '0';
    
    component PC
        port(
            DIN         : in std_logic_vector(9 downto 0);
            LD          : in std_logic;
            INC         : in std_logic;
            RST         : in std_logic;
            CLK         : in std_logic;
            PC_COUNT    : out std_logic_vector(9 downto 0));
    end component;
    
    --PC signals
    signal PC_COUNT     : std_logic_vector(9 downto 0) := "0000000000";

    component PC_MUX
        port(
            IMMED       : in std_logic_vector(9 downto 0);
            STACK       : in std_logic_vector(9 downto 0);
            INTERUPT    : in std_logic_vector(9 downto 0) := "1111111111";
            MUX_SEL     : in std_logic_vector(1 downto 0);
            MUX_OUT     : out std_logic_vector(9 downto 0));
    end component;
    
    --PC MUX signals  
    signal PC_MUX_OUT   : std_logic_vector(9 downto 0);
    
    component prog_rom
        port(
            ADDRESS     : in std_logic_vector(9 downto 0);
            INSTRUCTION : out std_logic_vector(17 downto 0);
            CLK         : in std_logic);
    end component;
    
    signal IR           : std_logic_vector(17 downto 0) := "000000000000000000";
    
    component REG_FILE
        port(
            DIN         : in std_logic_vector(7 downto 0);
            ADRX        : in std_logic_vector(4 downto 0);
            ADRY        : in std_logic_vector(4 downto 0);
            WR          : in std_logic;
            CLK         : in std_logic;
            DX_OUT      : out std_logic_vector(7 downto 0);
            DY_OUT      : out std_logic_vector(7 downto 0));
    end component;
    
    --REG_FILE signals
    signal DX_OUT       : std_logic_vector(7 downto 0) := "00000000";
    signal DY_OUT       : std_logic_vector(7 downto 0) := "00000000";
    
    component REG_FILE_MUX
        port(
            IN_PORT     : in std_logic_vector(7 downto 0);
            B           : in std_logic_vector(7 downto 0);
            STACK       : in std_logic_vector(7 downto 0);
            ALU_RESULT  : in std_logic_vector(7 downto 0);
            MUX_SEL     : in std_logic_vector(1 downto 0);
            MUX_OUT     : out std_logic_vector(7 downto 0));
    end component;
    
    signal REG_MUX_OUT  : std_logic_vector(7 downto 0) := "00000000";
    
    component ALU 
        port(
            CIN         : in std_logic;
            SEL         : in std_logic_vector(3 downto 0);
            A           : in std_logic_vector(7 downto 0);
            B           : in std_logic_vector(7 downto 0);
            RESULT      : out std_logic_vector(7 downto 0);
            C           : out std_logic;
            Z           : out std_logic);
    end component;
    
    signal RESULT       : std_logic_vector(7 downto 0) := "00000000";
    signal C            : std_logic := '0';
    signal Z            : std_logic := '0';
    
    component ALU_MUX
        port(
            A           : in std_logic_vector(7 downto 0);
            B           : in std_logic_vector(7 downto 0);
            SEL         : in std_logic;
            MUX_OUT     : out std_logic_vector(7 downto 0));
    end component;
    
    signal ALU_MUX_OUT  : std_logic_vector(7 downto 0) := "00000000";
    
    component FLAGS
        Port(
            CLK         : in std_logic;
            C_IN        : in std_logic;
            Z_IN        : in std_logic;
            FLG_C_SET   : in std_logic;
            FLG_C_CLR   : in std_logic;
            FLG_C_LD    : in std_logic;
            FLG_Z_LD    : in std_logic;
            FLG_LD_SEL  : in std_logic;
            FLG_SHAD_LD : in std_logic;
            C_FLAG      : out std_logic;
            Z_FLAG      : out std_logic);
    end component;
    
    signal C_FLAG       : std_logic := '0';
    signal Z_FLAG       : std_logic := '0';
    
    component SP 
        Port(
            RST         : in std_logic;
            LD          : in std_logic;
            INCR        : in std_logic;
            DECR        : in std_logic;
            CLK         : in std_logic;
            DATA_IN     : in std_logic_vector(7 downto 0);
            DATA_OUT    : out std_logic_vector(7 downto 0));
    end component;
    
    signal SP_DATA_OUT : std_logic_vector(7 downto 0) := "00000000";
    signal SP_DATA_OUT_LESS : std_logic_vector(7 downto 0) := "00000000";
    
    component SCR_DIN_MUX 
        Port(
            A       : in std_logic_vector(7 downto 0);
            B       : in std_logic_vector(9 downto 0);
            SEL     : in std_logic;
            MUX_OUT : out std_logic_vector(9 downto 0));
    end component;
    
    signal SCR_DIN_MUX_OUT : std_logic_vector(9 downto 0) := "0000000000";
    
    component SCR_ADDR_MUX
        Port(
            A       : in std_logic_vector(7 downto 0);
            B       : in std_logic_vector(7 downto 0);
            C       : in std_logic_vector(7 downto 0);
            D       : in std_logic_vector(7 downto 0);
            SEL     : in std_logic_vector(1 downto 0);
            MUX_OUT : out std_logic_vector(7 downto 0));
    end component;
    
    signal SCR_ADDR_MUX_OUT : std_logic_vector(7 downto 0) := "00000000";
    
    component SCR
        Port( 
            DATA_IN     : in std_logic_vector(9 downto 0);
            ADDR        : in std_logic_vector(7 downto 0);
            WE          : in std_logic;
            CLK         : in std_logic;
            DATA_OUT    : out std_logic_vector(9 downto 0));
    end component;
    
    signal DATA_OUT : std_logic_vector(9 downto 0) := "0000000000";

    component I_AND
        port(
            INT         : in std_logic;
            I_SET       : in std_logic;
            I_CLR       : in std_logic;
            CLK         : in std_logic;
            I_OUT       : out std_logic);
    end component;
        
    signal I_OUT        : std_logic := '0';
    
begin 

    MY_CONTROL_UNIT: CONTROL_UNIT port map(
        CLK => CLK,
        C => C_FLAG,
        Z => Z_FLAG,
        INT => I_OUT,
        RESET => RESET,
        OPCODE_HI_5 => IR(17 downto 13),
        OPCODE_LO_2 => IR(1 downto 0),
        RST => RST,
        PC_LD => PC_LD,
        PC_INC => PC_INC,
        PC_MUX_SEL => PC_MUX_SEL,
        SP_LD => SP_LD,
        SP_INCR => SP_INCR,
        SP_DECR => SP_DECR,
        SCR_DATA_SEL => SCR_DATA_SEL,
        SCR_WE => SCR_WE,
        SCR_ADDR_SEL => SCR_ADDR_SEL,
        RF_WR => RF_WR,
        RF_WR_SEL => RF_WR_SEL,
        ALU_SEL => ALU_SEL,
        ALU_OPY_SEL => ALU_OPY_SEL,
        FLG_C_LD => FLG_C_LD,
        FLG_C_SET => FLG_C_SET,
        FLG_C_CLR => FLG_C_CLR,
        FLG_Z_LD => FLG_Z_LD,
        FLG_SHAD_LD => FLG_SHAD_LD,
        FLG_LD_SEL => FLG_LD_SEL,
        I_SET => I_SET,
        I_CLR => I_CLR,
        IO_STRB => IO_STRB);
        
    MY_PC: PC port map(
        RST => RST,
        LD => PC_LD,
        INC => PC_INC,
        DIN => PC_MUX_OUT,
        CLK => CLK,
        PC_COUNT => PC_COUNT);
        
    MY_PC_MUX: PC_MUX port map(
        IMMED => IR(12 downto 3),
        STACK => DATA_OUT,
        INTERUPT => "1111111111",
        MUX_SEL => PC_MUX_SEL,
        MUX_OUT => PC_MUX_OUT);
        
    MY_PROG_ROM: prog_rom port map(
        ADDRESS => PC_COUNT,
        CLK => CLK,
        INSTRUCTION => IR);
    
    MY_REG_FILE: REG_FILE port map(
        WR => RF_WR,
        ADRX => IR(12 downto 8),
        ADRY => IR(7 downto 3),
        CLK => CLK,
        DIN => REG_MUX_OUT,
        DX_OUT => DX_OUT,
        DY_OUT => DY_OUT);
        
    MY_REG_FILE_MUX: REG_FILE_MUX port map(
        IN_PORT => IN_PORT,
        B => "00000000",
        STACK => DATA_OUT(7 downto 0),
        ALU_RESULT => RESULT,
        MUX_SEL => RF_WR_SEL,
        MUX_OUT => REG_MUX_OUT);
        
    MY_ALU: ALU port map(
        CIN => C_FLAG,
        SEL => ALU_SEL,
        A => DX_OUT,
        B => ALU_MUX_OUT,
        RESULT => RESULT,
        C => C,
        Z => Z);
    
    MY_ALU_MUX: ALU_MUX port map(
        A => DY_OUT,
        B => IR(7 downto 0),
        SEL => ALU_OPY_SEL,
        MUX_OUT => ALU_MUX_OUT);
    
    MY_FLAG: FLAGS port map(
        FLG_C_SET => FLG_C_SET,
        FLG_C_CLR => FLG_C_CLR,
        FLG_C_LD => FLG_C_LD,
        FLG_Z_LD => FLG_Z_LD,
        FLG_LD_SEL => FLG_LD_SEL,
        FLG_SHAD_LD => FLG_SHAD_LD,
        C_IN => C,
        Z_IN => Z,
        CLK => CLK,
        C_FLAG => C_FLAG,
        Z_FLAG => Z_FLAG);
        
    MY_SP: SP port map(
        RST => RST,
        LD => SP_LD,
        INCR => SP_INCR,
        DECR => SP_DECR,
        CLK => CLK,
        DATA_IN => DX_OUT,
        DATA_OUT => SP_DATA_OUT);
        
    MY_SCR_DIN_MUX: SCR_DIN_MUX port map(
        A => DX_OUT,
        B => PC_COUNT,
        SEL => SCR_DATA_SEL,
        MUX_OUT => SCR_DIN_MUX_OUT);
        
    MY_SCR_ADDR_MUX: SCR_ADDR_MUX port map(
        A => DY_OUT,
        B => IR(7 downto 0),
        C => SP_DATA_OUT,
        D => SP_DATA_OUT_LESS,
        SEL => SCR_ADDR_SEL,
        MUX_OUT => SCR_ADDR_MUX_OUT);
        
    MY_SCR: SCR port map(
        DATA_IN => SCR_DIN_MUX_OUT,
        WE => SCR_WE,
        ADDR => SCR_ADDR_MUX_OUT,
        CLK => CLK,
        DATA_OUT => DATA_OUT);
        
    MY_I_AND: I_AND port map(
        INT => INT,
        I_SET => I_SET,
        I_CLR => I_CLR,
        CLK => CLK,
        I_OUT => I_OUT);
        
    SP_DATA_OUT_LESS <= SP_DATA_OUT - "00000001";
    OUT_PORT <= DX_OUT;
    PORT_ID <= IR(7 downto 0);
        
     

end Behavioral;
