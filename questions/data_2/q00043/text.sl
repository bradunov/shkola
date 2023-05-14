Na kvadratni mreži so podane koordinate treh točk kvadrata @"A, B"@ in @"C"@. 
Določite koordinate četrte točke @"D"@.

@repeat(4)@ 
@center@ @"A"@ = (@xp[1]@, @yp[1]@), @hspacept(15)@ @"B"@ = (@xp[2]@, @yp[2]@), @hspacept(15)@ @"C"@ = (@xp[3]@, @yp[3]@)
@center@ @"D"@ = (@lib.check_number(xp[4],20)@, @lib.check_number(yp[4],20)@)
@/repeat@