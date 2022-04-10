
msg = {"pravougli trapez ", "jednakokraki trapez ", "trapez"} 

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

dif_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};
				
text_style = {["font_size"] = "16"}	

unit = {"cm", "cm\(\small^2\)"}
symb = {"(q = h\(\small_m\) )", "(q = s)", " "}
name = {"m", "n", "s", "q", "h\(\small_m\)", "d\(\small_1\)", "d\(\small_2\)", "O", "P"}

val = {}
ind = {}
out = {}
prt = {}
meas = {""}

for i = 1,2 do
    meas[i] = unit[1]
end	

ch = math.random(3)

max_range = 9
val[1] = 6 + math.random(max_range)                            --[[osnovice]]--
val[2] = 2 + math.random(val[1]-6)
val[5] = 2 + math.random(val[2])	                           --[[visina]]--

if (ch == 1) then                      --[[pravougli]]--
	val[3] = math.sqrt((val[1] - val[2])^2 + val[5]^2)         --[[krak1]]--
	val[4] = val[5]                                            --[[krak2]]--
	val[6] = math.sqrt(val[1]^2 + val[5]^2)                    --[[dijagonala1]]--
	val[7] = math.sqrt(val[2]^2 + val[5]^2)                    --[[dijagonala2]]--
end

if (ch == 2) then                       --[[jednakokraki]]--
	val[3] = math.sqrt(0.25*(val[1] - val[2])^2 + val[5]^2)    --[[krak1]]--
	val[4] = val[3]                                            --[[krak2]]--
	val[6] = math.sqrt(0.25*(val[1] + val[2])^2 + val[5]^2)    --[[dijagonala1]]--
	val[7] = val[6]                                            --[[dijagonala2]]--
end

if (ch == 3) then                        --[[opsti slucaj]]--
    tmp = math.floor((val[1] - val[2])*0.5)
	xm = math.random(tmp) 
	val[3] = math.sqrt(xm^2 + val[5]^2)                        --[[krak1]]--
	ym = val[1] - val[2] - xm
	val[4] = math.sqrt(ym^2 + val[5]^2)                        --[[krak2]]--
	val[6] = math.sqrt((val[2] + xm)^2 + val[5]^2)             --[[dijagonala1]]--
	val[7] = math.sqrt((val[2] + ym)^2 + val[5]^2)             --[[dijagonala2]]--
end

val[8] = val[1] + val[2] + val[3] + val[4]                 --[[obim]]--
val[9] = 0.5 * (val[1] + val[2]) * val[5]                  --[[povrsina]]--

for i = 3,8 do
	val[i] = lib.math.round_dec(val[i],3)
end

qst1 = math.random(3)
qst2 = 4 + math.random(3)

quest = ""
if (ch == 3) then
    quest = quest .. name[4].. " = " .. val[4] .. ","
end

ind[1] = qst1
nr = 1
for i = 5,9 do
	if(i ~= qst2) then 
	   nr = nr + 1
       ind[nr] = i	
    end   	   
end
out = lib.math.random_shuffle(ind)	

ans1 = lib.math.round_dec(val[out[1]],1)
ans2 = lib.math.round_dec(val[out[2]],1)
if (out[1] == 9) then
    meas[1] = unit[2]
end	
if (out[2] == 9) then
    meas[2] = unit[2]
end

nr = 1
for i = 1,3 do  
    if (i ~= qst1) then
        prt[nr] = i
	    nr = nr + 1
	end
end
prt[nr] = qst2	


mycanvas = function(no)

  ow = 8
  w = 200
  ov = 120
  v = 32

scale = 8

  lib.start_canvas(320, 120, "center") 
 
  lib.add_straight_path(3*v+3, scale+ow-2, {{w-ow-2*v, 0}}, style, true, false)    
  lib.add_straight_path(ov+2*ow-v-5, scale+ow-2, {{-3*v+ow-2, ov-3*ow-6}}, style, true, false)  
  lib.add_straight_path(ow+2, scale+3*v, {{w+2*ow+v, 0}}, style, true, false)
  lib.add_straight_path(w+2*v-5, scale+3*v, {{-v, -ov+3*ow+6}}, style, true, false)  
  lib.add_straight_path(w-ov+3+2*ow, scale+ow, {{0, 2*v+3*ow}}, dif_style, true, false) 
  lib.add_straight_path(ow, scale+3*v, {{w+2*ow, ow-3*v}}, dif_style, true, false)
  lib.add_straight_path(3*v+2, scale+ow-2, {{w-v-ow, 3*v-ow}}, dif_style, true, false)

  lib.add_text(ov+3*ow, scale+ov-2*ow, name[1], text_style) 
  lib.add_text(ov+3*ow, scale-3, name[2], text_style) 
  lib.add_text(2*(v-ow)-2, scale+2*(v-ow)-3, name[3], text_style)
  lib.add_text(w+2*v-ow, scale+2*(v-ow)-3, name[4], text_style)    
  lib.add_input(w-ov+ow, scale+2*v, 50, 30, name[5]) 
  lib.add_input(ov+2*v-4, scale+2*ow, 50, 30, name[6]) 
  lib.add_input(ov+2*v-4, scale+2*v, 50, 30, name[7])
    
  lib.end_canvas()
end              
     