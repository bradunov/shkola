
include("terms")

style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};
		
dif_style = {["off_color"] = "fff",
             ["on_color"] = "fff",
             ["line_color"] = "f9c",
			 ["off_line_color"] = "000",
             ["line_width"] = "2"};		

line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};
					
text_style = {["font_size"] = "14"}
small_style = {["font_size"] = "12"}	

arg = {}
fun = {}
 
out = {}
quest = ""


coef = 2 + math.random(8)
price = 10 * coef
init = 1 + math.random(3)
tv =  10 * coef * init
unit = 10 * math.random(8)
dim = 3 + math.random(4)

for i = 1,dim+1 do
	arg[i] = (i-1) * unit 
	fun[i] = coef * arg[i] + tv
	if (i > 1) then
		quest = quest .. tostring(arg[i]) 
		if (i < dim+1) then
			quest = quest .. ", "  
		end
	end
end 

dim_x = dim + 1              
dim_y = dim + init + 1            
       
mycanvas = function()

  lib.start_canvas(330, 240, "center")
  
    ow = 15
	ov = 10	
    v = 5
	w = 40

    dx = math.floor(270/dim_x)
    dy = math.floor(230/dim_y)
	
	lib.add_line(w+ov, dim*dy +ov, dim*dx, -dim*dy, dif_style, false, false)		
	
    for i = 1, dim+1 do
       lib.add_line(w+ov+(i-1)*dx, ov, 0, (dim+init) * dy, style, false, false)
       lib.add_text(w+ov+(i-1)*dx, dim_y*dy, tostring(arg[i]), small_style)  
	   if (i > 1) then
           lib.add_circle (w+ov+(i-1)*dx, (dim+1-i)*dy+ov, 3, line_style, false, false)	 
       end		   
    end
  
    for i = 1, dim_y+1 do
		if (i <= dim_y) then      
        lib.add_line(w+ov, ov+(i-1)*dy, dim * dx, 0, style, false, false) 
        end
		if (i <= dim+1) then
			lib.add_input(v, (dim+1-i)*dy, 50, 40, lib.check_number(fun[i],30))
     	end	  
    end

    lib.add_line(2*ov, ov+(dim_y-1)*dy, ow+dim_x*dx, 0, line_style, false, false)
    lib.add_line(w+ov, ov-v, 0, dim_y*dy-ow, line_style, false, false)
    lib.add_text((dim_x-1)*dx+2*ow, (dim_y-1)*dy, axis[1], small_style)  
	lib.add_text(dx+w+ow, v, axis[2], small_style) 

  lib.end_canvas()
end    
            
            