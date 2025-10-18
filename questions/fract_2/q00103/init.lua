
include("names")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "1"}

r = math.random(#zensko_ime_nom)
name = zensko_ime_nom[r] 

numb = {}
dif = {}
index = {}
dim = 7
for i = 1,9 do
	index[i] = i
end 
dif = lib.math.random_shuffle(index)

number = 445 + math.random(24)
for i = 1,dim do
	sign = math.random(2)
	if (sign == 1) then	
		numb[i] = number + dif[i]
	else
		numb[i] = number - dif[i]	
	end
numb[i] = lib.math.round(numb[i])		
end
number = lib.math.round_dec(number/100,1)

results = ""

for i = 1, dim do
	if i > 1 then
		results = results .. " && "
	end
	results = results .. "result[" .. tostring(i-1) .. "] == "
	if (math.abs (numb[i]-number*100) <= 5 ) then
		if (math.abs (numb[i]-number*100) == 5 ) then
			bound = math.floor(numb[i] / 10)
			if (bound == 2*math.floor(bound/2) ) then
			  results = results .. "1"
			else
			  results = results .. "0"
			end	
		else	
			 results = results .. "1"
		end
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
	    lib.add_input(v+(i-1)*w, 2*v, 50, 30, tostring(numb[i]))
		lib.add_circle (6*v+(i-1)*w, 2*v+ow, 5, style, false, true)
	end
  
    lib.end_canvas()
end           
         