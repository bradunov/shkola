
style = 
	{["off_color"] = "000",
        ["on_color"] = "f00",
        ["line_color"] = "f00",
        ["off_line_color"] = "000",
        ["line_width"] = "3"};

line_style = 
	{["line_color"] = "0cf",
        ["line_width"] = "3"};		

grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};			

			
dot_style = {["font_size"] = "40"}		
text_style = {["font_size"] = "16"}	

name = {"AB", "CD", "EF", "GH", "JK"}
xpt = {1, 8, 9.7, 15, 8}	
ypt = {7, 1, 5, 7, 1}	
--[[
         1     2     3     4     5      		
]]--		  

out = {}

scal = 0.5 * math.random(4)
sign = math.random(2)       --[[ +numb / -numb]]--
if (sign == 2) then
    numb = - scal
else
    numb = scal
end	
if (numb == 1) then
    numb = -1
    sign = 2
end	

dir = math.random(2) 
if (dir == 1) then       --[[MN / NM ]]--
    vect = "MN"
else
    vect = "NM"	
end	


if (dir == sign) then
	value = name[2]
else	
	value = name[5]
end

out = lib.math.random_shuffle(name)

for i = 1,5 do
    if (out[i] == value) then
	    ind = i - 1
	end	
end		

  mycanvas = function()
  
  results = ""

  for i = 1, 5 do
      if i > 1 then
         results = results .. " && "
      end
      results = results .. "result[" .. tostring(i-1) .. "] == "
      if (dir == sign) then
          if (i == 2 ) then
              results = results .. "1"
          else
              results = results .. "0"
          end
      else
          if (i == 5 ) then
              results = results .. "1"
          else
              results = results .. "0"
          end    		
      end
  end

  
  lib.start_canvas(340, 300, "center", results)  
  
    w = 20
    ow = 10
    v = 5

    lib.add_text(w+ow, (7-2*scal)*w, ".", dot_style, false, false)
    lib.add_text(2*w, (7-2*scal)*w+ow, "B", text_style, false, false)
    lib.add_text(w+ow, (7+2*scal)*w, ".", dot_style, false, false)
    lib.add_text(2*w, (7+2*scal)*w, "A", text_style, false, false)
    lib.add_line(w+ow, (7-2*scal)*w+ow, 0, 4*scal*w, style, false, true)

    lib.add_text((8-2*scal)*w+ow, w, ".", dot_style, false, false)
    lib.add_text((8-2*scal)*w+ow, w, "C", text_style, false, false)
    lib.add_text((8+2*scal)*w+ow, w, ".", dot_style, false, false)
    lib.add_text((8+2*scal)*w+ow, w, "D", text_style, false, false)
    lib.add_line((8-2*scal)*w+ow, w+ow, 4*scal*w, 0, style, false, true)	

    lib.add_text((9.7-1.7*scal)*w+ow, (5+scal)*w, ".", dot_style, false, false)
    lib.add_text((9.7-1.7*scal)*w+ow, (5+scal)*w, "E", text_style, false, false)
    lib.add_text((9.7+1.7*scal)*w+ow, (5-scal)*w, ".", dot_style, false, false)
    lib.add_text((9.7+1.7*scal)*w+ow, (5-scal)*w, "F", text_style, false, false)
    lib.add_line((9.7-1.7*scal)*w+ow, (5+scal)*w+ow, 3.5*scal*w, -2*scal*w, style, false, true)
--[[	
    lib.add_text(8*w+ow, 6*w, ".", dot_style, false, false)
    lib.add_text(8*w+ow, 6*w, "E", text_style, false, false)
    lib.add_text(11.5*w+ow, 4*w, ".", dot_style, false, false)
    lib.add_text(11.5*w+ow, 4*w, "F", text_style, false, false)
    lib.add_line(8*w+ow, 6*w+ow, 3.5*w, -2*w, style, false, true)	
]]--
    lib.add_text(15*w+ow, (7-2*scal)*w, ".", dot_style, false, false)
    lib.add_text(15*w, (7-2*scal)*w+ow, "G", text_style, false, false)
    lib.add_text(15*w+ow, (7+2*scal)*w, ".", dot_style, false, false)
    lib.add_text(15*w, (7+2*scal)*w+ow, "H", text_style, false, false)
    lib.add_line(15*w+ow, (7-2*scal)*w+ow, 0, 4*scal*w, style, false, true)	
	
    lib.add_text((8-2*scal)*w+ow, 13*w, ".", dot_style, false, false)
    lib.add_text((8-2*scal)*w+ow, 13*w, "K", text_style, false, false)
    lib.add_text((8+2*scal)*w+ow, 13*w, ".", dot_style, false, false)
    lib.add_text((8+2*scal)*w+ow, 13*w, "J", text_style, false, false)
    lib.add_line((8-2*scal)*w+ow, 13*w+ow, 4*scal*w, 0, style, false, true)

    lib.add_text(4*w+ow, 10*w, ".", dot_style, false, false)
    lib.add_text(4*w+ow, 10*w, "M", text_style, false, false)
    lib.add_text(8*w+ow, 10*w, ".", dot_style, false, false)
    lib.add_text(8*w+ow, 10*w, "N", text_style, false, false)	
    lib.add_line(4*w+ow, 10*w+ow, 4*w, 0, line_style, true, false) 		

    for i = 1,15 do
        lib.add_line(ow, ow+(i-1)*w, 16*w, 0, grid_style, false, false)
    end
    for i = 1,17 do
        lib.add_line(ow+(i-1)*w, ow, 0, 14*w, grid_style, false, false)
    end		

	
  lib.end_canvas()
end       