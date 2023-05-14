@imem@ je pojedel \(\frac{@enum[1]@}{@denom[1]@}\) tort in @imez@ je pojedla \(\frac{@enum[2]@}{@denom[2]@}\) tort. 
Oba sta pojedla del torte.

@vspace@
@center@ @lib.select_objects(6, 4,"table","sum(result) == "..tostring(boja), style, sln)@
@vspace@
Koliko tort je ostalo?

@center@ Ostalo je @lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(value)..");", nil, nil, solution)@  tort.