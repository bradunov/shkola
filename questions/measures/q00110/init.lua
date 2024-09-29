
include("shapes")

box_style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "2"};	

strip_style = 
	{["off_color"] = "f00",
        ["on_color"] = "f00",
        ["line_color"] = "f00",
        ["line_width"] = "1"};	

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "none",
        ["line_width"] = "1"};	
		
			

meas = {"m", "dm", "cm"}

space = "\( \ \ \ \)"

box = {}
box_out = {}


box[1] = 15 + math.random(10)
box[2] = 9 + math.random(6)
box[3] = 2 + math.random(6);

quest = ""
strip = 0
for j = 1,3 do
    box_out[j] = {}
	box_out[j][1] = math.floor(box[j]/10)
	box_out[j][2] = box[j] - 10 * box_out[j][1]
	if(box_out[j][1] ~= 0) then
	   quest = quest .. " " .. tostring(math.floor(box_out[j][1])) .. meas[2] 
	end
	if(box_out[j][2] ~= 0) then
	   quest = quest .. " " .. tostring(math.floor(box_out[j][2])) .. meas[3] 
	end	
	if (j < 3) then
        quest = quest .. ", " .. space   
	end	
    strip = strip + box[j] 	
end	

ribbon = 20 + math.random(20)
strip = 4 * strip + ribbon
strip_out = strip/ 100

 
mycanvas = function(no)

  lib.start_canvas(300, 150, "center")

	w = 50
	ow = 10
	v = 20
	ov =  160

    lib.add_rectangle (v, 2*(w-ow), ov, w, box_style, true, false)
    lib.add_straight_path(v, 2*(w-ow), {{9*ow, -5*ow}, {ov, 0}, {-9*ow, 5*ow}, {-ov, 0}}, box_style,  false, false)
    lib.add_straight_path(ov+v, 2*(w-ow), {{9*ow, -5*ow}, {0, w}, {-9*ow, 5*ow}, {0, -w}}, box_style,  false, false)

    lib.add_straight_path(v+ov/2-ow, w+2*(w-ow), {{0, -w}, {9*ow, -5*ow}, {ow, 0}, {-9*ow, 5*ow}, {0, w}, {-ow, 0}}, strip_style,  false, false)

    lib.add_straight_path(v, w+2*(w-ow)-(w-ow)/2, {{ov, 0}, {9*ow, -5*ow}, {0, -ow}, {-9*ow, 5*ow}, {-ov, 0}, {0, ow}}, strip_style,  false, false)

    lib.add_straight_path(v+(ov-ow)/2-3*ow, 2*(w-ow)-w/2, {{ov, 0}, {0, w}, {ow, -5*ow/9}, {0, -w},  {-ov, 0}, {-ow, 5*ow/9}}, strip_style,  false, false)

x = v+(ov-ow)/2-3*ow+ov/2
y = 2*(w-ow)-w/2
heart(lib, x, y, 1, strip_style, false, false)


  lib.add_curved_path(x-30, y, {{20, -20, 30, 0}, {20, 20, 30, 0}}, strip_style, false, false)

  lib.end_canvas()
end   
            