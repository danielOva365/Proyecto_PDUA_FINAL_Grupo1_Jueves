LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY PDUA_tb IS
END ENTITY PDUA_tb;

ARCHITECTURE testbench OF PDUA_tb IS


	SIGNAL rdata         :  STD_LOGIC_VECTOR(20 DOWNTO 0);
   SIGNAL U_I           :  STD_LOGIC_VECTOR(20 DOWNTO 0);	
	SIGNAL BUSC				:	STD_LOGIC_VECTOR(7 DOWNTO 0); 
	SIGNAL CONTROL_UNIT 	: 	STD_LOGIC_VECTOR(7 DOWNTO 0);	
	SIGNAL ADDRESS_BUS	:	STD_LOGIC_VECTOR(7 DOWNTO 0); 
	SIGNAL BUSA				:	STD_LOGIC_VECTOR(7 DOWNTO 0); 
	SIGNAL BUSB				:	STD_LOGIC_VECTOR(7 DOWNTO 0); 
	SIGNAL BUS_DATA_OUT	:	STD_LOGIC_VECTOR(7 DOWNTO 0); 
	SIGNAL BUS_DATA_IN	:	STD_LOGIC_VECTOR(7 DOWNTO 0); 
	SIGNAL addr          :  STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL dataout       :  STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL datainmem     :  STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL per_in        :  STD_LOGIC_VECTOR(7 DOWNTO 0):= (OTHERS => '0');
	SIGNAL mdr_en			:	STD_LOGIC := '0'; 
	SIGNAL mdr_alu_n		:	STD_LOGIC := '0'; 
	SIGNAL ir_en			:	STD_LOGIC := '0'; 
	SIGNAL mar_en			:	STD_LOGIC := '0';
	SIGNAL bank_wr_en		: 	STD_LOGIC := '0'; 
	SIGNAL BusB_addr		:	STD_LOGIC_VECTOR(2 DOWNTO 0):= (OTHERS => '0'); 
	SIGNAL BusC_addr		:	STD_LOGIC_VECTOR(2 DOWNTO 0):= (OTHERS => '0'); 
	SIGNAL wr_rdn        :  STD_LOGIC := '0';
	SIGNAL C             :  STD_LOGIC;
	SIGNAL N             :  STD_LOGIC;
	SIGNAL P             :  STD_LOGIC;
	SIGNAL Z             :  STD_LOGIC;
	SIGNAL rst           :  STD_LOGIC;
	SIGNAL selop         :  STD_LOGIC_VECTOR(2 DOWNTO 0); 
   SIGNAL shamt         :  STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL enaf          :  STD_LOGIC;
	SIGNAL clk           :  STD_LOGIC := '0'; 
	SIGNAL reset         :  STD_LOGIC := '1'; 
	SIGNAL INT           :  STD_LOGIC := '0';
	SIGNAL opcode        :  STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL q             :  STD_LOGIC;
	SIGNAL iom           :  STD_LOGIC;
	SIGNAL ir_clr        :  STD_LOGIC;
	SIGNAL external_bus  :  STD_LOGIC;
	
	
	
	
BEGIN 
		
		DUT: ENTITY WORK.PDUA
			PORT MAP(clk                => clk,
						reset              => reset,
						INT		          => INT,			
						rdata              => rdata
			);
			
			
						clk <= not clk after 10ns;
						reset <= '0' after 20ns;
					   INT  <=  '0' after 0ns;
				
									
END ARCHITECTURE;          

