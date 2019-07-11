# Kogge-Stone-Adder
16 Bit Adder 
this adder uses Kogge Stone Algorithm 
the idea here we have 
essential node thats initialize the adder 
dynamic node this node varies each state it takes p,g and generate new p,g 
for the essential node p , g equation 
g = a AND b
////////////////
p = a XOR b
///////////////
for the dynamic node 
//////////////
g = g1 + p1 g0
//////////////
p = p1 p0
///////////////
the carrier equation 
///////////////
c0= g0 + p0 g0
//////////////
c1= g1 + p1 c0 
//////////////
and so on 
//////////////
for the summation equation 
//////////////
a XOR b XOR c 
//////////////
the input carrier equlal zero 
