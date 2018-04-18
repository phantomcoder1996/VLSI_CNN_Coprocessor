Library ieee;
use ieee.std_logic_1164.all;

Entity RegisterBlock is

Port(en: in std_logic;
     data: in std_logic_vector(39 downto 0);
     dataout: out std_logic_vector(39 downto  0);

     rd:in std_logic;
     rst:in std_logic;
     clk: in std_logic
	);
end Entity;

Architecture RegisterBlock_Arch of RegisterBlock is

begin

port1out: entity work.nbitregister generic map(n=>8) port map(data(7 downto 0),rst,clk,en,dataout(7 downto 0));
port2out: entity work.nbitregister generic map(n=>8) port map(data(15 downto 8),rst,clk,en,dataout(15 downto 8));
port3out: entity work.nbitregister generic map(n=>8) port map(data(23 downto 16),rst,clk,en,dataout(23 downto 16));
port4out: entity work.nbitregister generic map(n=>8) port map(data(31 downto 24),rst,clk,en,dataout(31 downto 24));
port5out: entity work.nbitregister generic map(n=>8) port map(data(39 downto 32),rst,clk,en,dataout(39 downto 32));


end Architecture;
     
     