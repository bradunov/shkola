
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
circ_style = 
	{["off_color"] = "fff",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "1"}
		

text_style = {["font_size"] = "14"}

denom = {}
enum = {}
value = {}
answ = {}
out = {}

frac = {3, 4, 5, 6, 7, 8}
dim = 4

whole = 1 + math.random(5)
temp = math.random(5)
for i = 1,2 do
	denom[i] = frac[temp+i-1]
	enum[i] =  math.random(denom[i]-1)
	value[i] = (whole * denom[i] + enum[i]) / denom[i]
end
if (value[1] == value[2]) then
    enum[2] = 1
	value[2] = (whole * denom[2] + enum[2]) / denom[2]
end	

dif = math.abs(value[1] - value[2])
step = 2*dif/3 
if (value[1] < value[2]) then
    bl = 1
	br = 2
else
    bl = 2
	br = 1
end	

lft = tostring(whole) .. lib.frac_start() .. enum[bl] .. lib.frac_mid() .. denom[bl] .. lib.frac_end()	
rght = tostring(whole) .. lib.frac_start() .. tostring(enum[br]) .. lib.frac_mid() .. tostring(denom[br]) .. lib.frac_end()	

for i = 1,dim do
	arg = value[bl] - step * 0.5
	answ[i] = lib.math.round_dec(arg + (i-1)*step, 2)
end	
out = lib.math.random_shuffle(answ)

results = ""
for i = 1, dim do
  if i > 1 then
	 results = results .. " && "
  end
  results = results .. "result[" .. tostring(i-1) .. "] == "
  dl = out[i] - value[bl]
  dr = value[br] - out[i]
  if (dl * dr < 0) then
	  results = results .. "0"
  else
	  results = results .. "1"
  end	
end
  
mycanvas = function(no)

  lib.start_canvas(320, 100, "center", results)

	v = 5
	ow = 20
    ov = 50
	w = 280

	lib.add_line(ow, 2*v, w, 0, style, false, false)
	lib.add_line(5*ow, v, 0, 2*v, style, false, false) 
	lib.add_line(w -3*ow, v, 0, 2*v, style, false, false)    
	lib.add_straight_path(ow+v, 3*v/2, {{-v, v/2}, {v, v/2}}, style, false, false)
	lib.add_straight_path(ow+w-v, 3*v/2, {{v, v/2}, {-v, v/2}}, style, false, false)

	for i = 1,dim do
		lib.add_circle ((i-1)*(ow+ov)+ov, 3*ow, 5, circ_style, false, true)
	    lib.add_input((i-1)*(ow+ov)+ov-ow, ov+ow, 50, 40, tostring(out[i]))
	end
		
  lib.end_canvas()
end        
       