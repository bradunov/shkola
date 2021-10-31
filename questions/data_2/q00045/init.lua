
include("names")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};
		
dash_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};		
		
axis_style = 
	{["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};	
		
red_line = {["off_color"] = "none",
               ["on_color"] = "none",
               ["off_line_color"] = "f30",
               ["on_line_color"] = "000",			   
               ["line_width"] = "2"};			   

blue_line = {["off_color"] = "none",
               ["on_color"] = "none",
               ["off_line_color"] = "0cf",
               ["on_line_color"] = "000",			   
               ["line_width"] = "2"};			   

green_line = {["off_color"] = "none",
               ["on_color"] = "none",
               ["off_line_color"] = "3c3",
			   ["on_line_color"] = "000",
               ["line_width"] = "2"};			
			
text_style = {["font_size"] = "14"}


rz = math.random(#zensko_ime_nom);
rm = math.random(#musko_ime_nom)
imez = zensko_ime_nom[rz];
imem = musko_ime_nom[rm] 

x = {}
y = {}
out = {}
ind = {}
index = {1, 2, 3}

start = 1 + math.random(4)
init_temp = -5 * start


out[1] = 11 + start/2
out[2] = 1
out[3] = 11	

stampa = 3    

for i = 1,stampa do
    x[i] = {}
    x[i][1] = math.random(3)
	x[i][2] = 2 + math.random(4)  
	x[i][3] = 4 + math.random(5)	
	x[i][4] = 20 - x[i][1] - x[i][2] - x[i][3] 	
end

ind = lib.math.random_shuffle(index)

fin_ice = 0
for i = 1,stampa do
    if (ind[i] == 1) then	  
        fin_ice = x[i][1] + x[i][2]
	end
end	

  results = "" 
  for i = 1,stampa do 
      nr = i - 1
      if (nr > 0) then
          results = results .. "&& "
      end
      results = results .. "result[" .. tostring(nr) .. "] == "
      if (ind[i] == 1) then		      		  
          results = results .. "1 "
      else
          results = results .. "0 "
      end
  end
  
  
mycanvas = function()

  lib.start_canvas(350, 260, "center", results)

    w = 15
    ow = 20
    v = 5
  
  
    for i = 1,stampa do
	    init = out[ind[i]]
        if (ind[i] == 1) then	  
            y[1] = - start/2 
            y[2] = 0
            y[3] = -10
            y[4] = 0 
	    end	  
        if (ind[i] == 2) then
            y[1] = 0 
            y[2] = start
            y[3] = 0
            y[4] = 8 
	    end
        if (ind[i] == 3) then
            y[1] = -start/2 
            y[2] = - math.random(4)
            y[3] = 0
            y[4] = -10 - y[1] - y[2] - y[3]	  
	    end	
		if (i == 1) then
            st_style = red_line
        end	
        if (i == 2) then
            st_style = blue_line
        end
        if (i == 3) then
            st_style = green_line
        end
        lib.add_straight_path(ow+w, ow+init*w, {{x[i][1]*w,y[1]*w}, {x[i][2]*w,y[2]*w}, {x[i][3]*w,y[3]*w}, {x[i][4]*w,y[4]*w}}, st_style, false, true)  
    end	  
  
    for i = 1,21 do
       lib.add_line(ow+i*w, ow, 0, 14*w, style, false, false)
    end
  
    for i = 1,15 do
        lib.add_line(ow+w, ow+(i-1)*w, 20*w, 0, style, false, false)
    end

    lib.add_line(ow+w-v, ow+14*w, 21*w-v, 0, axis_style, false, false)
    lib.add_line(ow+w, ow-v, 0, 15*w-v, axis_style, false, false)
  
    zero = ow+11*w
    for i = 1,3 do
        text = tostring((i-1)*50)
        lib.add_text(w, zero-5*(i-1)*w, text, text_style) 
        lib.add_line(ow+w-v, zero-5*(i-1)*w, 2*v, 0, dash_style, false, false)	
    end	
    lib.add_text(w, ow+14*w, "-30", text_style)
    lib.add_text(2*(ow+v), ow, "°C", text_style)   
    lib.add_straight_path(2*(ow-v), ow, {{v,-2*v}, {v, 2*v}}, axis_style, false, false)
  
    for i = 1,5 do
        text = tostring((i-1)*5)
        lib.add_text(ow+w+5*(i-1)*w, ow+15*w, text, text_style) 
        lib.add_line(ow+w+5*(i-1)*w, ow+14*w-v, 0, 2*v, dash_style, false, false)	
    end	  
    lib.add_text(ow+21*w, ow+13*w, "min", text_style) 
    lib.add_straight_path(ow+21*w, ow+14*w-v, {{2*v,v}, {-2*v,v}}, axis_style, false, false)

  lib.end_canvas()
  
end  