 
number = {}
termx = ""
terminx = ""
free = "" 

for i = 1,3 do
    number[i] = num[i]
end	
termx = partx
terminx = partinx

operqu = opqu
opercont = opcont
if (opqu < 3) then
	op = math.random(2)
else
	op = 2 + math.random(2)
end  

ch = -1 + math.random(3)       --[[ ch = 0 num[i], ch=1  num[i]= -num[3]*num[i], ch=2  num[i]= num[3]*num[i], i=1,2]]--
if (ch > 0) then
	number[3] = 1 + math.random(4)
	if (ch == 1) then
		number[3] = - number[3]
		operqu = opcont
		opercont = opqu		
	end	
	for i = 1,2 do
		number[i] = number[3] * num[i]	
	end	
	termx = number[1] .. " x "
	terminx = -number[1] .. " x "		
end

if (ind[ITEM] == 1) then
	if (number[2] ~= 0) then
        mod = math.random(8)		
		if (mod < 5) then
			free = -number[2]
			if (op == operqu) then
				reply[ITEM] = msg[1]
			else
				reply[ITEM] = msg[2]		
			end
		else	
			free = number[2]
			reply[ITEM] = msg[2]			
		end	
		ineq[ITEM] = termx .. rel[op] .. free
	else
	    mod = math.random(4)
	    free = 0
		if (op == opercont) then
			reply[ITEM] = msg[1]
		else
			reply[ITEM] = msg[2]		
		end
		ineq[ITEM] = terminx .. rel[op] .. free	
	end	
end  
 
if (ind[ITEM] == 2) then
    mod = math.random(8)	
	if (mod < 5) then
		free = number[2]	
		if (op == opercont) then
			reply[ITEM] = msg[1]
		else
			reply[ITEM] = msg[2]		
		end
	else
		free = -number[2]
		if (number[2] == 0 and op == opercont) then
			reply[ITEM] = msg[1]
		else
			reply[ITEM] = msg[2]		
		end
    end	
	ineq[ITEM] = terminx .. rel[op] .. free
end 
  
if (ind[ITEM] == 3) then
    mod = math.random(8)
	free = number[2]
	if (mod < 5) then
		if (op == operqu) then
		    reply[ITEM] = msg[1]
		else
		    reply[ITEM] = msg[2]		
	    end
		ineq[ITEM] = free .. rel[op] .. terminx		
	else
		if (number[2] == 0 and op == opercont) then
			reply[ITEM] = msg[1]
		else
			reply[ITEM] = msg[2]		
		end		
		ineq[ITEM] = free  .. rel[op] .. termx			
	end	
end   

if (ind[ITEM] == 4) then
    mod = math.random(8)
	free = - number[2]
	if (mod < 5) then
		if (op == opercont) then
		    reply[ITEM] = msg[1]
		else
		    reply[ITEM] = msg[2]		
	    end
		ineq[ITEM] = free .. rel[op] .. termx		
	else
		if (number[2] == 0 and op == operqu) then
			reply[ITEM] = msg[1]
		else
			reply[ITEM] = msg[2]		
		end		
		ineq[ITEM] = free  .. rel[op] .. terminx			
	end	
end   