
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};

bar_style = {["off_color"] = "e6e6ff",
        ["on_color"] = "e6e6ff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
text_style = {["font_size"] = "16"}	

include("names")

mycanvas = function()

  index = {}
  ime = {""}
  q = {}
  out = {} 
  choice = {}  
  ind = {}   
  
 dimnames = #musko_ime_nom

  for i=1,dimnames do
      index[i] = i
  end
	
  r = lib.math.random_shuffle(index)
  for i=1,dimnames do
      ime[i] = musko_ime_nom[r[i]]
  end 

  min = 20
  max = 40
  level = max - min

  for i = 1,level do
      q[i] = min + i
  end

  out = lib.math.random_shuffle(q)
 
  for i = 1,6 do
      choice[i] = out[i]
  end

  ind = lib.math.argsort(choice)  
  tall = ime[ind[6]]
  short = ime[ind[1]]


  reply1 = "answer == '" .. tall .. "' ";  
  ans1 = "answer = '" .. tall .. "' ";  
  reply2 = "answer == '" .. short .. "' ";  
  ans2 = "answer = '" .. short .. "' ";  


  lib.start_canvas(380, 250, "center", results)

  w = 20
  ow = 10
  v = 15
 

  for i = 1,level,2 do
    lib.add_line(3*ow, i*ow, 15*w, 0, style, false, false)
    temp = q[level+1-i] % 4 
    if (temp == 0) then
        numb = tostring(q[level+1-i])
	    lib.add_text(ow, i*ow, numb, text_style, false, false)
    end
  end

  lib.add_line(3*ow, ow, 15*w, 0, bar_style, false, false)
  lib.add_line(3*ow, (level+1)*ow, 15*w, 0, bar_style, false, false)
  lib.add_text(ow, (level+1)*ow, tostring(min), text_style, false, false)
  lib.add_line(3*ow, ow, 0, level*ow, bar_style, false, false)
  lib.add_line(3*ow+15*w, ow, 0, level*ow, bar_style, false, false)

  for i = 1,6 do
      lib.add_rectangle (2*w+(i-1)*(2*v+w), ow*(max+1-choice[i]), 2*v, (choice[i]-min)*ow, bar_style, false, true)  
      lib.add_text(3*w+(i-1)*(2*v+w), (level+3)*ow, ime[i], text_style, false, false) 
  end
  
  lib.end_canvas()
end
 