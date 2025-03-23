
V koordinatnem sistemu se trikotnik @"ABC"@, (@"A"@(@ptx[1]@,@pty[1]@), @"B"@(@ptx[2]@,@pty[2]@), @"C"@(@ptx[3]@,@pty[3]@)) z vrtenjem preslika v trikotnik @"PQR"@. Če je kot vrteži @angle@ in je @direction[sg]@ usmerjen, središče vrteži pa je točka @point[ind]@ vpišite koordinate oglišč trikotnika  @"PQR"@ (na eno decimalno mesto).    
@center@ @mycanvas()@   
@center@ @"P("@ @lib.check_number(ptx[4],25)@, @lib.check_number(pty[4],25)@), @hspacept(5)@  @"Q("@ @lib.check_number(ptx[5],25)@, @lib.check_number(pty[5],25)@), @hspacept(5)@   @"R("@ @lib.check_number(ptx[6],25)@, @lib.check_number(pty[6],25)@)
Trikotnika @"ABC"@ in @"PQR"@ se ujemata. @hspace@ @lib.check_one_option_dropdown(answ, answ[1])@
         