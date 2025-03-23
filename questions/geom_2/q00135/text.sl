
Izračunajte polmera očrtanega (@dat[2]@) in včrtanega kroga (@dat[3]@) ter obseg @"O"@ pravilnega večkotnik s slike, če velja @hspacept(3)@ @quest@.
Računajte s tremi decimalnimi mesti in rezultat zapišite na dve decimalni mesti.                                                              
@center@ @mycanvas()@
@center@ @dat[2]@ = @lib.check_number(numb[2],35)@@meas@, @hspacept(15)@ @dat[3]@ = @lib.check_number(numb[3],35)@@meas@,  @hspacept(15)@ @"O"@ = @lib.check_number(circ,35)@@meas@
Če predpostavimo, da so obsegi teh krogov nekoliko večji ali manjši od obsega večkotnika, določimo interval, ki mu pripada število @pi@.
@center@  @lib.check_number(pi_lo,35)@ @hspacept(3)@ @sign@ @hspacept(3)@ @pi@ @hspacept(3)@ @sign@ @hspacept(3)@ @lib.check_number(pi_ho,35)@