
@center@ @mycanvas()@
Kateri
@repeat(2)@ 
@if ch == 1@
del krožnice ustreza središčnemu kotu  
@center@ @phi@ = @angc@@meas@ ?
@center@ @lib.check_fraction_denominator(1, part[ind])@ @hspacept(5)@ krožnice.
@elif ch == 2@
del krožnice ustreza obodnemu kotu
@center@ @alpha@ = @angp@@meas@ ?
@center@ @lib.check_fraction_denominator(1, part[ind])@ @hspacept(5)@ krožnice.
@elif ch == 3@
središčni kot ustreza \(\frac{@1@}{@tostring(part[ind])@}\) @hspacept(5)@ krožnice?
@center@ @phi@ = @lib.check_number(angc,40)@@meas@ 
@else@
obodni kot ustreza \(\frac{@1@}{@tostring(part[ind])@}\) @hspacept(5)@ krožnice?
@center@ @alpha@ = @lib.check_number(angp,40)@@meas@
@endif@
@/repeat@ 
