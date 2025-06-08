
Z združevanjem seštevancev izračunajte na najlažji način:
@repeat(2)@
@vspace@
@center@ @number[1]@ + @number[2]@ + @number[3]@ + @number[4]@   
@center@ = (@lib.check_number(term[1],40)@ + @lib.check_number(term[3],40)@) + (@lib.check_number(term[2],40)@ + @lib.check_number(term[4],40)@) 
@center@= @lib.check_number(value1,50)@ + @lib.check_number(value2,50)@ = @lib.check_number(result,50)@
@/repeat@