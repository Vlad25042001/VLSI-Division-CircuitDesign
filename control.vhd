-----------------------------------------------------------------------------------------------
-- Universitatea Transilvania din Brasov
-- Proiect     : Algoritm de împărțire fără restaurare (deîmpărțit pozitiv, împărțitor negativ)

-----------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
 
ENTITY control IS
PORT ( 
    clk     : IN  std_logic;
    reset   : IN  std_logic;
    --FSM inputs
    start   : IN  std_logic;
    count  : IN  std_logic;
    --FSM outputs
    ld_a    : OUT std_logic;
    ld_b    : OUT std_logic;
    clr_p   : OUT std_logic;
    ld_p    : OUT std_logic;
    ld_r    : OUT std_logic;
    ld_cat  : OUT std_logic;
    shift_p : OUT std_logic;
    shift_a : OUT std_logic;
    op      : OUT std_logic;
    final_a : OUT std_logic;
    ready   : OUT std_logic
);
END control;

ARCHITECTURE control OF control IS

  TYPE state IS (Initial, Load, Shift, Operation, Fin);
  SIGNAL currentState : state;
  SIGNAL nextState    : state;
  SIGNAL ld_r_ready   : std_logic;

BEGIN

CLC: PROCESS ( currentState, start, count ) BEGIN
  CASE currentState IS
    WHEN Initial => IF ( start   = '1' ) THEN
      	            nextState <= Load;
               ELSE 
      	            nextState <= Initial;
               END IF; 
    WHEN Load => nextState <= Shift;
    WHEN Shift => nextState <=Operation; 
	WHEN Operation => IF ( count = '1') THEN
		    nextState <=Shift;
		ELSE
		    nextState<=Fin;
		END IF; 
    WHEN Fin => nextState <= Initial;
  END CASE;
END PROCESS CLC;

REG: PROCESS ( clk ) BEGIN
  IF (clk'EVENT AND clk = '1') THEN
    IF (reset = '1') THEN
        currentState <= Initial;
    ELSE
        currentState <= nextState;
    END IF;
  END IF;
END PROCESS REG;

--FSM outputs
ld_a <= '1' WHEN ((currentState = Initial) AND (start = '1')) ELSE '0';
ld_b <= '1' WHEN ((currentState = Initial) AND (start = '1')) ELSE '0';
clr_p <= '1' WHEN ((currentState = Initial) AND (start = '1')) ELSE '0';
ld_p <= '1' WHEN (currentState = Load) ELSE '0';

shift_a <= '1' WHEN (currentState = Shift) ELSE '0';
shift_p <= '1' WHEN (currentState = Shift) ELSE '0';

op <= '1' WHEN (currentState = Operation) ELSE '0';

final_a <= '1' WHEN (currentState = Fin) ELSE '0'; 

ld_r_ready <= '1' WHEN ((currentState = Initial)AND (count = '0')) ELSE '0';
ld_r <= ld_r_ready;
ld_cat <= ld_r_ready;

-- ready is ld_r delayed
PROCESS ( clk ) BEGIN
  IF (clk'EVENT AND clk = '1') THEN
    IF (reset = '1') THEN
        ready <= '0';
    ELSE
        ready <= ld_r_ready;
    END IF;
  END IF;
END PROCESS;
  
END control;
