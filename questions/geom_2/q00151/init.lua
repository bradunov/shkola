
style = 
       {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};
		
red_style = 
       {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["line_width"] = "2"};	
		
dif_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};		
				
text_style = {["font_size"] = "14"}	

name = {"OA", "AB", "BC", "CD"} 
point = {"A", "B", "C", "D", "P", "Q", "R", "S"}

numb = {}
x = {}
y = {}
g = {}
h = {}
part = {}
dim = {}

quest = {""}

meas = "cm"
space = "\( \ \ \ \ \ \) "
ang = "∡"
	
total = 20
sing = 0

mycanvas = function(no)
 
  lib.start_canvas(320, 180, "center")
  
	ow = 10
	w = 250
	ov = 130
	v = 40
	scale = 2 *(1 + math.random(4))

	step1 = math.floor((w-v)/total)
	last = w - v + math.random(2*v)
	step2 = math.floor(last/total)

	lib.add_straight_path(ow, 3*ow, {{total*step1+2*v, 0}}, red_style, true, false) 
	lib.add_straight_path(ow, 3*ow, {{total*step2+2*v, ov}}, dif_style, true, false)
	coef = ov/(total*step2+2*v)

	xo = ow
	yo = 3*ow		
	lib.add_text(xo, yo-ow, "O", text_style, false, false) 
	numb[1] = 2 + math.random(4)
	x[1] = xo + step1*numb[1]
	y[1] = yo			
	lib.add_text(x[1], y[1]-ow, "A", text_style)
	numb[2] = 2 + math.random(4)		
	x[2] = x[1] + step1*numb[2]
	y[2] = yo				
	lib.add_text(x[2], y[2]-ow, "B", text_style) 
	numb[3] = 2 + math.random(4)		
	x[3] = x[2] + step1*numb[3]
	y[3] = yo				
	lib.add_text(x[3], y[3]-ow, "C", text_style) 
	numb[4] = total 
	for i = 1,3 do
		numb[4] = numb[4] - numb[i]
	end			
	x[4] = step1*total
	y[4] = yo				
	lib.add_text(x[4], y[4]-ow, "D", text_style) 		

	ch = 1 + math.random(3)
	xx = x[ch]
	yy = y[ch]
	gg = (xx-xo)/math.sqrt(1+coef^2)
	hh = gg * coef
	gg = gg + xo
	hh = hh + yo
	
	if (ch == 4) then
		ind = 3
	else 
		ind = ch-2 + math.random(3)
	end
	par = (hh - y[ind])/(gg - x[ind])
	text = "O".. point[4+ind] .. " = " .. "O".. point[ch]
	for i = 1,4 do
		g[i] = (y[i]-yo - x[i]*par+xo*coef)/(coef-par)
		h[i] = yo + coef * (g[i]-xo)
		if (i == 4 and g[i] > total*step2+ov-v) then
			lib.add_text(total*step2+v, ov+ow, point[4+i], text_style)	
			sing = 1
        else		
			lib.add_text(g[i], h[i]+ow, point[4+i], text_style)	
		end
		lib.add_straight_path(g[i], h[i], {{x[i]-g[i], par*(x[i]-g[i])}}, style, true, false) 			
		lib.add_circle (g[i], h[i], 3, style, true, false) 	
	end			
	
	lib.add_circle (xo, yo, 3, style, true, false)
	lib.add_circle (x[1], y[1], 3, style, true, false)		
	lib.add_circle (x[2], y[2], 3, style, true, false) 	
	lib.add_circle (x[3], y[3], 3, style, true, false) 	
	lib.add_circle (x[4], y[4], 3, style, true, false) 		
	lib.add_circle (gg, hh, 3, style, true, false)	

  lib.end_canvas()
  
	dim[1] = lib.math.round(numb[1]*step1/scale)
	part[1] = dim[1] 
	for i = 2,4 do 
	  dim[i] = lib.math.round(numb[i]*step1/scale)
	  part[i] = part[i-1] + dim[i]
	end

	for i = 1,2 do
	  quest[i] = ""
	  if (i == 1) then
	      k = 0
	  else
	      k = 2
	  end         
	  for j = 1,2 do
		  quest[i] = quest[i] .. name[k+j] .. " = " .. dim[k+j] .. meas .. ","
		  if (j == 1) then
			  quest[i] = quest[i] .. space
		  end
	  end
	end	  
  
    ans = ""  
    q1 = math.random(4)
    if (q1 == ind) then
        if (ind == 4) then
		    if (ch == 3) then
				q1 = 2
		    else
				q1 = 3	
			end
	    else
			if (ind == 1) then
				if (ch == 2) then
					q1 = 3
				else
					q1 = 2	
				end		  
			else
			    q1 = q1 - 1
			end
		end
    end
    q2 = math.random(3)	
	if (sing == 1) then
	    q1 = 1
		q2 = 1
    end		
    out1 = part[ch]*part[q1]/part[ind]	
    out1 = lib.math.round_dec(out1,1) 
    tmp = part[ch]*part[q2+1]/part[ind]
	out2 = tmp*dim[q2+1]/part[q2+1]
    out2 = lib.math.round_dec(out2,1)	
    ans = "O" .. point[4+q1] .. " = " .. lib.check_number(out1) .. meas .. "," .. space .. point[4+q2] .. point[4+q2+1] .. " = " .. lib.check_number(out2) .. meas
     
end                    
         