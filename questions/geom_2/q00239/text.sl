
V koordinatnem sistemu se rotacija trikotnika @"ABC"@, ( @"A"@(@ptx[1]@,@pty[1]@),  @"B"@(@ptx[2]@,@pty[2]@), @"C"@(@ptx[3]@,@pty[3]@) )  preslika v trikotnik @"PQR"@. Če je kot rotacije @angle@ in @direction[sg]@ orientiran, a center rotacije točka @point[ind]@ vpiši koordinate oglišč trikotnika  @"PQR"@ (na eno decimalno mesto).    
@center@ @mycanvas()@   
@center@ @"P("@ @lib.check_number(ptx[4],20)@, @lib.check_number(pty[4],20)@), @hspace@  @"Q("@ @lib.check_number(ptx[5],20)@, @lib.check_number(pty[5],20)@), @hspace@   @"R("@ @lib.check_number(ptx[6],20)@, @lib.check_number(pty[6],20)@)
Trikotnika @"ABC"@ in @"PQR"@ se ujemata. @hspace@ @lib.check_one_option_dropdown(answ, answ[1])@
      