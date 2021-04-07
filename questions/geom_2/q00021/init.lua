
style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "1"};

line_style = 
	{["line_color"] = "000",
        ["line_width"] = "2"};

yelow_style = 
	{["off_color"] = "ff9",
        ["on_color"] = "ff9",
        ["line_color"] = "000",
        ["line_width"] = "2"};

red_style = 
	{["off_color"] = "ffebcc",
        ["on_color"] = "ffebcc",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
green_style = 
	{["off_color"] = "cf9",
        ["on_color"] = "cf9",
        ["line_color"] = "000",
        ["line_width"] = "2"};	

blue_style = 
	{["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "2"};	

dot_style = {["font_size"] = "30"}	
text_style = {["font_size"] = "16"}


name = {"K1(S,r\(_1\))", "K2(T,r\(_2\))"} 
circ = {"K1", "K2"} 
cent = {"S", "T"}
pt = {"P", "Q", "A", "B", "C", "D"}
lin = {"SP", "TP", "AB", "CD", "PQ"}
ang = {"QSP", "QTP", "ASB", "DTC"}

symb = "\(\angle\)"

ind = math.random(4)

if (ind == 1) then
	a_left = ang[1]  
	a_right = ang[3]
	sign_a = "<" 
	s = math.random(2)
	if (s == 1) then
	    l_left = lin[5]  
	    l_right = lin[3]
		sign_s = "<" 
    else
	    l_left = lin[3]  
	    l_right = lin[5]
		sign_s = ">" 
    end
end	
if (ind == 2) then
	a_left = ang[2]  
	a_right = ang[4]
	sign_a = ">" 
	s = math.random(2)
	if (s == 1) then
	    l_left = lin[4]  
	    l_right = lin[5]
		sign_s = "<" 
    else
	    l_left = lin[5]  
	    l_right = lin[4]
		sign_s = ">" 
    end
end	
if (ind == 3) then
	a_left = ang[3]  
	a_right = ang[4]
	sign_a = "=" 
	s = math.random(2)
	if (s == 1) then
	    l_left = lin[4]  
	    l_right = lin[3]
		sign_s = "<" 
    else
	    l_left = lin[3]  
	    l_right = lin[4]
		sign_s = ">" 
    end
end	
if (ind == 4) then
	a_left = ang[1]  
	a_right = ang[2]
	sign_a = "<" 
	s = math.random(2)
	if (s == 1) then
	    l_left = lin[2]  
	    l_right = lin[1]
		sign_s = "<" 
    else
	    l_left = lin[1]  
	    l_right = lin[2]
		sign_s = ">" 
    end
end	
                                                               

mycanvas = function(no)

  lib.start_canvas(350, 220, "center")

  ov = 70
  ow = 20
  
  lib.add_straight_path (2*(ov+ow), ov-2*ow, {{-3*ow, ov}, {4*ow, 2*ow+3}}, green_style, false, false)
  lib.add_straight_path (2*(ov+ow), ov-2*ow+2, {{ov-ow, ov-ow-2}, {-ov+2*ow-2, ov-5}}, yelow_style, false, false)
  lib.add_line(2*(ov+ow)-1, ov-2*ow+1, ow, ov+2*ow, line_style, false, false)
  lib.add_text(2*(ov+ow), ow, pt[1], text_style)
  lib.add_text(2*ov+3*ow, 2*ov+ow-5, pt[2], text_style)

  lib.add_straight_path (ow+10, ov+ow+10, {{ov+ow, 0}, {0, ov+ow}}, blue_style, false, false)
  lib.add_line(ow+10, ov+ow+10, ov+ow, ov+ow, line_style, false, false)
  lib.add_text(ow, 2*(ov-ow), pt[3], text_style)
  lib.add_text(2*ov-ow, 2*ov+3*ow, pt[4], text_style)

  lib.add_straight_path (4*ov+ow-2, 3*ow, {{-ov+2, ow}, {ow, ov}}, red_style, false, false)
  lib.add_line(4*ov+ow-2, 3*ow, -ov+ow, ov+ow, line_style, false, false)
  lib.add_text(4*ov+ow+5, 3*ow, pt[5], text_style)
  lib.add_text(3*ov+2*ow, 2*ov+ow, pt[6], text_style)

  lib.add_circle(2*ov-ow, 2*(ov-ow), ov+ow, style, false, false)	  
  lib.add_text(ow, 2*ow, circ[1])
  lib.add_text(2*ov-ow, ov+ow, ".", dot_style, false, false)	
  lib.add_text(2*ov-ow-5, 4*ow+5, cent[1], text_style)   
  lib.add_circle(3*ov+ow, 4*ow, ov, style, false, false) 
  lib.add_text(4*ov+ow, ow, circ[2])
  lib.add_text(3*ov+ow, ov, ".", dot_style, false, false)
  lib.add_text(3*ov+ow+5, 3*ow+5, cent[2], text_style)
  		       
  lib.end_canvas()
end     
       

 
     
           
              
            
          
                   
         
        
       
            
    
          
          
    
    
                  
                
                