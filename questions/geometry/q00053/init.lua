
style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

result = {8,16,6,3,8,4}

test = {3,4,6,8,10,16}

answ = lib.math.random_shuffle(test)

ind = math.random(6)

for i = 1,6 do
    if(answ[i] == result[ind]) then
	   index = i-1
	end
end	
		 
w = 5
ow = 20
v = 70


mycanvas = function( )
  lib.start_canvas(300, 250, "center")
  
  lib.add_triangle (2*v, v+ow, 3*v, 2*v, style, false, false)
 
  if (ind == 1) then
     lib.add_straight_path (v/2, ow+2*v, {{(5*v-ow)/2-w, -v}}, style, false, false)
     lib.add_straight_path (3*v+2*ow-w, ow+2*v, {{w-(5*v-ow)/2, -v}}, style, false, false)
  end	

  if (ind == 2) then
     lib.add_straight_path (v/2, ow+2*v, {{(5*v-ow)/2-w, -v}}, style, false, false)
     lib.add_straight_path (3*v+2*ow-w, ow+2*v, {{w-(5*v-ow)/2, -v}}, style, false, false)
     lib.add_straight_path (2*v, ow, {{0, 2*v}}, style, false, false)
  end	  

  if (ind == 3) then
     lib.add_straight_path (v, v+2*ow, {{2*v, 0}}, style, false, false)
     lib.add_straight_path (2*v, ow, {{0, 2*v}}, style, false, false)
  end	
  
  if (ind == 4) then
     lib.add_straight_path (2*v, ow, {{0, 2*v}}, style, false, false)
  end	

  if (ind == 5) then
     lib.add_straight_path (v/2, ow+2*v, {{2*(v-ow)+w, v}, {2*(v-ow)+w, -v} }, style, false, false)
     lib.add_straight_path (2*v, ow, {{0, 3*v}}, style, false, false)
  end	

  if (ind == 6) then
     lib.add_straight_path (v/2, ow+2*v, {{v+2*ow-w, -v+ow}}, style, false, false)
     lib.add_straight_path (7*v/2, ow+2*v, {{-v-2*ow+w, -v+ow}}, style, false, false)
     lib.add_straight_path (2*v, ow, {{0, (3*v-5*w)/2}}, style, false, false)
  end	  
	   
  lib.end_canvas()
end       