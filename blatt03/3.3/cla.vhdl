library ieee;
use ieee.std_logic_1164.all;

entity cla is
  port (
    a : in std_logic_vector(3 downto 0);
    b : in std_logic_vector(3 downto 0);
    cin : in std_logic;
    cout : out std_logic;
    sum : out std_logic_vector(3 downto 0)
  );
end cla;

-- a simple example for an implementation using 2 predefined components can be found in the nandgate related to exercise sheet 1
-- Ein einfaches Beispiel fuer eine Implementierung die 2 vordefinierte Komponenten verwendet kann im nandgate das Uebungsblatt 1 beilag gefunden werden
architecture rtl of cla is
  component facla is
    port (
  -- ports of the facla
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    cin : in STD_LOGIC;
    g : out STD_LOGIC;
    p : out STD_LOGIC;
    sum : out STD_LOGIC
    );
  end component facla;

  component clag is
    port(
  -- ports of the clag 
    gin : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    pin : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    cin : IN STD_LOGIC;
    cout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    pout : OUT STD_LOGIC;
    gout : OUT STD_LOGIC
    );
  end component clag;

-- signals   
  signal P,G :std_logic_vector(3 downto 0);
  signal c : std_logic_vector(3 downto 0) ;
  signal pout , gout : std_logic;

begin
-- implement cla here
  facla0 : facla port map ( a(0) , b(0) , cin ,  G(0) ,P(0) , sum(0) );
  facla1 : facla port map ( a(1) , b(1) , c(0) , G(1) ,P(1) , sum(1) );
  facla2 : facla port map ( a(2) , b(2) , c(1) , G(2) ,P(2) , sum(2) );
  facla3 : facla port map ( a(3) , b(3) , c(2) , G(3) ,P(3) , sum(3) );
  cout <= c(3) ;
  clag0  : clag port map ( G , P , cin , c , pout , gout ) ;
end rtl;
