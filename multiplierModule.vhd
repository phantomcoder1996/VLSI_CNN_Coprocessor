Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.all;

ENTITY multiplierModule IS 
  GENERIC(n:integer :=8);
  PORT (
      --- inputs ---
        M1:IN std_logic_vector(n-1 downto 0);
        M2:IN std_logic_vector(n-1 downto 0);
        conv:IN std_logic;
        enableOp:IN std_logic;
        clk:IN std_logic;
    --- outputs ---
        resultN:OUT std_logic_vector(n-1 downto 0);
        endN:OUT std_logic
  );
  SIGNAL P,A,S: std_logic_vector(2*n downto 0):=(others=>'0');
  SIGNAL temp,M3 :std_logic_vector(n-1 downto 0);
END ENTITY;

ARCHITECTURE my_multiplier_module OF multiplierModule IS 
COMPONENT multiplier IS 
  GENERIC(n:integer :=8);
  
  PORT(
    --- inputs ---
        P1,A1,S1:IN std_logic_vector(2*n downto 0);
        conv:IN std_logic;
        enableOp:IN std_logic;
        clk:IN std_logic;
    --- outputs ---
        resultN:OUT std_logic_vector(n-1 downto 0);
        endN:OUT std_logic
        
      );
    END COMPONENT;
BEGIN 
--- calculate start value of A ---
--- A=[M1] [000s]
A(2*n downto 0) <= M1(n-1 downto 0) & "000000000";

--- calculate start value of S ---
--- S=[2's M1][0000s]
temp <= NOT M1;
M3 <= std_logic_vector(unsigned(temp + 1));
S(2*n downto 0)<= M3(n-1 downto 0) & "000000000";

--- calculate start value of P ---
--- P=[0000s][M2][0] ---
P(2*n downto 0) <= "00000000" & M2(n-1 downto 0) & '0';

mult: multiplier GENERIC MAP(n=>n)PORT MAP (P,A,S,conv,enableOp,clk,resultN,endN);
  

END my_multiplier_module;
