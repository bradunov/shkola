
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}		

x = {}
y = {}
mark = {"a", "b", "c", "d"}
result = {6, 15, 10}

ow = 15
ov = 150

max = 3

y[1] = 2 + math.random(max) 
y[2] = (y[1] + 1 + math.random(8 - y[1])) 

for i = 1, 2 do
    temp = math.sqrt(1 - y[i]*y[i]/100)
	x[i] =  math.floor(temp * ov)
	y[i] = y[i] * ow
end	

ind = math.random(3)
value = result[ind]

mycanvas = function(no)
  lib.start_canvas(300, 200, "center")
  
  lib.add_straight_path(ov, ow+ov, {{ov, 0}}, style, true, false)
  lib.add_text(2*ov-ow, ov+2*ow, "m", text_style, false, false)
  lib.add_straight_path(ov, ow+ov, {{0, -ov}}, style, true, false)
  lib.add_text(ov+ow, 2*ow, "n", text_style, false, false)   
  
  if (ind < 3) then
      for i = 1, ind do
         lib.add_straight_path(ov, ow+ov, {{x[i], -y[i]}}, style, true, false)
         lib.add_text(ov+x[i], ow+ov-y[i]+10, mark[2*i-1], text_style, false, false)  		 
         lib.add_straight_path(ov, ow+ov, {{-x[i], -y[i]}}, style, true, false)	
         lib.add_text(ov-x[i]+ow, ow+ov-y[i]-10, mark[2*i], text_style, false, false) 		 
      end		 
  else
      lib.add_straight_path(ov, ow+ov, {{x[1], -y[1]}}, style, true, false) 
      lib.add_text(ov+x[1], ow+ov-y[1]+10, mark[1], text_style, false, false)	  
	  lib.add_straight_path(ov, ow+ov, {{x[2], -y[2]}}, style, true, false) 
      lib.add_text(ov+x[2], ow+ov-y[2]+10, mark[2], text_style, false, false)	  
      lib.add_straight_path(ov, ow+ov, {{-x[2], -y[2]}}, style, true, false)
      lib.add_text(ov-x[2]+ow, ow+ov-y[2], mark[3], text_style, false, false)	  
  end

  lib.add_text(ov, ov, ".", dot_style, false, false)
  lib.add_text(ov, ov+2*ow, "O", text_style, false, false)
 		
  lib.end_canvas()
end
   