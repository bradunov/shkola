
bracketl = "{"
bracketr = "}"

cifra = {};
solut1 = {}
solut2 = {}
solut3 = {}

cifra[1] = math.random(3) - 1;
cifra[2] = cifra[1] + math.random(5 - cifra[1]);
cifra[3] = cifra[2] + math.random(7 - cifra[2]);
cifra[4] = cifra[3] + math.random(9 - cifra[3]);

for i = 1,4 do
    solut1[i] = "P[" .. i .. "] = " .. bracketl .. lib.check_number(cifra[i],10) .. bracketr
end	

n2 = 0
for i = 1,3 do	
    for j = i+1,4 do
		n2 = n2 + 1
        solut2[n2] = "Q[" .. n2 .. "] = " .. bracketl .. lib.check_number(cifra[i],10) .. ", " .. lib.check_number(cifra[j],10) .. bracketr	
	end	
end	
	
n3 = 0
for i = 1,2 do	
    for j = i+1,3 do 	
        for k = j+1,4 do
		    n3 = n3 + 1		
            solut3[n3] = "R[" .. n3 .. "] = " .. bracketl .. lib.check_number(cifra[i],10) .. ", " .. lib.check_number(cifra[j],10) .. ", " .. lib.check_number(cifra[k],10) .. bracketr		
		end	
	end	
end

