LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

ENTITY PDUA IS 
	GENERIC (MAX_WIDTH : INTEGER:=8);
	
	
	PORT (clk    				 : IN STD_LOGIC;
			reset  				 : IN STD_LOGIC;
			INT                : IN STD_LOGIC; 
			rdata              : IN STD_LOGIC_VECTOR(20 DOWNTO 0)
			); 
			
			
END ENTITY;

ARCHITECTURE PDUA_ctrl OF PDUA IS

   SIGNAL U_I           :  STD_LOGIC_VECTOR(20 DOWNTO 0);
	SIGNAL BUSC				:	STD_LOGIC_VECTOR(7 DOWNTO 0); 
   SIGNAL BUSC1			:	STD_LOGIC_VECTOR(7 DOWNTO 0); 	
	SIGNAL CONTROL_UNIT 	: 	STD_LOGIC_VECTOR(7 DOWNTO 0);	
	SIGNAL ADDRESS_BUS	:	STD_LOGIC_VECTOR(7 DOWNTO 0); 
	SIGNAL BUSA				:	STD_LOGIC_VECTOR(7 DOWNTO 0); 
	SIGNAL BUSB				:	STD_LOGIC_VECTOR(7 DOWNTO 0); 
	SIGNAL BUS_DATA_OUT	:	STD_LOGIC_VECTOR(7 DOWNTO 0); 
	SIGNAL BUS_DATA_IN	:	STD_LOGIC_VECTOR(7 DOWNTO 0);
 	SIGNAL addr          :  STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL dataout       :  STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL datainmem     :  STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL opcode        :  STD_LOGIC_VECTOR(4 DOWNTO 0);	
	SIGNAL BusB_addr		:	STD_LOGIC_VECTOR(2 DOWNTO 0); 
	SIGNAL BusC_addr		:	STD_LOGIC_VECTOR(2 DOWNTO 0);
   SIGNAL selop         :  STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL shamt         :  STD_LOGIC_VECTOR(1 DOWNTO 0); 
	SIGNAL mdr_en			:	STD_LOGIC; 
	SIGNAL mdr_alu_n		:	STD_LOGIC; 
	SIGNAL ir_en			:	STD_LOGIC; 
	SIGNAL mar_en			:	STD_LOGIC; 
	SIGNAL bank_wr_en		: 	STD_LOGIC; 
	SIGNAL wr_rdn        :  STD_LOGIC;
	SIGNAL C             :  STD_LOGIC;
	SIGNAL N             :  STD_LOGIC;
	SIGNAL P             :  STD_LOGIC;
	SIGNAL Z             :  STD_LOGIC;
	SIGNAL rst           :  STD_LOGIC;
	SIGNAL enaf          :  STD_LOGIC;
	SIGNAL int_clr       :  STD_LOGIC;
	SIGNAL ENA           :  STD_LOGIC; 
   SIGNAL INT_REG       :  STD_LOGIC;
	SIGNAL q             :  STD_LOGIC;
	SIGNAL iom           :  STD_LOGIC;
	SIGNAL ir_clr        :  STD_LOGIC;
	SIGNAL external_bus  :  STD_LOGIC;

								
BEGIN
		
	
	 shamt				<= U_I(20 DOWNTO 19); 
	 selop				<= U_I(18 DOWNTO 16); 
	 ir_en            <= U_I(15);
	 mar_en           <= U_I(14);
	 bank_wr_en		   <= U_I(13); 
	 BusC_addr		   <= U_I(12 DOWNTO 10); 
	 BusB_addr		   <= U_I(9 DOWNTO 7); 
    mdr_alu_n		   <= U_I(6);
	 mdr_en			   <= U_I(5);
	 wr_rdn <=  U_I(4);
	 enaf             <= U_I(3);
	 iom              <= U_I(2);
    ir_clr           <= U_I(1);
	 int_clr          <= U_I(0);

	 addr <=  ADDRESS_BUS;   
	 dataout <=  BUS_DATA_OUT; 
	 BUS_DATA_IN <=  datainmem; 
	 BUSC	<= BUSC1 WHEN mdr_alu_n = '0' ELSE (OTHERS => 'Z');
			
			
ir_component: ENTITY WORK.IR 
	PORT MAP(  clk     => clk, 
				  ir_en   => ir_en,
				  d       => BUSC,
				  reset   => reset,
				  sclr    => ir_clr, 
				  q       => opcode );
				
				
register_bank_component: ENTITY WORK.Register_Bank  				
	PORT	MAP(clk              => clk, 
				 reset            => reset, 
				 wr_en            => bank_wr_en, 
				 wr_addr          => BusC_addr, 
				 rd_addr          => BusB_addr, 
				 wr_data          => BUSC, 
				 BUSA 	         => BUSA, 
				 BUSB             => BUSB);
				 
				
mar_component: ENTITY WORK.MAR  
	PORT MAP(clk		=>	clk,     
				reset 	=>	reset, 
				MAR_en 	=>	mar_en, 
				d        => BUSC, 
				q        =>	ADDRESS_BUS);
				
				
				

mdr_component: ENTITY WORK.MDR 
	PORT MAP(    clock            => clk,   
				data_ex_in           => BUS_DATA_IN, 								 
			   mdr_alu_n        		=> mdr_alu_n,   
				mdr_en			  		=> mdr_en, 
				reset				  		=> reset, 
				dq					  		=> BUSC,
				Bus_data_out	  		=> bus_data_out   
			   
				); 
				
spram_component: ENTITY WORK.spram  


			  
	PORT MAP(  clk   =>  clk, 
	        wr_rdn   => wr_rdn, 
			  addr     => addr, 
			  w_data   => dataout,
			  r_data   => datainmem  
			  );
			  
			  
			  
			  
Control_Unit_component: ENTITY WORK.control_unit
		PORT MAP(
		clk    => clk, 
		rst    => reset, 
		INT    => INT_REG,
		opcode =>  opcode,
		C      =>  C,
		N      =>  N,
		Z      =>  Z,
		P      =>  P,
	   U_I    => U_I 
		
		);
		
	INT_REG_COMPONENT: ENTITY WORK.INT_REG
		PORT MAP(
		  clk          => clk,     
		  int_clr      => int_clr,
		  INT          => INT, 
	     q            => INT_REG,  
	     d            => '1' 
        
	);
		
		

		ALU_component: ENTITY WORK.ALU
			
		
		PORT MAP(
		clk    => clk, 
		rst    => reset, 
		BUSB   => BUSB, 
		BUSA   => BUSA,
		shamt  => shamt, 
		selop  => selop, 
		enaf   => enaf, 
		C      =>  C,
		N      =>  N,
		Z      =>  Z,
		P      =>  P, --
		BUSC   => BUSC1
		
		);
		
	
	
		
		
end ARCHITECTURE;

