
sold_style = 
	{["off_color"] = "cc0",
        ["on_color"] = "cc0",
        ["line_color"] = "fff",
        ["line_width"] = "1"};

blue_style = 
	{["off_color"] = "aaf",
        ["on_color"] = "aff",
        ["line_color"] = "fff",
        ["line_width"] = "1"};

brown_style = 
	{["off_color"] = "fc0",
        ["on_color"] = "fc0",
        ["line_color"] = "fff",
        ["line_width"] = "1"};

pink_style = 
	{["off_color"] = "f9c",
        ["on_color"] = "f9c",
        ["line_color"] = "fff",
        ["line_width"] = "1"};

red_style = 
	{["off_color"] = "f00",
        ["on_color"] = "f00",
        ["line_color"] = "fff",
        ["line_width"] = "1"};
		
orange_style = 
	{["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "fff",
        ["line_width"] = "1"};

green_style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "fff",
        ["line_width"] = "1"};

yelow_style = 
	{["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "fff",
        ["line_width"] = "1"};	
	
grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.1"};	

line_style = 
	{["off_line_color"] = "fff",
        ["on_line_color"] = "000",
        ["line_width"] = "3"};	
						
text_style = {["font_size"] = "14"}		

meas = {"cm", "cm\(\small^2\)"}
sp = "\(   \) "
	
name = {"1", "2", "3", "4", "5", "6", "7", "8"}
area = {3, 3.75, 5, 4, 5, 4, 5.25, 7}

ch = {}
dim = 8
qq = {}
answ = {""}

for i = 1,dim do
    ch[i] = i
end	

qq = lib.math.random_shuffle(ch)

for i = 1,4 do
    answ[i] = name[qq[i]] .. sp .. sp .. sp .. lib.check_number(area[qq[i]],30) .. meas[2]
end	


mycanvas = function()
	 		  
  lib.start_canvas(350, 320, "center")  
  
    ow = 5
    w = 125
    ov = 75
    v = 20
  
    lib.add_straight_path(v+2*ow, v+2*ow, {{v, 3*v}, {3*v, -3*v}, {-4*v, 0} }, brown_style, true, false) 
    lib.add_straight_path(2*ov, v+2*ow, {{0, 5*v}, {3*v, 0}, {-3*v, -5*v}}, green_style, true, false) 
    lib.add_straight_path(2*w-3*v, v+2*ow, {{5*v, 5*v}, {-v, -5*v}, {-4*v, 0} }, orange_style, true, false) 

    lib.add_straight_path(v+2*ow, ov+5*v+3*ow, {{0, 4*v}, {4*v, -2*v}, {-4*v, -2*v} }, sold_style, true, false)
    lib.add_straight_path(w-3*ow-v, w+3*v+ow, {{5*v, 0}, {-7*v, -4*v}, {2*v, 4*v}}, yelow_style, true, false) 
    lib.add_straight_path(w+ov+2*ow, w+v+ow, {{4*v, 4*v}, {0, -4*v}, {-4*v, 0}}, pink_style, true, false) 

    lib.add_straight_path(v+2*ow, 2*w+3*v, {{7*v, -2*v}, {0, -3*v}, {-7*v, 5*v}}, red_style, true, false)
    lib.add_straight_path(8*v+2*ow,  14*v+2*ow, {{7*v, 0}, {-3*v, -4*v}, {-4*v, 4*v}}, blue_style, true, false) 
   
    lib.add_text(3*v+ow, 2*v+ow, "1", text_style) 
    lib.add_text(9*v, 5*v+ow, "2", text_style)
    lib.add_text(11*v+2*ow, 2*v+ow, "3", text_style) 
    lib.add_text(2*(v+ow), 11*v, "4", text_style) 
    lib.add_text(5*v, 8*v, "5", text_style) 
    lib.add_text(14*v-2*ow, 9*v, "6", text_style)
    lib.add_text(6*v+2*ow, 13*v, "7", text_style) 	
    lib.add_text(12*v, 13*v, "8", text_style) 
	 
    for i = 1,16 do
        lib.add_line(2*ow, 2*ow+(i-1)*v, 15*v, 0, grid_style, false, false)
    end
    for i = 1,16 do
        lib.add_line(2*ow+(i-1)*v, 2*ow, 0, 15*v, grid_style, false, false)
    end
     	
  lib.end_canvas()
end 

          
         
            
            
            
            
            
            
            
            
            
            
            
            
            
     