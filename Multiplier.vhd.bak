--lma tbd2i feh tani htlla2i el moshkla en el counter mbi3desh ---
Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.all;

ENTITY multiplier IS 
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
    --- used signals --- 
        SIGNAL P,A,S,PA,PS,muxOut,muxResult,dffInp,dffOut:std_logic_vector(2*n downto 0);
        SIGNAL temp:std_logic_vector(n-1 downto 0); 
        SIGNAL counterOut:std_logic_vector(2 downto 0);
        SIGNAL sel:std_logic_vector(1 downto 0);
        SIGNAL c,dffEn:std_logic;
END ENTITY ;


ARCHITECTURE my_multiplier OF multiplier IS 
--- mux component ---
COMPONENT mux4X1 IS 
   GENERIC(n:integer :=17);
   PORT(
      sel:IN std_logic_vector(1 downto 0) ;
      input1,input2,input3,input4:IN std_logic_vector(n-1 downto 0);
      output:OUT std_logic_vector(n-1 downto 0)
    
    );
END COMPONENT;
--- mux 2 component ---
COMPONENT mux2X1 IS 
   GENERIC(n:integer :=8);
   PORT(
      sel:IN std_logic ;
      input1,input2:IN std_logic_vector(n-1 downto 0);
      output:OUT std_logic_vector(n-1 downto 0)
    
    );
END COMPONENT;
--- counter component ---
COMPONENT mCounter IS 
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
END COMPONENT;
--- dff component ---
COMPONENT my_nDFF IS 
GENERIC ( n : integer := 8);
PORT( Clk,Rst,enb : IN std_logic; 
		   d : IN std_logic_vector(n-1 DOWNTO 0); 
		   q : INOUT std_logic_vector(n-1 DOWNTO 0));
END COMPONENT;

----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------

BEGIN 
PROCESS(clk,counterOut,dffOut)
BEGIN 
IF(counterOut="000") THEN 
c<='0';
P<=P1;
A<=A1;
S<=S1;
dffEn<='1' ;
resultN<=(others=>'0');
ELSIF (counterOut="111")THEN
c<='1';
endN<='1';
dffEn<='0' ;
resultN<=dffInp(n+1 downto 2);
ELSE
c<='1';
P<=dffOut;
dffEn<='1' ;
resultN<=(others=>'0');
END IF;


END PROCESS;  
--- calculte mux inputs ---
PA<=P+A;
PS<=P+S;
sel<=P(1 downto 0);

--- create mux 4x1 ---
mux1: mux4X1 GENERIC MAP(n=>2*n+1)PORT MAP (sel,P,PA,PS,P,muxOut);
muxResult <=muxOut(2*n downto 2*n) & muxOut(2*n downto 1); --1 bit shifter to the right

--- create mux 2x1 ---
mux2: mux2X1 GENERIC MAP(n=>2*n+1)PORT MAP (c,P,muxResult,dffInp);

--- create counter ---
count:mCounter GENERIC MAP(n=>3)PORT MAP (enableOp,conv,'0',clk,counterOut);
--- create dff ---
dff:my_nDFF GENERIC MAP (n=>2*n+1) PORT MAP(clk,'0',dffEn,dffInp,dffOut);




  
  
END my_multiplier;