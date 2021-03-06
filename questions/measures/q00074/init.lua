include("terms")

out = {}
term = {}

index = {1,7,30,1}

day = 21 + math.random(99)
week = 2 + math.random(16)
month = 1 + math.random(5)
year_ind = math.random(6)

term[1] = day
term[2] = week * 7
term[3] = month * 30
term[4] = math.floor(365/(year_ind+2))

out = lib.math.argsort(term)

sign = math.random(2)
length = comp[sign]

if (sign == 1) then
    ind = out[4] - 1
else 
    ind = out[1] - 1
end	

answ = {""}
              
answ[1] = tostring(math.floor(day)) .. msg_day

if (week > 4 ) then
    answ[2] = tostring(math.floor(week)) .. msg_week[1]
else
    answ[2] = tostring(math.floor(week)) .. msg_week[2]
end	

if (month > 4 ) then	               
    answ[3] = tostring(math.floor(month)) .. msg_month[1]  
else
    answ[3] = tostring(math.floor(month)) .. msg_month[2]
end	
                
answ[4] = year[year_ind] .. msg_year
                



