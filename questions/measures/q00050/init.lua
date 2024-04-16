
include("names")
include("terms")

rf = math.random(#zensko_ime_dativ);
rm = math.random(#musko_ime_dativ)

ime_f = zensko_ime_dativ[rf];
ime_m = musko_ime_dativ[rm] 

ind = math.random(12)
birth_m = months[ind]

number = math.random(11)
temp = (ind + number)%12

if (temp == 0) then
    birth_f = months[12]
else	
    birth_f = months[temp]
end

if (number < 5) then
    index = padez[1]
else
	index = padez[2]
end	
          
