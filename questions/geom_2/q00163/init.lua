
include("shapes")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.7"};

green_style = 
	{["off_color"] = "3c3",
        ["on_color"] = "3c3",
        ["line_color"] = "000",
        ["line_width"] = "1"};

brown_style = 
	{["off_color"] = "c90",
        ["on_color"] = "c90",
        ["line_color"] = "000",
        ["line_width"] = "1"};

pink_style = {["off_color"] = "f9c",
             ["on_color"] = "f9c",
             ["line_color"] = "000",
             ["line_width"] = "1"};		
		
blue_style = {["off_color"] = "aff",
             ["on_color"] = "aff",
             ["line_color"] = "fff",
             ["line_width"] = "1"};		

text_style = {["font_size"] = "14"}	
			 

point = {"CE", "BC", "AD", "AB"}

numb = {}
tree = {}
quest = ""
ans = ""

meas = "m"
space = "\( \ \ \ \ \) "

numb[1] = 30 + math.random(40)
numb[2] = 20 + math.random(40)
numb[3] = 80 + math.random(320)
numb[4] = lib.math.round(numb[3] * numb[2] / numb[1])
tmp = math.floor(numb[4]/2)
numb[4] = tmp + math.random(numb[4])
numb[3] = lib.math.round(numb[4] * numb[1] / numb[2])

quest =  point[1] .. " = " .. numb[1] .. meas .. ", " .. space .. point[2] .. " = " .. numb[2] .. meas .. ", " .. space .. point[4] .. " = " .. numb[4] .. meas  
ans = lib.check_number(numb[3],30) .. meas 

mycanvas = function(no)

  w = 250
  ov = 150
  v = 40
  ow = 10

  lib.start_canvas(320, 170, "center")

  lib.add_straight_path (w+v, ow, {{-ov, ov}, {-ov+ow,0}, {ov, -ov}, {ov-ow, 0},}, blue_style, true, false)

  leaf(lib, 2*v-5, 2*ow, 0.7, green_style, false, false)
  lib.add_rectangle (2*v-ow, v+ow, ow, v-ow, brown_style, true, false)

  lib.add_circle(w+v, 2*v+5, 4, pink_style, false, false)
  lib.add_straight_path (w+v, ov-v, {{-5, -2*ow}, {ow, 0}, {-5, 2*ow} }, pink_style, true, false)

  lib.add_line(2*v, 2*v, 2*v-ow, 2*v-ow, style, false, false)
  lib.add_line(w+v, ov-v, -v-ow, -v-ow, style, false, false)   
  lib.add_line(2*v, 2*v, w-v, v-ow, style, false, false)
  lib.add_line(ov, ov, 2*v+ow, -2*v-ow, style, false, false)
  
  lib.add_circle(2*v, 2*v, 3, style, false, false)
  lib.add_text(2*v+ow, 2*v-ow, "D", text_style, false, false) 
  lib.add_circle(w+v, ov-v, 3, style, false, false)
  lib.add_text(w+v, ov-v+ow, "E", text_style, false, false) 
  lib.add_circle(ov, ov, 3, style, false, false) 
  lib.add_text(ov+ow, ov, "A", text_style, false, false)
  lib.add_circle(w-ow, v+2*ow, 3, style, false, false) 
  lib.add_text(w, v+2*ow, "C", text_style, false, false)
  lib.add_circle(2*(w-ov)+3, 2*(v+ow)-3, 3, style, false, false)  
  lib.add_text(2*(w-ov)+3, 3*v-ow, "B", text_style, false, false)

  lib.end_canvas()
end            