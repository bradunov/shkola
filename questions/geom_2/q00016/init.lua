
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};						

dot_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};
	
colour_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f30",
        ["line_color"] = "000",
        ["line_width"] = "1"};	
				
text_style = {["font_size"] = "16"}	

pt = {}
xd = {}
yd = {}
rect_pt = {}
rect_x = {}
rect_y = {}
ind = {}
qx = {}
qy = {}

pt = {"O", "A", "B", "J", "C", "D", "E", "F", "G", "H", "K", "L", "M", "N", "S", "P", "R", "T"}
xd = {1, 1, 1, 1, 3, 5, 7, 3, 5, 7, 3, 5, 7, 5, 9, 9, 9, 9}  
yd = {1, 3, 5, 7, 2, 1, 6, 4, 5, 4, 6, 7, 2, 3, 1, 3, 5, 7}

dim = 18
xnet = 9
ynet = 7

min = 0  
max = 6
for i = 1,3 do
    ind[i] = min + math.random(max)
    rect_pt[i] = pt[ind[i]]
    rect_x[i] = xd[ind[i]]
    rect_y[i] = yd[ind[i]]
	min = ind[i]
end	

qx[1] = rect_x[2] + rect_x[3] - rect_x[1]
qy[1] = rect_y[2] + rect_y[3] - rect_y[1]
qx[2] = rect_x[3] + rect_x[1] - rect_x[2]
qy[2] = rect_y[3] + rect_y[1] - rect_y[2]
qx[3] = rect_x[1] + rect_x[2] - rect_x[3]
qy[3] = rect_y[1] + rect_y[2] - rect_y[3]

sign = 0 
for i = 1,3 do
    if (sign == 0) then
        if (qx[i] > 0 and qx[i] <= xnet and qy[i] > 0 and qy[i] <= ynet) then
	        sign = i
            rect_x[4] = qx[i]
            rect_y[4] = qy[i] 
            for j = 1, dim do
			    if (qx[i] == xd[j] and qy[i] == yd[j]) then
                    rect_pt[4] = pt[j]
                    ind[4] = j					
                end					
            end	
        end		
	end
end	

if (sign == 0) then
    results = "result[0] == 1 && result[1] == 1 && result[2] == 1"
    answ = lib.check_string(msg, 80)	
    first = rect_pt[1]	
	second = rect_pt[2]
    point = rect_pt[3]	
else
    results = "result[0] == 1 && result[1] == 1 && result[2] == 1 && result[3] == 1"
    answ = lib.check_string_case(rect_pt[4], 80)
    first = rect_pt[sign]
    if (sign == 1) then
        op = math.random(2)
	    if (op == 1) then
            second = rect_pt[2]
            point = rect_pt[3]
	    else
            second = rect_pt[3]
            point = rect_pt[2]
        end		
    end
    if (sign == 2) then
        op = math.random(2)
    	if (op == 1) then
            second = rect_pt[1]
            point = rect_pt[3]
    	else
            second = rect_pt[3]
            point = rect_pt[1]
        end		
    end
    if (sign == 3) then
        op = math.random(2)
    	if (op == 1) then
            second = rect_pt[1]
            point = rect_pt[2]
    	else
            second = rect_pt[2]
            point = rect_pt[1]
        end		
    end
end	


mycanvas = function(no)

  lib.start_canvas(330, 260, "center", results)  
   
  w = 30
  ow = 10

  for i = 1,9 do
    lib.add_line(ow, ow+(i-1)*w, 10*w, 0, style, false, false)
  end

  for i = 1,11 do
    lib.add_line(ow+(i-1)*w, ow, 0, 8*w, style, false, false)
  end
  
--[[  moguce tacke  
  lib.add_text(ow+qx[1]*w, qy[1]*w, ".", dot_style, false, false)
  lib.add_text(ow+qx[1]*w, qy[1]*w, "1", text_style, false, false)
  lib.add_text(ow+qx[2]*w, qy[2]*w, ".", dot_style, false, false)
  lib.add_text(ow+qx[2]*w, qy[2]*w, "2", text_style, false, false)
  lib.add_text(ow+qx[3]*w, qy[3]*w, ".", dot_style, false, false)
  lib.add_text(ow+qx[3]*w, qy[3]*w, "3", text_style, false, false)
]]-- 
  
  for i = 1,dim do  
      lib.add_circle(ow+xd[i]*w, yd[i]*w+ow, 4, dot_style, false, false)
      lib.add_text(ow+xd[i]*w, yd[i]*w-4, pt[i], text_style, false, false)	  
  end  

  if (sign == 0) then
      imax = 3
  else	
      imax = 4
  end	  
  for i = 1,imax do
      lib.add_circle(ow+rect_x[i]*w, rect_y[i]*w+ow, 4, colour_style, false, true)
  end

  lib.end_canvas()
end
