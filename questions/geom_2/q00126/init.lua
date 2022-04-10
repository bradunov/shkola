
style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
red_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "f30",
        ["line_width"] = "2"}; 	

blue_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "0cf",
        ["line_width"] = "2"}; 			
		
point_style = 
	{["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};		

grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};	
							
text_style = {["font_size"] = "16"}

ang = {"ξ", "ζ"}
deg = "°"
numb = {}		   

ind = math.random(5)


mycanvas = function()
	 		  
  lib.start_canvas(250, 250, "center")   
  
   w = 16
   ow = 12
   v = 4

 if (ind == 1) then 
    ch = math.random(2)
	if (ch == 1) then
        lib.add_straight_path(v+0.3*w, v+4.7*w, {{6.7*w,2.3*w}, {0,-7*w}}, red_style, true, false)              	 
        lib.add_input(v, 4*w, 50, 30, ang[1])
        lib.add_input(v+5*w, ow+5*w, 50, 30, ang[2])
		numb[1] = 54
		numb[2] = 72
	end 
	if (ch == 2) then
        lib.add_straight_path(v+2.9*w, v+12.8*w, {{4.1*w,-12.8*w}, {4.1*w,12.8*w}}, red_style, true, false)  
        lib.add_straight_path(v+0.3*w, v+4.7*w, {{2.6*w, v+8*w}, {10.8*w,-8*w}}, blue_style, true, false)              	 
        lib.add_input(ow+5*w, v+w, 50, 30, ang[1])
        lib.add_input(2*w, 11*w, 50, 30, ang[2])
		numb[1] = 36
		numb[2] = 72
	end        
     lib.add_straight_path(v+0.3*w, v+4.7*w, {{6.7*w,-4.7*w}, {6.7*w,4.7*w}, {-2.5*w,8*w}, {-8.3*w,0}, {-2.5*w,-8*w}}, style, true, false)      
  end 

 if (ind == 2) then          
    ch = math.random(2)
	if (ch == 1) then
        lib.add_straight_path(v, v+7*w, {{7*w,0}, {-3.5*w,6*w}}, red_style, true, false)              	 
        lib.add_input(v-ow, 7*w, 50, 30, ang[1])
        lib.add_input(ow+4*w, 7*w, 50, 30, ang[2])
		numb[1] = 60
		numb[2] = 60
	end
	if (ch == 2) then
        lib.add_straight_path(v+3.5*w, v+13*w, {{7*w,-12*w}, {0,12*w}}, red_style, true, false)  
        lib.add_straight_path(v+3.5*w, v+13*w, {{10.4*w,-6*w}, {-3.5*w,6*w}}, blue_style, true, false)              	 
        lib.add_input(ow+8*w, 2*w, 50, 30, ang[1])
        lib.add_input(v+11*w, 8*w, 50, 30, ang[2])
		numb[1] = 30
		numb[2] = 30
	end
    lib.add_straight_path(v, v+7*w, {{3.5*w,-6*w}, {7*w,0}, {3.5*w,6*w}, {-3.5*w,6*w}, {-7*w,0}, {-3.5*w,-6*w}}, style, true, false)      	 
  end  

 if (ind == 3) then  
    ch = math.random(2)
	if (ch == 1) then
        lib.add_straight_path(v, v+7*w, {{7*w,0}, {-5*w,5*w}}, red_style, true, false)              	 
        lib.add_input(v-ow, 7*w, 50, 30, ang[1])
        lib.add_input(ow+4*w, 7*w, 50, 30, ang[2])
		numb[1] = lib.math.round_dec(67.5,1)
		numb[2] = 45
	end 
	if (ch == 2) then
        lib.add_straight_path(v, v+7*w, {{7*w,-7*w}, {-5*w,12*w}}, red_style, true, false)  
        lib.add_straight_path(v, v+7*w, {{14*w,0}, {-7*w,7*w}}, blue_style, true, false)              	 
        lib.add_input(v+4*w, 2*w, 50, 30, ang[1])
        lib.add_input(v+11*w, v+7*w, 50, 30, ang[2])
		numb[1] = lib.math.round_dec(22.5,1)
		numb[2] = 45
	end       
     lib.add_straight_path(v+2*w, v+2*w, {{5*w,-2*w}, {5*w,2*w}, {2*w,5*w}, {-2*w,5*w}, {-5*w,2*w}, {-5*w,-2*w}, {-2*w,-5*w}, {2*w,-5*w}}, style, true, false)      
  end 
  
  if (ind == 4) then 
    ch = math.random(2)
	if (ch == 1) then
        lib.add_straight_path(v+0.3*w, v+4.9*w, {{6.7*w,2.1*w}, {-6.7*w,2.1*w}}, red_style, true, false)              	 
        lib.add_input(v-ow, v+5*w, 50, 30, ang[1])
        lib.add_input(4*w, 7*w-v, 50, 30, ang[2])
		numb[1] = 72
		numb[2] = 36
		first = ang[1]
		second = ang[2]		
	end 
	if (ch == 2) then
        lib.add_straight_path(v+0.3*w, v+4.9*w, {{13.3*w,0}, {-10.8*w,7.8*w}}, red_style, true, false)  
        lib.add_straight_path(v+0.3*w, v+9.2*w, {{11*w,3.5*w}, {-8.5*w,0}}, blue_style, true, false)              	 
        lib.add_input(10*w, v+5*w, 50, 30, ang[1])
        lib.add_input(7*w, 12*w, 50, 30, ang[2])
		numb[1] = 36
		numb[2] = 18
	end         
     lib.add_straight_path(v+0.3*w, v+4.9*w, {{2.5*w,-3.5*w}, {4.2*w,-1.4*w}, {4.2*w, 1.4*w}, {2.5*w, 3.5*w}, {0, 4.3*w}, {-2.5*w, 3.5*w}, {-4.2*w, 1.4*w}, {-4.2*w,-1.4*w}, {-2.5*w,-3.5*w}, {0, -4.3*w}}, style, true, false)      
  end

 if (ind == 5) then 
    ch = math.random(2)
	if (ch == 1) then
        lib.add_straight_path(v, v+7*w, {{7*w,0}, {-6.2*w,3.3*w}}, red_style, true, false)              	 
        lib.add_input(v-ow, v+7*w, 50, 30, ang[1])
        lib.add_input(ow+3*w, v+7*w, 50, 30, ang[2])
		numb[1] = 75
		numb[2] = 30
	end 
	if (ch == 2) then
        lib.add_straight_path(v, v+7*w, {{13.1*w,-3.3*w}, {-9.6*w,9.3*w}}, red_style, true, false)  
        lib.add_straight_path(v, v+7*w, {{13.1*w,3.3*w}, {-12.3*w,0}}, blue_style, true, false)              	 
        lib.add_input(10*w, v+4*w, 50, 30, ang[1])
        lib.add_input(8*w, v+9*w, 50, 30, ang[2])
		numb[1] = 30
		numb[2] = 15
	end                
     lib.add_straight_path(v, v+7*w, {{0.8*w,-3.3*w}, {2.7*w,-2.7*w}, {3.5*w,-w}, {3.5*w, w}, {2.7*w, 2.7*w}, {0.8*w,3.3*w}, {-0.8*w,3.3*w}, {-2.7*w, 2.7*w}, {-3.5*w, w}, {-3.5*w, -w}, {-2.7*w, -2.7*w}, {-0.8*w,-3.3*w}}, style, true, false)      
  end 
  
--[[
  for i = 1,15 do
    lib.add_line(v, v+(i-1)*w, 14*w, 0, grid_style, false, false)
  end
  for i = 1,15 do
    lib.add_line(v+(i-1)*w, v, 0, 14*w, grid_style, false, false)
  end

  lib.add_circle (v+7*w, v+7*w, 7*w, grid_style, false, false)

  lib.add_circle (v+7*w, v+7*w, 2, style, false, false)
]]--

  lib.end_canvas()
end
        
            