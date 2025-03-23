 
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.1"};
		
blue_style = 
        {["line_color"] = "0cf",
        ["off_line_color"] = "0cf",
        ["line_width"] = "1"};		
		
red_style = 
	{["line_color"] = "f30",
        ["off_line_color"] = "f30",
        ["line_width"] = "2"};			
										
text_style = {["font_size"] = "16"}		
	
meas = "°"
symb = "∠"

index = {0, 0, 1, 2, 3}
value = {60, 60, 30, 15, 7.5}
mark = {"", "", "s", "ss", "sss"}

ch = {}
out = {}
qq = {}
ang = {}
sign = {""} 

quest = {""}
y = {}

ch = lib.math.random_shuffle(index)

ind = 1 + math.random(3)

for i = 1,ind do
    qq[i] = ch[i]
end
	
out = lib.math.argsort(qq)

sum = 0
for i = 1,ind do
    for j = 1,5 do
        if (qq[out[i]] == j-1) then
	        ang[i] = value[j]
			sum = sum + ang[i] 
			sign[i] = mark[j]
		end	
	end
end	

reply = ""
answ = ""
for i = 1,ind do
    if (i ~= ind) then
        reply = reply .. lib.check_number(ang[i],20) .. meas .. "+ " 
	    answ = answ .. lib.check_string_case(sign[i],20) .. "O" .. " + "		
	else
        reply = reply .. lib.check_number(ang[i],20) .. meas		
	    answ = answ .. lib.check_string_case(sign[i],20) .. "O" 
	end
end	
       
tng = math.tan(math.pi/6) 
tng2 =  2*tng/(1 - tng*tng)
          
mycanvas = function(no)

  ow = 10
  ov = 75
  v = 5

  x = 11 * ow
  y[1] = 10 * ow * tng
  y[2] = 10 * ow * tng2
  
  xs = 8*ow/(1+tng*tng2)
  ys = xs * tng2

  scale = 0.5  

  lib.start_canvas(300, 120, "center") 
  	
    lib.add_line(2*ow, 2*ov-5*ow+v, ov+4*ow, 0, style, true, false)	  
    lib.add_line(2*ow, 2*ov-4*ow-v, x, -y[1], red_style, false, false)
    lib.add_text(2*ov-ow, 2*ov-5*ow-y[1], "s", text_style, false, false)	 	  
    lib.add_line(2*ow, 2*ov-4*ow-v, x*scale, -y[2]*scale, style, false, false) 
 
    lib.add_line(10*ow, 2*ov-4*ow-v, -8*ow+xs+3, -ys+3, blue_style, true, false)  
    lib.add_line(10*ow+(-8*ow+xs)/4, 2*ov-4*ow-v+(-ys+3)/4, v, 0, blue_style, false, false)    
    lib.add_line(10*ow+3*(-8*ow+xs)/4, 2*ov-4*ow-v+3*(-ys+3)/4, v, 0, blue_style, false, false)     

    lib.add_text(4*ow, ov+2*ow, "O", text_style, false, false)
    lib.add_text(2*ov-4*ow, ov+v, "sO", text_style, false, false)
 
    quest[1] = symb .. "O = 60" .. meas 
    quest[2] = symb .. "sO = 30" .. meas  
    lib.add_input(2*ov, 2*ow, 150, 40, quest[1]) 
    lib.add_input(2*ov, 7*ow, 150, 40, quest[2]) 

  lib.end_canvas()
end               
