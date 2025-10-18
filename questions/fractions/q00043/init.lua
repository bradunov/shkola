
include("names")

r1 = math.random(#musko_ime_nom)
r2 = math.random(#musko_ime_nom-1)
if (r2 >= r1) then r2 = r2 + 1 end
ime1 = musko_ime_nom[r1]
ime2 = musko_ime_nom[r2] 

style =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};
		
text_style = {["font_size"] = "14"}

meas = {"cm", "m"}
first = {}
second = {}
choice = {}
nr = {}

space = "\( \ \ \ \ \) "

dim = 9
stampa = 5
for i = 1,dim do
	first[i] = 1.05 + 0.05 * i;
	second[i] = 1.15 + 0.05 * i;
	first[i] = lib.math.round_dec(first[i], 2)
	second[i] = lib.math.round_dec(second[i], 2)
end
first = lib.math.random_shuffle(first)
second = lib.math.random_shuffle(second)

for i = 1,2 do
	choice[i] = math.random(stampa)
end	
total = first[choice[1]] + second[choice[2]]
sum = 0
for i = 1,stampa do
	nr[i] = {}
    for j = 1,stampa do
		nr[i][j] = 0
		sum = first[i] + second[j]		
		if (sum == total) then
			nr[i][j] = 1
		end		
	end
end
total = 100 * (first[choice[1]] + second[choice[2]])
total = lib.math.round(total)

ans1 = ""
ans2 = ""
for i = 1,stampa do
	for j = 1,stampa do
		if (nr[i][j] == 1) then
			ans1 = ans1 .. space .. lib.check_number(first[i]) .. meas[2]
			ans2 = ans2 .. space .. lib.check_number(second[j]) .. meas[2]
		end
	end
end	

mycanvas = function()

  lib.start_canvas(350, 90, "center")
 
  v = 30
  ov = 80
  w = 120
  ow = 10
 
  lib.add_line(ow, ow, 0, 2*v, style, false, false)
  for i = 1,dim+1 do 
     lib.add_line(w+(i-1)*(v+ow), ow, 0, 2*v, style, false, false)
  end
	 
  for j = 1,3 do
    lib.add_line(ow, ow+(j-1)*v, 2*(w+v)+ow, 0, style, false, false)
  end

  lib.add_text(2*v, v-5, ime1,  text_style, false, false)
  lib.add_text(2*v, v+2*ow, ime2, text_style, false, false)
--[[
  lib.add_input(ow, v-ow-5, 50, 120, ime1)
  lib.add_input(ow, v+ow+5, 50, 120, ime2)
]]--  
  for i = 1,stampa do
      lib.add_text(w+ow+(i-1)*(v+ow)+5, v-5, first[i], text_style, false, false)   
      lib.add_text(w+ow+(i-1)*(v+ow)+5, 2*v-5, second[i], text_style, false, false)   
  end

  lib.end_canvas()
end     