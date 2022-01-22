
style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};
		
dif_style = {["off_color"] = "fff",
             ["on_color"] = "fff",
             ["line_color"] = "f9c",
			 ["off_line_color"] = "f9c",
             ["line_width"] = "2"};		

line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
					
text_style = {["font_size"] = "14"}
small_style = {["font_size"] = "12"}	

arg = {}
fun = {}
coef = {} 

coef[1] = 0.2
coef[2] = 5
coef[3] = 0.25
coef[4] = 4
coef[5] = 1/3
coef[6] = 3
coef[7] = 0.5
coef[8] = 2
coef[9] = 1

ch = math.random(9)

max_x = 10
dim_x = max_x + 1

arg[1] = math.random(max_x-1)
fun[1] = lib.math.round_dec(coef[ch] * arg[1] , 2)
fun[2] = math.random(max_x-1)
if (fun[2] == fun[1]) then
	fun[2] = fun[2] + 1
end	
arg[2] = lib.math.round_dec(fun[2] / coef[ch], 2) 

 
  mycanvas = function()

  lib.start_canvas(280, 230, "center")
  
    ow = 15
	ov = 10	
    v = 5
	w = 20

    dx = math.floor(200/max_x)	
	
	tmx = max_x*dx
	if (coef[ch] > 1) then
		tmx = math.floor(tmx / coef[ch])	
	end	
	tmy = tmx*coef[ch]	
	lib.add_line(w, dim_x*dx -ov, tmx, -tmy, dif_style, false, false)		

    for i = 1, dim_x do
       lib.add_line(w+i*dx, ov, 0, max_x * dx, style, false, false)
	   if (i == 2*math.floor(i/2)) then
          lib.add_text(w+i*dx, dim_x*dx, i, small_style)  	  
       end		  
    end
  
    for i = 1, dim_x do
        lib.add_line(w, ov+(i-1)*dx, dim_x * dx, 0, style, false, false)
		tmp = max_x-i
	   if (tmp == 2*math.floor(tmp/2) and tmp ~= 0) then
          lib.add_text(ov, ov+i*dx, tmp, small_style)  	  
       end			
    end

    lib.add_line(ov, ov+max_x*dx, ow+dim_x*dx, 0, line_style, false, false)
    lib.add_line(w, ov-v, 0, ow+max_x*dx, line_style, false, false)
    lib.add_text(w+dim_x*dx, w+(max_x-1)*dx, "x", text_style)  
	lib.add_text(ov+dx, 2, "y", text_style) 
    lib.add_text(ov, dim_x*dx, "0", small_style)	   
       

  lib.end_canvas()
end       
             
            
 