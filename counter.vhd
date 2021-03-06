Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mCounter IS 
  GENERIC(n:integer :=3);
  PORT(
    ------------ enable inputs ----------------------
        enableOp:IN std_logic; --needs to set enable of the counter
        conv:IN std_logic; --enable of the counter
        --num:IN std_logic_vector(7 downto 0); --the number of bits (8 bits)
        --output ---
    ------------ Rst inputs --------------------------
        rst:IN std_logic;
        --conv,enableOp---
    ------------ clk input -----------------
        clk:IN std_logic;
    ------------ output --------------------
        output: INOUT std_logic_vector(n-1 downto 0)
      );
   SIGNAL num:std_logic_vector(n-1 downto 0):=(others=>'1'); 
   SIGNAL counter:std_logic_vector(n-1 downto 0):=(others=>'0');
   SIGNAL en,temp,rstSig:std_logic;
END ENTITY;


ARCHITECTURE multiplierCounter OF mCounter IS
  
  BEGIN
  --- check end status ---
  temp<='0' when output="111" 
  ELSE '1';
 
  
  --- set enable for the counter---
  en<= ((not conv) AND enableOp AND temp);
  --- set rst signal ---
  rstSig<= (rst AND enableOp AND (not conv));
  
  PROCESS(clk)
  BEGIN
  
  --- check stop cond ---
  IF(rstSig = '1') THEN 
  counter<=(others => '0');
  output<=counter;
  ELSIF (rising_edge(clk)) THEN 
   	if(en = '1') then
  	counter<=counter+1;
  	output<=counter;
	END IF;
  END IF;
  
  
  END PROCESS; 
    
    
    
  END multiplierCounter ;
  
