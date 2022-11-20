
include("terms")

term = {" "}
term[1] = "2 - 3b" 
term[2] = "3xy" 
term[3] = "a\(^{\small 2}\)b + a + 4" 
term[4] = "2 - 3x\(^{\small 2}\)"      
term[5] = "x\(^{\small 2}\) + y\(^{\small 2}\)"  
term[6] = "a\(^{\small 2}\) + 2ab + b\(^{\small 2}\)"     
term[7] = "x\(^{\small 2}\) - ay\(^{\small 2}\)"             
term[8] = "a\(^{\small 3}\) - 3a\(^{\small 2}\)b\(^{\small 2}\) + b\(^{\small 3}\)" 
term[9] = "3x\(^{\small 2}\) - x + 9x\(^{\small 2}\)"  
term[10] = "x - 3xa\(^{\small 3}\)"      
term[11] = "a\(^{\small 3}\) - 2"            
term[12] = "x\(^{\small 3}\) + a\(^{\small 2}\) - 3a\(^{\small 2}\)x\(^{\small 2}\)"              
term[13] = "3xy\(^{\small 2}\)"             
term[14] = "axy\(^{\small 5}\)"            
term[15] = "xy + 3y\(^{\small 2}\) - 8"            
term[16] = "x\(^{\small 3}\)y\(^{\small 2}\)+x\(^{\small 2}\)y\(^{\small 3}\)"             
term[17] = "x\(^{\small 3}\)y\(^{\small 2}\)"
term[18] = "xa - y + 2" 
term[19] = "a\(^{\small 2}\)b\(^{\small 2}\)m + 4xy\(^{\small 3}\)" 
term[20] = "3+x\(^{\small 2}\)- y"                	 
term[21] = "-xy\(^{\small 3}\) + 4x\(^{\small 3}\)y + 5xy\(^{\small 3}\)"
term[22] = "-k\(^{\small 2}\) + 0,2k\(^{\small 2}\)"
term[23] = "a\(^{\small 2}\) - ab + ab\(^{\small 2}\) + ab"
term[24] = "- k\(^{\small 2}\)m\(^{\small 3}\)n\(^{\small 4}\)p\(^{\small 5}\)"
term[25] = "p\(^{\small 3}\) - 2 - 2p - 3p\(^{\small 3}\) - p + 6"
term[26] = "ay\(^{\small 3}\) - 3a\(^{\small 2}\) + 4ay\(^{\small 2}\) + 4 + 3a\(^{\small 2}\) - ay\(^{\small 3}\)"
term[27] = "2x\(^{\small 3}\) - 2xy\(^{\small 2}\) + x - xy\(^{\small 2}\) - y\(^{\small 2}\) + 3xy\(^{\small 2}\) - x - 2x\(^{\small 3}\)"

solut = {2, 1, 3, 2, 2, 3, 2, 3, 2, 2, 2, 3, 1, 1, 3, 2, 1, 3, 2, 3, 2, 1, 2, 1, 3, 2, 1}
degr = {1, 2, 3, 2, 2, 2, 3, 4, 2, 4, 3, 4, 3, 7, 2, 5, 5, 2, 5, 2, 4, 2, 3, 14, 3, 3, 2}

dim = 27
stampa = 4

index = {}
ind = {}
qq = {}

quest = {""}
answ = {""}

for i = 1,dim do
    index[i] = i
end	
ind = lib.math.random_shuffle(index)

for i = 1,stampa do
   	quest[i] = term[ind[i]]	
	qq[i] = degr[ind[i]] 
	tmp = solut[ind[i]]
	answ[i] = name[tmp]	  
end  
    