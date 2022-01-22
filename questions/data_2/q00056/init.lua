
line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};
					
text_style = {["font_size"] = "14"}	

arg = {}
fun = {}
out = {}

coef = 1 + math.random(8)
ch = math.random(2)
if (ch == 2) then
    coef = 1/coef
end

min_range = 2
max_range = 12
range = max_range - min_range + 1
dim = 6

for i = min_range,max_range do
    out[i] =  i
end	

ind = math.random(2)
if (ind == 1) then
    arg = lib.math.random_shuffle(out)
else
    fun = lib.math.random_shuffle(out)	
end	

for i = 1,range do
    if (ind == 1) then
        fun[i] = arg[i] * coef 
	else
	    arg[i] = fun[i] / coef
	end	
end	
test_a = arg[range]
test_f = fun[range]


  mycanvas = function()

  lib.start_canvas(350, 100, "center")
  
    ow = 15
	ov = 10	
    v = 5
	w = 20     

	 
    for i = 1,dim+1  do
        lib.add_line(i*2*(w+v)-ov, ow, 0, 3*w, line_style, false, false)
    end
    lib.add_line(ov, ow, 0, 3*w, line_style, false, false)

    for i = 1,2 do
        lib.add_line(ov, i*(w+ov)+ow, 17*w-ov, 0, line_style, false, false)
    end
    lib.add_line(ov, ow, 17*w-ov, 0, line_style, false, false)

    tmp = math.random(dim)

	
    for i = 1,dim do
	    if (i == tmp) then
		    lib.add_text(ow+2*i*(w+v), 2*ow, lib.dec_to_str(lib.math.round_dec(test_a, 3)), text_style, false, false)
            lib.add_text(ow+2*i*(w+v), 3*w, lib.dec_to_str(lib.math.round_dec(test_f, 3)), text_style, false, false)	
        else			
	        sgn = math.random(2)				
	        if (sgn == 1) then
                lib.add_text(ow+2*i*(w+v), 2*ow, lib.dec_to_str(lib.math.round_dec(arg[i], 3)), text_style, false, false)
                lib.add_input(2*i*(ow+ov)-ov, ov+2*w, 50, 30, lib.check_number(lib.math.round_dec(fun[i], 3),30))			   
	        else
                lib.add_input(2*i*(ow+ov)-ov, w, 50, 30, lib.check_number(lib.math.round_dec(arg[i], 3),30))
                lib.add_text(ow+2*i*(w+v), 3*w, lib.dec_to_str(lib.math.round_dec(fun[i], 3)), text_style, false, false)	
            end				
	    end		
    end

    lib.add_text(w+v, 2*ow, "x", text_style, false, false)  
    lib.add_text(w+v, 3*w, "y", text_style, false, false) 

  lib.end_canvas()
end       
                  
          
            
 