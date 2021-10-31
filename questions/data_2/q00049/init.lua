
include("terms")
                            
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};

yelow_style = {["off_color"] = "ff0",
               ["on_color"] = "ff0",
               ["line_color"] = "000",
               ["line_width"] = "2"};

green_style = {["off_color"] = "6f6",
                ["on_color"] = "6f6",
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

point = {"0-14", "15-29", "30-44", "45-59", "60-74", "75-90"}
bound = {15, 30, 45, 60, 75} 
mid = {7, 22, 37, 52, 67, 82}

qa = {}
qb = {}

step = 5
step2 = 2 * step
step4 = 4 * step
number = 10 * step2

ind = math.random(2)
nre = ind - 1 + math.random(4)
edge = bound[nre]

max_a = 0
for i = 1,3 do
    if (i == 1) then	  
        min =  - 1
	else
        min =  max_a
    end		
    qa[i] = min + math.random(i+1)
    qa[7-i] = min + math.random(i+1)
    if (max_a < qa[i]) then
        max_a = qa[i]
    end
    if (max_a < qa[7-i]) then
        max_a = qa[7-i]
    end
end	

max_b = 0
for i = 1,3 do
    if (i == 1) then	  
        min =  - 1
	else
        min =  max_b
    end	
    qb[i] = min + math.random(i+1)
    qb[7-i] = min + math.random(i+1)
    if (max_b < qb[i]) then
        max_b = qb[i]
    end
    if (max_b < qb[7-i]) then
        max_a = qb[7-i]
    end
end

qa[4] = step4
qb[4] = step4
for i = 1,6 do
    if (i ~= 4) then 
        qa[4] = qa[4] - qa[i]
        qb[4] = qb[4] - qb[i]
    end	
end	

sum_a = 0
sum_b = 0
if (ind == 1) then
    min_range = nre + 1
	max_range = 6
else
    min_range = 1
	max_range = nre
end		
for i = min_range,max_range do
    sum_a = sum_a + qa[i]	
    sum_b = sum_b + qb[i]
end	
sum_a = sum_a * step
sum_b = sum_b * step

aver_a = 0
aver_b = 0
for i = 1,6 do
    aver_a = aver_a + qa[i] * mid[i]
	aver_b = aver_b + qb[i] * mid[i]
end	
aver_a = aver_a/20
aver_b = aver_b/20


index = math.random(2)
quest = ""



if (index == 1) then	
    if (ind == 1) then  
        quest = msg[3] .. " " .. edge .. " " .. msg[ind] .. msg[4]
    else
        quest =  msg[3] .. " " .. msg[ind] .. " " .. edge .. msg[4]	
    end	
	outa = sum_a
	outb = sum_b
else
    quest = msg[5] 
	outa = aver_a
	outb = aver_b
end


if (max_a < qa[4]) then
    max_a = qa[4]
end
if (max_b < qb[4]) then
    max_b = qb[4]
end

if (max_a > max_b) then
    max_range = max_a
else
    max_range = max_b
end


if (max_range - 2*math.floor(max_range/2) ~= 0 ) then
    max_range = max_range + 1
end   	 
scale = math.floor(max_range/2)



mycanvas = function()

  lib.start_canvas(350, 130, "center")

  w = 20
  ow = 10
  v = 5

  
  x = 2*w + ow
  for i = 1,6 do
      lib.add_text(w+x, w+v, point[i], text_style, false, false) 	  
	  lib.add_text(w+x-ow, 2*w+v, "(", small_style, false, false) 
      lib.add_text(w+x, 2*w+v, mid[i], small_style, false, false)	  
      lib.add_text(w+x+ow, 2*w+v, ")", small_style, false, false)	    	  
      x = x + 2*w + ow
  end 
  lib.add_rectangle (v, 3*w, 2*w, w+ow, yelow_style, false, false)
  lib.add_rectangle (v, 4*w+ow, 2*w, w+ow, green_style, false, false)  
  lib.add_text(v+w, 4*w-v, "A", group_style, false, false) 
  lib.add_text(v+w, 5*w+v, "B", group_style, false, false) 	  

  for i = 1,7 do
    lib.add_line(i*(2*w + ow)-v, ow, 0, 6*w-ow, line_style, false, false)
  end
    lib.add_line(v, ow, 0, 6*w-ow, line_style, false, false)

  for i = 1,3 do
    lib.add_line(v, w+i*(w+ow)+ow, 17*w, 0, line_style, false, false)
  end
    lib.add_line(v, ow, 17*w, 0, line_style, false, false)

  for i = 1,6 do
      numb_a = qa[i] * step
      lib.add_text(w+i*(2*w + ow), 4*w-v, numb_a, text_style, false, false)
      numb_b = qb[i] * step
      lib.add_text(w+i*(2*w + ow), 5*w+v, numb_b, text_style, false, false)
  end	  
	    
  lib.end_canvas()
end   
     