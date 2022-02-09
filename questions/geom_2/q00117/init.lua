
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

name = {"a", "b", "h\(\small_a\)", "d\(\small_1\)", "d\(\small_2\)", "O", "P"}

val = {}
ind = {}
out = {}

max_range = 9

val[1] = 6 + math.random(max_range)                        --[[stranice]]--
val[2] = 4 + math.random(val[1]-5)
val[3] = 2 + math.random(val[2]-3)	                         --[[visina]]--

tmp = math.sqrt(val[2]^2 - val[3]^2)
val[4] = math.sqrt((val[1]+tmp)^2 + val[3]^2)              --[[dijagonala]]--
val[5] = math.sqrt((val[1]-tmp)^2 + val[3]^2)
val[6] = 2 *(val[1] + val[2])                              --[[obim]]--
val[7] = val[1] * val[3]                                  --[[povrsina]]--

for i = 4,5 do
	val[i] = lib.math.round_dec(val[i],3)
end

qst1 = math.random(2)
qst2 = qst1 + math.random(3)
qst3 = qst2 + math.random(7 - qst2)

nr = 0
for i = 1,7 do
	if(i ~= qst1 and i ~= qst2 and i ~= qst3) then
	   nr = nr + 1
       ind[nr] = i
    end   	   
end
out = lib.math.random_shuffle(ind)	

ans1 = lib.math.round_dec(val[out[1]],1)
ans2 = lib.math.round_dec(val[out[4]],1)


mycanvas = function(no)

  ow = 8
  w = 200
  ov = 120
  v = 32

  lib.start_canvas(320, 110, "center") 
 
  lib.add_straight_path(3*v+3, ow-2, {{w+2*ow-2, 0}}, style, true, false)    
  lib.add_straight_path(ov+2*ow-v-5, ow-2, {{-3*v+ow-2, ov-3*ow-6}}, style, true, false)  
  lib.add_straight_path(ow+2, 3*v, {{w+2*ow-2, 0}}, style, true, false)
  lib.add_straight_path(w+3*ow, 3*v, {{3*v-ow+2, -ov+3*ow+6}}, style, true, false)  
  lib.add_straight_path(w-ov+3+2*ow, ow, {{0, 2*v+3*ow}}, dif_style, true, false) 
  lib.add_straight_path(ow, 3*v, {{w+ow+3*v, ow-3*v}}, dif_style, true, false)
  lib.add_straight_path(3*v+2, ow-2, {{w+3*ow-3*v-3, 3*v-ow}}, dif_style, true, false)

  lib.add_text(ov+ow, ov-2*ow, name[1], text_style) 
  lib.add_text(2*(v-ow)-2, 2*(v-ow)-3, name[2], text_style)   
  lib.add_input(w-ov-2*ow, 3*ow, 50, 30, name[3]) 
  lib.add_input(ov+2*v-4, 2*ow, 50, 30, name[4]) 
  lib.add_input(ov, 2*ow, 50, 30, name[5])
    
  lib.end_canvas()
end 
         