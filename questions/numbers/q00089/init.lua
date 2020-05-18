include("terms")
include("names")

dimnames = 6
index = {}
for i=1,dimnames do
    index[i] = i
end
	
r = lib.math.random_shuffle(index)

ime1 = zensko_ime_nom[r[1]]
ime2 = zensko_ime_nom[r[2]] 

sign = {"+","-"}
answ = {""}


add = math.random(15) + 5;
term = (add + math.random(29)) * 10;
add = add*10

ind = math.random(2)
if (ind == 1) then 
    result = term*2 + add
else 
    result = term*2 - add
end	 
    
            
answ[1] = tostring(math.floor(term)) .. " " .. sign[1] .. " " .. tostring(math.floor(add))

answ[2] = tostring(math.floor(term)) .. " " .. sign[1] .. " (" .. tostring(math.floor(term)) .. " " .. sign[1] .. " " .. tostring(math.floor(add)) .. ")"
	               
answ[3] = tostring(math.floor(term)) .. " " .. sign[1] .. " (" .. tostring(math.floor(term)) .. " " .. sign[2] .. " " .. tostring(math.floor(add)) .. ")"  
                
answ[4] = tostring(math.floor(term)) .. " " .. sign[2] .. " (" .. tostring(math.floor(term)) .. " " .. sign[2] .. " " .. tostring(math.floor(add)) .. ")"                   
                  
answ[5] = tostring(math.floor(term)) .. " " .. sign[2] .. " " .. tostring(math.floor(add))                  
                              
     
            
			  
			  
		  