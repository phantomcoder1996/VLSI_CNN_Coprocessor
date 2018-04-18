Library ieee;
use ieee.std_logic_1164.all;

entity DMATestBench is

end entity;


Architecture DMAArch of DMATestBench is

Signal clk,rst,start,conv,size,stride,opfinished: std_logic;
Signal AcceleratorOutput:std_logic_vector(7 downto 0);
Signal AcceleratorWR:std_logic;
signal port1,port2,port3,port4,port5,port6,port7,port8,port9,port10: std_logic_vector(39 downto 0);


constant clockperiod : time:=10 ns;
begin

RamCache: entity work.ramCacheInterface port map(clk,rst,start,conv,size,stride,opfinished,AcceleratorOutput,AcceleratorWR,port1,port2,port3,port4,port5,port6,port7,port8,port9,port10);

process
begin
clk<='0';
wait for clockperiod/2;
clk<='1';
wait for clockperiod/2;
end process;


process

begin

rst<='1';
start<='1';
conv<='1';
size<='1';
stride<='0';
opfinished<='0';
AcceleratorWr<='0';

wait for clockperiod;

rst<='0';

wait for clockperiod;

start<='0';

wait for 5*clockperiod;

Acceleratorwr<='1';
opfinished<='1';

wait for clockperiod;

Acceleratorwr<='0';

wait for clockperiod;








end process;
 






end DMAArch;
