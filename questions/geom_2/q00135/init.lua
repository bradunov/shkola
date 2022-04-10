
style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
red_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "f30",
        ["line_width"] = "2"}; 	

blue_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "0cf",
        ["line_width"] = "2"}; 	

green_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "6f6",
        ["line_width"] = "2"}; 	

yelow_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "f90",
        ["line_width"] = "2"}; 		

point_style = 
	{["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};		

grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};	
							
text_style = {["font_size"] = "16"}

meas =  "cm"
dat = {"a", "R", "r", "d\(\small_v\)", "d\(\small_m\)"}
pi = "π"
sign = "≤"
spc = "\( \ \ \)"
numb = {}
quest = ""

root2 = lib.math.round_dec(math.sqrt(2),3)
root3 = lib.math.round_dec(math.sqrt(3),3)	
con = lib.math.round_dec(math.pi/180, 3)

ind = math.random(7)

if (ind == 1) then
    numb[4] = 0
	numb[5] = 0
   	numb[1] = 3 + math.random(15)
	numb[2] = lib.math.round_dec(numb[1] / root3, 3)
    numb[3] = lib.math.round_dec(0.5 *	numb[2],3)	
    quest = dat[1] .. " = " .. numb[1] .. meas 	
    circ = 3 * numb[1]
end	

if (ind == 2) then
    numb[5] = 0  
    ch = math.random(2)
    if (ch == 1) then	
		numb[1] = 3 + math.random(15)
		numb[4] = lib.math.round_dec(numb[1] * root2,3)
		numb[2] = lib.math.round_dec(0.5 * numb[4],3)
		numb[3] = 0.5 *	numb[1]
		quest = dat[1] .. " = " .. numb[1] .. meas 		
	else
    	numb[4] = 3 + math.random(15)
	    numb[2] = 0.5 * numb[4]		
	    numb[1] = lib.math.round_dec(numb[4] / root2, 3)
		numb[3] = lib.math.round_dec(0.5 * numb[1],3)
		quest = dat[4] .. " = " .. numb[4] .. meas 		
    end	
    circ = 4 * numb[1]	
end	

if (ind == 3) then
    numb[5] = 0
    numb[1] = 3 + math.random(15)
	enum = math.sin (54 * con)
	denom = math.sin (72 * con)	
	numb[2] = lib.math.round_dec(numb[1] * enum/denom,3)
    numb[3] = math.sqrt(numb[2]^2 - 0.25*numb[1]^2)
	numb[3] = lib.math.round_dec(numb[3],3)
	numb[4] = math.sqrt((numb[2]+numb[3])^2 + 0.25*numb[1]^2)
	numb[4] = lib.math.round_dec(numb[4],3)	
    circ = 5 * numb[1]	
    quest = dat[1] .. " = " .. numb[1] .. meas .. ", " .. spc .. dat[4] .. " = " .. numb[4] .. meas 	
end	

if (ind == 4) then
    ch = 2 + math.random(3)
	if (ch == 3) then
	    ch = 1
    	numb[1] = 3 + math.random(15)
		numb[2] = numb[1] 
	    numb[4] = 2 *	numb[1]		
		numb[5] = lib.math.round_dec(numb[1] * root3,3)
		numb[3] = lib.math.round_dec(0.5 * numb[5],3) 		
    end			
	if (ch == 4) then
    	numb[4] = 3 + math.random(15)
	    numb[2] = 0.5 * numb[4]		
	    numb[1] = numb[2] 
		numb[3] = lib.math.round_dec(0.5 * numb[1] * root3,3)	
		numb[5] = 2 * numb[3]		
    end	
	if (ch == 5) then
    	numb[5] = 3 + math.random(15)
	    numb[3] = 0.5 * numb[5]	
		numb[1] = lib.math.round_dec(2 * numb[3] / root3,3)
	    numb[2] = numb[1] 
		numb[4] = 2 * numb[1]		
    end	
	quest = dat[ch] .. " = " .. numb[ch] .. meas	
    circ = 6 * numb[1]	
end	

if (ind == 5) then
    ch = 2 + math.random(3)
	if (ch == 3) then
	    ch = 1
    	numb[1] = 3 + math.random(15)
		numb[2] = numb[1] / math.sqrt(2-root2)
	    numb[2] = lib.math.round_dec(numb[2],3)		
	    numb[4] = 2 *	numb[2]
	    numb[3] = math.sqrt(numb[2]^2 - 0.25*numb[1]^2) 
	    numb[3] = lib.math.round_dec(numb[3],3)		
		numb[5] = 2 * numb[3]		
    end		
	if (ch == 4) then
    	numb[4] = 3 + math.random(15)
	    numb[2] = 0.5 * numb[4]		
		numb[1] = numb[2] * math.sqrt(2-root2)
	    numb[1] = lib.math.round_dec(numb[1],3)		
	    numb[3] = math.sqrt(numb[2]^2 - 0.25*numb[1]^2) 
	    numb[3] = lib.math.round_dec(numb[3],3)		
		numb[5] = 2 * numb[3] 	
    end	
	if (ch == 5) then
    	numb[5] = 3 + math.random(15)
		numb[3] = 0.5 * numb[5]
	    numb[1] = numb[5] * (root2 - 1)
	    numb[1] = lib.math.round_dec(numb[1],3)		
		numb[2] =  numb[5] / math.sqrt(2+root2)
	    numb[2] = lib.math.round_dec(numb[2],3)			
	    numb[4] = 2 * numb[2]	
    end		
    circ = 8 * numb[1]
    quest = dat[ch] .. " = " .. numb[ch] .. meas	 	
end	

if (ind == 6) then
    numb[1] = 3 + math.random(15)
	enum = math.cos (36 * con)
	numb[2] = lib.math.round_dec(2 * numb[1] * enum,3)
    numb[3] = math.sqrt(numb[2]^2 - 0.25*numb[1]^2)
	numb[3] = lib.math.round_dec(numb[3],3)
	numb[4] = 2 * numb[2]
	numb[5] = numb[1] * math.sqrt(4 - (numb[1]/numb[2])^2)  
	numb[5] = lib.math.round_dec(numb[5],3)	
    circ = 10 * numb[1] 
    ch = 3 + math.random(2)	
    quest = dat[1] .. " = " .. numb[1] .. meas .. ", " .. spc .. dat[ch] .. " = " .. numb[ch] .. meas 	
end	

if (ind == 7) then
    ch = 2 + math.random(3)
	if (ch == 3) then
	    ch = 1
    	numb[1] = 3 + math.random(15)
		numb[2] = numb[1] / math.sqrt(2-root3) 
	    numb[2] = lib.math.round_dec(numb[2],3)	
		numb[3] = 0.5 * numb[2] * math.sqrt(2 + root3) 
	    numb[3] = lib.math.round_dec(numb[3],3)			
	    numb[4] = 2 *	numb[2]
		numb[5] = numb[2] 					
    end		
	if (ch == 4) then
    	numb[4] = 3 + math.random(15)
	    numb[2] = 0.5 * numb[4]	
		numb[5] = numb[2]  		
		numb[1] = numb[2] * math.sqrt(2-root3)
	    numb[1] = lib.math.round_dec(numb[1],3)		
		numb[3] = 0.5 * numb[2] * math.sqrt(2 + root3) 
	    numb[3] = lib.math.round_dec(numb[3],3)			
    end	
	if (ch == 5) then
    	numb[5] = 3 + math.random(15)
		numb[2] = numb[5] 
	    numb[4] = 2 * numb[2]			
	    numb[1] = numb[2] * math.sqrt(2-root3)	
	    numb[1] = lib.math.round_dec(numb[1],3)	
		numb[3] = 0.5 * numb[2] * math.sqrt(2 + root3)  
	    numb[3] = lib.math.round_dec(numb[3],3)			
    end		
    circ = 12 * numb[1]
    quest = dat[ch] .. " = " .. numb[ch] .. meas	
end	

pi_ho = lib.math.round_dec(circ / (2*numb[3]),2)
pi_lo = lib.math.round_dec(circ / (2*numb[2]),2)
	
numb[2] = lib.math.round_dec(numb[2],2)
numb[3] = lib.math.round_dec(numb[3],2)
circ = lib.math.round_dec(circ, 2)	

mycanvas = function()
	 		  
  lib.start_canvas(200, 180, "center")   
  
   w = 12
   ow = 9
   v = 3

   if (ind == 1) then 
      lib.add_input(v+4*w, v+2*w, 40, 30, dat[1]) 
	                     	 
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false) 
	  lib.add_line(v, v+7*w, 7*w, 0, yelow_style, false, false)
      lib.add_input(v+2*w, ow+5*w, 40, 30, dat[2])

      lib.add_circle (v+7*w, v+7*w, 2, style, false, false)
	  lib.add_circle (v+7*w, v+7*w, 3.4*w, green_style, false, false)
	  lib.add_line(v+7*w, v+7*w, 3.4*w, 0, green_style, false, false) 
      lib.add_input(v+7*w, ow+5*w, 40, 30, dat[3])

      lib.add_circle (v+7*w, v+7*w, 2, style, false, false) 
      lib.add_straight_path(v, v+7*w, {{10.5*w,-6*w},  {0,12*w}, {-10.5*w,-6*w}}, style, true, false)  
   end 
  
   if (ind == 2) then          
      lib.add_input(ow+5*w, ow-v, 40, 30, dat[1]) 
	   	  
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false) 
	  lib.add_line(v+2*w, v+2*w, 5*w, 5*w, yelow_style, false, false)
      lib.add_input(3*w, ow+4*w, 40, 30, dat[2]) 

      lib.add_circle (v+7*w, v+7*w, 2, style, false, false)	  
	  lib.add_circle (v+7*w, v+7*w, 4.9*w, green_style, false, false)
	  lib.add_line(v+7*w, v+7*w, 4.9*w, 0, green_style, false, false)
      lib.add_input(v+8*w, ow+5*w, 40, 30, dat[3]) 

      lib.add_line(v+2*w, v+12*w, 10*w,-10*w, red_style, true, false) 
      lib.add_input(7*w, ow+3*w, 40, 30, dat[4])

      lib.add_circle (v+7*w, v+7*w, 2, style, false, false)
    lib.add_straight_path(v+2*w, v+2*w, {{10*w,0}, {0,10*w}, {-10*w,0},  {0,-10*w}}, style, true, false)	
   end   
 
   if (ind == 3) then 
      lib.add_input(2*w, v+w, 40, 30, dat[1]) 
	   	  
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false) 
	  lib.add_line(ow-2, v+4.7*w, 7*w, 2.4*w, yelow_style, false, false)
      lib.add_input(v+2*w, ow+4*w, 40, 30, dat[2]) 

      lib.add_circle (v+7*w, v+7*w, 2, style, false, false)	  
	  lib.add_circle (v+7*w, v+7*w, 5.6*w, green_style, false, false)
	  lib.add_line(v+7*w, v+7*w, 5.5*w, 1.7*w, green_style, false, false)
      lib.add_input(v+8*w, ow+6*w, 40, 30, dat[3]) 

      lib.add_line(v+3*w, v+12.8*w, 4*w,-12.8*w, red_style, true, false) 
      lib.add_input(6*w-v, ow+2*w, 40, 30, dat[4])

      lib.add_circle (v+7*w, v+7*w, 2, style, false, false)	  
      lib.add_straight_path(v+0.3*w, v+4.7*w, {{6.7*w,-4.7*w}, {6.7*w,4.7*w}, {-2.5*w,8*w}, {-8.3*w,0}, {-2.5*w,-8*w}}, style, true, false)      
   end 

  if (ind == 4) then          
          lib.add_input(v, v+2*w, 40, 30, dat[1]) 
	   	  
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false) 
	  lib.add_line(v, v+7*w, 7*w, 0, yelow_style, false, false)
      lib.add_input(v+2*w, ow+5*w, 40, 30, dat[2]) 

      lib.add_circle (v+7*w, v+7*w, 2, style, false, false)	  
	  lib.add_circle (v+7*w, v+7*w, 6*w, green_style, false, false)
	  lib.add_line(v+7*w, v+7*w, 5.2*w, -2.8*w, green_style, false, false)
      lib.add_input(v+9*w, v+5*w, 40, 30, dat[3]) 

      lib.add_line(v+3.5*w, v+13*w, 7*w,-12*w, red_style, true, false) 
      lib.add_input(v+6*w, ow+2*w, 40, 30, dat[4])

      lib.add_line(v+3.5*w, v+13*w, 10.5*w,-6*w, blue_style, true, false) 
      lib.add_input(ow+7*w, v+10*w, 40, 30, dat[5])

      lib.add_circle (v+7*w, v+7*w, 2, style, false, false)	  
      lib.add_straight_path(v, v+7*w, {{3.5*w,-6*w}, {7*w,0}, {3.5*w,6*w}, {-3.5*w,6*w}, {-7*w,0}, {-3.5*w,-6*w}}, style, true, false)      	 
   end  

   if (ind == 5) then  
      lib.add_input(ow+w, 1, 40, 30, dat[1]) 
	   
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false) 
	  lib.add_line(v, v+7*w, 7*w, 0, yelow_style, false, false)
      lib.add_input(v+2*w, ow+5*w, 40, 30, dat[2]) 

      lib.add_circle (v+7*w, v+7*w, 2, style, false, false)	  
	  lib.add_circle (v+7*w, v+7*w, 6.4*w, green_style, false, false)
	  lib.add_line(v+7*w, v+7*w, 5.9*w, 2.5*w, green_style, false, false)
      lib.add_input(v+8*w, ow+6*w, 40, 30, dat[3]) 

      lib.add_line(v+2*w, v+12*w, 10*w,-10*w, red_style, true, false) 
      lib.add_input(v+6*w, v+4*w, 40, 30, dat[4])

      lib.add_line(v+2*w, v+12*w, 12*w,-5*w, blue_style, true, false) 
      lib.add_input(ow+7*w, v+9*w, 40, 30, dat[5])

      lib.add_circle (v+7*w, v+7*w, 2, style, false, false)	  	  
      lib.add_straight_path(v+2*w, v+2*w, {{5*w,-2*w}, {5*w,2*w}, {2*w,5*w}, {-2*w,5*w}, {-5*w,2*w}, {-5*w,-2*w}, {-2*w,-5*w}, {2*w,-5*w}}, style, true, false)      
   end 
  
   if (ind == 6) then 
      lib.add_input(v+11*w, v, 40, 30, dat[1]) 
	   	  
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false) 
	  lib.add_line(v+2, v+5*w, 7*w-2, 2*w, yelow_style, false, false)
      lib.add_input(v+2*w, ow+6*w, 40, 30, dat[2]) 

      lib.add_circle (v+7*w, v+7*w, 2, style, false, false)	  
	  lib.add_circle (v+7*w, v+7*w, 6.6*w, green_style, false, false)
	  lib.add_line(v+7*w, v+7*w, 6.6*w, 0, green_style, false, false)
      lib.add_input(v+9*w, ow+5*w, 40, 30, dat[3]) 

      lib.add_line(v+2.7*w, v+12.7*w, 8.6*w,-11.4*w, red_style, true, false) 
      lib.add_input(v+6*w, v+2*w, 40, 30, dat[4])

      lib.add_line(v+2.7*w, v+12.7*w, 8.5*w,0, blue_style, true, false) 
      lib.add_input(v+6*w, ow+9*w, 40, 30, dat[5])

      lib.add_circle (v+7*w, v+7*w, 2, style, false, false)	  
      lib.add_straight_path(v+0.3*w, v+4.9*w, {{2.5*w,-3.5*w}, {4.2*w,-1.4*w}, {4.2*w, 1.4*w}, {2.5*w, 3.5*w}, {0, 4.3*w}, {-2.5*w, 3.5*w}, {-4.2*w, 1.4*w}, {-4.2*w,-1.4*w}, {-2.5*w,-3.5*w}, {0, -4.3*w}}, style, true, false)      
   end

   if (ind == 7) then 
      lib.add_input(ow+10*w, ow, 40, 30, dat[1]) 
	   	  
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false) 
	  lib.add_line(v, v+7*w, 7*w, 0, yelow_style, false, false)
      lib.add_input(v+2*w, ow+5*w, 50, 40, dat[2]) 

      lib.add_circle (v+7*w, v+7*w, 2, style, false, false)	  
	  lib.add_circle (v+7*w, v+7*w, 6.7*w, green_style, false, false)
	  lib.add_line(v+7*w, v+7*w, 6.5*w, 1.5*w, green_style, false, false)
      lib.add_input(v+9*w, ow+6*w, 40, 30, dat[3]) 

      lib.add_line(v+3.5*w, v+13*w, 7*w,-12*w, red_style, true, false) 
      lib.add_input(ow+5*w, ow+3*w, 40, 30, dat[4])
      lib.add_line(v+3.5*w, v+13*w, 7*w, 0, blue_style, true, false) 
      lib.add_input(ow+5*w, ow+11*w, 40, 30, dat[5])

      lib.add_circle (v+7*w, v+7*w, 2, style, false, false)	  
      lib.add_straight_path(v, v+7*w, {{0.8*w,-3.3*w}, {2.7*w,-2.7*w}, {3.5*w,-w}, {3.5*w, w}, {2.7*w, 2.7*w}, {0.8*w,3.3*w}, {-0.8*w,3.3*w}, {-2.7*w, 2.7*w}, {-3.5*w, w}, {-3.5*w, -w}, {-2.7*w, -2.7*w}, {-0.8*w,-3.3*w}}, style, true, false)      
   end 
  
--[[
  for i = 1,15 do
    lib.add_line(v, v+(i-1)*w, 14*w, 0, grid_style, false, false)
  end
  for i = 1,15 do
    lib.add_line(v+(i-1)*w, v, 0, 14*w, grid_style, false, false)
  end
]]--

  lib.end_canvas()
end
                              
            