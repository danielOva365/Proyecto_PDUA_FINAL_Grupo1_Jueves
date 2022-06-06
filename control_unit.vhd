LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

ENTITY Control_unit IS 
	PORT(clk         : IN STD_LOGIC;
	     int         : IN STD_LOGIC;
	     rst 	     : IN STD_LOGIC;
		  C           : IN STD_LOGIC;
		  N           : IN STD_LOGIC;
        P           : IN STD_LOGIC;
        Z           : IN STD_LOGIC;
		  opcode      : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		  U_I         : OUT STD_LOGIC_VECTOR(20 DOWNTO 0)
		  
	  );


END ENTITY Control_unit;

ARCHITECTURE RTL OF Control_unit IS


	 
	SIGNAL result :STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL load          			:STD_LOGIC;
	SIGNAL upc         			   :STD_LOGIC_VECTOR(2 DOWNTO 0); 
	SIGNAL datab       			   :STD_LOGIC_VECTOR(2 DOWNTO 0); 
	SIGNAL control_unitdata       :  STD_LOGIC_VECTOR(2 DOWNTO 0);
   SIGNAL ir_en						:	STD_LOGIC; 
	SIGNAL mar_en						:	STD_LOGIC; 
	SIGNAL bank_wr_en					: 	STD_LOGIC; 
	SIGNAL selop         			:  STD_LOGIC_VECTOR(2 DOWNTO 0); 
   SIGNAL shamt                  :  STD_LOGIC_VECTOR(1 DOWNTO 0); 
	SIGNAL mdr_en			         :	STD_LOGIC;
	SIGNAL mdr_alu_n		         :	STD_LOGIC; 
	SIGNAL BusB_addr		         :	STD_LOGIC_VECTOR(2 DOWNTO 0); 
	SIGNAL BusC_addr		         :	STD_LOGIC_VECTOR(2 DOWNTO 0); 
	SIGNAL wr_rdn                 :	STD_LOGIC;
   SIGNAL enaf                   :	STD_LOGIC;
	SIGNAL iom                    :  STD_LOGIC;
	SIGNAL ir_clr                 :  STD_LOGIC;
   SIGNAL clr_upc                :  STD_LOGIC;
	SIGNAL en_upc                 :  STD_LOGIC;
   SIGNAL int_clr                :  STD_LOGIC;
	SIGNAL jcond                  :  STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL offset        :  STD_LOGIC_VECTOR(2 DOWNTO 0);
   SIGNAL uaddr         :  STD_LOGIC_VECTOR(7 DOWNTO 0); 
	SIGNAL d             :  STD_LOGIC_VECTOR(2 downto 0);
	SIGNAL rdata         : STD_LOGIC_VECTOR(28 DOWNTO 0);
	
BEGIN 
	
	shamt				<= rdata(28 DOWNTO 27); 
	selop				<= rdata(26 DOWNTO 24); 
	ir_en		 		<= rdata(23);           
	mar_en			<= rdata(22); 
	bank_wr_en		<= rdata(21); 
	BusC_addr		<= rdata(20 DOWNTO 18); 
	BusB_addr		<= rdata(17 DOWNTO 15); 
	mdr_alu_n		<= rdata(14); 
	mdr_en			<= rdata(13); 
	wr_rdn			<= rdata(12);
	enaf 				<= rdata(11);
	iom				<= rdata(10);
	ir_clr			<= rdata(9);
	int_clr			<= rdata(8);
	clr_upc			<= rdata(6);
	en_upc			<= rdata(7);
	jcond			   <= rdata(5 DOWNTO 3);
	offset			<= rdata(2 DOWNTO 0);
   U_I            <= rdata(28 DOWNTO 8);
	        
	
	
	upc_component: ENTITY WORK.upc 
	
	PORT MAP(
		      
				clk       => clk,
				clr_uPC   => clr_uPC,
				en_uPC    => en_uPC,
			   d         => d,
		      q         => upc,
				rst     	 => rst	
				
				);
	
	
	add_sub_component: ENTITY WORK.add_sub 

	PORT MAP(    a        => upc,
					 b        => "001",
					 addn_sub => '0',
					 s        => result,
					 cout     => OPEN);
					 
					 
	 uProgramMemory_component:	ENTITY WORK.uProgramMemory
		
	 PORT MAP(
	 uaddr  => uaddr,
	 U_I    => rdata
	 
		 
	 );
	 
	 uaddr <= opcode & upc;
		
		load <= '0' WHEN jcond = "000" ELSE 
			     '1'	WHEN jcond = "001" ELSE 				 
		         Z WHEN jcond =  "010" ELSE
				   N WHEN jcond =  "011" ELSE
		         C WHEN jcond =  "100" ELSE 
		         P WHEN jcond =  "101" ELSE 
		       int WHEN jcond =  "110" ELSE
	          '0' WHEN jcond =  "111"; 		
			
	   d <= result WHEN load = '0' ELSE
					  offset WHEN load = '1'; 
					  
END ARCHITECTURE;

 