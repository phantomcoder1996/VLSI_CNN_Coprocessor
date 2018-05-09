Library ieee;
use ieee.std_logic_1164.all;

Entity RamCacheInterface is


Port(

clk: in std_logic;
rst: in std_logic;

Start: in std_logic;
conv: in std_logic;
size: in std_logic;
stride: in std_logic

);

end entity;



Architecture RamCacheInterfaceArch of RamCacheInterface is

--------------------COMPONETS--------------------------

COMPONENT Accelerator is

Port(
clk:in std_logic;

port1: in std_logic_vector(39 downto 0);
port2: in std_logic_vector(39 downto 0);
port3: in std_logic_vector(39 downto 0);
port4: in std_logic_vector(39 downto 0);
port5: in std_logic_vector(39 downto 0);
port6: in std_logic_vector(39 downto 0);
port7: in std_logic_vector(39 downto 0);
port8: in std_logic_vector(39 downto 0);
port9: in std_logic_vector(39 downto 0);
port10: in std_logic_vector(39 downto 0);

opFinished: out std_logic;


AcceleratorOutput: out std_logic_vector(7 downto 0);

AcceleratorWr    :inout std_logic;

conv:in std_logic;

size: in std_logic;

enableOp: in std_logic

);

end COMPONENT;

COMPONENT ram IS
	PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		address : IN  std_logic_vector(17 DOWNTO 0);
		datain  : IN  std_logic_vector(7 DOWNTO 0);
		dataout : OUT std_logic_vector(39 DOWNTO 0));
END COMPONENT;

COMPONENT cache2 is 
port(
DataFromRam: in std_logic_vector(39 downto 0); --input from DMA
DataFromAccelerator: in std_logic_vector(7 downto 0); --input from accelerator

DataOut: out std_logic_vector(7 downto 0); --input TO DMA
port1:out std_logic_vector(39 downto 0);
port2:out std_logic_vector(39 downto 0);
port3:out std_logic_vector(39 downto 0);
port4:out std_logic_vector(39 downto 0);
port5:out std_logic_vector(39 downto 0);
port6:out std_logic_vector(39 downto 0);
port7:out std_logic_vector(39 downto 0);
port8:out std_logic_vector(39 downto 0);
port9:out std_logic_vector(39 downto 0);
port10:out std_logic_vector(39 downto 0);

cacheAddress:in std_logic_vector(3 downto 0);
rd:in std_logic;
wr: in std_logic;

rst:in std_logic;

clk:in std_logic
);

end COMPONENT;

---------------------SIGNALS----------------------------
Signal ramdataoutput: std_logic_vector(39 downto 0);
Signal cacheDataInput: std_logic_vector(39 downto 0);
Signal ramDataInput: std_logic_vector(7 downto 0);
Signal cacheDataOut: std_logic_vector(7 downto 0);
Signal ramAddress: std_logic_vector(17 downto 0);
Signal cacheAddress: std_logic_vector(3 downto 0);
Signal wrRam: std_logic;
Signal wrCache: std_logic;
Signal rdRam: std_logic;
Signal rdCache: std_logic;
Signal DMAWRcache:std_logic;
Signal oprENACC:std_logic;

Signal AccOutput: std_logic_vector(7 downto 0);
---------------------------------------------------------

Signal opFinished: std_logic; --Signal from accelerator to indicate that the operation
--has finished

Signal AcceleratorOutput: std_logic_vector(7 downto 0);

Signal AcceleratorWr    : std_logic;

--ports to be connected to the accelerator
------------------------------------------
Signal port1:   std_logic_vector(39 downto 0);
Signal port2:   std_logic_vector(39 downto 0);
Signal port3:   std_logic_vector(39 downto 0);
Signal port4:   std_logic_vector(39 downto 0);
Signal port5:   std_logic_vector(39 downto 0);
Signal port6:   std_logic_vector(39 downto 0);
Signal port7:   std_logic_vector(39 downto 0);
Signal port8:   std_logic_vector(39 downto 0);
Signal port9:   std_logic_vector(39 downto 0);
Signal port10:  std_logic_vector(39 downto 0);

---------------------------------------------------------
begin

wrCache<= DMAWRcache or AcceleratorWr;

DMA: entity work.DMA port map(
start,
Conv,
Size,
ramdataoutput,
cacheDatainput,
cacheDataOut,
ramDataInput,
ramAddress,
CacheAddress,
wrRam,
DMAwrCache,
rdRam,
rdCache,
opfinished,
stride,
clk,
rst,
oprENACC
);

--Ram: entity work.Ram port map(clk,wrRam,ramAddress,ramDataInput,ramDataOutput);

myRam: Ram port map(clk,wrRam,ramAddress,ramDataInput,ramDataOutput);

myCache: cache2 port map(cacheDatainput,AcceleratorOutput,cacheDataOut,
port1,
port2,
port3,
port4,
port5,
port6,
port7,
port8,
port9,
port10,
cacheAddress,
rdCache,
WrCache,
rst,
clk
);


myACC: Accelerator Port map(
clk,
port1,
port2,
port3,
port4,
port5,
port6,
port7,
port8,
port9,
port10,
opFinished,
AcceleratorOutput,
AcceleratorWr  ,
conv,
size,
oprENACC

);
 
--------------opFinishedACC
--------------AccWr    :out std_logic;  w out

end RamCacheInterfaceArch; 

