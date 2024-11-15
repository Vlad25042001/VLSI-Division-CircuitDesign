-----------------------------------------------------------------------------------------------
-- Universitatea Transilvania din Brasov
-- Proiect     : Algoritm de împărțire fără restaurare (deîmpărțit pozitiv, împărțitor negativ)
-----------------------------------------------------------------------------------------------



LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mult_test IS
GENERIC (per : time := 20 ns);
END mult_test;

ARCHITECTURE mult_test OF mult_test IS
COMPONENT mult
  PORT ( 
    clk     : IN  std_logic;
    reset   : IN  std_logic;
    a       : IN  std_logic_vector(3 DOWNTO 0); 
    b       : IN  std_logic_vector(3 DOWNTO 0); 
    start   : IN  std_logic;
	cat     : OUT std_logic_vector(3 DOWNTO 0);
    p       : OUT std_logic_vector(4 DOWNTO 0);
    ready   : OUT  std_logic
  );
END COMPONENT;

  SIGNAL clk     : std_logic := '1';
  SIGNAL reset   : std_logic;
  SIGNAL start   : std_logic;

  SIGNAL a      : std_logic_vector(3 DOWNTO 0);
  SIGNAL b      : std_logic_vector(3 DOWNTO 0);
  SIGNAL cat      : std_logic_vector(3 DOWNTO 0);
  SIGNAL p      : std_logic_vector(4 DOWNTO 0);
  SIGNAL ready  : std_logic;

  
BEGIN
  clk <= NOT clk AFTER per/2;
  reset <= '1', '0' AFTER 2*per;
  start <= '0', '1' AFTER 5*per, '0' AFTER 6*per, '1' AFTER 25*per, '0' AFTER 26*per;
  a <= "0110","0111" AFTER 10*per;
  b <= "1111","1101" AFTER 10*per;

  dut: mult
  PORT MAP( 
        clk         => clk, 
        reset       => reset, 

        a           => a,  
        b           => b,  

        start       => start,
		cat         => cat,
        p           => p,     
        ready       => ready
   ); 
    
END mult_test;
