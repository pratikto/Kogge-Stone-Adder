library ieee;
use ieee.std_logic_1164.all;

---------------------------------------------
-- Kogge Stone 16 bit Adder 
----------------------------------------------
entity KSA is 
port (
-- first number we want to add
x : IN std_logic_vector (15 downto 0);
-- second number we want to add 
y : IN std_logic_vector (15 downto 0);
-- essential input carry 
cin     : IN std_logic;
-- the summation 
sum    : OUT std_logic_vector (15 downto 0);
-- the output carry 
cout   : OUT std_logic 
);
end KSA;
architecture behaviour of KSA is 
-- here is the essential node of the adder 
---------------------------------------------
component essentialnode is 
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
end component;
----------------------------------------------
-- the dynamic node which change and get the previous p and g and give new state 
----------------------------------------------
component dynamicnode is 
port (
-- node inputs terminals 
Pprevious : IN std_logic ;
Gprevious : IN std_logic ;
pcurrent  : IN std_logic ;
gcurrent  : IN std_logic ;
-- node outputs terminals 
pout : OUT std_logic ;
gout : OUT std_logic 
);
end component;
-----------------------------------------------
-- internal p , g signal 
signal gin : std_logic_vector (15 downto 0);
signal pin : std_logic_vector (15 downto 0);
--  we will specify the output of each Kogge Stone stage
--stage 1
SIGNAL g_1 : std_logic_vector(15 downto 0);
SIGNAL p_1 : std_logic_vector(15 downto 0);
--stage 2
SIGNAL g_2 : std_logic_vector(15 downto 0);
SIGNAL p_2 : std_logic_vector(15 downto 0);
--stage 3
SIGNAL g_3 : std_logic_vector(15 downto 0);
SIGNAL p_3 : std_logic_vector(15 downto 0);
--stage 4
SIGNAL g_4 : std_logic_vector(15 downto 0);
SIGNAL p_4 : std_logic_vector(15 downto 0);
----------------------------------------------
-- the internal carrier  
signal c    : std_logic_vector (15 downto 0);
begin

-- here is the essential node and we will generate the desired signal 
essentialstage : 
	for i in 0 to 15 generate
		state : essentialnode port map (x => x(i),y => y(i),g => gin(i),p => pin(i));
	end generate;
-- this design is multiple stage 
-- stage 1
-- carry operation for for saving first bit 
g_1(0) <= gin(0);
p_1(0) <= pin(0);
stage1 :
	for i in 0 to 14 generate
		state : dynamicnode port map (Gprevious => gin(i),Pprevious => pin(i),gcurrent => gin(i+1),pcurrent => pin(i+1) ,gout => g_1(i+1) ,pout => p_1(i+1));
	end generate;
-- stage 2
-- carry operation for stage2
buffar1:
	for i in 0 to 1 generate
		g_2(i) <= g_1(i);
		p_2(i) <= p_1(i);
	end generate;
stage2 :
	for i in 0 to 13 generate
		state : dynamicnode port map (Gprevious => g_1(i),Pprevious => p_1(i),gcurrent => g_1(i+2),pcurrent => p_1(i+2) ,gout => g_2(i+2) ,pout => p_2(i+2));
	end generate;
-- stage 3
-- carry operation for stage3
buffar2:
	for i in 0 to 3 generate
		g_3(i) <= g_2(i);
		p_3(i) <= p_2(i);
	end generate;
stage3 :
	for i in 0 to 11 generate
		state : dynamicnode port map (Gprevious => g_2(i),Pprevious => p_2(i),gcurrent => g_2(i+4),pcurrent => p_2(i+4) ,gout => g_3(i+4) ,pout => p_3(i+4));
	end generate;	
-- stage 4
-- carry operation for stage4
buffar3:
	for i in 0 to 15 generate
		g_4(i) <= g_3(i);
		p_4(i) <= p_3(i);
	end generate;
--stage4 :
	--for i in 0 to 15 generate
		--state : dynamicnode port map (Gprevious => g_3(i),Pprevious => p_3(i),gcurrent => g_3(i+8),pcurrent => p_3(i+8) ,gout => g_4(i+8) ,pout => p_4(i+8));
	--end generate;
-- here is the part we generate the carry 
CarryGeneration :
	for i in 0 to 15 generate
		c(i) <= g_4(i) or (cin and p_4(i));
	end generate;
cout <= c(15);
----------------------------------------------
-- in this part we will  write the summation function and how we get it 
----------------------------------------------
sum(0) <= cin xor pin(0);
summation :
	for i in 1 to 15 generate
		sum(i) <= c(i-1) xor pin(i);
	end generate;

end behaviour;