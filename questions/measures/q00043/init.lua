
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

colour_style = 
	{["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "000",
        ["line_width"] = "1"};

brown_style = 
	{["off_color"] = "c90",
        ["on_color"] = "c90",
        ["line_color"] = "000",
        ["line_width"] = "1"};

red_line = 
	{["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "f90",
        ["line_width"] = "6"};

blue_line = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "6f6",
        ["line_width"] = "3"};
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "14"}


name = {"čas", "časa", "časova"}

period = {"pre", "posle"}
index = math.random(2)

ind_h = math.random(12) - 1
numb_h = ind_h 
if (index == 2) then
    numb_h = numb_h + 12
end

hour = name[3]
if (numb_h == 1 or numb_h == 21) then
    hour = name[1] 
end
if (numb_h > 1 and numb_h < 5) then
    hour = name[2] 
end
if (numb_h == 22 or numb_h == 23) then
    hour = name[2] 
end	

ind_m = math.random(12) - 1 
numb_m = 5*ind_m 

  w = 5 
  ow = 10
  ov = 15
  wy = 100
  oc = 150

  cor = 0.02*wy
  ad = cor * ind_m
  if (ind_h>2 and ind_h < 9) then
     xad = -ad
  else
     xad = ad
  end
  if (ind_h < 6) then
     yad = ad
  else
     yad = -ad
  end

--[[blue]]--
if (ind_m == 0) then
   xm = 0 
   ym = -wy+2*ow 
end
if (ind_m == 1) then
   xm = wy/2-ow/5 
   ym = -wy+2*ow 
end
if (ind_m == 2) then
   xm = wy-ov 
   ym = -wy/2 
end
if (ind_m == 3) then
   xm = wy 
   ym = 0 
end
if (ind_m == 4) then
   xm = wy-ov 
   ym = wy/2-w 
end
if (ind_m == 5) then
   xm = wy/2-ow/5 
   ym = wy-2*ow 
end
if (ind_m == 6) then
   xm = 0 
   ym = wy-2*ow 
end
if (ind_m == 7) then
   xm = -wy/2+ow/5-2 
   ym = wy-2*ow 
end
if (ind_m == 8) then
   xm = -wy+ov 
   ym = wy/2-w 
end
if (ind_m == 9) then
   xm = -wy 
   ym = 0 
end
if (ind_m == 10) then
   xm = -wy+ov 
   ym = -wy/2+w 
end
if (ind_m == 11) then
   xm = -wy/2+ow/5-2 
   ym = -wy+2*ow 
end

--[[red]]--
if (ind_h == 0) then
   xh = 0 
   yh = -wy+2*ov  
end
if (ind_h == 1) then
   xh = wy/2-ov 
   yh = -wy+3*ov 
end
if (ind_h == 2) then
   xh = wy-4*ow 
   yh = -wy/3 
end
if (ind_h == 3) then
   xh = wy-2*ov 
   yh = 0 
end
if (ind_h == 4) then
   xh = wy-4*ow
   yh = wy/3 
end
if (ind_h == 5) then
   xh = wy/2-ov 
   yh = wy-3*ov 
end
if (ind_h == 6) then
   xh = 0 
   yh = wy-2*ov 
end
if (ind_h == 7) then
   xh = -wy/2+ov 
   yh = wy-3*ov 
end
if (ind_h == 8) then
   xh = -wy+4*ow 
   yh = wy/3 
end
if (ind_h == 9) then
   xh = -wy+2*ov 
   yh = 0 
end
if (ind_h == 10) then
   xh = -wy+4*ow 
   yh = -wy/3 
end
if (ind_h == 11) then
   xh = -wy/2+ov
   yh = -wy+3*ov 
end


	
mycanvas = function()

  lib.start_canvas(300, 300, "center")

  lib.add_circle (oc, 2*ow, ow, brown_style, true, false )
  lib.add_ellipse(oc, 2*ov+ow, 2*ov, ov, colour_style, true, false )

  lib.add_circle (oc, oc, wy+ow, colour_style, true, false )
  lib.add_circle (oc, oc, wy, style, true, false )

  lib.add_circle (oc-3*ov, 2*(oc-ov)-ow, ow, brown_style, true, false )
  lib.add_circle (oc+3*ov, 2*(oc-ov)-ow, ow, brown_style, true, false )


  lib.add_straight_path(oc, wy/2, {{0, ov}}, style,  false, false)
  lib.add_text(oc, wy/2+2*ow, "12", text_style, false, false)  
  lib.add_straight_path(oc+wy/2, 2*wy/3, {{-w, ow}}, style,  false, false)
  lib.add_text(oc+wy/2-ow, 2*wy/3+2*ow-w, "1", text_style, false, false)   
  lib.add_straight_path(oc+2*wy/3+2*ow, wy, {{-ow, w}}, style,  false, false)
  lib.add_text(oc+2*wy/3, wy+w, "2", text_style, false, false)

  lib.add_straight_path(oc+wy-ov, oc, {{ ov, 0}}, style,  false, false)
  lib.add_text(oc+wy-2*ow, oc, "3", text_style, false, false)   
  lib.add_straight_path(oc+wy/2, oc+wy-ov, {{-w, -ow}}, style,  false, false)
  lib.add_text(oc+2*wy/3, oc+wy/2-ov, "4", text_style, false, false)  
  lib.add_straight_path(oc+2*wy/3+2*ow, oc+2*wy/3-ov-w, {{-ow, -w}}, style,  false, false) 
  lib.add_text(oc+wy/2-ow, oc+2*wy/3, "5", text_style, false, false)   
  
  lib.add_straight_path(oc, oc+wy-ov, {{0, ov}}, style,  false, false)
  lib.add_text(oc, oc+wy-ov-ow, "6", text_style, false, false) 
  lib.add_straight_path(wy/2+ov-2, oc+2*wy/3-ov-w, {{ow, -w}}, style,  false, false)
  lib.add_text(wy+w, oc+2*wy/3, "7", text_style, false, false)  
  lib.add_straight_path(2*wy/3+3*ow, oc+wy-ov, {{w, -ow}}, style,  false, false)
  lib.add_text(2*wy/3+ov, oc+wy/2-ow, "8", text_style, false, false)   

  lib.add_straight_path(oc-wy, oc, {{ ov, 0}}, style,  false, false)
  lib.add_text(wy-2*ov, oc, "9", text_style, false, false)  
  lib.add_straight_path(2*wy/3+3*ow, oc-wy+ov, {{w, ow}}, style,  false, false) 
  lib.add_text(2*wy/3+ov, wy+ow, "10", text_style, false, false)  
  lib.add_straight_path(wy/2+ov-2, oc-2*wy/3+ov+w, {{ow, w}}, style,  false, false)  
  lib.add_text(wy+w, 2*wy/3+ov, "11", text_style, false, false) 

  lib.add_straight_path(oc, oc, {{xm, ym}}, blue_line,  false, false)
  lib.add_straight_path(oc, oc, {{xh+xad, yh+yad}}, red_line,  false, false)

  lib.add_text(oc, oc-ow, ".", dot_style, false, false)

       
  lib.end_canvas()
end      
             
                           
                       
       
     
                
                            
                       
    