
include("terms")

style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};											

red_style = 
	{["off_color"] = "f30",
        ["on_color"] = "f30",
        ["line_color"] = "f00",
        ["line_width"] = "1"};	
		
blue_style = 
	{["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "cff",
        ["line_width"] = "1"};		

green_style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "6f6",
        ["line_width"] = "1"};	

orange_style = 
	{["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "f90",
        ["line_width"] = "1"};	

pink_style = 
	{["off_color"] = "f9c",
        ["on_color"] = "f9c",
        ["line_color"] = "f9c",
        ["line_width"] = "1"};			

yelow_style = 
	{["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "ff0",
        ["line_width"] = "1"};	
		
text_style = {["font_size"] = "14"}	


triang = {"O", "A", "B", "J", "C", "D", "E", "F", "G", "H", "K", "L", "M", "N", "S", "P", "R", "T"}
x = {} 
y = {}
ind = {}
fig = {""}
fig_x = {}
fig_y = {}
fig_ind = {}
answ = {""}
sign = {""}
out = {""}
index = {}
reply = {""}

dim = 5
stampa = 6  
      
mycanvas = function(no)

  w = 30
  v = 35
  ow = 10
 
  start = math.random(2)
  for i = 1,stampa do
      xc = math.random(dim)
      y[i] = math.random(dim)
	  ind[i] = start         --[[ 1 = osnovica dole, 2 = osnovica gore ]]--
	  if (start == 1) then
	      start = 2
	  else
          start = 1
      end		
      temp = y[i] - 2*math.floor(y[i]/2) 
      if (ind[i] == 1) then	
          if (temp == 0) then
              x[i] = ow + v/2 + xc*v
          else
              x[i] = ow + xc*v
          end		
	  else
          if (temp == 0) then	
              x[i] = ow  + xc*v 
          else
              x[i] = ow + v/2 + xc*v
          end
      end
	  y[i] = y[i] * w
  end	  

  nr = 0
  for i = 1,stampa-1 do
    double = 0
      xx = x[i]
      yy = y[i]
      ndi = ind[i]
      for j = i+1,stampa do
	      if (x[j] == xx and y[j] == yy and ind[j] == ndi) then
		      double =  1
		  end
	  end
      if (double == 0) then	  
          nr = nr + 1	
          fig_x[nr] = xx
          fig_y[nr] = yy
          fig_ind[nr] = ndi
	  end 
  end
  nr = nr + 1	
  fig_x[nr] = x[stampa]
  fig_y[nr] = y[stampa]
  fig_ind[nr] = ind[stampa]

  for i = 1,nr do
      mark = (i-1)* 3 + math.random(3) 
      fig[i] = triang[mark]
  end	  
  
  br = 0
  for i = 1, nr-1 do 
      term =  fig[i] .. ", "    
      for j = i+1, nr do 
	      br = br + 1 	  
	      if (fig_ind[i] == fig_ind[j]) then
		      sign[br] = msg[1]
		  else
		      sign[br] = msg[2]  
          end		  
          answ[br] =  term .. fig[j]    
     end
  end	

  for i = 1,br do
      index[i] = i
  end	  
  out = lib.math.random_shuffle(index)
  for i = 1,6 do
      if (i <= br) then
          reply[i] = lib.check_string(sign[out[i]],15) .. " " .. answ[out[i]]
	  else
          reply[i] = ""
      end
  end	  
      

  lib.start_canvas(250, 180, "center") 

  for i = 1,nr do 
      if (i == 1) then
          st_style = orange_style
      end	
      if (i == 2) then
          st_style = green_style
      end
      if (i == 3) then
          st_style = yelow_style
      end
      if (i == 4) then
          st_style = pink_style
      end
      if (i == 5) then
          st_style = blue_style
      end
      if (i == 6) then
          st_style = red_style
      end		  
      if (fig_ind[i] == 1) then 
          lib.add_triangle (fig_x[i], fig_y[i], v, w, st_style, true, false)		  
      else		  
          lib.add_triangle (fig_x[i], fig_y[i], v, -w, st_style, true, false)
      end
	  lib.add_text(fig_x[i], fig_y[i], fig[i], text_style, false, false)
  end	  

  for j = 1,5 do         
      if (j-2*math.floor(j/2) == 0) then
          x1 = ow + v/2
          x2 = ow 
          imax = 5
      else
          x1 = ow 
          x2 = ow + v/2
          imax = 6
      end
      for i = 1,5 do
          lib.add_triangle (x1+i*v, j*w, v, w, style, false, false)
          lib.add_triangle (x2+i*v, j*w, v, -w, style, false, false)
      end
  end

  lib.end_canvas()
end                
   
     
      
            
         
      
      
       
      

         