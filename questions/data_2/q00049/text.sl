
Tabela prikazuje rezultate testov dveh skupin študentov, @"A"@ in @"B"@. 
@center@ @mycanvas()@
Za vsako skupino vnesite 
@if index == 1@
število učencev, ki imajo @edge@ i več točk.
@elif index == 2@
število učencev, ki imajo manj od @edge@ točk.
@else@
povprečno število točk celotne skupine (uporabite povprečne vrednosti, podane z rdečimi številimi).
@endif@ 
@center@ skupina @"A"@ @hspacept(5)@ @lib.check_number(outa,40)@,@hspacept(25)@ skupina @"B"@ @hspacept(5)@ @lib.check_number(outb,40)@