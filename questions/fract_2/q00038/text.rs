
@imem@ je pojeo  \(\frac{@enum[1]@}{@denom[1]@}\) kolača i @imez@ je pojela \(\frac{@enum[2]@}{@denom[2]@}\) kolača. 
Oboj deo kolača koji su njih dvoje pojeli. 
@vspace@
@center@ @lib.select_objects(6, 4,"table","sum(result) == "..tostring(boja), style, sln)@
@vspace@
Koliko kolača je ostalo?
@center@ Ostalo je @lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(value)..");", nil, nil, solution)@  kolača.
 