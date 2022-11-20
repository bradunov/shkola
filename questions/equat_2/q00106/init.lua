
include("terms")

solut = {"a+b", "2a-3b", "3xy", "(a+4)(b-4)", "(a+2)/(a-3)", "x^2+y^2", "(a+b)^2", "x^2-y^2", "(a-b)^2", "3x^2-x+9", "((x-3)^2-y)/(2(x+y))", "a^3-2b", "(x^2+a^2)/(3xa)", "3xy^2", "3x^2y", "3x^2y^2", "(x-y)^2/(x+y)^3", "3(xy)^2", "3(x/y)^2", "3x/y^2", "3x^2/y", "2n", "-n", "np", "kp+q", "2n-1"}

dim = 26
stampa = 3

index = {}
ind = {}

quest = {""}
answ = {""}

for i = 1,dim do
    index[i] = i
end	
ind = lib.math.random_shuffle(index)

for i = 1,stampa do
   	quest[i] = title[ind[i]]	
	answ[i] = lib.check_string(solut[ind[i]],120)	
end              