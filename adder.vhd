library ieee;
use ieee.std_logic_1164.all;

ENTITY adder IS
         PORT( a,b,cin : IN std_logic;                  
               c,cout : OUT std_logic);
END adder;

ARCHITECTURE arcadder OF adder IS
BEGIN
              c <= a XOR b XOR cin;
             cout <= (a AND b) or (cin AND (a XOR b));
   
END arcadder;
