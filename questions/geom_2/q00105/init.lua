
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
line_style = 
	{["line_color"] = "f30",
        ["line_width"] = "2"};		
grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};			
colour_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "2"};			

dot_style = {["font_size"] = "40"}		
text_style = {["font_size"] = "16"}	

name_a = {"OA", "OB", "AO", "AJ", "BJ", "BO", "MT", "AT", "JA", "JM", "BE", "JB", "OT", "OE", "BA", "EM", "TM"}
name_s = {"OJ", "AB", "TE", "BA", "ET", "AM", "OE", "JT", "BM", "OT", "JE", "OM", "BT", "AE", "EA"}	
--[[
            1     2     3     4     5     6     7     8     9    10    11    12    13    14    15    16    17   

OA = BJ = EM  /  AT = JM = BE  /  OB = AJ = TM  /  BE = JM = AT  /  AB = TE  /  OE = AM  /  OT = BM			
]]--		  

q = {}
q1 = {}
q2 = {}
out = {}

dim = 13
stampa = 9

ind = math.random(10)

if (ind == 1) then
	a1 = 16 
    a2 = 2 
	sum1 = 4
	sum2 = 5
end

if (ind == 2) then
	a1 = 17
    a2 = 3 
	sum1 = 1
	sum2 = 0	
end	

if (ind == 3) then
	a1 = 16 
    a2 = 17 
	sum1 = 5
	sum2 = 4	
end	

if (ind == 4) then
	a1 = 11 
    a2 = 4 
	sum1 = 8
	sum2 = 0	
end	

if (ind == 5) then
	a1 = 10 
    a2 = 6 
	sum1 = 7
	sum2 = 6		
end	

if (ind == 6) then
	a1 = 8 
    a2 = 5 
	sum1 = 11
	sum2 = 0	
end

if (ind == 7) then
	a1 = 10 
    a2 = 3 
	sum1 = 9
	sum2 = 10	
end

if (ind == 8) then
	a1 = 13 
    a2 = 4 
	sum1 = 13
	sum2 = 0
end 

if (ind == 9) then
	a1 = 5 
    a2 = 14 
	sum1 = 15
	sum2 = 0
end 

if (ind == 10) then
	a1 = 10 
    a2 = 15 
	sum1 = 14
	sum2 = 0
end 

first = name_a[a1] 
second = name_a[a2] 
nr = 0
for i = 1,dim do
	if (i ~= sum1 and i ~= sum2) then	
        nr = nr + 1		
		q[nr] = i			    
	end	
end
q1 = lib.math.random_shuffle(q)
if (sum2 == 0) then
	max_range = stampa - 1
else
	max_range = stampa - 2	
end	
for i = 1, max_range do
	q2[i] = q1[i]
end	
q2[stampa] = sum1
if (sum2 ~= 0) then	
	q2[stampa-1] = sum2
end	
out = lib.math.random_shuffle(q2)	


 mycanvas = function()
	
  results = ""

  for i = 1, stampa do
      if i > 1 then
         results = results .. " && "
      end
      results = results .. "result[" .. tostring(i-1) .. "] == "
      if (sum2 ~= 0) then
          if (name_s[out[i]] == name_s[sum1] or name_s[out[i]] == name_s[sum2] ) then
              results = results .. "1"
          else
              results = results .. "0"
          end
      else
          if (name_s[out[i]] == name_s[sum1]) then
              results = results .. "1"
          else
              results = results .. "0"
          end    		
      end
  end

 
  lib.start_canvas(320, 320, "center", results)  
  
    w = 20
    ow = 10
    v = 5

    if (ind == 1) then
       lib.add_line(10*w+ow, 4*w+ow, w, 3*w, line_style, true, false) 
       lib.add_line(2*w+ow, 4*w+ow, 5*w, -2*w, line_style, true, false) 	
    end
	
    if (ind == 2) then
       lib.add_line(2*w+ow, 4*w+ow, w, 3*w, line_style, true, false) 
       lib.add_line(6*w+ow, 9*w+ow, 5*w, -2*w, line_style, true, false) 	
    end	
	
    if (ind == 3) then
       lib.add_line(10*w+ow, 4*w+ow, w, 3*w, line_style, true, false) 
       lib.add_line(6*w+ow, 9*w+ow, 5*w, -2*w, line_style, true, false) 	
    end	
		
    if (ind == 4) then
       lib.add_line(3*w+ow, 7*w+ow, 5*w, -2*w, line_style, true, false) 
       lib.add_line(7*w+ow, 2*w+ow, 3*w, 2*w, line_style, true, false) 
    end	
	
    if (ind == 5 ) then
       lib.add_line(2*w+ow, 4*w+ow, 5*w, -2*w, line_style, true, false) 
       lib.add_line(8*w+ow, 5*w+ow, 3*w, 2*w, line_style, true, false) 
    end	
	
    if (ind == 6) then
       lib.add_line(7*w+ow, 2*w+ow, w, 3*w, line_style, true, false) 	
       lib.add_line(3*w+ow, 7*w+ow, 3*w, 2*w, line_style, true, false) 
    end
		
    if (ind == 7) then
       lib.add_line(2*w+ow, 4*w+ow, w, 3*w, line_style, true, false) 
       lib.add_line(8*w+ow, 5*w+ow, 3*w, 2*w, line_style, true, false)
    end
	
    if (ind == 8) then
       lib.add_line(3*w+ow, 7*w+ow, 5*w, -2*w, line_style, true, false) 
       lib.add_line(2*w+ow, 4*w+ow, 4*w, 5*w, line_style, true, false)   
    end 

    if (ind == 9) then
       lib.add_line(7*w+ow, 2*w+ow, w, 3*w, line_style, true, false) 
       lib.add_line(2*w+ow, 4*w+ow, 8*w, 0, line_style, true, false)  
    end 
	
    if (ind == 10) then
       lib.add_line(7*w+ow, 2*w+ow, -4*w, 5*w, line_style, true, false) 
       lib.add_line(8*w+ow, 5*w+ow, 3*w, 2*w, line_style, true, false)  
    end 	
	
    st_i = 5 * w
    st_j = w + ow  
    nr = 0
    for j = 1,3 do  
  	    y = 11*w+j*st_j
        for  i = 1,3 do
	         nr = nr + 1
	         x = w+ow+(i-1)*st_i
             lib.add_circle (x, y, v, colour_style, false, true)
             lib.add_input(x+v, y-ow, 50, 30, name_s[out[nr]])
	     end
    end
		   
   for i = 1,11 do
        lib.add_line(w+ow, ow+(i-1)*w, 12*w, 0, grid_style, false, false)
    end
    for i = 1,13 do
        lib.add_line(ow+i*w, ow, 0, 10*w, grid_style, false, false)
    end

    lib.add_text(2*w+ow, 4*w, ".", dot_style, false, false)
    lib.add_text(2*w+ow, 4*w, "O", text_style, false, false)  
    lib.add_text(11*w+ow, 7*w, ".", dot_style, false, false)
    lib.add_text(11*w+ow, 7*w, "M", text_style, false, false)
    lib.add_text(6*w+ow, 9*w, ".", dot_style, false, false)
    lib.add_text(6*w+ow, 9*w, "T", text_style, false, false)
    lib.add_text(10*w+ow, 4*w, ".", dot_style, false, false)
    lib.add_text(10*w+ow, 4*w, "E", text_style, false, false)	
    lib.add_text(3*w+ow, 7*w, ".", dot_style, false, false)
    lib.add_text(3*w+ow, 7*w, "A", text_style, false, false)
    lib.add_text(8*w+ow, 5*w, ".", dot_style, false, false)
    lib.add_text(8*w+ow, 5*w, "J", text_style, false, false)
    lib.add_text(7*w+ow, 2*w, ".", dot_style, false, false)
    lib.add_text(7*w+ow, 2*w, "B", text_style, false, false)	

  lib.end_canvas()
end        
   