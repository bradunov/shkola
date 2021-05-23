
include("terms")

style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
dif_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};		

blue_style = 
	{["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "1"};				
		
text_style = {["font_size"] = "14"}		

meas = {"\(^\circ\)", "'"}
symb = "\(\small\angle\)"

numb = {"α", "β", "ω", "γ", "δ"}

ang_g = {}
ang_m = {}

answ = {}
ind = {}

dat = ""

sign = math.random(3)
first_g = 50 +(2 - sign) * math.random(20)
first_m = math.random(59) - 1

ang_g[1] = first_g 
ang_m[1] = first_m 
ang_g[2] = 179 - first_g 
ang_m[2] = 60 - first_m 
temp =  math.floor(ang_m[2]/60) 
ang_g[2] = ang_g[2] + temp    
ang_m[2] = ang_m[2] - 60 * temp

ch = math.random(3)

if (ch == 1) then
    angle_g = ang_g[2]
    angle_m = ang_m[2]
end	

if (ch == 2) then
    angle_g = 89 - ang_g[1]
    angle_m = 60 - ang_m[1]
    temp =  math.floor(angle_m/60) 
    angle_g = angle_g + temp    
    angle_m = angle_m - 60 * temp	
end	

if (ch == 3) then
    angle_g = ang_g[1]
    angle_m = ang_m[1]
end	
	
dat = angle_g .. meas[1] .. " "
if (angle_m ~= 0) then
    dat = dat .. angle_m .. meas[2] .. " "
end

for i = 1,2 do
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

  lib.start_canvas(320, 220, "center")

  if (ch == 1) then
      lib.add_straight_path(v+ow, ov-2*ow, {{0, -ov+v+2*ow}, {2*v, 0}}, dif_style, true, false)  
      lib.add_straight_path(w-v-ow, ov-2*ow, {{-v-ow-3, 2*v-ow+3}, {-2*v-2*ow+2, -2*v+5}}, dif_style, true, false)
      lib.add_text(ov, ov+v+2*ow, "P", text_style)
      lib.add_text(v+ow, 3*ow, "Q", text_style)
      lib.add_straight_path(5*ow, 2*v, {{0, v+ow }, {4*ow, 3*ow}}, blue_style, true, false) 
      lib.add_input(v+3, w-ov+7,  50, 30, numb[3])
      lib.add_input(w-v+5, v, 50, 30, numb[1])  
      lib.add_input(2*v+ow, v, 50, 30, numb[2])  	
  end 
  
  if (ch == 2) then
      lib.add_straight_path(2*v+ow, 2*v-ow, {{2*ow, -3*ow}, {0, 4*ow}}, blue_style, true, false)   
      lib.add_straight_path(ov-v, v, {{0, ov-v-2*ow}}, dif_style, true, false)  
      lib.add_text(3*v-5, ov-ow, "P", text_style)
      lib.add_input(2*v-5, v+ow+5,  50, 30, numb[3])
      lib.add_input(v+3, w-ov+5,  50, 30, numb[1])  
      lib.add_input(w-2*v, w-ov+5, 50, 30, numb[2])  	
  end   

  if (ch == 3) then
      lib.add_straight_path(ov-v, v, {{0, ov-v-2*ow}}, dif_style, true, false)  
      lib.add_straight_path(ov-v, v,{{2*(v+ow)+2, 2*v-ow+2}}, dif_style, true, false)
      lib.add_text(ov-v, ov-ow, "P", text_style)
      lib.add_text(w-v+ow, ov-v+5, "Q", text_style)
      lib.add_straight_path(ov-v, 2*v, {{0, -v }, {4*ow, 3*ow-2}}, blue_style, true, false) 
      lib.add_input(2*v+ow+5, v+5, 50, 30, numb[3])
      lib.add_input(v+3, w-ov+5,  50, 30, numb[1])   
      lib.add_input(w-2*v, w-ov+5, 50, 30, numb[2])  	
  end 
  
--[[
  lib.add_straight_path(6*ow+5, ov-5*ow+6, {{-2*ow+4, 3*ow-6 }, {3*ow, 0}}, style, true, false) 
  lib.add_input(v+3, w-ov+5,  50, 30, numb[1]) 
  lib.add_straight_path(w+7, 2*v+ow, {{-3*ow+2, 4*ow}, {-4*ow, 0}}, style, true, false) 
  lib.add_input(w-v-ow, w-ov+5, 50, 30, numb[2]) 
  lib.add_straight_path(w+8, 4*ow, {{3*ow+2, 0}, {-2*ow, 3*ow}}, style, true, false) 
      lib.add_input(w-v+5, v, 50, 30, numb[1])  
  lib.add_straight_path(2*v+ow, 2*v-ow, {{2*ow, -3*ow}, {4*ow, 0}}, style, true, false) 
  lib.add_input(2*v+ow, v, 50, 30, numb[2]) 
]]-- 
 
  lib.add_straight_path(w+ow, v, {{-v-2*ow, 2*v+ow}}, style, true, false)
  lib.add_straight_path(ov-v, v, {{-v-2*ow, 2*v+ow}}, style, true, false) 
  lib.add_straight_path(ov-v, v, {{ov, 0}}, style, true, false)   
  lib.add_straight_path(v+ow, ov-2*ow, {{ov, 0}}, style, true, false)  
 
  lib.add_text(v+ow, ov-ow, "A", text_style) 
  lib.add_text(w-v-ow, ov-ow, "B", text_style)
  lib.add_text(w+ow, 3*ow, "C", text_style)
  lib.add_text(w-ov+ow, 3*ow, "D", text_style)

  lib.end_canvas()
end 
         
         
  
  
      
       
  

       

      
      
      
       
  

       

            
            
            
          