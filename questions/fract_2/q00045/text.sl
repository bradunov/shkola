Kateri del površine pravokotnika na sliki pokriva manjši pravokotnik, ki ima dolžino enako \(\frac{@enum[1]@}{@denom[1]@}\) dolžine danega pravokotnika in širino enako \(\frac{@enum[2]@}{@denom[2]@}\) širine danega pravokotnika?
Pobarvaj manjši pravokotnik in izračunaj.

@vspace@
@center@ @lib.select_objects(8, 6,"table","sum(result) == "..tostring(boja), style, sln)@
@vspace@

@center@ Manjši pravokotnik pokriva 
@center@ @lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(value)..");", nil, nil, solution)@  površine danega pravokotnika.