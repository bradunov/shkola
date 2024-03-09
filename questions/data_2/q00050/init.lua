
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};
		
dash_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};		
		
axis_style = 
	{["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};	
		
red_style = {["off_color"] = "f30",
               ["on_color"] = "f30",
               ["line_color"] = "000",			   			   
               ["line_width"] = "1"};			   

blue_style = {["off_color"] = "0cf",
               ["on_color"] = "0cf",
               ["line_color"] = "000",			   
               ["line_width"] = "1"};	
			   
green_style = {["off_color"] = "6f6",
               ["on_color"] = "6f6",
               ["line_color"] = "000",		   
               ["line_width"] = "1"};			
				   
red_line = {["off_color"] = "none",
               ["on_color"] = "none",
               ["line_color"] = "f00",			   
               ["off_line_color"] = "f00",			   
               ["line_width"] = "2"};			   

blue_line = {["off_color"] = "none",
               ["on_color"] = "none",
               ["line_color"] = "0cf",
               ["off_line_color"] = "0cf",			   
               ["line_width"] = "2"};	
			   
green_line = {["off_color"] = "none",
               ["on_color"] = "none",
               ["line_color"] = "3c3",
               ["off_line_color"] = "3c3",			   
               ["line_width"] = "2"};	

line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		

	
small_style = {["off_line_color"] = "f30",
               ["font_size"] = "12"}	
			   
					
text_style = {["font_size"] = "14"}

year = {"2013", "2014", "2015", "2016", "2017"}

--[[
sept = {23, 24, 24, 25, 26}
oct = {14, 18, 17, 15, 16}
nov = {10, 7, 8, 11, 10}
]]--


sept = {}
oct = {}
nov = {}
sum = {}
dif = {}
tmp = {}

for i = 1,5 do
    sept[i] = 20 + math.random(6)
    oct[i] = 12 + math.random(7)
    nov[i] = 6 + math.random(6)
end   

min_range = 7
max_range = 26  
dim = max_range - min_range + 1

max_aver = 0
ind_a = 0
max_dif = 0
ind_d = 0
for i = 1,5 do
	dif = sept[i] - nov[i]
    if (dif > max_dif) then
	    max_dif = dif
		ind_d = i
    else
        if (dif == max_dif) then    
		    nov[i] = nov[i] + 1
        end		
	end	
    sum = sept[i] + oct[i] + nov[i]
    if (sum > max_aver) then
	    max_aver = sum
		ind_a = i
    else  
        if (sum == max_aver) then    
		    oct[i] = oct[i] - 1
        end		
	end

end	    

ch = math.random(2)

index = math.random(3)
quest = ""
reply = ""
if (index == 1) then 
    quest = text[1]
	reply = lib.check_one_option_dropdown(year, year[ind_a])
end
if (index == 2) then 
    quest = text[2] 
	reply = lib.check_one_option_dropdown(year, year[ind_d])	
end
if (index == 3) then 
    quest = text[3] 
	reply = lib.check_one_option_dropdown(position, position[ch])
end

mycanvas = function()

  lib.start_canvas(350, 300, "center")

    wx = 15
    wy = 20	
    ow = 25
    v = 5
	ov = 10
 
    xs = ow + (sept[1] - min_range + 1) * wx
    lib.add_straight_path(xs, ow+4*wy, {{(sept[2]-sept[1])*wx,-wy}, {(sept[3]-sept[2])*wx, -wy}, {(sept[4]-sept[3])*wx,-wy}, {(sept[5]-sept[4])*wx, -wy}}, green_line, true, false)

    xo = ow + (oct[1] - min_range + 1) * wx
    lib.add_straight_path(xo, ow+4*wy, {{(oct[2]-oct[1])*wx,-wy}, {(oct[3]-oct[2])*wx, -wy}, {(oct[4]-oct[3])*wx,-wy}, {(oct[5]-oct[4])*wx, -wy}}, red_line, true, false)

    xn = ow + (nov[1] - min_range + 1) * wx
    lib.add_straight_path(xn, ow+4*wy, {{(nov[2]-nov[1])*wx,-wy}, {(nov[3]-nov[2])*wx, -wy}, {(nov[4]-nov[3])*wx,-wy}, {(nov[5]-nov[4])*wx, -wy}}, blue_line, true, false)


    for i = 1,(dim+1) do
       lib.add_line(ow+i*wx, ow, 0, 5*wy, style, false, false)
    end
  
    for i = 1,6 do
        lib.add_line(ow+wx, ow+(i-1)*wy, dim*wx, 0, style, false, false)
    end

    lib.add_line(ow+v, ow+5*wy, (dim+1)*wx, 0, axis_style, false, false)
    lib.add_line(ow+wx, ow-v, 0, 6*wy-v, axis_style, false, false)

    zero = ow+5*wy

    for i = 1,5 do
        lib.add_text(wx, zero-i*wy, tostring(year[i]), text_style) 
        lib.add_line(ow+wx-v, zero-i*wy, 2*v, 0, dash_style, false, false)			
    end	
    lib.add_text(ow, v, title[1], text_style)   
    lib.add_straight_path(2*ow-wx, ow, {{v,-2*v}, {v, 2*v}}, axis_style, false, false)
  
    temp = min_range + 1
    for i = 1,dim,2 do
        lib.add_text(ow+wx+i*wx, 7*wy, tostring(temp), text_style) 
        lib.add_line(ow+wx+i*wx, ow+5*wy-v, 0, 2*v, dash_style, false, false)	
		temp = temp + 2
    end	   
    lib.add_text(ow+(dim+1)*wx, 6*wy-v, "°C", text_style) 	
    lib.add_straight_path((dim+2)*wx+v, 6*wy, {{2*v,v}, {-2*v,v}}, axis_style, false, false)


scale  = 6

  x = 4*wy + ow
  for i = 1,5 do
      lib.add_text(wy+x, (scale+3)*wy+v, year[i], text_style, false, false) 	  
      x = x + 2*wy + ov
  end 
  if (ch == 1) then
      corr = 0
  else
      corr = 3
  end	  
  lib.add_rectangle (v, (scale+4)*wy, 4*wy+ov, 2*wx, green_style, false, false)
  lib.add_rectangle (v, (scale+5)*wy+ov, 4*wy+ov, 2*wx, red_style, false, false) 
  lib.add_rectangle (v, (scale+6)*wy+2*ov, 4*wy+ov, 2*wx, blue_style, false, false)  
  lib.add_text(ow+wy, (scale+5)*wy-v, title[2+corr], text_style, false, false) 
  lib.add_text(ow+wy, (scale+6)*wy+v, title[3+corr], text_style, false, false) 	  
  lib.add_text(ow+wy, (scale+7)*wy+ov, title[4+corr], text_style, false, false)   



 for i = 1,6 do
    lib.add_line(i*(2*wy + ov)+ 2*wy+v, (scale+2)*wy+ov, 0, 6*wy, line_style, false, false)
  end
    lib.add_line(v, (scale+2)*wy+ov, 0, 6*wy, line_style, false, false)

  for i = 1,4 do
    lib.add_line(v, (scale+2)*wy+i*(wy+ov)+ov, 17*wy, 0, line_style, false, false)
  end
    lib.add_line(v, (scale+2)*wy+ov, 17*wy, 0, line_style, false, false)


  for i = 1,5 do
      lib.add_input(2*(i+1)*ow, (scale+4)*wy+2, 40, 30, lib.check_number(sept[i],15))
      lib.add_input(2*(i+1)*ow, (scale+6)*wy-v, 40, 30, lib.check_number(oct[i],15))
      lib.add_input(2*(i+1)*ow, (scale+8)*wy-wx, 40, 30, lib.check_number(nov[i],15))
  end

  lib.end_canvas()
  
end   