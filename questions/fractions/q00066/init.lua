
style = 
	{["off_color"] = "fff",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "1"}

number = {7, 8, 9}
trace = {1, 0.1, 0.01}
dgr = {}
out = {}
res = {}

for i = 1,3 do
    dgr[i] = 10^(-i)	
end
for j = 1,3 do
    for i = 1,3 do
		k = (j-1)*3+i
		out[k] = number[j] * dgr[i]
		out[k] = lib.math.round_dec(out[k], i)
	end
end	 
ind = math.random(3)
ch = math.random(3)
sol1 = out[(ch-1)*3+ind]
nr = 9
for k = 1,9 do
	i = k - 3*math.floor((k-1)/3)
	if (i ~= ind) then 
		nr = nr + 1	
		out[nr] = trace[i] - out[k]	
		out[nr] = lib.math.round_dec(out[nr], i)		
	else 	
		if (out[k] == sol1) then
			nr = nr + 1	
			out[nr] = trace[i] - out[k]			
			out[nr] = lib.math.round_dec(out[nr], i)			
			sol2 = out[nr]	
		else
			op = math.random(2)
			if (op == 1) then
				out[k] = trace[i] - out[k]	
				out[k] = lib.math.round_dec(out[k], i)				
			end
		end
	end
end

res = lib.math.random_shuffle(out)            

stampa = 12
sg1 = 0
sg2 = 0
for i = 1,18 do
    if (res[i] == sol1) then 
	    sg1 = i
	    if (i > stampa) then		
			sg1 = i - stampa
		end
	end
    if (res[i] == sol2) then 
		sg2 = i
		if (i > stampa) then		
			sg2 = i - stampa
		end
	end
end
if (sg1 > 0) then	
	res[sg1] = sol1
end
if (sg2 > 0) then	
	res[sg2] = sol2
end
            
results = ""

for i = 1, stampa do
	if i > 1 then
	 results = results .. " && "
	end
	results = results .. "result[" .. tostring(i-1) .. "] == "
	if (i == sg1 or i == sg2) then
	  results = results .. "1"
	else
	  results = results .. "0"
	end	
end
  
mycanvas = function(no)  

 lib.start_canvas(300, 140, "center", results)
 
    w = 40
    ow = 50
    v = 5
    par = math.ceil(stampa/2)	
	for i = 1,stampa do
		if (i > par) then 
			lib.add_input((i-par-1)*ow, 2*w, 50, 30, tostring(res[i]))
			lib.add_circle (5*v+(i-par-1)*ow, 3*w-v, 6, style, false, true)
		else
			lib.add_input((i-1)*ow, 2*v, 50, 30, tostring(res[i]))
			lib.add_circle (5*v+(i-1)*ow, w, 6, style, false, true)
		end
	end
  
    lib.end_canvas()
end          
       