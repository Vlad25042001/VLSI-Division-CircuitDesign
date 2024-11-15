-----------------------------------------------------------------------------------------------
-- Universitatea Transilvania din Brasov
-- Proiect     : Algoritm de împărțire fără restaurare (deîmpărțit pozitiv, împărțitor negativ)

-----------------------------------------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY date IS
PORT ( 
    clk     : IN  std_logic;
    reset   : IN  std_logic;
    a       : IN  std_logic_vector(3 DOWNTO 0); 
    b       : IN  std_logic_vector(3 DOWNTO 0); 
    ld_a    : IN  std_logic;
    ld_b    : IN  std_logic;
    clr_p   : IN  std_logic;
    ld_p    : IN  std_logic;
    op      : IN  std_logic;
    shift_p : IN  std_logic;
    shift_a : IN  std_logic;
    final_a : IN  std_logic;
    ld_r    : IN  std_logic;
    ld_cat  : IN  std_logic;
    count   : OUT std_logic;
    p       : OUT std_logic_vector(4 DOWNTO 0);
    cat     : OUT std_logic_vector(3 DOWNTO 0)
);
END date;

ARCHITECTURE date OF date IS
  SIGNAL reg_a     : std_logic_vector(3 DOWNTO 0);
  SIGNAL reg_b     : std_logic_vector(3 DOWNTO 0);
  SIGNAL reg_p     : std_logic_vector(4 DOWNTO 0);
  SIGNAL reg_cat   : std_logic_vector(3 DOWNTO 0);
  SIGNAL reg_r     : std_logic_vector(4 DOWNTO 0);
  SIGNAL count_in  : std_logic_vector(3 DOWNTO 0);
BEGIN

--reg A
PROCESS(clk)
  BEGIN
    IF (clk'EVENT AND clk = '1') THEN
      IF (reset = '1') THEN 
        reg_a <= (others => '0');
		count_in <= (others => '0');
      ELSIF (ld_a = '1') THEN
	    count_in <= (others => '0');
        reg_a <= a;
      ELSIF (shift_a = '1') THEN 
	    reg_a <= reg_a( 2 downto 0 ) & reg_p(4); 
        count_in <= count_in +'1';
	  ELSIF (final_a = '1') THEN
		reg_a <= reg_a( 2 downto 0 ) & reg_p(4);
      END IF;
    END IF;    
END PROCESS;
count <= '0' WHEN count_in = "0100" else '1';

--reg B
PROCESS(clk)
  BEGIN
    IF (clk'EVENT AND clk = '1') THEN
      IF (reset = '1') THEN 
        reg_b <= (others => '0');
      ELSIF (ld_b = '1') THEN
        reg_b <= b;
      END IF;
    END IF;    
END PROCESS;


--reg P
PROCESS(clk)
  BEGIN
    IF (clk'EVENT AND clk = '1') THEN
      IF (reset = '1') THEN 
        reg_p <= (others => '0');
      ELSIF (clr_p = '1') THEN
        reg_p <= (others => '0');
      ELSIF (ld_p = '1') THEN
	     reg_p <= reg_p + ('1'& reg_b);
      ELSIF(shift_p = '1') THEN
         reg_p <= reg_p(3 DOWNTO 0) & reg_a(3);
      ELSIF(op = '1' AND reg_p(4)='0') THEN
          reg_p <= reg_p +('1'& reg_b) ;
      ELSIF(op = '1' AND reg_p(4)='1') THEN
          reg_p <= reg_p + (not('1'& reg_b)+'1') ;
		END IF;
	  IF(final_a = '1' AND reg_p(4) = '1') THEN
		  reg_p <= reg_p + (not('1'& reg_b)+'1') ;
      END IF;
    END IF;    
END PROCESS;


--reg R
PROCESS(clk)
  BEGIN
    IF (clk'EVENT AND clk = '1') THEN
      IF (reset = '1') THEN 
        reg_r <= (others => '0');
      ELSIF (ld_r = '1') THEN
        reg_r <= reg_p ;
      END IF;
    END IF;    
END PROCESS;
p <= reg_r;


--reg cat
PROCESS(clk)
  BEGIN
    IF (clk'EVENT AND clk = '1') THEN
      IF (reset = '1') THEN 
        reg_cat <= (others => '0');
      ELSIF (ld_cat = '1') THEN
        reg_cat <=  reg_a + '1';
      END IF;
    END IF;    
END PROCESS;
cat <= reg_cat;

END date;
