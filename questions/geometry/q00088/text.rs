
Dve stranice četvorougla su nacrtane na mreži plavim linijama. 
@if ind == 1@ 
Treća stranica je paralelna sa stranicom @"a"@. Četvrta stranica je normalna na stranicu @"a"@.
@elif ind == 2@
Treća stranica je paralelna sa stranicom @"a"@. Četvrta stranica je paralelna sa stranicom @"b"@.
@elif ind == 3@
Treća stranica je normalna na stranicu @"b"@. Četvrta stranica je paralelna stranici @"b"@.
@else@
Treća stranica je normalna na stranicu @"a"@. Četvrta stranica je normalna na stranicu @"b"@.
@endif@
@center@ @mycanvas()@
Koristi ove informacije da dovršiš četvorougao. Oboj linije na slici koje predstavljaju druge dve stranice četvorougla.