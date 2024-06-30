
@ime@ je nabrala  @rezultat@@"kg"@ jabuka. \
Prvog dana je prodala \(\frac{1}{@imenilac1@}\), a drugog dana \(\frac{1}{@imenilac2@}\) jabuka. 
@vspace@
Koliko jabuka je @ime@ prodala?  
@center@ @lib.check_number(brojp)@@"kg"@   
@vspace@
Koji deo jabuka nije prodala? 
@center@ @lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(vrednost)..");", nil, nil, solution)@ 
