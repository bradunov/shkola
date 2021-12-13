
include("terms")

                            
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};

red_style = {["off_color"] = "f30",
               ["on_color"] = "f30",
               ["line_color"] = "000",
               ["line_width"] = "2"};

blue_style = {["off_color"] = "0cf",
                ["on_color"] = "0cf",
                ["line_color"] = "000",
                ["line_width"] = "2"};
				
yelow_style = {["off_color"] = "fff",
                ["on_color"] = "f90",
                ["line_color"] = "000",
                ["line_width"] = "2"};				

line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
text_style = {["font_size"] = "14"}	
group_style = {["font_size"] = "16"}	
small_style = {["off_line_color"] = "f30",
               ["font_size"] = "12"}	


girl = {443, 491, 509, 408, 450, 433, 406} 
boy = {442, 482, 505, 395, 430, 423, 377}


qg = {}
qb = {}
out = {}
ind = {}

dim = 7

for i = 1,dim do
    qg[i] = 400  + math.random(119)
    qb[i] = 380 + math.random(120)
end   


index = math.random(9)
ch = math.random(dim)

if (index == 1) then
    for i = 1,dim do
	    if (qg[i] > qb[i]) then  
		    ind[i] = 1
		else
            ind[i] = 0
	    end
    end	
end	
if (index == 2) then
    for i = 1,dim do
	    if (qb[i] > qg[i]) then  
		    ind[i] = 1
		else
            ind[i] = 0
	    end
    end	
end	
if (index == 3) then
    out = lib.math.argsort(qg)
	ind[out[dim]] = 1
	max = qg[out[dim]]
    for i = 1,dim-1 do
	    if (qg[out[dim-i]] == max) then  
		    ind[out[dim-i]] = 1
		else
            ind[out[dim-i]] = 0
	    end
    end	
end	
if (index == 4) then
    out = lib.math.argsort(qb)
	ind[out[dim]] = 1
	max = qb[out[dim]]
    for i = 1,dim-1 do
	    if (qb[out[dim-i]] == max) then  
		    ind[out[dim-i]] = 1
		else
            ind[out[dim-i]] = 0
	    end
    end	
end	
if (index == 5) then
    out = lib.math.argsort(qg)
	ind[out[1]] = 1
	min = qg[out[1]]
    for i = 2,dim do
	    if (qg[out[i]] == min) then  
		    ind[out[i]] = 1
		else
            ind[out[i]] = 0
	    end
    end	
end	
if (index == 6) then
    out = lib.math.argsort(qb)
	ind[out[1]] = 1
	min = qb[out[1]]
    for i = 2,dim do
	    if (qb[out[i]] == min) then  
		    ind[out[i]] = 1
		else
            ind[out[i]] = 0
	    end
    end	
end
if (index == 7) then
    adg = 0
    adb = 0
    for i = 1,dim do
        adg = adg + qg[i]
        adb = adb + qb[i]	
        ind[i] = 0		
    end	
    sumg = 0
    sumb = 0
	if (adg > adb) then 
        sumg = 1
	else
	    if (adg < adb) then 
           sumb = 1	
        end
    end			
end
if (index == 8) then
    sumg = 0
    sumb = 0
	if (qg[ch] > qb[ch]) then 
        sumg = 1
	else
	    if (qg[ch] < qb[ch]) then 
           sumb = 1	
        end
    end		
end
if (index == 9) then
    sumg = 0
    sumb = 0
	if (qg[ch] < qb[ch]) then 
        sumg = 1
	else
	    if (qg[ch] > qb[ch]) then 
           sumb = 1	
        end
    end		
end

task = quest[index]
if (index > 7) then	
    task = task .. name[ch] .. "?"
else
    if (index < 7) then
        task = task .. coment
    end		
end	

answ = ""	
if (index > 6) then	
    if (sumg == 0 and sumb == 0) then
	    sgn = 3
	else
       	if (sumg == 1 and sumb == 0) then
	        sgn = 1
		else
		    sgn = 2
		end
    end		
    answ = answ .. lib.check_one_option_dropdown(msg, msg[sgn])
end

results = "" 
for i = 1,dim do 
    nr = i - 1
    if (nr > 0) then
        results = results .. "&& "
    end
    results = results .. "result[" .. tostring(nr) .. "] == "
	if (index > 6) then
	      results = results .. "0 "
	else 	  
        if (ind[i] == 1) then		      		  
            results = results .. "1 "
        else
            results = results .. "0 "
		end	
    end
end
  

mycanvas = function()

  lib.start_canvas(350, 220, "center", results)

  w = 20
  ow = 10
  v = 5
  
  scale = 520
  
  x = 2*(w + ow)
  for i = 1,dim do
      lib.add_circle (x, ow+10*w, 5, yelow_style, false, true)
	  x = x + 2*w 
  end  

  x = ow + 2*w
  for i = 1,dim do
      y = (scale-qg[i])/20
      lib.add_rectangle (x, ow+y*w, ow, (8-y)*w, red_style, false, false)
      y = (scale-qb[i])/20	  
      lib.add_rectangle (x+ow, ow+y*w, ow, (8-y)*w, blue_style, false, false)
      x = x + 4*ow
  end

  for i = 1,2*dim+1 do
      lib.add_line(3*ow, ow+i*ow, 14*w+ow, 0, style, false, false)
  end

  lib.add_line(3*ow, ow, 14*w+ow, 0, line_style, false, false)
  lib.add_line(3*ow, ow+8*w, 14*w+ow, 0, line_style, false, false)
  lib.add_line(3*ow, ow, 0, 8*w, line_style, false, false)
  lib.add_line(16*w, ow, 0, 8*w, line_style, false, false)
  
  numb = 500
  for i = 1,dim do
      lib.add_text(ow+v, ow+i*w, numb, text_style, false, false)
	  numb = numb - 20
  end  
  lib.add_text(ow+v, ow+8*w, "360", text_style, false, false)
  lib.add_text(ow+v, ow, "520", text_style, false, false)  
  
  x = 2*(w + ow)
  for i = 1,dim do
      lib.add_text(x, ow+9*w, point[i], text_style, false, false)    
      x = x + 2*w 
  end 
	  
  lib.end_canvas()
end   
          