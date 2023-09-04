
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

red_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["line_width"] = "2"};

dif_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};

point_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};	
		
blue_style = {["off_color"] = "aff",
             ["on_color"] = "aff",
             ["line_color"] = "fff",
             ["line_width"] = "1"};		

text_style = {["font_size"] = "14"}	
			 

point = {"A", "B", "A₁", "B₁", "C"}
plane = "π"
 
space = "\( \ \ \ \ \) "

numb = {}

index = math.random(2)
if (index == 2) then 
    note = msg[2]
else
    note = msg[1]	
end	

numb[1] = math.random(10) - 1
numb[2] = numb[1] + math.random(10) - 1

if (numb[1] == 0) then 
    index = 3
    note = msg[1]	
end	

if (index == 2) then
    tmp = - numb[2]
else
    tmp = numb[2]
end	
numb[3] = math.abs(numb[1]-tmp) + 2 + math.random(7)
numb[4] = math.sqrt(numb[3]^2 - (numb[1]-tmp)^2)

numb[4] = lib.math.round_dec(numb[4], 1)		
mycanvas = function(no)

  w = 250
  ov = 150
  v = 40
  ow = 10

  lib.start_canvas(320, 170, "center")

  lib.add_straight_path (2*v, 2*(v-ow), {{-2*v+ow, ov-2*v}, {w-ow,0}, {2*v-ow, -2*v+ow}, {-w+ow, 0},}, blue_style, true, false)

  if (index == 1) then
	lib.add_line(ov-v, v, w-ov+v, -v+ow, style, false, false)
	lib.add_line(ov-v, v, 0, v+ow, dif_style, false, false)
	lib.add_line(ov-v, 2*v+ow, w-ov+v, ow, red_style, false, false)
	lib.add_line(w, ow, 0, 2*v+ow, dif_style, false, false)
	lib.add_circle(ov-v, v, 2.5, point_style, false, false)  
	lib.add_text(2*(v+ow)+5, v-ow, "A", text_style, false, false)
	lib.add_circle(ov-v, 2*v+ow, 2.5, point_style, false, false)
	lib.add_text(3*v-ow, 2*(v+ow), point[3], text_style, false, false)
	lib.add_circle(w, ow, 2.5, point_style, false, false) 
	lib.add_text(w+ow, ow, "B", text_style, false, false)
	lib.add_circle(w, w-ov, 2.5, point_style, false, false) 
	lib.add_text(w+ow, w-ov, point[4], text_style, false, false)
  end

  if (index == 2) then
	lib.add_line(2*v, ov, w-2*v, -ov+ow, dif_style, false, false)  
	lib.add_line(2*v, ov, 2*ow+5, (-ov+ow)/(w-2*v)*(2*ow+5), style, false, false)
	lib.add_line(w, ow, -ov+v+7, 2*v+4, style, false, false)
	lib.add_line(2*v, 2*v+ow, 0, v+2*ow, dif_style, false, false)
	lib.add_line(2*v, 2*v+ow, w-2*v, ow, red_style, false, false)
	lib.add_line(w, ow, 0, 2*v+ow, dif_style, false, false)
	lib.add_circle(2*v, ov, 2.5, point_style, false, false)  
	lib.add_text(2*v-ow, ov, "A", text_style, false, false)
	lib.add_circle(2*v, 2*v+ow, 2.5, point_style, false, false)
	lib.add_text(2*v-ow, 2*(v+ow), point[3], text_style, false, false)
	lib.add_circle(w, ow, 2.5, point_style, false, false) 
	lib.add_text(w+ow, ow, "B", text_style, false, false)
	lib.add_circle(w, w-ov, 2.5, point_style, false, false) 
	lib.add_text(w+ow, w-ov, point[4], text_style, false, false)
	lib.add_circle(ov-2, 2*(v+ow)-6, 2.5, point_style, false, false)  
	lib.add_text(ov, 2*(v+ow)+5, "C", text_style, false, false)
  end
  
  if (index == 3) then
	lib.add_line(ov-v, 2*v+ow, w-ov+v, -2*v, style, false, false)
	lib.add_line(ov-v, 2*v+ow, w-ov+v, ow, red_style, false, false)
	lib.add_line(w, ow, 0, 2*v+ow, dif_style, false, false)
	lib.add_circle(ov-v, 2*v+ow, 2.5, point_style, false, false)  
	lib.add_text(3*v-ow, 2*(v+ow), "A = ", text_style, false, false)
	lib.add_text(3*v+ow, 2*(v+ow), point[3], text_style, false, false)
	lib.add_circle(w, ow, 2.5, point_style, false, false) 
	lib.add_text(w+ow, ow, "B", text_style, false, false)
	lib.add_circle(w, w-ov, 2.5, point_style, false, false) 
	lib.add_text(w+ow, w-ov, point[4], text_style, false, false)
  end
  
  lib.add_text(v-ow, 3*v, plane, text_style, false, false)

  lib.end_canvas()
end   
            
 
     
            