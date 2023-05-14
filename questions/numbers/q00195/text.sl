Izračunaj razliko števil @number1@ in @number2@. Nato, ne da bi računali, določite vrednost neznane številke x s stalno razliko.
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