
include("shapes")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "2"};

diff_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "c60",
        ["line_width"] = "2"};

text_style = {["font_size"] = "40",
             ["line_width"] = "0.5"}

out = {}
index = {}
for i = 1,6 do 
    index[i] = i
end
out = lib.math.random_shuffle(index)	
out[7] = out[1]
out[8] = out[2]


mycanvas = function()

  ind = math.random(5)

  results = ""

  for i = 1, 6 do
	if i > 1 then
		results = results .. " && "
	end
	results = results .. "result[" .. tostring(i-1) .. "] == "
	if (i == out[3]) then
	  results = results .. "1"
	else
	  results = results .. "0"
	end
  end
  
  lib.start_canvas(350, 150, "center", results)

  v = 5
  w = 10
  ow = 30

 
  scale = 0.7

  y = ow
  d = 7*ow-v
  x = 0
  for i = 1,8 do
    x = x + ow
    if (out[i] == 4) then 
		x = x + v
     lib.add_triangle (x, y, 30, 30, diff_style, false, false)
	 	x = x + v
	end	 
    if (out[i] == 6) then	
		 	x = x + v
     heart(lib, x, y+w, scale, diff_style, false, false)
	end	 
    if (out[i] == 3) then 
	x = x + v
     lib.add_circle (x +v, y, 15, diff_style, false, false)
	 	x = x + v
	end	 
    if (out[i] == 5) then 
	 	 	x = x - v
     cross(lib, x , y-v, scale, diff_style, false, false)
	 	 	x = x + w
	end	 
    if (out[i] == 1) then 

     lib.add_rectangle (x , y-w-v, 30, 30, diff_style, false, false)
	x = x + w+v	 
	end
    if (out[i] == 2) then 
	 	 	x = x - v
     diamond(lib, x , y, scale, diff_style, false, false)
	 	 	x = x + w
	end

   end	 
 
   y = 4*ow
   lib.add_rectangle (ow, y-w-v, 30, 30, style, false, true)
   diamond(lib, 3*ow, y, scale, style, false, true)
   lib.add_circle (5*ow, y, 15, style, false, true )
   lib.add_triangle (7*ow, y, 30, 30, style, false, true)
   cross(lib, 8*ow, y-v, scale, style, false, true)	  
   heart(lib, 10*ow, y+w, scale, style, false, true)

   lib.end_canvas()
end                                  
                  