
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};

line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
					
text_style = {["font_size"] = "14"}

arg = {}
fun = {}
axis = {"x", "y"}

ch = math.random(4)

if (ch < 3) then 
    coef = ch
else
    if (ch == 3) then
        coef = 0.5
    else
        coef = 1.5	
    end		
end	

min_x = 2
max_x = 9
for i = 1,2 do
    arg[i] = min_x + math.random(max_x - min_x)
    fun[i] = coef * arg[i]
end	

dim_x = max_x + 1 

mycanvas = function()

  lib.start_canvas(250, 190, "center")

    dx = math.floor(150/max_x)	

    ow = 15
    v = 5

	
	lib.add_line(ow+v, dim_x*dx , max_x*dx, -coef*max_x*dx, line_style, false, false)		

    for i = 1, dim_x do
       lib.add_line(ow+v+i*dx, ow, 0, max_x * dx, style, false, false)
	   if (i == 2*math.floor(i/2)) then
          lib.add_text(ow+v+i*dx, v+dim_x*dx, i, text_style)  	  
       end		  
    end
  
    for i = 1, dim_x do
        lib.add_line(ow+v, ow+(i-1)*dx, dim_x * dx, 0, style, false, false)
		tmp = max_x-i
	   if (tmp == 2*math.floor(tmp/2) and tmp ~= 0) then
          lib.add_text(ow-v, ow+i*dx, tmp, text_style)  	  
       end			
    end

    lib.add_line(ow-v, ow+max_x*dx, ow+dim_x*dx, 0, line_style, false, false)
    lib.add_line(ow+v, ow-v, 0, ow+max_x*dx, line_style, false, false)
    lib.add_text(ow+dim_x*dx, ow+v+(max_x-1)*dx, axis[1], text_style)  
	lib.add_text(ow-v+dx, v, axis[2], text_style) 
    lib.add_text(ow-v, v+dim_x*dx, "0", text_style)	

  lib.end_canvas()
  
end              
       
            