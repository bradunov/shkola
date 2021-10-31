
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

scale_max = (scale + 4) * 20

mycanvas = function()

  lib.start_canvas(350, scale_max, "center")

  w = 20
  ow = 10
  v = 5

  x = 2*w
  for i = 1,6 do
      lib.add_rectangle (x, 3*ow+w*(scale-1-qa[i]/2), ow, qa[i]*ow, yelow_style, false, false)
      lib.add_rectangle (x+ow, 3*ow+w*(scale-1-qb[i]/2), ow, qb[i]*ow, green_style, false, false)
      x = x + 5*ow
  end

  for i = 1,scale-1 do
      numb = tostring((scale-i)*10)
      lib.add_line(3*ow, ow+i*w, 14*w+ow, 0, style, false, false)
	  lib.add_text(ow, ow+i*w, numb, text_style, false, false)
  end

  lib.add_line(3*ow, ow, 14*w+ow, 0, line_style, false, false)
  lib.add_line(3*ow, ow+scale*w, 14*w+ow, 0, line_style, false, false)
  lib.add_line(3*ow, ow, 0, scale*w, line_style, false, false)
  lib.add_line(16*w, ow, 0, scale*w, line_style, false, false)
  lib.add_text(ow, ow+scale*w, "0", text_style, false, false)
  numb = tostring(scale*10)
  lib.add_text(ow, ow, numb, text_style, false, false)  
  
  x = 2*w + ow
  for i = 1,6 do
      lib.add_text(x, (scale+1)*w, point[i], text_style, false, false) 
	  lib.add_text(x-ow, (scale+2)*w-v, "(", small_style, false, false) 
      lib.add_text(x, (scale+2)*w-v, mid[i], small_style, false, false) 
	  lib.add_text(x+ow, (scale+2)*w-v, ")", small_style, false, false)	    
      x = x + 2*w + ow
  end 
  lib.add_rectangle (6*w-v, (scale+3)*w, w, w, yelow_style, false, false)
  lib.add_rectangle (12*w-v, (scale+3)*w, w, w, green_style, false, false)  
  lib.add_text(6*w+v, (scale+4)*w-ow, "A", group_style, false, false) 
  lib.add_text(12*w+v, (scale+4)*w-ow, "B", group_style, false, false) 	   
	  
  lib.end_canvas()
end   
        