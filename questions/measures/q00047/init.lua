
red_style = {["off_color"] = "f30",
         ["on_color"] = "f30",
         ["line_color"] = "000",
         ["line_width"] = "2"};
		 
green_style = {["off_color"] = "6f6",
               ["on_color"] = "6f6",
               ["line_color"] = "000",
               ["line_width"] = "2"};

blue_style = {["off_color"] = "0cf",
               ["on_color"] = "0cf",
               ["line_color"] = "000",
               ["line_width"] = "2"};

brown_style = {["off_color"] = "c60",
               ["on_color"] = "c60",
               ["line_color"] = "000",
               ["line_width"] = "2"};
                                                                                                                                                                                                                                                                                                
line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["off_line_color"] = "000",
        ["line_width"] = "2"}; 

dot_style = {["font_size"] = "30"}

include("terms")


index = {1, 2, 3}
ind = lib.math.random_shuffle(index)

h_colour = colour[ind[1]]
m_colour = colour[ind[2]]
l_colour = colour[ind[3]]
b_colour = colour[ind[2]+3]
l_comp = padez[ind[1]]
h_comp = padez[ind[3]]

if (ind[1] == 1) then
    h_style = blue_style
else
    if (ind[1] == 2) then  
        h_style = red_style 
    else		
        h_style = green_style
	end
end	
if (ind[2] == 1) then
    m_style = blue_style
else
    if (ind[2] == 2) then  
        m_style = red_style 
    else		
        m_style = green_style
	end
end	
if (ind[3] == 1) then
    l_style = blue_style
else
    if (ind[3] == 2) then  
        l_style = red_style 
    else		
        l_style = green_style
	end
end	


reply1 = "answer == '" .. name1[1] .. "' "  ..
        "|| answer == '" .. name1[2] .. "'" ;
ans1 = "answer = '" .. name1[2] .. "' ";
reply2 = "answer == '" .. name2[1] .. "' "  ..
        "|| answer == '" .. name2[2] .. "'" ;
ans2 = "answer = '" .. name2[2] .. "' ";

	
mycanvas = function()
  
  lib.start_canvas(350, 260, "center")
  
  lib.add_straight_path(35, 110, {{120, -60}}, line_style, false, true)
  lib.add_triangle (100, 95, 30, 30, brown_style, false, true)
  lib.add_rectangle (20, 80, 15, 30, h_style, false, false)
  lib.add_circle (28, 72, 7, h_style, false, false)
  lib.add_rectangle (152, 20, 15, 30, l_style, true)
  lib.add_circle (160, 12, 7, l_style, false, false)

  lib.add_straight_path(200, 110, {{120, 60}}, line_style, false, true)
  lib.add_triangle (250, 152, 30, 30, brown_style, false, true) 
  lib.add_rectangle (318, 140, 15, 30, m_style, true)
  lib.add_circle (325, 132, 7, m_style, true, false)
  lib.add_rectangle (185, 80, 15, 30, l_style, true)
  lib.add_circle (193, 72, 7, l_style, false, false)

  lib.add_straight_path(35, 235, {{120, -60}}, line_style, false, true)
  lib.add_triangle (100, 220, 30, 30, brown_style, false, true)
  lib.add_rectangle (20, 205, 15, 30, h_style, false, false)
  lib.add_circle (28, 197, 7, h_style, false, false)
  lib.add_rectangle (150, 145, 15, 30, m_style, true)
  lib.add_circle (157, 137, 7, m_style, true, false)
 
  lib.end_canvas()
end       
 
                     
    
    
                  
            
                      
            