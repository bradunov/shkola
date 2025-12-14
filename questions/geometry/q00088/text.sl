
Dve stranici štirikotnika sta na mreži narisani z modrimi črtami.
@if ind == 1@ 
Tretja stranica je vzporedna s stranico @"a"@. Četrta stranica je pravokotna na stranico @"a"@.
@elif ind == 2@
Tretja stranica je vzporedna s stranico @"a"@. Četrta stranica je vzporedna s stranico @"b"@.
@elif ind == 3@
Tretja stranica je pravokotna na stranico @"b"@. Četrta stranica je vzporedna s stranico @"b"@.
@else@
Tretja stranica je pravokotna na stranicu @"a"@. Četrta stranica je pravokotna na stranicu @"b"@.
@endif@
@center@ @mycanvas()@
S temi podatki dokončaj štirikotnik. Pobarvajte daljice na sliki jima pripadata drugi dve stranici štirikotnika.
