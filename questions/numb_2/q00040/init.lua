
bracketl = "{"
bracketr = "}"
natur0 = "N₀"
dot = "\(\dots\)"

prime = {2,3,5,7}
q = {}
qq = {}
numb = {} 
q[1] = math.random(3)
q[2] = q[1] + math.random(6 - q[1]) 
q[3] = q[2] + math.random(9 - q[2])
for i = 1, 3 do
    qq[i] = q[1]
	qq[i+3] = q[2]
	qq[i+6] = q[3]	
end
numb = lib.math.random_shuffle(qq)
value = numb[1]
for i = 2,9 do
    value = value * 10 + numb[i]
end	

solut = {}

solut[1] = bracketl	
for i = 1,4 do
    solut[1] = solut[1] .. lib.check_number(i,15) .. ", "
end				
solut[1] = solut[1] .. " " .. dot .. " " .. bracketr

solut[2] = bracketl	
for i = 1,3 do
    solut[2] = solut[2] .. lib.check_number(prime[i],15) .. ", "
end				
solut[2] = solut[2] .. lib.check_number(prime[4],15) .. bracketr

solut[3] = bracketl	
for i = 1,2 do
    solut[3] = solut[3] .. lib.check_number(q[i],15) .. ", "
end				
solut[3] = solut[3] .. lib.check_number(q[3],15) .. bracketr
                   
solut[4] = bracketl	
for i = 1,4 do
    solut[4] = solut[4] .. lib.check_number(i-1,15) .. ", "
end				
solut[4] = solut[4] .. " " .. dot .. " " .. bracketr         
        
solut[5] = bracketl	
for i = 2,6,2 do
    solut[5] = solut[5] .. lib.check_number(i,15) .. ", "
end				
solut[5] = solut[5] .. " " .. dot .. " , " .. lib.check_number(96,20) .. ", " .. lib.check_number(98,20) .. bracketr       
            