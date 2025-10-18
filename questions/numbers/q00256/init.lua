
include("names")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "1"}

r = math.random(#zensko_ime_nom)
ime = zensko_ime_nom[r] 

customer = {}
dif = {}
index = {}
dim = 7
for i = 1,9 do
	index[i] = i
end 
dif = lib.math.random_shuffle(index)

number = 10 * (1 + math.random(8))
for i = 1,dim do
	sign = math.random(2)
	if (sign == 1) then	
		customer[i] = number + dif[i]
	else
		customer[i] = number - dif[i]	
	end
	customer[i] = lib.math.round(customer[i])
end

results = ""

  for i = 1, dim do
      if i > 1 then
         results = results .. " && "
      end
      results = results .. "result[" .. tostring(i-1) .. "] == "
      if (dif[i] <= 5 ) then
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
	    lib.add_input(v+(i-1)*w, 2*v, 50, 30, tostring(customer[i]))
		lib.add_circle (6*v+(i-1)*w, 2*v+ow, 5, style, false, true)
	end
  
    lib.end_canvas()
end           
         