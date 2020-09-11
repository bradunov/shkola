
include("names")

dimnames = 6
index = {}
for i=1,dimnames do
    index[i] = i
end
	
r = lib.math.random_shuffle(index)

ime1 = zensko_ime_nom[r[1]]
ime2 = zensko_ime_nom[r[2]] 

town = {"Sidnej", "Tokio", "Peking", "Toronto", "Sijetl"}
padez = {"Sidneju", "Tokiju", "Pekingu", "Torontu", "Sijetlu"}
diff = {8, 7, 6, -6, -9}

ind = math.random(5)
t_town = 12 + diff[ind]

amint = {7, 8}
pmint = {15, 23}

bl = {}
br = {}
tl = {}
tr = {}

numb = 0

a = amint[1]
b = amint[2]
c = a + diff[ind]
d = b + diff[ind]

if(c < 0) then
   c = c + 24
   d = d + 24
end

if (c >= pmint[1] and d <= pmint[2]) then
     numb = numb + 1
	 bl[numb] = a
	 br[numb] = b
     tl[numb] = c
	 tr[numb] = d
end	 
      
c = amint[1]
d = amint[2]
a = c - diff[ind]
b = d - diff[ind]
if (a >= pmint[1] and b <= pmint[2]) then
     numb = numb + 1
	 bl[numb] = a
	 br[numb] = b
     tl[numb] = c
	 tr[numb] = d
end	

a = pmint[1]
b = pmint[2]
c = a + diff[ind]
d = b + diff[ind]

if(c < 0) then
   c = c + 24
   d = d + 24
end

if (c >= pmint[1] and c < pmint[2]) then
    numb = numb + 1
	bl[numb] = a
    tl[numb] = c
	if (d > pmint[2]) then
	   tr[numb] = pmint[2]	 
	   br[numb] = tr[numb] - diff[ind] 
	end   
end	 
if (d > pmint[1] and d <= pmint[2]) then
    numb = numb + 1
	br[numb] = b
	tr[numb] = d	 	
	if (c < pmint[1]) then
	     tl[numb] = pmint[1]	 
	     bl[numb] = tl[numb] - diff[ind]
    end   
end	

reply = {}
 
if (ind == 5) then
    reply[1] = "answer == '" .. tostring(bl[1]) .. "' "  ..
        "|| answer == '" .. tostring( bl[2]) .. "'" ;
    reply[2] = "answer == '" .. tostring(br[1]) .. "' "  ..
        "|| answer == '" .. tostring( br[2]) .. "'" ;
    reply[3] = "answer == '" .. tostring(tl[1]) .. "' "  ..
        "|| answer == '" .. tostring( tl[2]) .. "'" ;
    reply[4] = "answer == '" .. tostring(tr[1]) .. "' "  ..
        "|| answer == '" .. tostring( tr[2]) .. "'" ;		
else
    reply[1] = tostring(bl[1]) 
	reply[2] = tostring(br[1]) 
    reply[3] = tostring(tl[1]) 
	reply[4] = tostring(tr[1]) 
end		          
      