
edge = {}
out = {}
sign = {""} 
reply = ""

min_range = 10
max_range = 20

edge[1] = min_range + math.random(max_range - min_range)
edge[2] = min_range +5 + math.random(max_range - min_range)
tmp3 = edge[1] + edge[2]	
edge[3] = min_range - 5 + math.random(tmp3 - 6 - min_range)
tmp1 = edge[2] + edge[3] 
if (tmp1 <= edge[1]) then
    edge[3] = edge[3] + edge[1] - tmp1 +1
end
tmp2 = edge[1] + edge[3]
if (tmp2 <= edge[2]) then
    edge[3] = edge[3] + edge[2] - tmp2 +1
end


out = lib.math.argsort(edge)

if (tmp3 <= edge[3]) then
    reply = msg
else
    if (edge[out[1]] == edge[out[2]]) then
	    sign[1] = answ[1]
	else 
	    sign[1] = answ[2]
    end	
    if (edge[out[2]] == edge[out[3]]) then
	    sign[2] = answ[1]
	else 
	    sign[2] = answ[2]
    end			
    reply = symb .. lib.check_string_case(ang[out[1]],30) .. " " .. " " .. lib.check_one_option_dropdown(answ, sign[1]) .. " " .. " " .. symb .. lib.check_string_case(ang[out[2]],30) .. " " .. lib.check_one_option_dropdown(answ, sign[2]) .. " " .. symb .. lib.check_string_case(ang[out[3]],30) 
end                    
              