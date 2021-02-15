
colour_style = 
	{["off_color"] = "cfc",
        ["on_color"] = "cfc",
        ["line_color"] = "000",
        ["line_width"] = "2"};

line_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
text_style = {["font_size"] = "16"}

numb = {}
out = {}
xm = {}
ym = {}
xt = {}
yt = {}


total = 12
max = math.floor(total/4)
numb[1] = 1+math.random(max)
numb[2] = numb[1] + math.random(3*max - numb[1])
numb[3]	= total - numb[1] - numb[2]
if (numb[3] < 2) then
    numb[2] = math.floor(numb[2]/2)
	numb[3] = total - numb[1] - numb[2]
end	

factor = 8 + math.random(92)
for i = 1,3 do
    out[i] = numb[i] * factor
end
total = total * factor	

mycanvas = function()

  w = 5 
  ow = 10
  v = 50
  ov = 15
  wy = 100
  oc = 150
  ocy = 120

ind = -1
for i = 1,3 do
    ind = ind + numb[i] 
    if (ind == 0) then
       xm[i] = 0 
       ym[i] = -wy+ow 
       xt[i] = xm[i]-2*ow 
       yt[i] = ym[i]+v 	   
    end
    if (ind == 1) then
       xm[i] = wy/2-ow/5 
       ym[i] = -wy+2*ow 
       xt[i] = 0
       yt[i] = ym[i]+ov 		   
    end
    if (ind == 2) then
       xm[i] = wy-ov 
       ym[i] = -wy/2 
	   xt[i] = xm[i]-v 
       yt[i] = ym[i]-ov
    end
    if (ind == 3) then
       xm[i] = wy 
       ym[i] = 0 
	   xt[i] = xm[i]-v 
       yt[i] = ym[i]-2*ow 	   
    end
    if (ind == 4) then
       xm[i] = wy-ov 
       ym[i] = wy/2-w 
	   xt[i] = xm[i]-ov 
       yt[i] = 0	   
    end
    if (ind == 5) then
       xm[i] = wy/2-ow/5 
       ym[i] = wy-2*ow 
	   xt[i] = xm[i]+ov 
       yt[i] = ym[i]-v	   
    end
    if (ind == 6) then
       xm[i] = 0 
       ym[i] = wy-ow 
	   xt[i] = xm[i]+2*ow 
       yt[i] = ym[i]-v	   
    end
    if (ind == 7) then
       xm[i] = -wy/2+ow/5-2 
       ym[i] = wy-2*ow 
	   xt[i] = 0 
       yt[i] = ym[i]-2*ov	 	   
    end
    if (ind == 8) then
       xm[i] = -wy+ov 
       ym[i] = wy/2-w 
	   xt[i] = xm[i]+v 
       yt[i] = ym[i]+ov	   
    end
    if (ind == 9) then
       xm[i] = -wy 
       ym[i] = 0 
	   xt[i] = xm[i]+v 
       yt[i] = ym[i]+2*ow	   
    end
    if (ind == 10) then
       xm[i] = -wy+ov 
       ym[i] = -wy/2+w 
	   xt[i] = xm[i]+v 
       yt[i] = 0	 	   
    end
    if (ind == 11) then
       xm[i] = -wy/2+ow/5-2 
       ym[i] = -wy+2*ow 
	   xt[i] = xm[i]-ov 
       yt[i] = ym[i]+v	  	   
    end
end
	
  lib.start_canvas(300, 250, "center")

  lib.add_circle (oc, ocy, wy-w, colour_style, true, false )
  corr = math.floor(wy/4)

  ch = math.random(3)
  for i = 1,3 do
      lib.add_straight_path(oc, ocy, {{xm[i], ym[i]}}, line_style,  false, false)    
	  x = oc + xt[i] 
	  y = ocy + yt[i]  	  
	  if (i == ch) then
	     lib.add_text(x, y, tostring(out[i]), text_style, false, false)	 
      else		 
	     lib.add_input(x-ov, y-ov, 50, 30, lib.check_number(out[i],30))
      end  	  
  end 

  lib.end_canvas()
end           

      
                
             
                           
                       
       
     
                
                            
                       
    