
include("names")
include("terms")

style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};
		
dif_style = {["off_color"] = "fff",
             ["on_color"] = "fff",
             ["line_color"] = "3c3",
			 ["off_line_color"] = "000",
             ["line_width"] = "2"};		

line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};
					
text_style = {["font_size"] = "14"}
small_style = {["font_size"] = "12"}	

name = {}
name_a = {}
r1 = math.random(#zensko_ime_nom)
r2 = math.random(#musko_ime_nom)
name[1] = zensko_ime_nom[r1]
name[2] = musko_ime_nom[r2] 
name_a[1] = zensko_ime_gen[r1]
name_a[2] = musko_ime_gen[r2] 

vel = {}
free = {}
equ = {""}

free[1] = 0
free[2] = 500 + math.random(1500) 
for i = 1,2 do
	vel[i] = 50 + math.random(50) 
	tmp = vel[i]
	if (i == 2) then
		tmp = - tmp	
	end
    equ[i] = "y = " .. lib.check_number(tmp, 30) .. "* x " .. lib.check_string(" + ", 10) .. lib.check_number(free[i], 30)	
end 

ind = math.random(2)


dim_x = free[2]/vel[2]               
dim_y = free[2]     

                
                
mycanvas = function()

  if (ind == 1) then	
	  results = "result[0] == 1 && result[1] == 0"       	
  else 
	  results = "result[0] == 0 && result[1] == 1"     
  end

  lib.start_canvas(310, 190, "center", results)
 
	w = 30 
    ow = 25
	ov = 15	
    v = 10

    stamp_y = 6
    dx = 270/dim_x
    dy = 150/dim_y
	sx = lib.math.round(dim_x/10)
	sy = math.floor(free[2]/stamp_y)	
    sdx = sx * dx
    sdy = sy * dy	
	corr_y = free[2] - stamp_y*sy	
	
    grad = vel[1]/vel[2]
	if (grad > 1 ) then
	    xx = dim_y*dy / grad
	    yy = dim_y*dy
	else
		xx = dim_x*dx
		yy = grad*dim_y*dy	
    end			   	   
	lib.add_line(w, ow+(dim_y+corr_y)*dy, xx, -yy+corr_y*dy, dif_style, false, true)		
	lib.add_line(w, ow-corr_y*dy, dim_x*dx, dim_y*dy, dif_style, false, true)		

	stamp_x = lib.math.round(dim_x/sx) 	
    for i = 1, stamp_x do
        lib.add_line(w+i*sdx, ow, 0, (dim_y+corr_y)*dy, style, false, false)
		if (i-2*math.floor(i/2) == 0) then
			arg = tostring(i * sx)		
			lib.add_text(w+i*sdx, v+ow+(dim_y+corr_y)*dy, arg, small_style) 
        end			
    end
    lib.add_text(ow, ow+v+(dim_y+corr_y)*dy, "0", small_style) 
			
	for i = 1, stamp_y do
	    if (i == stamp_y) then
		    fun = free[2]
		else
			fun = tostring(i * sy)
		end
        lib.add_line(w, ow+(dim_y+corr_y)*dy-i*sdy, stamp_x*sdx, 0, style, false, false) 
  		lib.add_text(ov, ow+(dim_y+corr_y)*dy-i*sdy, fun, small_style)  
    end
	
    lib.add_line(w, ow+(dim_y+corr_y-1)*dy, v+(dim_x+2)*dx, 0, line_style, false, false)
    lib.add_line(w, ov, 0, v+(dim_y+corr_y)*dy, line_style, false, false)
    lib.add_text(dim_x*dx, v+(dim_y-1)*dy, axis[1], small_style)  
	lib.add_text(2*w+ov, v, axis[2], small_style) 
	
  lib.end_canvas()
end   
            