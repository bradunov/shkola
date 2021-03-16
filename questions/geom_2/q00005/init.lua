
style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

dot_style = {["font_size"] = "40"}	

trian = {8, 16, 6, 3, 8, 4, 6}    
lin = {13, 18, 15, 6, 10, 6, 10}

test_tr = {3, 4, 6, 8, 12, 16}
test_ln = {6, 8, 10, 13, 15, 18}

ans_tr = lib.math.random_shuffle(test_tr)
ans_ln = lib.math.random_shuffle(test_ln)

ind = math.random(7)

for i = 1,7 do
    if(ans_tr[i] == trian[ind]) then
	   index_tr = i-1
	end
    if(ans_ln[i] == lin[ind]) then
	   index_ln = i-1
	end	
end	
		 
w = 5
ow = 20
v = 70


mycanvas = function( )
  lib.start_canvas(300, 180, "center")
  
  lib.add_triangle (2*v, v+ow, 3*v, 2*v, style, false, false)
 
  if (ind == 1) then
     lib.add_straight_path (v/2, ow+2*v, {{(5*v-ow)/2-w, -v}}, style, false, false)
     lib.add_straight_path (3*v+2*ow-w, ow+2*v, {{w-(5*v-ow)/2, -v}}, style, false, false)
     lib.add_text(2*v, ow/2, ".", dot_style, false, false)
     lib.add_text(2*ow-3, 2*v+8, ".", dot_style, false, false)
     lib.add_text(3*v+2*ow-5, 2*v+8, ".", dot_style, false, false)	 
     lib.add_text(v+ow-4, v+8, ".", dot_style, false, false)
     lib.add_text(3*v-ow+4, v+8, ".", dot_style, false, false)
     lib.add_text(2*v, 3*v/2-2, ".", dot_style, false, false)
 end	

  if (ind == 2) then
     lib.add_straight_path (v/2, ow+2*v, {{(5*v-ow)/2-w, -v}}, style, false, false)
     lib.add_straight_path (3*v+2*ow-w, ow+2*v, {{w-(5*v-ow)/2, -v}}, style, false, false)
     lib.add_straight_path (2*v, ow, {{0, 2*v}}, style, false, false)
     lib.add_text(2*v, ow/2, ".", dot_style, false, false)
     lib.add_text(2*ow-3, 2*v+8, ".", dot_style, false, false)
     lib.add_text(3*v+2*ow-5, 2*v+8, ".", dot_style, false, false)	 
     lib.add_text(v+ow-4, v+8, ".", dot_style, false, false)
     lib.add_text(3*v-ow+4, v+8, ".", dot_style, false, false)
     lib.add_text(2*v, 3*v/2-2, ".", dot_style, false, false)
     lib.add_text(2*v, 2*v+8, ".", dot_style, false, false)	 
  end	  

  if (ind == 3) then
     lib.add_straight_path (v, v+2*ow, {{2*v, 0}}, style, false, false)
     lib.add_straight_path (2*v, ow, {{0, 2*v}}, style, false, false)
     lib.add_text(2*v, ow/2, ".", dot_style, false, false)
     lib.add_text(2*ow-3, 2*v+8, ".", dot_style, false, false)
     lib.add_text(3*v+2*ow-5, 2*v+8, ".", dot_style, false, false)
     lib.add_text(2*v, 2*v+8, ".", dot_style, false, false)
     lib.add_text(2*v, v+ow+8, ".", dot_style, false, false)
     lib.add_text(v+2, v+ow+8, ".", dot_style, false, false)
     lib.add_text(3*v-2, v+ow+8, ".", dot_style, false, false)	 
  end	
  
  if (ind == 4) then
     lib.add_straight_path (2*v, ow, {{0, 2*v}}, style, false, false)
     lib.add_text(2*v, ow/2, ".", dot_style, false, false)
     lib.add_text(2*ow-3, 2*v+8, ".", dot_style, false, false)
     lib.add_text(3*v+2*ow-5, 2*v+8, ".", dot_style, false, false)
     lib.add_text(2*v, 2*v+8, ".", dot_style, false, false)	 
  end	

  if (ind == 5) then
     lib.add_straight_path (2, ow, {{2*v, 0} }, style, false, false)
     lib.add_straight_path (2, ow, {{v/2, 2*v}}, style, false, false)
     lib.add_straight_path (2, ow, {{3*(v+ow/2), 2*v-2} }, style, false, false)
     lib.add_text(2*v, ow/2, ".", dot_style, false, false)
     lib.add_text(2*ow-3, 2*v+8, ".", dot_style, false, false)
     lib.add_text(3*v+2*ow-5, 2*v+8, ".", dot_style, false, false)
     lib.add_text(w, ow/2, ".", dot_style, false, false)
     lib.add_text(3*v/2-5, v-7, ".", dot_style, false, false)	 
  end	

  if (ind == 6) then
     lib.add_straight_path (v/2, ow+2*v, {{v+2*ow-w, -v+ow}}, style, false, false)
     lib.add_straight_path (7*v/2, ow+2*v, {{-v-2*ow+w, -v+ow}}, style, false, false)
     lib.add_straight_path (2*v, ow, {{0, (3*v-5*w)/2}}, style, false, false)
     lib.add_text(2*v, ow/2, ".", dot_style, false, false)
     lib.add_text(2*ow-3, 2*v+8, ".", dot_style, false, false)
     lib.add_text(3*v+2*ow-5, 2*v+8, ".", dot_style, false, false)
     lib.add_text(2*v, 3*v/2-7, ".", dot_style, false, false)	 
  end	

  if (ind == 7) then
     lib.add_straight_path (2*v, ow, {{-v+ow, 2*v}}, style, false, false)
     lib.add_straight_path (2*v, ow, {{v-ow, 2*v}}, style, false, false)
     lib.add_text(2*v, ow/2, ".", dot_style, false, false)	 
     lib.add_text(2*ow-3, 2*v+8, ".", dot_style, false, false)
     lib.add_text(3*v+2*ow-5, 2*v+8, ".", dot_style, false, false)
     lib.add_text(v+ow, 2*v+8, ".", dot_style, false, false)
     lib.add_text(3*v-ow, 2*v+8, ".", dot_style, false, false)	 
  end	  
	   
  lib.end_canvas()
end   
