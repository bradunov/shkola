
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};	

line_style = 
	{["line_color"] = "f30",
        ["line_width"] = "2"};		
		
blue_style = 
	{["off_color"] = "fff",
        ["on_color"] = "0cf",
        ["line_color"] = "000",
        ["off_line_color"] = "000",
        ["line_width"] = "1"};		
		
red_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f30",
        ["line_color"] = "000",
        ["off_line_color"] = "000",
        ["line_width"] = "1"};			
		
text_style = {["font_size"] = "14"}		

point = {"A", "B", "C", "D", "E", "F", "G", "H"}
points = {"M", "N", "O", "P", "Q", "R", "S", "T"}
dim = 8

x = {}
y = {}
xs = {}
ys = {}
ind = {}
answ = {""}
q = {}
qq = {}
out = {}
stamp = {}
stamps = {}

for i = 1,dim do
    stamp[i] = 0
	stamps[i] = 0
end	

grid = 13

min = 0
for i = 1,dim do
    x[i] = min + math.random(2)
	y[i] = x[i] + math.random(grid-1-x[i])
	min = min + 1
	if (i == 4 or i == 7) then
	    min = min + 1	
    end		
end	

for i = 1,dim do
    xs[i] = y[i]
	ys[i] = x[i]
end

q = lib.math.argsort(x)
nr = 0
ind[q[1]] = 1
for i = 2,dim do
	ind[q[i]] = 1     
    if (x[q[i]] == x[q[i-1]]) then
        if (y[q[i]] == y[q[i-1]]) then
            nr = nr + 1
			x[q[i]] = x[q[i]] + 1
			for j = 1,dim do
			    if (j ~= q[i]) then
				    if (x[q[i]] == x[j]) then
					    x[q[i]] = x[q[i]] + 1
					end 
                end
            end
			xs[q[i]] = xs[q[i]] + 1				
			for j = 1,dim do
			    if (j ~= q[i]) then
				    if (xs[q[i]] == xs[j]) then
					    xs[q[i]] = xs[q[i]] + 1
					end 
                end
            end								
			ind[q[i]] = 0
		end
    end	
end	

br = 0
for i = 1,dim do
    if (ind[i] == 1) then
	    br = br + 1
	    out[br] = i
	end
end	
qq = lib.math.random_shuffle(out)	

if (nr < 3) then
    for i = 1, 3-nr do
        x[qq[i]] = x[qq[i]] + 1
	    xs[qq[i]] = xs[qq[i]] + 1		
	    ind[qq[i]] = 0  
    end	 
end	
			
br = 0
for i = 1, dim do
    if (ind[i] == 1) then
	    br = br + 1
        answ[br] = lib.check_string_case(point[i], 10) .. " - " .. lib.check_string_case(points[i], 10) 
	end			
end		

results = ""
for i = 1, dim do
  if i > 1 then
    results = results .. " && "
  end
  if (ind[i] == 1) then
     results = results .. "result[" .. tostring(2*(i-1)) .. "] == 1 && result[" .. tostring(2*i-1) .. "] == 1"
  else
     results = results .. "result[" .. tostring(2*(i-1)) .. "] == 0 && result[" .. tostring(2*i-1) .. "] == 0"
  end
end


mycanvas = function(no)
  lib.start_canvas(300, 280, "center", results)  
  
  w = 20
  ow = 10

  for i = 1,grid+1 do
    lib.add_line(w, i*w, grid*w, 0, style, false, false)
  end

  for i = 1,grid+1 do
    lib.add_line(i*w, w, 0, grid*w, style, false, false)
  end

  lib.add_line(w, w, grid*w, grid*w, line_style, true, false)
  lib.add_text(3*ow/2, 3*ow/2, "s", text_style, false, false)
  
  for i = 1,dim do
 	  lib.add_circle (x[i]*w, y[i]*w, 3, blue_style, false, true)	 
	  lib.add_circle (xs[i]*w, ys[i]*w, 3, red_style, false, true)	
	  if (ind[i] == 1) then
          stamp[i] = 1	  
          lib.add_text(x[i]*w, -ow+y[i]*w, point[i], text_style, false, false)	
          stamps[i] = 1		  
          lib.add_text(xs[i]*w, -ow+ys[i]*w, points[i], text_style, false, false)	
      end	
  end	  

  for i = 1,dim do
	  if (ind[i] == 0) then
	  	  sign = 0  
	      signs = 0	  
          for j = 1,dim do
		      if (j ~= i) then 
				  if (x[i] == x[j] and y[i] == y[j] and stamp[j] == 1) then
			          sign = 1
	              end
		          if (xs[i] == xs[j] and ys[i] == ys[j] and stamps[j] == 1) then
			          signs = 1 			  
			      end	    
			  end			  
          end  
	      if (sign == 0) then
		      stamp[i] = 1
              lib.add_text(x[i]*w, -ow+y[i]*w, point[i], text_style, false, false)
          end 	  
          if (signs == 0) then
		      stamps[i] = 1
              lib.add_text(xs[i]*w, -ow+ys[i]*w, points[i], text_style, false, false)	
          end
      end			  
  end	  
	
  lib.end_canvas()
end  
     
     