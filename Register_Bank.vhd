LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;


ENTITY Register_Bank IS 
	GENERIC( DATA_WIDTH  :integer:= 8; 
			   ADDR_WIDTH  :integer:= 3); 
	PORT(clk             :IN STD_LOGIC; 
		  wr_en            :IN STD_LOGIC; 
		  wr_addr          :IN STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0); 
		  rd_addr          :IN STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0); 
		  wr_data          :IN STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0); 
		  reset            :IN STD_LOGIC;
		  BUSA 	         :OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0); 
		  BUSB            :OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) 
		  
		  );
		  END ENTITY; 
		  
		  ------ 
ARCHITECTURE rtl OF Register_Bank IS
			TYPE mem_2d_type IS ARRAY(0 TO 2**ADDR_WIDTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0); 

			SIGNAL array_reg: mem_2d_type; 
SIGNAL en: std_logic_vector(2**ADDR_WIDTH-1 downto 0); 
CONSTANT acc_addr : unsigned(ADDR_WIDTH-1 DOWNTO 0) := to_unsigned(7,ADDR_WIDTH); 


 BEGIN
	MEM_BANK: PROCESS(clk, wr_en, reset) 
		BEGIN
			IF(reset = '1') THEN
				array_reg(0) <= "00000001";
				array_reg(1) <= "01111111";
				array_reg(2) <= "11111101";
				array_reg(3) <= "11110111";
				array_reg(4) <= "11100111";
				array_reg(5) <= "10100011";
				array_reg(6) <= "10001111";
				array_reg(7) <= "10001001";
			ELSIF(rising_edge(clk))THEN 
				IF(wr_en = '1') THEN 
					array_reg(to_integer(unsigned(wr_addr)))<= wr_data; 
				END IF;
			END IF;
END PROCESS;

BUSB <= array_reg(to_integer(unsigned(rd_addr)));		
BUSA <= array_reg(to_integer(acc_addr));
END ARCHITECTURE;		  