
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};											

dot_style = 
	{["off_color"] = "none",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};
	
red_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f30",
        ["line_color"] = "f30",
        ["off_line_color"] = "000",
        ["line_width"] = "0.2"};	
		
blue_style = 
	{["off_color"] = "0cf",
        ["on_color"] = "0cf",
        ["line_color"] = "0cf",
        ["line_width"] = "0.2"};			
				
text_style = {["font_size"] = "16"}	

pt = {"O", "A", "B", "J", "C", "D", "E", "F", "G", "H", "K", "L", "M", "N", "S", "P", "R", "T"}
xd = {1, 1, 1, 1, 3, 5, 7, 3, 5, 7, 3, 5, 7, 5, 9, 9, 9, 9}  
yd = {1, 3, 5, 7, 2, 1, 6, 4, 5, 4, 6, 7, 2, 3, 1, 3, 5, 7}

dim = 18
xnet = 9
ynet = 7

rect_pt = {}
rect_x = {}
rect_y = {}
ind = {}

fig_pt = {}
fig_x = {}
fig_y = {}
fnd = {}

value_pt = {}
value_x = {}
value_y = {}

out_pt = {}
out_x = {}
out_y = {}

qx = {}
qy = {}
sign = {}

min = 1  
max = 16

--[[ prvo teme]]--
ind[1] = min + math.random(max)
    rect_pt[1] = pt[ind[1]]
    rect_x[1] = xd[ind[1]]
    rect_y[1] = yd[ind[1]]

--[[ drugo teme]]--
if (rect_x[1] > math.floor(xnet/2) ) then
    rect_x[2] = rect_x[1] - 2
else
    rect_x[2] = rect_x[1] + 2	
end	
if (rect_y[1] > math.floor(ynet/2) ) then
    rect_y[2] = rect_y[1] - 1
else
    rect_y[2] = rect_y[1] + 1	
end	

for j = 1, dim do
    if (rect_x[2] == xd[j] and rect_y[2] == yd[j]) then
        rect_pt[2] = pt[j]
        ind[2] = j					
    end					
end	

--[[ trece teme - do 2 opcije]]--
ltry_x = rect_x[1]
rtry_x = rect_x[2]
if (rect_y[1] < rect_y[2]) then	
    ltry_y = rect_y[1] - 1
    rtry_y = rect_y[2] + 1	
else
    ltry_y = rect_y[1] + 1
    rtry_y = rect_y[2] - 1	
end	

nr = 2
if (ltry_y > 0 and  ltry_y  <= ynet) then
   for j = 1, dim do
	   if (ltry_x == xd[j] and ltry_y == yd[j]) then
           nr = nr + 1	   
           rect_pt[nr] = pt[j]
           rect_x[nr] = xd[j]
           rect_y[nr] = yd[j]
           ind[nr] = j			   
       end	
	   if (rtry_x ~= ltry_x) then
	       if (rtry_x == xd[j] and ltry_y == yd[j]) then
               nr = nr + 1			   
               rect_pt[nr] = pt[j]
               rect_x[nr] = xd[j]
               rect_y[nr] = yd[j]
               ind[nr] = j			   
           end	
       end		   
    end 
end		
if (rtry_y > 0 and  rtry_y <= ynet) then
   for j = 1, dim do
	   if (ltry_x == xd[j] and rtry_y == yd[j]) then
           nr = nr + 1	   
           rect_pt[nr] = pt[j]
           rect_x[nr] = xd[j]
           rect_y[nr] = yd[j]
           ind[nr] = j				   
       end	
	   if (rtry_x ~= ltry_x) then
	       if (rtry_x == xd[j] and rtry_y == yd[j]) then
               nr = nr + 1			   
               rect_pt[nr] = pt[j]
               rect_x[nr] = xd[j]
               rect_y[nr] = yd[j]
               ind[nr] = j			   
           end	
       end		   
    end 
end	

--[[ slike]]--

tran = min + math.random(max)
tran_pt = pt[tran]
tran_x = xd[tran]
tran_y = yd[tran]

err = 0		
for k = 1,nr do             --[[ rect_pt[k] -> tran_pt  ]]--	
    if (err == 0) then
	    if (rect_pt[k] ~= tran_pt) then
            fig_x[k] = tran_x
            fig_y[k] = tran_y
            fig_pt[k] = tran_pt
            fnd[k] = tran		
            sign[k] = 1
		    origin = rect_pt[k]
			picture = fig_pt[k]
            sum = 1
            for i = 1,nr do
                if (i ~= k) then
                    sign[i] = 0
                    qx[i] = rect_x[i] + fig_x[k] - rect_x[k]
                    qy[i] = rect_y[i] + fig_y[k] - rect_y[k]
	                if (qx[i] > 0 and qx[i] <= xnet and qy[i] > 0 and qy[i] <= ynet) then
	                    sum = sum + 1
	                    sign[i] = 1
                        fig_x[i] = qx[i]
                        fig_y[i] = qy[i] 
                        for j = 1, dim do
			                if (qx[i] == xd[j] and qy[i] == yd[j]) then
                                fig_pt[i] = pt[j]
                                fnd[i] = j					
                            end					
                        end	
                    end		
                end
	        end	
            if (sum > 2) then
	            err = 1 
		        br = 0
                for i = 1,nr do
			        if (sign[i] == 1) then
				        br = br + 1
				        value_pt[br] = rect_pt[i]
                        value_x[br] = rect_x[i]
                        value_y[br] = rect_y[i] 					
				        out_pt[br] = fig_pt[i]
                        out_x[br] = fig_x[i]
                        out_y[br] = fig_y[i] 
				    end          			
                end	
            end	
        end	
    end	
end 
    
answ = ""
if (nr == 2 ) then
    answ = msg1	
end

if (err == 0 ) then
    answ = msg2	
end

mycanvas = function(no)

  lib.start_canvas(330, 260, "center", "result[0] == 1") 
  w = 30
  ow = 10

  if (nr > 2) then 
	  lib.add_straight_path (ow+value_x[1]*w, ow+value_y[1]*w, {{(value_x[2]-value_x[1])*w, (value_y[2]-value_y[1])*w}, {(value_x[3]-value_x[2])*w, (value_y[3]-value_y[2])*w}, {(value_x[1]-value_x[3])*w, (value_y[1]-value_y[3])*w}}, blue_style, true, false)
  end	  
	  
  if (err == 1) then	  
	  lib.add_straight_path (ow+out_x[1]*w, ow+out_y[1]*w, {{(out_x[2]-out_x[1])*w, (out_y[2]-out_y[1])*w}, {(out_x[3]-out_x[2])*w, (out_y[3]-out_y[2])*w}, {(out_x[1]-out_x[3])*w, (out_y[1]-out_y[3])*w}}, red_style, false, true)	  
  else
      lib.add_circle(ow+tran_x*w, ow+tran_y*w, 4, red_style, false, true)
  end
  
  lib.add_line(ow+w, ow+w, 8*w, 4*w, style, false, false)
  lib.add_line(ow+w, ow+3*w, 8*w, 4*w, style, false, false)
  lib.add_line(ow+w, ow+5*w, 4*w, 2*w, style, false, false)
  lib.add_line(ow+5*w, ow+w,  4*w, 2*w, style, false, false)

  lib.add_line(ow+9*w, ow+w, -8*w, 4*w, style, false, false)
  lib.add_line(ow+9*w, ow+3*w, -8*w, 4*w, style, false, false)
  lib.add_line(ow+9*w, ow+5*w, -4*w, 2*w, style, false, false)
  lib.add_line(ow+5*w, ow+w,  -4*w, 2*w, style, false, false)

  for i = 1,9 do
    lib.add_line(ow, ow+(i-1)*w, 10*w, 0, style, false, false)
  end

  for i = 1,11 do
    lib.add_line(ow+(i-1)*w, ow, 0, 8*w, style, false, false)
  end
   
  for i = 1,dim do  
      lib.add_circle(ow+xd[i]*w, yd[i]*w+ow, 4, dot_style, false, false)
      lib.add_text(ow+xd[i]*w, yd[i]*w-4, pt[i], text_style, false, false)	  
  end  

  lib.end_canvas()
end  
    

      

         