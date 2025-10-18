
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};

diff_style = 
	{["off_line_color"] = "000",
        ["line_color"] = "f30",
        ["line_width"] = "2"};	


line_style = 
	{["line_color"] = "0cf",
        ["line_width"] = "2.5"};			

text_style = {["font_size"] = "14"}

dim = 12
ind = math.random(4)

  results = ""

  if (ind == 1) then
      results = "result[0] == 0 && result[1] == 1 && result[2] == 1 && result[3] == 0"
  end
  if (ind == 2) then
	  results = "result[0] == 0 && result[1] == 1 && result[2] == 0 && result[3] == 1"
  end
  if (ind == 3) then
      results = "result[0] == 1 && result[1] == 0 && result[2] == 0 && result[3] == 1"
  end
  if (ind == 4) then		  
      results = "result[0] == 1 && result[1] == 0 && result[2] == 1 && result[3] == 0"
  end

mycanvas = function()
	  
  lib.start_canvas(200, 200, "center", results)
  
  wx = math.floor(200/dim)  
  ow = 10

  lib.add_line(ow+10*wx, ow+6*wx, -8*wx, 4*wx, diff_style, false, true)	  
  lib.add_line(ow+10*wx, ow+6*wx, -8*wx, 0, diff_style, false, true)
  lib.add_line(ow+2*wx, ow+2*wx, 0, 8*wx, diff_style, false, true)
  lib.add_line(ow+2*wx, ow+2*wx, 3*wx+4, 6*wx+8, diff_style, false, true)
  
  lib.add_line(ow+2*wx, ow+2*wx, 6*wx, 0, line_style, false, false)
  lib.add_line(ow+8*wx, ow+2*wx, 2*wx, 4*wx, line_style, false, false)
 
  for i = 2,dim do
     lib.add_line(ow+(i-1)*wx, ow, 0, dim*wx, style, false, false)
  end
  for i = 2,dim do
    lib.add_line(ow, ow+(i-1)*wx, dim*wx, 0, style, false, false)
  end 

  lib.add_input(ow+4*wx, ow+wx/2, 50, 30, "a")
  lib.add_input(ow+8*wx, ow+3*wx, 50, 30, "b")

  lib.end_canvas()
end   
            