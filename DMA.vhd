-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
Entity DMA is
port(
start: in std_logic;
conv:in std_logic;
size: in std_logic;

ramdatain: in std_logic_vector(39 downto 0);
cachedataout: out std_logic_vector(39 downto 0);
cachedatain: in std_logic_vector(7 downto 0);
ramdataout: out std_logic_vector(7 downto 0);
ramAddress: out std_logic_vector(17 downto 0);
cacheAddress:out std_logic_vector(3 downto 0);
--Signals
wrRam: out std_logic;
wrcache: out std_logic;
rdRam: out std_logic;
rdcache: out std_logic;

opFinished: in std_logic;--Signal from mu;tiplier or adder
--to indicate that the operation has finished

Stride: in std_logic;

clk: in std_logic;
rst: in std_logic;
 
oprEN : out std_logic

);
end entity;

Architecture DMA_Arch of DMA is

Type State is ( readFilter,readwindow,writeresult,openable,done);

Signal dmaState : state;
Signal counterout: std_logic_vector(2 downto 0);
Signal counterRst,counterEn:std_logic;

Signal baseAddressCounterOut: std_logic_vector(15 downto 0);
Signal baseAddressCounterRst,baseAddressCounterEn: std_logic;

Signal windowoffset: std_logic_vector(17 downto 0);

--Constant filterAdd: integer := 131073; --2^17+1
--Constant writeoffset: integer:=65536; --2^16
--Constant imageAdd: integer:=0;

Constant filterAdd: std_logic_vector(17 downto 0):=(0=>'1',17=>'1',others=>'0');
Constant writeoffset:  std_logic_vector(17 downto 0):=(16=>'1',others=>'0');
Constant imageAdd:  std_logic_vector(17 downto 0):=(others=>'0');
Constant endOfCount1:std_logic_vector(15 downto 0):=(others=>'1');
Constant endOFCount2:std_logic_vector(15 downto 0):=(0=>'0',others=>'1');
Constant six:std_logic_vector(3 downto 0):="0110";
Constant five:std_logic_vector(3 downto 0):="0101";
Constant one: std_logic_vector(2 downto 0):="001";
Constant two: std_logic_vector(2 downto 0):="010";


Signal endOfCount:std_logic_vector(15 downto 0);
Signal ramreadaddress: std_logic_vector(17 downto 0);
Signal startNO:std_logic_vector(3 downto 0);



Signal filterDone: std_logic:='0';
Signal windowRead: std_logic:='0';
Signal imageRead: std_logic:='0';

Signal windowSize: std_logic_vector(2 downto 0);
Signal endOfWindow: std_logic_vector(2 downto 0);
Signal endOfWindow2: std_logic_vector(2 downto 0);



constant  startofcount: std_logic_vector(15 downto 0):=(others=>'0');
constant firstRowoffset: std_logic_vector(17 downto 0):=(others=>'0');
constant secondRowoffset: std_logic_vector(17 downto 0):=(8=>'1',others=>'0');
constant thirdRowoffset: std_logic_vector(17 downto 0):=(8=>'1',9=>'1',others=>'0');
constant fourthRowoffset: std_logic_vector(17 downto 0):=(10=>'1',others=>'0');
constant fifthRowoffset: std_logic_vector(17 downto 0):=(10=>'1',8=>'1',others=>'0');

begin


windowCounter:entity work.counter generic map(n=>3) port map(clk,counterout,counterRst,CounterEn);
BaseAddressCounter: entity work.Stridecounter generic map(n=>16) port map(clk,baseAddressCounterOut,baseAddressCounterRst,baseAddressCounterEn,stride);

DMATempRegister: entity work.nbitregisterf generic map(n=>40) port map(ramdatain,rst,clk,'1',cacheDataOut);

DMATempWriteRegister: entity work.nbitregisterf generic map(n=>8) port map(cachedatain,rst,clk,'1',ramdataout);
process(clk,rst)
begin

--start shall be given as a pulse for this to work

if(start='1' and conv='0') then  --------------CONVOLUTRION WLAHY
dmaState<= readfilter;

elsif(start='1' and conv='1') then 
dmaState<= readWindow;

elsif(rising_edge(clk)) then

case dmaState is

when readfilter =>
 	if(filterdone='1') then
		dmaState<=readwindow;
	end if;

when readWindow=>
	if(windowRead='1') then
		dmaState<=openable;
	end if;

when openable=>
	if(opfinished='1') then
		dmaState<=writeresult;
	else oprEN<= '1';
	end if;

	

when writeresult=>
	if(imageRead='1') then
		dmaState<=done;
	else
		dmaState<=readWindow;
	end if;
when others=>
		dmaState<=done;
end case;

end if;
	
end process;

--Signals control

windowsize<="101" when size='1' else "011";
filterDone<='1' when dmaState=readfilter and counterout=windowsize else '0';
--windowread<='1' when dmaState=readWindow and counterout=endofwindow2 else '0';
windowread<='1' when ((dmaState=readWindow and baseAddressCounterout=startofcount and conv='1' and counterout=windowsize)or(dmaState=readWindow and counterout=endofwindow2 and baseAddressCounterout/=startofcount))
 else '0';
imageRead<='1' when  baseAddressCounterout=endofCount
else '0';
endOfWindow<= std_logic_vector(unsigned(windowsize)+unsigned(one));
endOfWindow2<= std_logic_vector(unsigned(windowsize)-unsigned(one));
--Output signals
wrRam<='1' when dmastate=writeResult
else '0';

WrCache<='1' when (dmastate=readfilter or dmastate=readwindow)
else '0';

rdRam<='1' when dmastate=readfilter or dmastate=readwindow
else '0';

rdCache<='1' when dmastate=writeResult
else '0';

--cacheDataout<=RamDatain;
--ramDataout<=CacheDataIn;

windowoffset<=firstrowoffset when counterout="001" and dmastate=readFilter  
	else secondrowoffset when counterout="010" and dmastate=readFilter
        else thirdrowoffset when counterout="011" and dmastate=readFilter
        else fourthrowoffset when counterout="100" and dmastate=readFilter
	else fifthrowoffset when counterout="101" and dmastate=readFilter

        else firstrowoffset when counterout="001"  and dmastate=readWindow  and conv='1'  and baseAddressCounterOut=startofcount
	else secondrowoffset when counterout="010" and dmastate=readWindow  and conv='1' and baseAddressCounterOut=startofcount
        else thirdrowoffset when counterout="011"  and dmastate=readWindow  and conv='1'  and baseAddressCounterOut=startofcount
        else fourthrowoffset when counterout="100" and dmastate=readWindow  and conv='1' and baseAddressCounterOut=startofcount
	else fifthrowoffset when counterout="101"  and dmastate=readWindow  and conv='1'  and baseAddressCounterOut=startofcount


        else firstrowoffset when counterout="000" and dmastate=readWindow 
	else secondrowoffset when counterout="001" and dmastate=readWindow 
        else thirdrowoffset when counterout="010" and dmastate=readWindow 
        else fourthrowoffset when counterout="011" and dmastate=readWindow 
	else fifthrowoffset when counterout="100" and dmastate=readWindow 

        else (others=>'0');



ramreadaddress<=std_logic_vector(unsigned(filteradd)+unsigned(windowoffset)) when dmastate=readfilter
else  std_logic_vector(unsigned("00"&baseAddressCounterOut)+unsigned(windowoffset)) when dmastate=readwindow;

--ToDO ramaddress and counter enables equations as well as cache address

ramaddress<=std_logic_vector(unsigned(ramreadaddress)+unsigned(writeoffset)) when dmastate=writeresult
else ramreadaddress;

counterEn<='1' when dmastate=readwindow or dmastate=readfilter
else '0';

BaseAddresscounterEN<='1' when dmastate=writeResult
else '0';

counterRst<='1' when (counterOut=endOfWindow and dmastate=readwindow )or (counterOut=windowsize and dmastate=openable) or dmastate=done else '0';
BaseAddressCounterRst<='1' when dmaState=done or rst='1' else '0';

startNO<= five when conv='1' and baseAddressCounterOut=startofcount
else six;

cacheAddress<=('0'&counterout) when dmaState=readfilter
else std_logic_vector(unsigned('0'&counterout)+unsigned(startNO)) when dmaState=readWindow ------------------------five 
else "0000" when dmaState=writeResult
else "0000";

endOfCount<=endofCount1 when stride='0' else endofCount2;
--Stride 0 means no stride
end DMA_Arch;






