library ieee;
use ieee.std_logic_1164.all;


package avalon_interface_vhdl_pkg is
    -- GENERIC (ST_DATA_WIDTH      : positive := 32,
    --          MM_DATA_WIDTH      : positive := 32);

    -- Avalon-ST Master: Define two collections of signals, one for each direction.
    type from_AvalonST_source is record
        Error : std_logic_vector(1 DOWNTO 0);
        Valid : std_logic;
        Sop   : std_logic;
        Eop   : std_logic;
        Empty : std_logic;
        Data  : std_logic_vector(31 DOWNTO 0); 
		--Tx_Data_xDO  : std_logic_vector(ST_DATA_WIDTH - 1 DOWNTO 0);
    end record ;
    type to_AvalonST_source is record
        Ready : std_logic;
    end record ;


    -- Avalon-MM Master: Define two collections of signals, one for each direction.
    type from_AvalonMM_Master is record
        Address       : std_logic_vector(7 DOWNTO 0);
        Read          : std_logic;
        WriteData     : std_logic_vector(31 DOWNTO 0); 
        Write         : std_logic;
		--Tx_Data_xDO  : std_logic_vector(ST_DATA_WIDTH - 1 DOWNTO 0);
    end record ;
    type to_AvalonMM_Master is record
        ReadData      : std_logic_vector(31 DOWNTO 0);
        WaitRequest   : std_logic;
    end record ;

end avalon_interface_vhdl_pkg;

