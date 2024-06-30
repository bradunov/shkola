
Izračunaj razliku brojeva @number1@ i @number2@. Zatim, ne računajući, odredi vrednost nepoznatog broja x koristeći stalnost razlike. 
@center@ @number1@ - @number2@ = @lib.check_number(result,30)@

@vspace@
@center@ (@number1@ + @term[1]@) - (@number2@ + x) =  @result@  
@center@ x = @lib.check_number(term[1],30)@ 

@center@ (@number1@ - x) - (@number2@ - @term[2]@) = @result@
@center@ x = @lib.check_number(term[2],30)@

@center@ (@number1@ + x) - (@number2@ + @term[3]@) = @result@  
@center@ x = @lib.check_number(term[3],30)@

@center@ (@number1@ - @term[4]@) - (@number2@ - x) = @result@  
@center@ x = @lib.check_number(term[4],30)@
