@ime@ je nabrala  @rezultat@@"kg"@ jabolk. \
Prvi dan je prodala \(\frac{1}{@imenilac1@}\), drugi dan pa \(\frac{1}{@imenilac2@}\) jabolk. 

@vspace@

Koliko jabolk je @ime@ prodala? @hspacept(5)@ 
@center@ @lib.check_number(brojp)@@"kg"@   

@vspace@

Kateri del jabolk ni bila prodana? 
@center@ @lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(vrednost)..");", nil, nil, solution)@