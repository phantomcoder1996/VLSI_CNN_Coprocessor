
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity counter is
generic(n:integer :=7);
port(
clk: in std_logic;

counterout: out std_logic_vector(n-1 downto 0);

rst:in std_logic;



en: in std_logic

);


end entity;

Architecture counterArch of counter is
signal count: integer := 0;

begin

process(clk,rst) is
begin

if rst = '1' then
   count<=0; --asynch reset
elsif(rising_edge(clk)) then
   if  en='1' then
   
       count<=(count+1);
   end if;
end if;


end process;

counterout<=std_logic_vector(to_unsigned(count,counterout'length));


end counterArch;