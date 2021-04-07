
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}		

x = {}
y = {}

sign = {}
left = {}
right = {}

out = {}
index = {}

mark = {"a", "b", "c", "d"}
ang = {"mOa", "mOb", "mOn", "aOn", "aOb", "aOc", "cOb", "mOd", "nOd", "cOd"}
qq = {}
qq[1] = {0,1,1,1,1,1,1,1,1,1}
qq[2] = {2,0,2,2,2,2,2,1,2,2}
qq[3] = {2,1,0,2,1,2,1,1,0,1}
qq[4] = {2,1,1,0,1,2,1,1,1,1}
qq[5] = {2,1,2,2,0,2,2,1,2,2}
qq[6] = {2,1,1,1,1,0,1,1,1,1}
qq[7] = {2,1,2,2,1,2,0,1,2,1}
qq[8] = {2,2,2,2,2,2,2,0,2,2}
qq[9] = {2,1,0,2,1,2,1,1,0,1}
qq[10] = {2,1,2,2,1,2,2,1,2,0}


symb = "\(\angle\)"

ow = 15
ov = 150

max = 3

y[1] = 1 + math.random(max) 
y[2] = y[1] + 1 + math.random(8 - y[1]) 

for i = 1, 2 do
    temp = math.sqrt(1 - y[i]*y[i]/100)
	x[i] =  math.floor(temp * ov)
	y[i] = y[i] * ow
end	

ind = math.random(3) 

if (ind == 1) then
	max = 5
else
	if (ind == 2) then
	    max = 7	
	else
        max = 10
    end
end	

nr = 0
for i = 1,max-1 do
	for j = i+1,max do
		nr = nr + 1
	    left[nr] = ang[i]  
	    right[nr] = ang[j]
	    if (qq[i][j] == 2) then
	        sign[nr] = ">" 
        else
            if (qq[i][j] == 1) then
	            sign[nr] = "<" 
            else
	            sign[nr] = "=" 	
            end
	    end		
    end		
end	

for i = 1,nr do
    index[i] = i
end	
out = lib.math.random_shuffle(index)
	

mycanvas = function(no)

  lib.start_canvas(300, 230, "center")
  
  lib.add_straight_path(ov, ow+ov, {{ov, 0}}, style, true, false)
  lib.add_text(2*ov-ow, ov+2*ow, "m", text_style, false, false)
  lib.add_straight_path(ov, ow+ov, {{0, -ov}}, style, true, false)
  lib.add_text(ov-ow, 2*ow, "n", text_style, false, false)   
  
  lib.add_straight_path(ov, ow+ov, {{x[1], -y[1]}}, style, true, false) 
  lib.add_text(ov+x[1]-ow, ov-y[1], mark[1], text_style, false, false)
  lib.add_straight_path(ov, ow+ov, {{-ov+ow, -x[2]+3*ow}}, style, true, false)
  lib.add_text(2*ow, ov-x[2]+3*ow, mark[2], text_style, false, false)  
	  
  if (ind > 1) then	  
	  lib.add_straight_path(ov, ow+ov, {{x[2]-ow, -ov}}, style, true, false) 
      lib.add_text(ov+x[2]-10, 2*ow, mark[3], text_style, false, false)	  
	  if (ind == 3) then
          lib.add_straight_path(ov, ow+ov, {{-ov+ow, 0}}, style, true, false)
          lib.add_text(2*ow, 2*ow+ov, mark[4], text_style, false, false)
      end
   end	  

  lib.add_text(ov, ov+2, ".", dot_style, false, false)
  lib.add_text(ov, ov+2*ow, "O", text_style, false, false)
 		
  lib.end_canvas()
end     

