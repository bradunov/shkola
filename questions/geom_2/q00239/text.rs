
U koordinatnom sistemu se rotacijom trougao @"ABC"@, ( @"A"@(@ptx[1]@,@pty[1]@),  @"B"@(@ptx[2]@,@pty[2]@), @"C"@(@ptx[3]@,@pty[3]@) )  preslikava u trougao @"PQR"@. Ako je ugao rotacije @angle@ i @direction[sg]@ orjentisan, a centar rotacije tačka @point[ind]@ upiši koordinate temena trougla  @"PQR"@ (na jednu decimalu).    
@center@ @mycanvas()@   
@center@ @"P("@ @lib.check_number(ptx[4],20)@, @lib.check_number(pty[4],20)@), @hspace@  @"Q("@ @lib.check_number(ptx[5],20)@, @lib.check_number(pty[5],20)@), @hspace@   @"R("@ @lib.check_number(ptx[6],20)@, @lib.check_number(pty[6],20)@)
Trouglovi @"ABC"@ i @"PQR"@ su podudarni. @hspace@ @lib.check_one_option_dropdown(answ, answ[1])@            