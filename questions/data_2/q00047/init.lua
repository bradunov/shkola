
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
				   
blue_line = {["off_color"] = "none",
               ["on_color"] = "none",
               ["line_color"] = "0cf",			   
               ["off_line_color"] = "000",			   
               ["line_width"] = "2"};			   

red_line = {["off_color"] = "none",
               ["on_color"] = "none",
               ["line_color"] = "f00",
               ["off_line_color"] = "000",			   
               ["line_width"] = "2"};	
					
text_style = {["font_size"] = "14"}

out = {}
index = {}

girl = {130, 132, 136, 140, 146, 156, 161, 165, 168, 170, 172, 173}
boy = {135, 137, 140, 143, 146, 152, 160, 168, 175, 179, 183, 185}

miny = 7
maxy = 18
dim = maxy - miny + 1
mint = girl[1]
maxt = boy[dim]

ch = math.random(2)
ind = math.random(dim)
if (ind == 5 or ind == 7) then
    ind = 6
end		
ch_y = 6 + ind
if (ch == 1) then
    ch_t = girl[ind]
else
    ch_t = boy[ind]	
end	

index = math.random(4)
reply = ""
if (index == 1) then 
    reply = msg[1] .. lib.check_number(8, 15) .. msg[2] .. lib.check_number(12, 15) 
end
if (index == 2) then 
    reply = msg[3] .. lib.check_number(11, 15) .. msg[4] .. lib.check_number(13, 15) 
end
if (index == 3) then 
    reply = msg[5] .. lib.check_number(11, 15) 
end
if (index == 4) then 
    reply = msg[5] .. lib.check_number(12, 15) 
end

mycanvas = function()

if (ch == 1) then
     results = "result[0] == 1 && result[1] == 0"
else
     results = "result[0] == 0 && result[1] == 1"
end

  lib.start_canvas(350, 220, "center", results)

    wx = 25
    wy = 15	
    ow = 20
    v = 5
  
    scale = 0.2 * wy
	
    lib.add_straight_path(ow+wx, ow+dim*wy, {{wx,(girl[1]-girl[2])*scale}, {wx,(girl[2]-girl[3])*scale}, {wx,(girl[3]-girl[4])*scale}, {wx,(girl[4]-girl[5])*scale}, {wx,(girl[5]-girl[6])*scale}, {wx,(girl[6]-girl[7])*scale}, {wx,(girl[7]-girl[8])*scale}, {wx,(girl[8]-girl[9])*scale}, {wx,(girl[9]-girl[10])*scale}, {wx,(girl[10]-girl[11])*scale}, {wx,(girl[11]-girl[12])*scale}}, red_line, false, true)  
    lib.add_straight_path(ow+wx, ow+(dim-1)*wy, {{wx,(boy[1]-boy[2])*scale}, {wx,(boy[2]-boy[3])*scale}, {wx,(boy[3]-boy[4])*scale}, {wx,(boy[4]-boy[5])*scale}, {wx,(boy[5]-boy[6])*scale}, {wx,(boy[6]-boy[7])*scale}, {wx,(boy[7]-boy[8])*scale}, {wx,(boy[8]-boy[9])*scale}, {wx,(boy[9]-boy[10])*scale}, {wx,(boy[10]-boy[11])*scale}, {wx,(boy[11]-boy[12])*scale}}, blue_line, false, true)  

    for i = 1,dim do
       lib.add_line(ow+i*wx, ow, 0, 12*wy, style, false, false)
    end
  
    for i = 1,13 do
        lib.add_line(ow+wx, ow+(i-1)*wy, (dim-1)*wx, 0, style, false, false)
    end

    lib.add_line(ow+wy, ow+12*wy, dim*wx, 0, axis_style, false, false)
    lib.add_line(ow+wx, ow-v, 0, 13*wy-v, axis_style, false, false)
  
    zero = ow+12*wy
	height = girl[1]
    for i = 1,7 do
        lib.add_text(wy, zero-2*(i-1)*wy, tostring(height), text_style) 
        lib.add_line(ow+wx-v, zero-2*(i-1)*wy, 2*v, 0, dash_style, false, false)	
        height = height + 10		
    end	
    lib.add_text(3*wx, ow-v, title[1], text_style)   
    lib.add_straight_path(2*ow, ow, {{v,-2*v}, {v, 2*v}}, axis_style, false, false)
  
    year = miny
    for i = 1,dim do
        lib.add_text(ow+wx+(i-1)*wx, ow+13*wy, tostring(year), text_style) 
        lib.add_line(ow+wx+(i-1)*wx, ow+12*wy-v, 0, 2*v, dash_style, false, false)	
		year = year + 1
    end	  
    lib.add_text(ow+dim*wx, 12*wy, title[2], text_style) 
    lib.add_straight_path((dim+1)*wx, 13*wy, {{2*v,v}, {-2*v,v}}, axis_style, false, false)

  lib.end_canvas()
  
end   
                   