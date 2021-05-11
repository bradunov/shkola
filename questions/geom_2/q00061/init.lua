
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

trian = "\(\small\triangle\)"
eq =  "\(\small\cong\)"

circ = {"K\(\small_1\)(S,r\(\small_1\))", "K\(\small_2\)(T,r\(\small_2\))"} 
cent = {"S", "T"}
pt = {"C", "D", "A", "B", "E"}
name = {"ASB", "CSD", "CTD", "DTE"}
rule = {"SSS", "SUS", "USU", "SSU"}

reply = ""
ans = ""
reply = "answer == '" .. name[2] .. "," .. name[3] .. "," .. name[4] .. "' "  ..
        "|| answer == '" .. name[2] .. "," .. name[4] .. "," .. name[3] .. "' "  ..
        "|| answer == '" .. name[3] .. "," .. name[2] .. "," .. name[4] .. "' "  ..
        "|| answer == '" .. name[3] .. "," .. name[4] .. "," .. name[2] .. "' "  ..
        "|| answer == '" .. name[4] .. "," .. name[2] .. "," .. name[3] .. "' "  ..
        "|| answer == '" .. name[4] .. "," .. name[3] .. "," .. name[2] ..  "'" ;
ans = "answer = '" .. name[2] .. "," .. name[3] .. "," .. name[4] .. "' ";
                    
mycanvas = function(no)

  lib.start_canvas(350, 200, "center")

  ov = 70
  ow = 20
 
 lib.add_straight_path (2*(ov+ow), ov-2*ow, {{-3*ow, ov}, {4*ow, 2*ow+3}}, green_style, false, false)
  lib.add_straight_path (2*ov-ow, 2*(ov-ow), { {-4*ow, -2*ow-3}, {ow, ov+2*ow}, {3*ow, -ov+3},}, blue_style, false, false)

  lib.add_straight_path (2*ov+3*ow, 2*ov+2, {{ 5*ow, -3*ow}, {-ov, -3}}, red_style, false, false)
  lib.add_straight_path (2*(ov+ow), ov-2*ow+2, {{ov-ow, ov-ow-2}, {-ov+2*ow-2, ov-5}}, yelow_style, false, false)
  lib.add_line(2*(ov+ow)-1, ov-2*ow+1, ow, ov+2*ow, line_style, false, false)

  lib.add_text(2*(ov+ow), ow, pt[1], text_style)
  lib.add_text(2*ov+3*ow, 2*ov+ow-5, pt[2], text_style)
  lib.add_text(ov-2*ow, ov-ow, pt[3], text_style)
  lib.add_text(ov-10, 2*(ov+ow), pt[4], text_style)  
  lib.add_text(4*ov+ow+10, 4*ow, pt[5], text_style)
  lib.add_text(3*ov+3*ow-5, ov+2*ow+8, "2cm", text_style)
  lib.add_text(2*(ov+ow), 4*ow, "2cm", text_style)

  lib.add_circle(2*ov-ow, 2*(ov-ow), ov+ow, style, false, false)	  
  lib.add_input(ov, ow, 100, 30, circ[1])
  lib.add_text(2*ov-ow, ov+ow, ".", dot_style, false, false)	
  lib.add_text(2*ov-ow-5, 4*ow+5, cent[1], text_style)   
  lib.add_circle(3*ov+ow, 4*ow, ov, style, false, false) 
  lib.add_input(2*(ov+ow), ow, 100, 30, circ[2])
  lib.add_text(3*ov+ow, ov, ".", dot_style, false, false)
  lib.add_text(3*ov+ow+5, 3*ow+5, cent[2], text_style)

  lib.end_canvas()
end   


   

   
       
       

 
     
           
              
            
          
                   
         
        
       
            
    
          
          
    
    
                  
                
                