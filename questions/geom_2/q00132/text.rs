
@center@ @mycanvas()@
Koji
@repeat(2)@ 
@if ch == 1@
deo kružne linije odgovara centralnom uglu  
@center@ @phi@ = @angc@@meas@ ?
@center@ @lib.check_fraction_denominator(1, part[ind])@ @hspacept(5)@ kružne linije.
@elif ch == 2@
deo kružne linije odgovara periferijskom uglu 
@center@ @alpha@ = @angp@@meas@ ?
@center@ @lib.check_fraction_denominator(1, part[ind])@ @hspacept(5)@ kružne linije.
@elif ch == 3@
centralni ugao odgovara \(\frac{@1@}{@tostring(part[ind])@}\) @hspacept(5)@ kružne linije?
@center@ @phi@ = @lib.check_number(angc,40)@@meas@ 
@else@
periferijski ugao odgovara \(\frac{@1@}{@tostring(part[ind])@}\) @hspacept(5)@ kružne linije?
@center@ @alpha@ = @lib.check_number(angp,40)@@meas@
@endif@
@/repeat@ 
