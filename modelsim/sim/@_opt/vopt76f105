library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        instrF          : in     vl_logic_vector(31 downto 0);
        pcF             : out    vl_logic_vector(31 downto 0);
        readdataM       : in     vl_logic_vector(31 downto 0);
        aluoutM         : out    vl_logic_vector(31 downto 0);
        writedataM      : out    vl_logic_vector(31 downto 0);
        memwriteM       : out    vl_logic;
        ampM            : out    vl_logic_vector(3 downto 0);
        immctrlD        : in     vl_logic_vector(4 downto 0);
        itype           : in     vl_logic;
        jalD            : in     vl_logic;
        jalrD           : in     vl_logic;
        bunsignedD      : in     vl_logic;
        branchD         : in     vl_logic_vector(3 downto 0);
        pcsrcD          : in     vl_logic;
        aluctrlD        : in     vl_logic_vector(3 downto 0);
        alusrcaD        : in     vl_logic_vector(1 downto 0);
        alusrcbD        : in     vl_logic_vector(1 downto 0);
        memwriteD       : in     vl_logic;
        lunsignedD      : in     vl_logic;
        lwhbD           : in     vl_logic_vector(1 downto 0);
        swhbD           : in     vl_logic_vector(1 downto 0);
        memtoregD       : in     vl_logic;
        regwriteD       : in     vl_logic;
        opD             : out    vl_logic_vector(6 downto 0);
        funct3D         : out    vl_logic_vector(2 downto 0);
        funct7D         : out    vl_logic_vector(6 downto 0);
        rdD             : out    vl_logic_vector(4 downto 0);
        rs1D            : out    vl_logic_vector(4 downto 0);
        immD            : out    vl_logic_vector(11 downto 0);
        zeroD           : out    vl_logic;
        ltD             : out    vl_logic
    );
end datapath;
