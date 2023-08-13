
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
			 

point = {"A₁", "B₁"}
plane = "π"
 
space = "\( \ \ \ \ \) "

numb = {}
quest = ""
ans = ""

ind = math.random(3)

index = math.random(2)
if (index == 2) then 
    note = msg[2]
else
    note = msg[1]	
end	

numb[1] = math.random(10)
if (ind < 3) then
	numb[2] = numb[1] + math.random(10)
    quest = "B" .. point[2] .. " = " .. numb[2] .. "cm,"	
	if (index == 2) then
		tmp = - numb[2]
	else
		tmp = numb[2]
	end		
	if (ind == 1) then
		numb[3] = math.abs(numb[1]-tmp) + 2 + math.random(7)
		numb[4] = math.sqrt(numb[3]^2 - (numb[1]-tmp)^2)
        quest = quest .. space .. "AB" .. " = " .. numb[3] .. "cm"
		numb[4] = lib.math.round_dec(numb[4],1)		
        ans = point[1] .. point[2] .. " = " .. lib.check_number(numb[4]) .. "cm"		
	else
		numb[4] = 2 + math.random(7)
		numb[3] = math.sqrt(numb[4]^2 + (numb[1]-tmp)^2)	
        quest = quest .. space .. point[1] .. point[2] .. " = " .. numb[4] .. "cm"				
		numb[3] = lib.math.round_dec(numb[3],1)
		ans = "AB" .. " = " .. lib.check_number(numb[3]) .. "cm"
    end
else
	numb[4] = 2 + math.random(7)
	numb[3] = numb[4] + 2 + math.random(7)	
	tmp = math.sqrt(numb[3]^2 - numb[4]^2)		
	if (index == 2) then
		numb[2] = math.abs(tmp - numb[1])
	else
		numb[2] = numb[1] + tmp
	end	
    quest = "AB"  .. " = " .. numb[3] .. "cm," .. space	.. point[1] .. point[2] .. " = " .. numb[4] .. "cm"
	numb[2] = lib.math.round_dec(numb[2],1)
	ans = "B" .. point[2] .. " = " .. lib.check_number(numb[2]) .. "cm"
end
	
		
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
	lib.add_text(3*v-ow, 2*(v+ow), point[1], text_style, false, false)
	lib.add_circle(w, ow, 2.5, point_style, false, false) 
	lib.add_text(w+ow, ow, "B", text_style, false, false)
	lib.add_circle(w, w-ov, 2.5, point_style, false, false) 
	lib.add_text(w+ow, w-ov, point[2], text_style, false, false)
  else
	lib.add_line(2*v, ov, w-2*v, -ov+ow, dif_style, false, false)  
	lib.add_line(2*v, ov, 2*ow+5, (-ov+ow)/(w-2*v)*(2*ow+5), style, false, false)
	lib.add_line(w, ow, -ov+v+7, 2*v+4, style, false, false)
	lib.add_line(2*v, 2*v+ow, 0, v+2*ow, dif_style, false, false)
	lib.add_line(2*v, 2*v+ow, w-2*v, ow, red_style, false, false)
	lib.add_line(w, ow, 0, 2*v+ow, dif_style, false, false)
	lib.add_circle(2*v, ov, 2.5, point_style, false, false)  
	lib.add_text(2*v-ow, ov, "A", text_style, false, false)
	lib.add_circle(2*v, 2*v+ow, 2.5, point_style, false, false)
	lib.add_text(2*v-ow, 2*(v+ow), point[1], text_style, false, false)
	lib.add_circle(w, ow, 2.5, point_style, false, false) 
	lib.add_text(w+ow, ow, "B", text_style, false, false)
	lib.add_circle(w, w-ov, 2.5, point_style, false, false) 
	lib.add_text(w+ow, w-ov, point[2], text_style, false, false)
	lib.add_circle(ov-2, 2*(v+ow)-6, 2.5, point_style, false, false)  
	lib.add_text(ov, 2*(v+ow)+5, "C", text_style, false, false)
  end
   
  lib.add_text(v-ow, 3*v, plane, text_style, false, false)

  lib.end_canvas()
end   
        
 
     
            