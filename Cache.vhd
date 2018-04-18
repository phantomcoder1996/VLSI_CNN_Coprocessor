Library ieee;
use ieee.std_logic_1164.all;

Entity cache is 
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

end entity;

Architecture cachearch of cache is

Signal decoderout: std_logic_vector(15 downto 0);
Signal decoderen: std_logic;
begin

decoderen<= rd or wr;
addressDecoder: entity work.decoder generic map(n=>4) port map(decoderen,cacheaddress,decoderout);
g1:entity work.registerblock port map( decoderout(1),DataFromRam,port1,rd,rst,clk);
g2:entity work.registerblock port map( decoderout(2),DataFromRam,port2,rd,rst,clk);
g3:entity work.registerblock port map( decoderout(3),DataFromRam,port3,rd,rst,clk);
g4:entity work.registerblock port map( decoderout(4),DataFromRam,port4,rd,rst,clk);
g5:entity work.registerblock port map( decoderout(5),DataFromRam,port5,rd,rst,clk);
g6:entity work.registerblock port map( decoderout(6),DataFromRam,port6,rd,rst,clk);
g7:entity work.registerblock port map( decoderout(7),DataFromRam,port7,rd,rst,clk);
g8:entity work.registerblock port map( decoderout(8),DataFromRam,port8,rd,rst,clk);
g9:entity work.registerblock port map( decoderout(9),DataFromRam,port9,rd,rst,clk);
g10:entity work.registerblock port map(decoderout(10),DataFromRam,port10,rd,rst,clk);

resultReg: entity work.nbitregister port map(datafromAccelerator,rst,clk, decoderout(11),dataout);










end cachearch;


