
include("terms")

line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};
					
text_style = {["font_size"] = "14"}	

arg = {}
fun = {}
out = {}

coef = 0.5 * (3 + math.random(7))

min_range = 3
max_range = 12
range = max_range - min_range + 1
dim = 6

for i = min_range,max_range do
    out[i] =  i * 0.5
end	
arg = lib.math.random_shuffle(out)

for i = 1,range do
    fun[i] = arg[i] * coef 
end	
test_a = 1
test_f = coef


  mycanvas = function()

  lib.start_canvas(350, 100, "center")
  
    ow = 15
	ov = 10	
    v = 5
	w = 20     

	 
    for i = 2,dim+1  do
        lib.add_line(i*2*(w+v)-ov, ow, 0, 4*w, line_style, false, false)
    end
    lib.add_line(v, ow, 0, 4*w, line_style, false, false)
    lib.add_line(2*w+ow, ow, 0, 4*w, line_style, false, false)

    for i = 1,2 do
        lib.add_line(v, i*(w+2*ov)+ow, 17*w-v, 0, line_style, false, false)
    end
    lib.add_line(v, ow, 17*w-v, 0, line_style, false, false)

    lib.add_text(w+2*(w+v), 2*ow+v, lib.dec_to_str(lib.math.round_dec(test_a, 3)), text_style, false, false)
    lib.add_text(w+2*(w+v), 3*w+ov, lib.dec_to_str(lib.math.round_dec(test_f, 3)), text_style, false, false)			
	
    for i = 2,dim do
	    sgn = math.random(2)				
	    if (sgn == 1) then
            lib.add_text(ow+2*i*(w+v), 2*ow+v, lib.dec_to_str(lib.math.round_dec(arg[i], 3)), text_style, false, false)
            lib.add_input(2*i*(ow+ov)-ov, 3*w, 50, 30, lib.check_number(lib.math.round_dec(fun[i], 3),35))			   
	    else
            lib.add_input(2*i*(ow+ov)-ov, w+v, 50, 30, lib.check_number(lib.math.round_dec(arg[i], 3),30))
            lib.add_text(ow+2*i*(w+v), 3*w+ov, lib.dec_to_str(lib.math.round_dec(fun[i], 3)), text_style, false, false)	
        end						
    end

    lib.add_text(w+ov, 2*ow-v, axis[1], text_style, false, false)  
    lib.add_text(w+ov, 2*ow+ov, "(h)", text_style, false, false) 
    lib.add_text(w+ov, 3*w+v, axis[2], text_style, false, false) 
    lib.add_text(w+ov, 4*w, "(km)", text_style, false, false) 

  lib.end_canvas()
end            