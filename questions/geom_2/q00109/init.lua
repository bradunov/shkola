
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
				
text_style = {["font_size"] = "14"}	

name = {"a", "b", "c", "P", "t", "R", "r", "O", "h"}

val = {}
ind = {}
out = {}

max_range = 4
numb2 = 2 + math.random(max_range)
numb1 = math.random(numb2 - 1)
val[1] = numb2^2 - numb1^2                        --[[stranice]]--
val[2] = 2 * numb1 * numb2
val[3] = numb2^2 + numb1^2	
ch = math.random(2)
if (ch == 2) then
	tmp = val[2]
	val[2] = val[1]
	val[1] = tmp
end	
	
fct = math.random(3)
val[8] = 0	                                  --[[obim]]--
for i = 1,3 do
	val[i] = val[i] * fct
	val[8] = val[8] + val[i]
end	
val[5] = 0.5 * val[3]                         --[[ tezisna linija]]--
val[6] = val[5]                               --[[opisani krug]]-- 	
val[4] = val[1] * val[2]
val[7] = val[4] / val[8]	                  --[[upisani krug]]--
val[9] = val[4] / val[3]                      --[[ visina]]-- 
val[4] = 0.5 * val[4]                         --[[povrsina]]--

for i = 1,9 do
	val[i] = lib.math.round_dec(val[i],2)
end

qst1 = 1
qst2 = 1 + math.random(5)

nr = 0
for i = 2,9 do
	if(i ~= qst2) then
	   nr = nr + 1
       ind[nr] = i
    end   	   
end
out = lib.math.random_shuffle(ind)	

ans1 = out[1]
ans2 = out[4]


mycanvas = function(no)

  ow = 10
  w = 250
  ov = 150
  v = 40

  lib.start_canvas(320, 140, "center") 
 
  lib.add_straight_path(2*(ow+v)+3, ow-2, {{w-2*v+ow-2, ov-v+2}}, style, true, false)    
  lib.add_straight_path(ov-v-5, ow-2, {{-2*v+2*ow-2, ov-3*ow-6}}, style, true, false)  
  lib.add_straight_path(v+2, 3*v, {{w-ow-2, 0}}, style, true, false)  

  lib.add_straight_path(4*v, 3*v, {{-2*(v-ow)+5, -3*v+ow}}, dif_style, true, false) 
  lib.add_straight_path(w-ov+5, ow, {{0, 2*v+3*ow}}, dif_style, true, false) 
  
  lib.add_text(ov-ow, 2*(v-ow), "t", text_style)
  lib.add_text(2*v-ow-3, 2*(v-ow), "b", text_style)
  lib.add_text(ov+v+ow+2, 2*(v-ow), "a", text_style)   
  lib.add_text(ov+2*ow, ov-2*ow, "c", text_style) 
  lib.add_text(w-ov+ow, 2*(v-ow), "h", text_style) 
    
  lib.end_canvas()
end 