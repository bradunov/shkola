
include("terms")

meas = "\(^\circ\)"
trian = "\(\small\triangle\)"
symb = {"α", "β", "γ", "δ"}
sp = "\(\ \)"

index = {2, 3, 4, 5, 6, 9, 12}
numb = {}
ang = {}

numb[1] = math.random(4)
numb[2] = math.random(5)
sum = numb[1] + numb[2]
numb[3] = 1
for i = 1,6 do	
    if (sum >= index[i] and sum < index[i+1]) then
            tmp = i + math.random(7 - i)
	    numb[3] = index[tmp] - sum
	end	
end	
sum = sum + numb[3]

q = lib.math.gcd(numb[1], numb[2])
qq = lib.math.gcd(q, numb[3])
if (qq ~= 1) then
    sum = 0
	for i = 1,3 do
        numb[i] = math.floor(numb[i]/qq)
		sum = sum + numb[i]
	end
end	

val = math.floor(180/sum)

sign_a = 1
for i = 1,3 do
    ang[i] = numb[i] * val
    if (ang[i] == 90) then
	sign_a = 2
    end	
    if (ang[i] > 90) then
	sign_a = 3
   end		
end
name_a = msg_a[sign_a]
	
sign_e = 1
if (ang[1] == ang[2] or ang[2] == ang[3] or ang[3] == ang[1] ) then
    sign_e = 2
end	
if (ang[1] == ang[2] and ang[2] == ang[3]) then
    sign_e = 3
end	
name_e = msg_e[sign_e]
            
quest = ""
for i = 1,3 do
    if (numb[i] == 1) then
	    text = ""
	else
        text = tostring( math.floor(numb[i]))
    end	
    quest = quest .. sp .. sp .. sp .. symb[i] .. " = " .. text .. symb[4] .. ", "
end	
