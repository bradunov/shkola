
style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "1"};

line_style = 
	{["line_color"] = "000",
        ["line_width"] = "1"};

yelow_style = 
	{["off_color"] = "ff9",
        ["on_color"] = "ff9",
        ["line_color"] = "000",
        ["line_width"] = "2"};
			
text_style = {["font_size"] = "16"}

unit = {"cm", "cm²", "°"}  

pt = {"A", "B", "C", "D"}
name = {"AD", "BC", "AB", "CD", "O", "P", "∠DBC"}

val = {}
ind = {}
out = {}
meas = {""}

for i = 1,5 do
    meas[i] = unit[1]
end	

qst1 = math.random(2)
qst2 = 2 + math.random(2)
qst3 = math.random(7)
if (qst3 == qst1 or qst3 == qst2) then
    qst3 = 4 + math.random(3)
end		
if (qst3 == 7) then	
    meas[3] = unit[3]
else
    if (qst3 == 6) then
        meas[3] = unit[2]	
	end
end	

max_range = 6

val[2] = 2 + math.random(max_range)                        --[[poluprecnici]]--
val[1] = val[2] + 1 + math.random(max_range)
if (qst3 == 7) then	
    val[4] = val[2] * math.sqrt(2)
	if (qst1 == 1) then
	    qst2 = 4
    else
        qst2 = 3
    end		
else	
    val[4] = 2 + math.random(2*val[2]-4)	           --[[CD]]--
end	

tmp = 0.5 * val[4]
val[3] = math.sqrt(val[1]^2 - tmp^2) + math.sqrt(val[2]^2 - tmp^2)     --[[AB]]--
val[5] = 2 *(val[1] + val[2])                              --[[obim]]--
val[6] = 0.5 * val[3] * val[4]                           --[[povrsina]]--
val[7] = 90                                               --[[ ugao DAC]]--

for i = 3,6  do                                          
    val[i] = lib.math.round_dec(val[i],3)
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
for i = 4,5 do
    if (out[i-3] == 6) then
        meas[i] = unit[2]  
    end
end	

mycanvas = function(no)

  lib.start_canvas(250, 150, "center")

  ov = 55
  ow = 15
  
  lib.add_straight_path (2*(ov+ow)+8, 2*ow+3, {{-ov, ov-7}, {ov+ow+2, ow+2}}, yelow_style, false, false)
  lib.add_straight_path (2*(ov+ow)+8, 2*ow+3, {{2*ow+2, 2*ow-2}, {-ow-2, ov-ow-3}}, yelow_style, false, false)
  lib.add_line(2*(ov+ow)+8, 2*ow+3, ow, ov+ow-2, line_style, false, false)
  lib.add_line(2*ov-ow-2, ov+2*ow-5, ov+2*ow, -ow-4, line_style, false, false)    
  lib.add_circle(2*ov-ow, 2*(ov-ow), ov+ow, style, false, false)	  	 
  lib.add_circle(3*ov+ow, 4*ow, ov-ow, style, false, false) 
  
  lib.add_text(ov+2*ow, ov+ow, pt[1], text_style)   
  lib.add_text(3*ov+ow+5, ov-5, pt[2], text_style)
  lib.add_text(2*(ov+ow)+6, ow+2, pt[3], text_style)
  lib.add_text(2*(ov+2*ow), 2*ov+2, pt[4], text_style)  

  lib.end_canvas()
end     
      