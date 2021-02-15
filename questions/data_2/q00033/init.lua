
include("terms")

style =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.1"};

dif_style =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};
		
bar_style = 
    {["off_color"] = "e6e6ff",
        ["on_color"] = "e6e6ff",
        ["line_color"] = "000",
        ["line_width"] = "2"};		
		
marker_style = 
	{["off_color"] = "fff",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "1"};
		
		
text_style = {["font_size"] = "16"}

numb = {}
mark = {}
out = {}
qq = {}

for i = 1,5 do
    mark[i] = i
end

total = 25 + math.random(15)
max = math.floor(total/5)
sum = 0
for i = 1,2 do
    numb[i] = i + math.random(max+i)
	if (i == 1) then
	    numb[i] = math.random(3) - 1
	end	
    numb[6-i] = i + math.random(max+i)		
	sum = sum + numb[i] + numb[6-i]
end

if (sum + 3 > total) then
    total = sum + 2 + math.random(5)
end
numb[3]	= total - sum 

out = lib.math.argsort(numb)
minlev = 0
maxlev = numb[out[5]]
level = maxlev - minlev

cor = 0
if (level - 2*math.floor(level/2) ~= 0) then
    level = level + 1
    cor = 1
end	

for i = 1,level do
      qq[i] = minlev + i
end

ind = 1 + math.random(4)
med = math.floor(level/2)

mycanvas = function()  

  results = ""
  
  for i = 1,5 do 
      index = i - 1
      if (index > 0) then
          results = results .. "&& "
      end
      results = results .. "result[" .. tostring(index) .. "] == "	  
      if (i == ind) then	  
          results = results .. "1 "		  
	  else
          results = results .. "0 " 
      end 
  end		  
      
  lib.start_canvas(350, 300, "center", results)
 
  v = 35
  ov = 80
  w = 120
  ow = 20

--[[ tabela ]]--
  lib.add_line(ow, ow, 0, 2*v, dif_style, false, false)
  for i = 1,6 do 
     lib.add_line(w+ow+(i-1)*v, ow, 0, 2*v, dif_style, false, false)
  end
	 
  for j = 1,3 do
    lib.add_line(ow, ow+(j-1)*v, w+5*v, 0, dif_style, false, false)
  end

  lib.add_text(ov, v, msg[1], text_style, false, false)
  lib.add_text(ov, 2*v, msg[2], text_style, false, false)
  
  for i = 1,5 do
      lib.add_text(w+i*v, v, mark[6-i], text_style, false, false)  
      lib.add_text(w+i*v, 2*v, numb[6-i], text_style, false, false)   
  end

--[[ grafikom ]]--

 oww = math.floor(120/level) + 1 
  vv = 15

  for i = 2,level,2 do
      j = level+1-i
      temp = qq[i] % 4 
      if (temp == 0) then
        term = tostring(qq[i])
	    lib.add_text(ow, w+j*oww, term, text_style, false, false)
      lib.add_line(2*ow, w+j*oww, 13*ow+vv, 0, dif_style, false, false)
      else
      lib.add_line(2*ow, w+j*oww, 13*ow+vv, 0, style, false, false)
    end
  end

  lib.add_line(2*ow, w+oww, 13*ow+vv, 0, dif_style, false, false)
  lib.add_line(2*ow, w+(level+1)*oww, 13*ow+vv, 0, bar_style, false, false)
  lib.add_text(ow, w+(level+1)*oww, tostring(minlev), text_style, false, false)
  lib.add_line(2*ow, w+oww, 0, level*oww, dif_style, false, false)
  lib.add_line(15*ow+vv, w+oww, 0, level*oww, dif_style, false, false)

  for i = 1,5 do
      if (i == ind) then
  		  if (numb[i] > med) then
		      err = numb[i] - math.random(3)
		  else
		      err = numb[i] + math.random(3)	
          end	
	  else
          err = numb[i]	  
      end  
      lib.add_rectangle (3*ow+(i-1)*(2*vv+ow), w+oww*(maxlev+1+cor-err), 2*vv, (err-minlev)*oww, bar_style, true, false)  
      lib.add_circle(4*ow+(i-1)*(2*vv+ow)-5, w+(level+3)*oww, 10, marker_style, false, true)
      lib.add_text(4*ow+(i-1)*(2*vv+ow)-5, w+(level+3)*oww, mark[i], text_style, false, false)  	  
  end
  
  lib.end_canvas()
end                     
      
  
    
            
            
            
           
   
   
        
    
   
        
       
             
       