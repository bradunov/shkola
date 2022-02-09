
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

name = {"a", "b", "d\(\small_1\)", "d\(\small_2\)", "O", "P"}

val = {}
ind = {}
out = {}

max_range = 6

val[1] = 2 + math.random(max_range)                        --[[stranice]]--
val[2] = val[1] + 1 + math.random(max_range)
val[4] = 2 + math.random(2*val[1]-3)	           --[[d2]]--

tmp = 0.5 * val[4]
val[3] = math.sqrt(val[1]^2 - tmp^2) + math.sqrt(val[2]^2 - tmp^2)     --[[d1]]--
val[5] = 2 *(val[1] + val[2])                              --[[obim]]--
val[6] = 0.5 * val[3] * val[4]                           --[[povrsina]]--

for i = 3,6 do
	val[i] = lib.math.round_dec(val[i],3)
end

qst1 = math.random(2)
qst2 = 2 + math.random(2)
--[[
qst3 = qst2 + math.random(6 - qst2)
]]--
qst3 = math.random(6)
if (qst3 == qst1 or qst3 == qst2) then
    qst3 = 4 + math.random(2)
end		

nr = 0
for i = 1,6 do
	if(i ~= qst1 and i ~= qst2 and i ~= qst3) then
	   nr = nr + 1
       ind[nr] = i
    end   	   
end
out = lib.math.random_shuffle(ind)	

ans1 = lib.math.round_dec(val[out[1]],1)
ans2 = lib.math.round_dec(val[out[2]],1)

mycanvas = function(no)

  ow = 8
  w = 200
  ov = 120
  v = 32

  lib.start_canvas(320, 110, "center") 
 
  lib.add_straight_path(3*v+3, ow-2, {{w+2*ow-2, v+2*ow}}, style, true, false)    
  lib.add_straight_path(ov+2*ow-v-5, ow-2, {{-3*v+ow-2, v+2*ow}}, style, true, false)  
  lib.add_straight_path(ow+2, v+3*ow-2, {{3*v-ow+2, v+2*ow}}, style, true, false)
  lib.add_straight_path(3*v+4, 3*v+6, {{w+2*ow-2, -v-2*ow}}, style, true, false)  
  lib.add_straight_path(w-ov+3+2*ow, ow, {{0, 2*v+3*ow+6}}, dif_style, true, false) 
  lib.add_straight_path(ow, v+3*ow-2, {{w+ow+3*v, 0}}, dif_style, true, false)

  lib.add_text(2*(v-ow)-2, 2*ow, name[1], text_style)
  lib.add_text(2*(v-ow)-2, ov-v, name[1], text_style)
  lib.add_text(w+ow, 2*ow, name[2], text_style) 
  lib.add_text(w+ow, ov-v, name[2], text_style)    
  lib.add_input(w-ov+ow, 3*ow, 50, 30, name[4]) 
  lib.add_input(ov+v-4, v, 50, 30, name[3]) 

    
  lib.end_canvas()
end            
            