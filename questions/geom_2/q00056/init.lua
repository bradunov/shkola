 
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
								

meas = {"\(^\circ\)", "'"}
numb = {"\(\small\alpha\)", "\(\small\beta\)", "\(\small\gamma\)", "\(\small\alpha_1\)", "\(\small\beta_1\)", "\(\small\gamma_1\)" }

name = {"BC", "AB", "AC"}
answ = {"=", ">", "<"}

ang_g = {}
ang_m = {}
ang = {}
sign = {""} 
result = ""
reply = ""

ind = math.random(3)
ang_g[2] = 50 +(2 - ind) * math.random(30)
ang_m[2] = math.random(51) - 1
ang[2] = ang_g[2] * 60 + ang_m[2]	
ang_g[1] = 178 - 2 * ang_g[2] 
ang_m[1] = 120 - 2 * ang_m[2]
temp =  math.floor(ang_m[1]/60) 
ang_g[1] = ang_g[1] + temp    
ang_m[1] = ang_m[1] - 60 * temp
ang[1] = ang_g[1] * 60 + ang_m[1]
ang_g[3] = ang_g[2] 
ang_m[3] = ang_m[2] 
ang[3] = ang[2] 
ang_g[4] = 2 * ang_g[2] 
ang_m[4] = 2 * ang_m[2] 
temp =  math.floor(ang_m[4]/60) 
ang_g[4] = ang_g[4] + temp    
ang_m[4] = ang_m[4] - 60 * temp
ang[4] = 2 * ang[2] 
ang_g[5] = 179 - ang_g[2] 
ang_m[5] = 60 - ang_m[2] 
temp =  math.floor(ang_m[5]/60) 
ang_g[5] = ang_g[5] + temp    
ang_m[5] = ang_m[5] - 60 * temp
ang[5] = ang_g[5] * 60 + ang_m[5] 
ang_g[6] = ang_g[5] 
ang_m[6] = ang_m[5] 
ang[6] = ang[5] 

ch = math.random(6)
quest = ang_g[ch] .. meas[1]
if (ang_m[ch] ~= 0) then
    quest = quest .. " " .. ang_m[ch] .. meas[2] 
end	

if (ang[1] > 5400) then
    result =  "answer == '" .. msg1[3] .. "' "  ..
        "|| answer == '" .. msg2[3] .. "'" ;
    ans = "answer = '" .. msg1[3] .. "' ";
else
    if (ang[1] < 5400) then
        result =  "answer == '" .. msg1[1] .. "' "  ..
           "|| answer == '" .. msg2[1] .. "'" ;
        ans = "answer = '" .. msg1[1] .. "' ";
    else	   
        result =  "answer == '" .. msg1[2] .. "' "  ..
           "|| answer == '" .. msg2[2] .. "'" ;
        ans = "answer = '" .. msg1[2] .. "' ";
	end
end	

if (ang[1] > ang[2]) then
	sign[1] = answ[1]
	sign[2] = answ[3]
    reply = lib.check_string_case(name[2],30) .. " " .. " " .. lib.check_one_option_dropdown(answ, sign[1]) .. " " .. " " .. lib.check_string_case(name[3],30) .. " " .. lib.check_one_option_dropdown(answ, sign[2]) .. " " .. lib.check_string_case(name[1],30)  	
else 
    if (ang[1] < ang[2]) then
	    sign[1] = answ[3]
	    sign[2] = answ[1]
        reply = lib.check_string_case(name[1],30) .. " " .. " " .. lib.check_one_option_dropdown(answ, sign[1]) .. " " .. " " .. lib.check_string_case(name[2],30) .. " " .. lib.check_one_option_dropdown(answ, sign[2]) .. " " .. lib.check_string_case(name[3],30)  	
    else 
	    sign[1] = answ[1]
	    sign[2] = answ[1]
        reply = lib.check_string_case(name[1],30) .. " " .. " " .. lib.check_one_option_dropdown(answ, sign[1]) .. " " .. " " .. lib.check_string_case(name[2],30) .. " " .. lib.check_one_option_dropdown(answ, sign[2]) .. " " .. lib.check_string_case(name[3],30)  	
    end			
end     
                         
mycanvas = function(no)

  ow = 5
  w = 125
  ov = 75
  v = 20

  lib.start_canvas(250, 100, "center") 
          
           
    lib.add_straight_path(v, ov, {{w+v+5*ow, 0}, {-ov, -3*v}, {-ov, 3*v} }, style, true, false) 
    lib.add_line(w+ov-2*ow, ov, v, 0, style, false, false)
    lib.add_line(w-2*ow, v-ow, v, -v+4, style, false, false)  

    lib.add_input(ov+ow, 0, 50, 20, "A")
    lib.add_input(v, ov, 50, 20, "B") 
    lib.add_input(w+2*v, ov, 50, 20, "C") 

    lib.add_input(ov+3*ow, 3*ow, 50, 30, numb[1])
    lib.add_input(w-3*ow, ow, 50, 30, numb[4])	
    lib.add_input(2*v, ov-v, 50, 30, numb[2]) 
    lib.add_input(ow, ov-v, 50, 30, numb[5])
    lib.add_input(w+v-ow, ov-v, 50, 30, numb[3]) 	
    lib.add_input(w+2*(v+ow), ov-v, 50, 30, numb[6])	
    
  lib.end_canvas()
end       
            