
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};		
		
text_style = {["font_size"] = "14"}		

meas = {"°", "'"}
numb = {"α", "β", "γ", "δ"}

ang_g = {}
ang_m = {}
answ = {}

ch = math.random(2)

sign = math.random(3)
first_g = 50 +(2 - sign) * math.random(15)
first_m = math.random(59) - 1

ang_g[2] = first_g 
ang_m[2] = first_m 	
ang_g[3] = 179 - first_g 
ang_m[3] = 60 - first_m 
temp =  math.floor(ang_m[3]/60) 
ang_g[3] = ang_g[3] + temp    
ang_m[3] = ang_m[3] - 60 * temp

if (ch == 1) then
    ang_g[1] = 90
    ang_m[1] = 0
    ang_g[4] = 90 
    ang_m[4] = 0 	
else	
    ang_g[1] = ang_g[2] 
    ang_m[1] = ang_m[2] 
    ang_g[4] = ang_g[3]
    ang_m[4] = ang_m[3]
end	

out = 1 + math.random(2)
number = numb[out]
dat = ang_g[out] .. meas[1] .. " "
if (ang_m[out] ~= 0) then
    dat = dat .. ang_m[out] .. meas[2] .. " "
end	

for i = 1,4 do
    answ[i] = lib.check_number(ang_g[i],30) .. meas[1] .. " "	
    if (ang_m[i] ~= 0) then
        answ[i] = answ[i] .. lib.check_number(ang_m[i],20) .. meas[2] .. " "
	end	
end	

mycanvas = function(no)

  ow = 10
  w = 250
  ov = 150
  v = 40

  lib.start_canvas(320, 160, "center")
    
  lib.add_straight_path(2*v, v, {{ov, 0}, {v, 2*v}, {-ov-2*v, 0}}, style, true, false)    

  if (ch == 1) then 
     lib.add_straight_path(2*v, v, {{-v, 0}, {0, 2*v}}, style, true, false)
     lib.add_text(v+ow, 3*ow, "D", text_style)
  else
     lib.add_straight_path(2*v, v, {{-v, 2*v}}, style, true, false)
     lib.add_text(2*v+ow, 3*ow, "D", text_style)
end

  lib.add_text(v+ow, 3*v+ow, "A", text_style) 
  lib.add_text(w+2*ow, 3*v+ow, "B", text_style)
  lib.add_text(w-v+ow, 3*ow, "C", text_style)

  lib.end_canvas()
end   
       
  
      
  

       

            
            
            
          