
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
max = math.floor(total/6)
sum = 0
for i = 1,2 do
    numb[i] = i + math.random(max+i)
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

ind = math.random(5)

mycanvas = function()  
     
  lib.start_canvas(350, 300, "center")
 
  v = 35
  ov = 80
  w = 120
  ow = 20
  vv = 15
  sft = w + ov 


--[[ grafikom ]]--

  oww = math.floor(120/level) + 1 

  for i = 2,level,2 do
      j = level+1-i
      temp = qq[i] % 4 
      if (temp == 0) then
          term = tostring(qq[i])
	      lib.add_text(ow, j*oww, term, text_style, false, false)
          lib.add_line(2*ow, j*oww, 13*ow+vv, 0, dif_style, false, false)
      else
          lib.add_line(2*ow, j*oww, 13*ow+vv, 0, style, false, false)
      end
  end

  lib.add_line(2*ow, oww, 13*ow+vv, 0, dif_style, false, false)
  lib.add_line(2*ow, (level+1)*oww, 13*ow+vv, 0, bar_style, false, false)
  lib.add_text(ow, (level+1)*oww, tostring(minlev), text_style, false, false)
  lib.add_line(2*ow, oww, 0, level*oww, dif_style, false, false)
  lib.add_line(15*ow+vv, oww, 0, level*oww, dif_style, false, false)

  for i = 1,5 do
      lib.add_rectangle (3*ow+(i-1)*(2*vv+ow), oww*(maxlev+1+cor-numb[i]), 2*vv, (numb[i]-minlev)*oww, bar_style, true, false)  
      lib.add_text(4*ow+(i-1)*(2*vv+ow)-5, (level+2)*oww+5, mark[i], text_style, false, false)  	  
  end

--[[ tabela ]]--
  lib.add_line(ow, sft+ow, 0, 2*v, dif_style, false, false)
  for i = 1,6 do 
     lib.add_line(w+ow+(i-1)*v, sft+ow, 0, 2*v, dif_style, false, false)
  end
	 
  for j = 1,3 do
    lib.add_line(ow, sft+ow+(j-1)*v, w+5*v, 0, dif_style, false, false)
  end

  lib.add_text(ov, sft+v, msg[1], text_style, false, false)
  lib.add_text(ov, sft+2*v, msg[2], text_style, false, false)
  
  for i = 1,5 do
      lib.add_text(w+i*v, sft+v, mark[i], text_style, false, false)  
      if (i == ind) then	  
          lib.add_text(w+i*v, sft+2*v, numb[i], text_style, false, false) 
      else
          lib.add_input(w+i*v-ow, sft+2*v-10, 50, 30, lib.check_number(numb[i], 15))	
      end		  
  end
  
  lib.end_canvas()
end    

  
      
  
    
            
            
            
           
   
   
        
    
   
        
       
             
       