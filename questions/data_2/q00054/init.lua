
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
coef = {} 
out = {}

coef[1] = 0.25
coef[2] = 0.25
coef[3] = 1/3
coef[4] = 0.5
coef[5] = 1

max_x = 14
dim_x = max_x + 1
max_y = 7
dim_y = max_y + 1
dim = 6
ch = math.random(3)

for i = 1,max_x-3 do
    out[i] = 2 + i
end	
arg = lib.math.random_shuffle(out)
for i = 1,max_x-3 do
    fun[i] = coef[ch] * arg[i]
end	

  results = ""
  ind = 0
  if (ch < 3) then
      ind = 1
  else
      ind = 2
  end
  
  for i = 1, 4 do     
      if i > 1 then
         results = results .. " && "
      end
      results = results .. "result[" .. tostring(i-1) .. "] == "      
      if (i == ind ) then
          results = results .. "1"
      else
          results = results .. "0"
      end
  end
  
  mycanvas = function()

  lib.start_canvas(350, 250, "center", results)
  
    ow = 15
	ov = 10	
    v = 5
	w = 20

    dx = math.floor(270/max_x)	
    scale = dim_y * dx + w + ov

    for i = 2,4 do			
	    lib.add_line(w, dim_y*dx -ov, max_x*dx, -coef[i]*max_x*dx, dif_style, false, true)		
    end
	tmy = ov+(dim_y-1)*dx - ov
    tmx = tmy * coef[5]			
	lib.add_line(w, dim_y*dx -ov, tmx, -tmy, dif_style, false, true)	
	
    for i = 1, dim_x do
       lib.add_line(w+i*dx, ov, 0, max_y * dx, style, false, false)
	   if (i == 2*math.floor(i/2)) then
          lib.add_text(w+i*dx, dim_y*dx, i, small_style)  	  
       end		  
    end
  
    for i = 1, dim_y do
        lib.add_line(w, ov+(i-1)*dx, dim_x * dx, 0, style, false, false)
		tmp = max_y-i
	   if (tmp == 2*math.floor(tmp/2) and tmp ~= 0) then
          lib.add_text(ov, ov+i*dx, tmp, small_style)  	  
       end			
    end

    lib.add_line(ov, ov+max_y*dx, ow+dim_x*dx, 0, line_style, false, false)
    lib.add_line(w, ov-v, 0, ow+max_y*dx, line_style, false, false)
    lib.add_text(w+dim_x*dx, ow+(max_y-1)*dx, axis[1], small_style)  
	lib.add_text(ow+dx, 2, axis[2], small_style) 
    lib.add_text(ov, dim_y*dx, "0", small_style)	   
       
 
    for i = 1,dim+1  do
        lib.add_line(i*2*(w+v)-ov, scale, 0, 3*w, line_style, false, false)
    end
    lib.add_line(ov, scale, 0, 3*w, line_style, false, false)

    for i = 1,2 do
        lib.add_line(ov, i*(w+ov)+scale, 17*w-ov, 0, line_style, false, false)
    end
    lib.add_line(ov, scale, 17*w-ov, 0, line_style, false, false)

    for i = 1,dim do
	    sgn = math.random(2)		
	    if (sgn == 1) then
            lib.add_text(ov+2*i*(w+v), scale+ow, arg[i], text_style, false, false)
            lib.add_input(2*i*(ow+ov)-v, scale+2*w-v, 50, 30, lib.check_number(lib.math.round_dec(fun[i], 2),30))			   
	    else
            lib.add_input(2*i*(ow+ov)-v, scale+v, 50, 30, lib.check_number(arg[i],30))
            lib.add_text(ov+2*i*(w+v), scale+2*w+v, lib.dec_to_str(lib.math.round_dec(fun[i], 2)), text_style, false, false)				   
	    end
    end

    lib.add_text(w+v, scale+ow, "x", text_style, false, false)  
    lib.add_text(w+v, scale+2*w+v, "y", text_style, false, false) 

  lib.end_canvas()
end       
          
            
 