msg = {"Skup rešenja je  ", "Nema rešenja "}




  for i = 0,columns-1 do
    numb2 = 3 + math.random(max_range)
    numb1 = math.random(numb2 - 1)
	q[i] = {}
	q[i][1] = numb2^2 - numb1^2        kateta1  
	q[i][2] = 2 * numb1 * numb2          kateta2
	ch = math.random(2)
	if (ch == 2) then
	    tmp = q[i][2]
		q[i][2] = q[i][1]
		q[i][1] = tmp
	end	
	q[i][3] = numb2^2 + numb1^2      hipotenuza
	fct = math.random(4)	
	for j = 1,3 do
	    q[i][j] = q[i][j] * fct
	end

  end
