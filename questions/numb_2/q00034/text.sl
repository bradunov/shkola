Fabrika je proizvedla @ind@ modelov obutve v naslednjih količinah: @number[1]@,  @number[2]@,  @number[3]@ in  @number[4]@ parov obutve. Želi, da jih enakomerno razdeli po svojih prodajalnah.
@vspace@
Koliko največ prodajaln lahko oskrbi z enakimi paketi obutve?
@center@ Lahko oskrbi največ @lib.check_number(prod, 30)@ prodajaln.
@vspace@
Koliko parov vsakega modela bo prejela ena prodajalna?
@center@ Vsaka prodajalna bo prejela
@center@ @lib.check_number(value[1], 50)@ parov prvega modela,
@center@ @lib.check_number(value[2], 50)@ parov drugega modela,
@center@ @lib.check_number(value[3], 50)@ parov tretjega modela,
@center@ @lib.check_number(value[4], 50)@ parov četrtega modela.