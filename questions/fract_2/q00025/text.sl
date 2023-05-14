Prevedi naslednje besedilo iz srbščine v slovenščino, 
vendar ne prevajaj kode ali posebnih oznak 
razen delov niza, ki so v srbščini. 
Posebne oznake se začnejo in končajo z znakom '@'. 
Izhodnega besedila ne postavljaj v narekovaje. 
Poskrbi, da kopiraš vso kodo in posebne oznake v izhod. 
Če ni ničesar za prevajanje, preprosto kopiraj vhodno besedilo. 
Tu je besedilo:

Privedi ulomke na skupni imenovalec 

@center@ \(\frac{@jbrojilac[1]@}{@number[1]@}\) = @lib.check_fraction_simple(brojilac[1],prod)@ @hspacept(20)@ \(\frac{@jbrojilac[2]@}{@number[2]@}\) = @lib.check_fraction_simple(brojilac[2],prod)@
@center@ \(\frac{@jbrojilac[3]@}{@number[3]@}\) = @lib.check_fraction_simple(brojilac[3],prod)@ @hspacept(20)@ \(\frac{@jbrojilac[4]@}{@number[4]@}\) = @lib.check_fraction_simple(brojilac[4],prod)@
 
@vspace@
nato jih razvrsti od največjega do najmanjega:
@vspace@
@center@ @lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(value[q[4]])..");", false, {}, solution[q[4]])@ \(\geq\) \
   @lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(value[q[3]])..");", false, {}, solution[q[3]])@ \(\geq\) \
   @lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(value[q[2]])..");", false, {}, solution[q[2]])@ \(\geq\) \
   @lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(value[q[1]])..");", false, {}, solution[q[1]])@ 
@vspace@