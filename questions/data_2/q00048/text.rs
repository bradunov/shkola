
Grafikon prikazuje rezultate testiranja dve grupe učenika, @"A"@ i @"B"@. 
@center@ @mycanvas()@
Za svaku grupu upiši 
@if index == 1@
broj učenika koji imaju @edge@ i više poena.
@elif index == 2@
broj učenika koji imaju manje od @edge@ poena.
@else@
prosečan broj poena cele grupe (koristi srednje vrednosti date crvenim brojevima).
@endif@ 
@center@ grupa @"A"@ @hspacept(5)@ @lib.check_number(outa,40)@,@hspacept(25)@ grupa @"B"@ @hspacept(5)@ @lib.check_number(outb,40)@
            