
yelow_style = {["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};
		
red_style = {["off_color"] = "f30",
        ["on_color"] = "f30",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};		

ime = {"crvenih", "crvena" }

edge = 2 + math.random(7)
circ = 4 * edge

number = 1 + math.random(4)
base = number * number
padez = ime[1]

temp = math.floor(base/10)
rest = base - temp*10

if(rest == 4) then 
   padez = ime[2]
end   

edge_med = number * edge
circ_med = 4 * edge_med

edge_big = (number + 1) * edge
circ_big = 4 * edge_big

add = 2 * number + 1
out = {number, 2*number, add, 2*number-1, 1}
answ = lib.math.random_shuffle(out)

for i = 1,5 do
    if(answ[i] == add) then 
	   ind = i - 1
	end
end	

			
ow = 10
v = math.floor(20/(number+1)) * 10
w = (1 + number) * v

mycanvas = function( )
  lib.start_canvas(300, 180, "center")
 
  for i = 1,number do
      for j = 1,number do
          lib.add_rectangle (ow+(i-1)*v, ow+(j-1)*v, v, v, yelow_style, true, false)		  
	  end	  
  end
  
lib.add_rectangle (w, 2*ow, v, v, red_style, true, false) 
  
  lib.end_canvas()
end
    