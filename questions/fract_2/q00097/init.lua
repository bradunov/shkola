
include("terms")

style =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

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
	 		  
  lib.start_canvas(330, 300, "center")   

	ow = 8  
	w = 12
	v = 40
	ov = 100
	tab = 156
	

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
   
   	owt = 10  
	wt = 15
	vt = 50
	ovt = 68
	tabt = tab
   
	lib.add_line(owt, tabt, 0, 3*vt-owt, grid_style, false, false)
	lib.add_line(owt+vt, tabt, 0, 3*vt-owt, grid_style, false, false)
	for i = 1,4 do 
		lib.add_line(owt+vt + i*(vt+wt), tabt, 0, 3*vt-owt, grid_style, false, false)
	end
	lib.add_line(owt, tabt, 4*ovt+vt-owt, 0, grid_style, false, false)	 
	for j = 1,3 do
		lib.add_line(owt, tabt+j*vt-owt, 4*ovt+vt-owt, 0, grid_style, false, false)
	end

	for j = 1,2 do
		lib.add_text(vt-wt, j*vt+tabt+2*owt, name[j], text_style, false, false)  
	end
	for i = 1,4 do
		lib.add_text(2*owt + i*ovt, tabt+wt, msg[i], text_style, false, false)	
	end
	lib.add_text(2*owt + 3*ovt, tab+2*wt, msg[5], text_style, false, false)  
	lib.add_text(2*owt + 4*ovt, tabt+2*wt, msg[6], text_style, false, false)  	

	for j = 1,2 do
		for i = 1,2 do	
            lib.add_line(i*(vt+wt)+wt, tabt+j*vt+2*owt, 3*owt, 0, style, false, false)		
			if (i == 1) then
				lib.add_input(i*(vt+wt), tabt+j*vt-owt, 60, 60, lib.check_number(size[j]*10,20))
				lib.add_text(i*(vt+wt)+3*owt, tabt+j*vt+3*owt, "100", text_style, false, false) 
			else			
				lib.add_input(i*(vt+wt), tabt+j*vt-owt, 60, 60, lib.check_number(size[j],20))
				lib.add_text(i*(vt+wt)+3*owt, tabt+j*vt+3*owt, "10", text_style, false, false) 
			end		
		end	
		for i = 3,4 do		
			if (i == 3) then
				lib.add_input(i*(vt+wt), tabt+j*vt, 60, 60, lib.check_number(size[j]/10,20))
			else			
				lib.add_input(i*(vt+wt), tabt+j*vt, 60, 60, lib.check_number(size[j]*10,20))
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
      