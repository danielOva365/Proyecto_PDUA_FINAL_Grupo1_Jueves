LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;


ENTITY MAR IS 
	GENERIC (MAX_WIDTH : INTEGER:=7);
	PORT (clk        : IN STD_LOGIC;
			reset      : IN STD_LOGIC;
			MAR_en : IN STD_LOGIC;
			d          : IN STD_LOGIC_VECTOR(MAX_WIDTH DOWNTO 0);
			q          : OUT STD_LOGIC_VECTOR(MAX_WIDTH DOWNTO 0)
			);
END ENTITY;

-------

ARCHITECTURE rtl of MAR is 
BEGIN
	dff: PROCESS(clk, reset, d)
	BEGIN
		IF(reset = '1') THEN
			q <= (OTHERS => '0');
		ELSIF(rising_edge(clk)) THEN
			IF (MAR_en = '1') THEN 
			  q <= d;
			
			END IF;
	   END IF;
	END PROCESS;

END ARCHITECTURE;

