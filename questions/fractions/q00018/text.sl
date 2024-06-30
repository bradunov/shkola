
@ime@ je nabrala  @rezultat@@"kg"@ jabolk. \
Prvi dan je prodala \(\frac{1}{@imenilac1@}\), drugi dan pa \(\frac{1}{@imenilac2@}\) jabolk. 
@vspace@
Koliko jabolk je @ime@ prodala?  
@center@ @lib.check_number(brojp)@@"kg"@   
@vspace@
Katerega dela jabolk ni prodala?
@center@ @lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(vrednost)..");", nil, nil, solution)@