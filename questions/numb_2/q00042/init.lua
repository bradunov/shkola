
bracketl = "{"
bracketr = "}"

und = "\(\subset\)"  
empt = "\(\emptyset\)"
op1 = "\(\leq\)" 
op2 = "\(\geq\)"
op3 = "\(\gt\)"
op4 = "\(\lt\)"
n0 = "\(N_0\)"  
nn = "\(N\)"
elem = "\(\in\)"  

prime = {2, 3, 5, 7, 11, 13, 17, 19}

stampa = 8

dim = {}
reply = {""}
solut = {}
choice = {}

descr_w = {"banana", "sveska", "visibaba", "ananas", "internet"} 

--[[ tekst]]--
dim[1] = 3
dim[2] = 5
dim[3] = 5
dim[4] = 3
dim[5] = 5

--[[prazan skup ]]--
dim[6] = 0     
 
number = {}
nr = {}

number[1] = {0}
nr[1] = 1
dim[7] = 1

number[2] = {}
cif = math.random(9)
nr[2] = 4 + math.random(5)
for i = 1,nr[2] do
    number[2][i] = cif
end	
dim[8] = 1

number[3] = {}
nr[3] = 3 + math.random(4)
cif = math.random(9)
mmax = {}
for i = 1, nr[3] do
    number[3][i] = 0
    mmax[i] = math.random(4)
    for j = 1, mmax[i] do 
	    number[3][i] = number[3][i]*10 + cif
	end
end
qq = lib.math.argsort(mmax)
dim[9]  = 1
for i = 2, nr[3] do
    if (mmax[qq[i]] ~= mmax[qq[i-1]]) then
	    dim[9] = dim[9] + 1
    end
end	
	
number[4] = {}
cifra = {}
value = 0
for i = 1,9 do
    cifra[i] = 2*math.random(4) - 1
    value = value*10 + cifra[i]
end	
cc = lib.math.argsort(cifra)
number[4][1] = cifra[cc[1]]
br = 1
for i = 2,9 do
    if (cifra[cc[i]] ~= cifra[cc[i-1]]) then
	    br = br + 1
		number[4][br] = cifra[cc[i]]
	end
end	
if (br < 3) then 
    jmax = 3 - br
    for j = 1, jmax do
	    br = br + 1
		number[4][br] = 2*j
		value = value * 10 + number[4][br]
	end
end	
dim[10] = br	

total = 16

q = {}
for i = 1,total do
    q[i] = i
end
choice = lib.math.random_shuffle(q)	


for i = 1,stampa do
    ind = choice[i]
    solut[i] = bracketl
    if (ind < 6) then
	    solut[i] = solut[i] .. " a | " .. "a je slovo reči " .. descr_w[ind] .. " " .. bracketr 
		reply[i] = tostring(dim[ind])
	end
	if (ind == 6) then
	    solut[i] = empt
	    reply[i] = tostring(dim[ind])
	end			
    if (ind > 6 and ind < 10) then	
        for j = 1, nr[ind-6] do
            temp = number[ind-6][j] 
		    if (j == nr[ind-6]) then
    	        solut[i] = solut[i] .. " " .. temp .. " " .. bracketr	
		    else
    	        solut[i] = solut[i] .. " " .. temp .. ","	
		    end	
		end	
	    reply[i] = tostring(dim[ind])
    end	
	if (ind == 10) then
	    solut[i] = solut[i] .. " x | " .. "x je cifra broja " .. tostring(value) .. " " .. bracketr 
	    reply[i] = tostring(dim[ind])		
	end	
    if (ind == 11) then
	    numb = 7 + math.random(7)
	    solut[i] = solut[i] .. " x | " .. "x" .. elem .. n0 .. ", x" .. op1 .. numb .. " " .. bracketr 
		dim[ind] = numb + 1
		reply[i] = tostring(dim[ind])
	end	 
    if (ind == 12) then
	    numb = 7 + math.random(7)
	    solut[i] = solut[i] .. " x | " .. "x" .. elem .. nn .. ", " .. " x" .. " " .. op2 .. " " .. numb .. " " .. bracketr 
		reply[i] = "b"
	end	 	
    if (ind == 13) then
	    numb = 6 + math.random(13)
	    solut[i] = solut[i] .. " x | " .. "x je prost broj, " .. " x" .. " " .. op4 .. " " .. numb .. " " .. bracketr 
		sum = 0
		for j = 1,8 do
		    if (prime[j] < numb) then
			    sum = sum + 1
			end	
        end			
		reply[i] = tostring(sum)
	end	 
    if (ind == 14) then
	    numb = 7 + math.random(7)		
	    solut[i] = solut[i] .. " x | " .. "x" .. elem .. n0 .. ", x je paran broj, x" .. op4 .. numb .. " " .. bracketr 
		temp = math.floor((numb+1)/2)
		dim[ind] = temp
		reply[i] = tostring(dim[ind])
	end	 	
    if (ind == 15) then		
	    solut[i] = solut[i] .. " x | " .. "x je arapska cifra " .. bracketr 
		dim[ind] = 10
		reply[i] = tostring(dim[ind])
	end	 	
    if (ind == 16) then	
	    numb = 7 + math.random(7)	
	    solut[i] = solut[i] .. " x | " .. "x" .. elem .. nn .. ", x sadrži " .. numb .. " " .. bracketr 
		reply[i] = "b"
	end	 		
end                         
                 
            
             
          



 


          
          
    
    
                  
                
                