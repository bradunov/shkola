
style = 
	{["off_color"] = "fff",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "1"}

estim = {}
out= {""}
index = {}
dif = {}
dim = 7

for i = 1,5 do
	index[i] = i-1
end 
dif = lib.math.random_shuffle(index)

numb1 = 200 + math.random(99)
numb2 = 50 + math.random(49)
if (numb2 == lib.math.gcd(numb1, numb2)) then
	numb2 = numb2 + 3
end	

quot = numb1/numb2
 
estim[1] = lib.math.round(quot)
estim[2] = math.ceil(quot) 
if (estim[2] == estim[1]) then
    estim[2] = estim[2] + 1
end	
estim[3] = math.floor(quot)
if (estim[3] == estim[1]) then
    estim[3] = estim[3] - 1
end	
estim[4] = lib.math.round_dec(quot, 1)


for i = 4,dim do
	sign = math.random(2)
	if (sign == 1) then	
		estim[i] = estim[4] + 0.3 * dif[i-3]
	else
		estim[i] = estim[4] - 0.3 * dif[i-3]	
	end
	estim[i] = lib.math.round_dec(estim[i],1)
    if (i > 3) then
	    for j = 1,i do
		    if (estim[i] == estim[j]) then
			    estim[i] = estim[i] - 0.7
	if (estim[i] < 0) then
		estim[i] = 0.3
	end
	            estim[i] = lib.math.round_dec(estim[i],1)
            end	
        end
    end			     
end
  
estim = lib.math.random_shuffle(estim)
bound = math.abs (quot - estim[1])
out[1] = lib.dec_to_str(estim[1])
sg = 1
for i = 2,dim do
    if (math.abs (quot - estim[i]) < bound) then
		bound = math.abs (quot - estim[i])	
		sg = i
	end
	out[i] = lib.dec_to_str(estim[i])
end


results = ""

  for i = 1, dim do
      if i > 1 then
         results = results .. " && "
      end
      results = results .. "result[" .. tostring(i-1) .. "] == "
      if (i == sg ) then
          results = results .. "1"
      else
          results = results .. "0"
      end	
  end
  
mycanvas = function(no)  

 lib.start_canvas(280, 80, "center", results)
 
    w = 40
    ow = 50
    v = 5
	
	for i = 1,dim do
	    lib.add_input((i-1)*w, 2*v, 50, 30, out[i])
		lib.add_circle (5*v+(i-1)*w, 2*v+ow, 5, style, false, true)
	end
  
    lib.end_canvas()
end           