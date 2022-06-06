LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

ENTITY INT_REG IS 
	PORT(clk         : IN STD_LOGIC;
		  int_clr     : IN STD_LOGIC;
	     INT         : IN STD_LOGIC;
	     d           : IN STD_LOGIC;
      -- rst 	     : IN STD_LOGIC;
	     q     : OUT STD_LOGIC
	  );


END ENTITY INT_REG;

ARCHITECTURE RTL OF INT_REG IS

	SIGNAL ena   : STD_LOGIC;
	
	BEGIN 
	
	dff: PROCESS(clk, int_clr, d, INT)
	BEGIN 
		IF(int_clr = '1') THEN 
			q  <= '0';
		ELSIF(rising_edge(clk)) THEN 
			IF(ena = '1') THEN 
				q  <= '1';
			ELSIF (INT = '1') THEN 
			   q  <= d;
			END IF;
		END IF;
	END PROCESS;
	

END ARCHITECTURE;  
	