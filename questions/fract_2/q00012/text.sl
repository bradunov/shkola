
Izračunajte na dva načina:
1) pretvorite mešana števila v ulomke, večje od 1, in izračunajte rezultat,
2) ločeno izračunajte cel del in ulomek rezultata.
Rezultat zapišite v najenostavnejši obliki.
@vspace@
1) @hspacept(10)@ @whl[1]@\(\frac{@enum_p[1]@}{@denom[1]@}\) @sign@ @whl[2]@\(\frac{@enum_p[2]@}{@denom[2]@}\)  
@center@ = @hspacept(3)@  @lib.check_fraction_simple(enum[1], denom[1])@  @sign@  @lib.check_fraction_simple(enum[2], denom[2])@ @hspacept(3)@ = @hspacept(3)@ @ans1@
@vspace@
2) @hspacept(10)@ @whl[1]@\(\frac{@enum_p[1]@}{@denom[1]@}\) @sign@ @whl[2]@\(\frac{@enum_p[2]@}{@denom[2]@}\)  
@center@ = @hspacept(3)@  (@lib.check_number(first,30)@ @sign@ @lib.check_number(whl[2],30)@) + (@lib.check_fraction_simple(second, denom[1])@  @sign@  @lib.check_fraction_simple(enum_p[2], denom[2])@) 
@center@ = @hspacept(3)@ @lib.check_number(whole, 30)@ + @lib.check_fraction_simple(broj_p, imenilac)@  @hspacept(3)@ = @hspacept(3)@ @ans2@