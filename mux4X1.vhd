Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mux4X1 IS 
  GENERIC(n:integer :=17);
  PORT(
      sel:IN std_logic_vector(1 downto 0) ;
      input1,input2,input3,input4:IN std_logic_vector(n-1 downto 0);
      output:OUT std_logic_vector(n-1 downto 0)
    
    );
END ENTITY;

ARCHITECTURE my_mux4X1 OF mux4X1 IS 
BEGIN 
output<=input1 WHEN sel="00"
ELSE input2 WHEN sel="01"
ELSE input3 WHEN sel="10"
ELSE input4;
  
END my_mux4X1;