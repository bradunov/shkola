
include("terms")

meas = {"m", "m²", "m³", "°"}  
slope = {30, 45}

ch = {}
edge = {}

ind = math.random(2)
ch[1] = math.random(2)
ch[2] = math.random(2)

if (ind == 1) then
	edge[1] = 4 + math.random(11)
	data = edge[1]
	if (ch[2] == 1) then
		edge[3] = edge[1] / (2* math.sqrt(3))
		edge[5] = edge[1] / math.sqrt(3)
	else
		edge[3] = edge[1] /2
		edge[5] = edge[1] / math.sqrt(2)
	end	    
else	
	edge[3] = 0.5 *(2 + math.random(7))
	data = edge[3]	
	if (ch[2] == 1) then
		edge[1] = 2 * edge[3] * math.sqrt(3)
		edge[5] = 2 * edge[3] 
	else
		edge[1] = 2 * edge[3] 
		edge[5] = edge[3] * math.sqrt(2)
	end	    
end	
if (ch[1] == ch[2]) then		
	edge[2] = edge[1]
	edge[4] = edge[5]
else
	if (ch[1] == 1) then
		edge[2] = 2*edge[3]*math.sqrt(3)      
		edge[4] = 2 * edge[3]		
	else
		edge[2] = 2 * edge[3]
		edge[4] = edge[3] * math.sqrt(2)	
	end
end

numb = 15 + math.random(10)
area = edge[1]*edge[4] + edge[2]*edge[5]
area = math.ceil(area * numb)

vol = edge[1] * edge[2] * edge[3] / 3		       
vol = lib.math.round_dec(vol, 1)            
         