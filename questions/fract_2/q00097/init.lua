
include("terms")
msg = {"stotine", "desetine", "decimal.", "procen.", "broj", "%" } 
name = {"žuta", "zelena"} 

style =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};

green_style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "1"};

yelow_style = 
	{["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "ff0",
        ["line_width"] = "1"};	
	
grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};	
		
text_style = {["font_size"] = "16"}
		
								
x = {}
y = {}
size = {}
broj = {}
reply = {""}
ans = {""}

mycanvas = function()
	 		  
  lib.start_canvas(330, 350, "center")   

	ow = 10  
	w = 15
	v = 50
	ov = 68
	tab = 195

	for i = 1,11 do
	    x[i] = ov+(i-1)*w
	    y[i] = i*w
	end

   --[[yelow]]--

	i = 2 + math.random(3)
	j = 1 + math.random(3)
	ind = 0
	lib.add_straight_path (x[1], y[1], {{x[i] - x[1],0}, {0,y[j] - y[1]}, {x[1] - x[i],0}, {0,y[1] - y[j]}}, yelow_style, true, true)  
	area = (i - 1) * (j - 1)
	size[1] = math.ceil(area/10)
	if (area ~= 10) then
	if (area < 10) then
		add = 10 - area	
	else
		add = 20 - area
	end
	if (add == 1) then
		p = 1
		s = 1
	else
		if (add - 2*math.floor(add/2) == 0) then
			p = math.random(2)
			s = add /p
		else
			p = 1
			s = add
		end
		if (j+s > 11) then
			p = add
			s = 1
			ind = j+2
		end
	end			
	lib.add_straight_path (x[1], y[j], {{x[1+p] - x[1],0}, {0,y[j+s] - y[j]}, {x[1] - x[1+p],0}, {0,y[j] - y[j+s]}}, yelow_style, true, true)  		
	end
	 
   --[[green]]-- 
	i = 5 + math.random(4)
	if (ind == 0) then 
	j = math.random(3)	
	else
	j = ind
	end		
	lib.add_straight_path (x[i], y[j], {{x[11] - x[i],0}, {0,y[11] - y[j]}, {x[i] - x[11],0}, {0,y[j] - y[11]}}, green_style, true, true)  
	area = (11 - i) * (11 - j)
	size[2] = math.ceil(area/10)
	if (area - 10*math.floor(area/10) ~= 0) then	 
	add = 10*math.ceil(area/10) - area 
	if (add - 2*math.floor(add/2) == 0) then
		p = math.random(2)
		s = add /p
	else
		p = add
		s = 1
	end
	lib.add_straight_path (x[i], y[11], {{x[i-p] - x[i],0}, {0,y[11-s] - y[11]}, {x[i] - x[i-p],0}, {0,y[11] - y[11-s]}}, green_style, true, true)  		
	end   

	for i = 1,11 do
	lib.add_line(ov, i*w, 10*w, 0, grid_style, false, false)
	end
	for i = 1,11 do
	lib.add_line(ov+(i-1)*w, w, 0, 10*w, grid_style, false, false)
	end

   --[[tabela]]-- 
   
	lib.add_line(ow, tab, 0, 3*v-ow, style, false, false)
	lib.add_line(ow+v, tab, 0, 3*v-ow, style, false, false)
	for i = 1,4 do 
		lib.add_line(ow+v + i*(v+w), tab, 0, 3*v-ow, style, false, false)
	end
	lib.add_line(ow, tab, 4*ov+v-ow, 0, style, false, false)	 
	for j = 1,3 do
		lib.add_line(ow, tab+j*v-ow, 4*ov+v-ow, 0, style, false, false)
	end

	for j = 1,2 do
		lib.add_text(v-w, j*v+tab+2*ow, name[j], text_style, false, false)  
	end
	for i = 1,4 do
		lib.add_text(2*ow + i*ov, tab+w, msg[i], text_style, false, false)	
	end
	lib.add_text(2*ow + 3*ov, tab+2*w, msg[5], text_style, false, false)  
	lib.add_text(2*ow + 4*ov, tab+2*w, msg[6], text_style, false, false)  	

	for j = 1,2 do
		for i = 3,4 do		
			if (i == 3) then
				lib.add_input(i*(v+w), tab+j*v, 60, 60, lib.check_number(size[j]/10))
			else			
				lib.add_input(i*(v+w), tab+j*v, 60, 60, lib.check_number(size[j]*10))
			end		
		end
	end	
	
--[[    PROBLEM - STAMPANJE RAZLOMAKA U TABELI
    j = 1,2 do
        reply[j] = ""
	    broj[j] = size[j] * 10
		reply[j] = lib.frac_start() .. lib.check_number(broj[j]) .. lib.frac_mid() .. lib.check_number(100,20) .. lib.frac_end() 	
		lib.add_input(2*ow+ov, tab+j*v, 60, 60, reply[j])
    end		
    j = 1,2 do
        ans[j] = ""
		ans[j] = lib.frac_start() .. lib.check_number(size[j]) .. lib.frac_mid() .. lib.check_number(10,20) .. lib.frac_end() 	
		lib.add_input(2*ow+2*ov, tab+j*v, 60, 60, ans[j])
    end		
]]--
				
  lib.end_canvas()

  total = (size[1] + size[2]) * 10  
end
