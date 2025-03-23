
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
text_style = {["font_size"] = "14"}		
		

meas = "°"
symb = {"α", "β", "γ", "δ", "ω"}
sp = "\(\ \ \ \ \)"

index = {2, 3, 4, 5, 6, 9, 12, 15, 18, 24, 30, 45}
dim = 12
numb = {}
ang = {}

q = {}
q1 = {}
q2 = {}
qq = {}

sum = 0
for i = 1,3 do
    numb[i] = 3 + math.random(2+i)
    sum = sum + numb[i]
end	
numb[4] = 1
for i = 1,dim-1 do	
    if (sum >= index[i] and sum < index[i+1]) then
            tmp = i + math.random(dim - i)
	    numb[4] = index[tmp] - sum
	end	
end	
sum = sum + numb[4]

q1 = lib.math.gcd(numb[1], numb[2])
q2 = lib.math.gcd(numb[3], numb[4])
qq = lib.math.gcd(q1, q2)
if (qq ~= 1) then
    sum = 0
	for i = 1,4 do
        numb[i] = math.floor(numb[i]/qq)
		sum = sum + numb[i]
	end
end	

val = math.floor(360/sum)

for i = 1,4 do
    ang[i] = numb[i] * val		
end
ind = 0
for i = 1,4 do
    if (ang[i] == 180) then
        ind = i
	end	
end
if (ind ~= 0) then
    q = lib.math.argsort(numb)
	numb[ind] = numb[ind] - 1
    ang[ind] = numb[ind] * val	
	numb[q[1]] = numb[q[1]] + 1
    ang[q[1]] = numb[q[1]] * val	
end		
	
sign = 1
if (ang[1] == ang[3] and ang[2] == ang[4] ) then
    sign = 2
end	
if (ang[1] == 90 and ang[2] == 90 and ang[3] == 90 and ang[4] == 90 ) then
    sign = 3
end
if (ang[1] + ang[4] == 180  and ang[2] + ang[3] == 180) then
    sign = 4
end	
if (ang[1] + ang[2] == 180  and ang[3] + ang[4] == 180) then
    sign = 4
end	
if (ang[1] == ang[3]  and ang[2] ~= ang[4]) then
    sign = 5
end	
if (ang[1] ~= ang[3]  and ang[2] == ang[4]) then
    sign = 5
end
for i = 1,4 do
    if (ang[i] > 180) then
        sign = 6
	end	
end	
name = msg[sign]
          
quest = ""
for i = 1,4 do
    if (numb[i] == 1) then
	    text = ""
	else
        text = tostring( math.floor(numb[i]))
    end	
    quest = quest .. sp .. symb[i] .. " = " .. text .. symb[5] .. ", " 
end	   
        
mycanvas = function(no)

  ow = 6
  w = 150
  ov = 90
  v = 24

  lib.start_canvas(200, 100, "center")
  
  lib.add_straight_path(ov+v, 2*ow, {{w-ov, ov-ow}}, style, true, false)
  lib.add_straight_path(ov-v, v+ow, {{-2*v, ov-3*ow}}, style, true, false) 
  lib.add_straight_path(v, 2*v, {{ov+v, -v}}, style, true, false)   
  lib.add_straight_path(ow, ov-ow, {{w+v, 0}}, style, true, false)  
  
  lib.add_input(v-5, 2*v-5,  50, 30, symb[1])
  lib.add_input(w-v, 2*v-5, 50, 30, symb[2])
  lib.add_input(ov+ow, ow-3, 50, 30, symb[3]) 
  lib.add_input(2*v-ow, 3*ow, 50, 30, symb[4])  
	
  lib.add_text(v+ow, ov+5, "A", text_style) 
  lib.add_text(w+2*ow+5, ov+5, "B", text_style)
  lib.add_text(w-v, 3*ow, "C", text_style)
  lib.add_text(w-ov-ow, v+ow, "D", text_style)

  lib.end_canvas()
end 
        