
include("terms")

style =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};
		
text_style = {["font_size"] = "16"}
small_style = {["font_size"] = "14"}

temp = {}
out = {}
nr_low = {}
nr_high = {}

min_range = -4
max_range = 7
sg = 0
for i = 1,7 do
    temp[i] = min_range + math.random(max_range)
	if (temp[i] < 0) then
	    sg = 1
	end
end
if (sg == 0) then
    tmp = math.random(7)
	temp[tmp] = -temp[tmp]
end	

min_temp = temp[1]
max_temp = temp[1]
nr_min = 1
nr_max = 1
for i = 2,7 do
    if (temp[i] < min_temp) then
	    min_temp = temp[i]
        nr_min = i
	end
    if (temp[i] > max_temp) then
	    max_temp = temp[i]
        nr_max = i
	end
end	
nrl = 0
nrh = 0
for i = 1,7 do    
    if (temp[i] == temp[nr_min]) then
	    nrl = nrl + 1
        nr_low[nrl] = i
    end		
    if (temp[i] == temp[nr_max]) then
	    nrh = nrh + 1
        nr_high[nrh] = i
    end		
end
reply1 = "answer == '" .. name[nr_low[1]] .. "' "  
if (nrl > 1) then
    for j = 2,nrl do
		reply1 = reply1 .. "|| answer == '" .. name[nr_low[j]] .. "'" 
	end
end	
ans1 = "answer = '" .. name[nr_low[1]] .. "' ";
reply2 = "answer == '" .. name[nr_high[1]] .. "' "  
if (nrh > 1) then
    for j = 2,nrh do
		reply2 = reply2 .. "|| answer == '" .. name[nr_high[j]] .. "'" 
	end
end	
ans2 = "answer = '" .. name[nr_high[1]] .. "' ";
	
grad_temp = max_temp - min_temp
ch = math.random(2)
if (ch == 1) then
	first = 1
	second = 1 + math.random(6)
else
	first = 7
	second = math.random(6)
end
dif = math.abs(temp[second] - temp[first])
out = lib.math.argsort(temp)
answ = ""
for i = 1,7 do
	answ = answ .. lib.check_number(temp[out[i]], 20) 
	if (i < 7) then
		answ = answ .. ", "
    end		
end

mycanvas = function()

  lib.start_canvas(350, 90, "center")
 
  v = 35
  ov = 80
  ow = 10
 
  lib.add_line(ow, ow, 0, 2*v, style, false, false)
  for i = 1,8 do 
     lib.add_line(ow+5+(i+1)*v, ow, 0, 2*v, style, false, false)
  end
	 
  for j = 1,3 do
    lib.add_line(ow, ow+(j-1)*v, 4*ov, 0, style, false, false)
  end

  lib.add_input(v-ow, v-2*ow, 50, 30, msg[1])
  lib.add_input(v-2*ow, 2*v-2*ow, 70, 30, msg[2])

  for i = 1,7 do
      lib.add_input(5+(i+1)*v, v-2*ow, 50, 30, short[i]) 
      lib.add_text(3*ow+(i+1)*v, 2*v-ow, temp[i], text_style, false, false)
  end

  lib.end_canvas()
end                                 
       