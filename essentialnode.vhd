library ieee;
use ieee.std_logic_1164.all;
-- this the essentialnode is carring the initial state of the adder 
-- its input is the first input carry 
 
entity essentialnode is 
port (
-- node input terminal 
x : IN std_logic ;
-- node input terminal 
y : IN std_logic ;
-- g output terminlal of node 
g : OUT std_logic ;
-- P output terminal  of node 
p : OUT std_logic 
);
end essentialnode;

architecture behaviour of essentialnode is 
begin 
g <= x and y;
p <= x xor y;
end behaviour;