Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mux2X1 IS 
  GENERIC(n:integer :=8);
  PORT(
      sel:IN std_logic ;
      input1,input2:IN std_logic_vector(n-1 downto 0);
      output:OUT std_logic_vector(n-1 downto 0)
    
    );
END ENTITY;

ARCHITECTURE my_mux2X1 OF mux2X1 IS 
BEGIN 
output<= input1 WHEN sel='0'
                ELSE input2 WHEN sel='1';
             
  
END my_mux2X1;

