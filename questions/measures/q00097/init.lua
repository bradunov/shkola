
style = {["off_color"] = "fff",
         ["on_color"] = "fff",
         ["line_color"] = "000",
         ["line_width"] = "1"};
		 
text_style = {["font_size"] = "16"}

text2_style = {["line_color"] = "f30",
              ["line_width"] = "1", 
              ["font_size"] = "16"}

include("names")

rm = math.random(#musko_ime_dativ); 
ime = musko_ime_dativ[rm];

day1 = {"ponedeljak", "utorak", "sredu", "četvrtak", "petak", "subotu", "nedelju"}
day2 = {"ponedeljak", "utorak", "sredu", "cetvrtak", "petak", "subotu", "nedelju"}
choice1 = {"prvog", "drugog", "trećeg", "četvrtog"}
choice2 = {"prve", "druge", "treće", "četvrte"}

month_n = {"JANUAR", "FEBRUAR", "MART", "APRIL", "MAJ", "JUN", "JUL", "AVGUST", "SEPTEMBAR", "OKTOBAR", "NOVEMBAR", "DECEMBAR"}
month_d = {"januaru", "februaru", "martu", "aprilu", "maju", "junu", "julu", "avgustu", "septembru", "oktobru", "novembru", "decembru"}
month_g = {"januara", "februara", "marta", "aprila", "maja", "juna", "jula", "avgusta", "septembra", "oktobra", "novembra", "decembra"}
nmb_month = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
numb_position = {3, 6, 7, 3, 5, 1, 3, 6, 2, 4, 7, 2}

ind_m = math.random(12)
ind_d = math.random(7)

reply = "answer == '" .. day1[ind_d] .. "' "  ..
        "|| answer == '" .. day2[ind_d] .. "'" ;
ans = "answer = '" .. day1[ind_d] .. "' ";

  
  ind_or = math.random(4)
  if (ind_d == 3 or ind_d > 5) then
      birth = choice2[ind_or]
  else	
      birth = choice1[ind_or]  
  end	

  finish_m = month_g[ind_m]
  
  temp = ind_d - numb_position[ind_m]
  if (temp >= 0) then  
      finish_d = temp + ind_or * 7 - 6
  else
      finish_d = temp + ind_or * 7 + 1 
  end	  
 
mycanvas = function()
  
  imax = math.ceil((nmb_month[ind_m] - 8 + numb_position[ind_m])/7) + 2

  lib.start_canvas(350, 280, "center")

  w = 20
  ow = 30
  ov = 40

  for i = 1,6 do
    lib.add_line(ow+i*ov, ow+w-5, 0, imax*ow, style, false, false)
  end
  lib.add_line(ow, w-5, 0, (imax+1)*ow, style, false, false)
  lib.add_line(ow+7*ov, w-5, 0, (imax+1)*ow, style, false, false)
	  
  
  for i = 1,imax + 2 do
    lib.add_line(ow, w+(i-1)*ow-5, 7*ov, 0, style, false, false)
  end

  lib.add_text(4*ov, ow, month_n[ind_m], text2_style, true, false)
  lib.add_text(7*ov, ow, "2020", text2_style, true, false)  
  lib.add_text(ow+w, 2*ow, "P", text2_style, true, false)  
  lib.add_text(3*ow, 2*ow, "U", text2_style, true, false)  
  lib.add_text(4*ow+w/2, 2*ow, "S", text2_style, true, false) 
  lib.add_text(5*ow+w, 2*ow, "Č", text2_style, true, false)
  lib.add_text(7*ow, 2*ow, "P", text2_style, true, false)  
  lib.add_text(8*ow+w/2, 2*ow, "S", text2_style, true, false) 
  lib.add_text(9*ow+w, 2*ow, "N", text2_style, true, false)

  for i =  numb_position[ind_m], 7 do
    temp = i+1-numb_position[ind_m] 
    lib.add_text(i*ov+5, 3*ow, i+1-numb_position[ind_m], text_style, false, false) 
  end	
   
  for j =  4, imax+2 do
      y = j*ow
      for i =  1, 7 do
	      if (temp < nmb_month[ind_m]) then 
	          temp = temp + 1
              lib.add_text(i*ov+5, y, temp, text_style, false, false) 
		  end	  
	  end	  
  end

  lib.end_canvas()
end      
  
          
                  
                      
         
                