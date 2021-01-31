
Izračunaj pretvaranjem decimalnog broja u razlomak. Zapiši rezultat i u obliku neskrativog razlomka i u obliku decimalnog broja.

@repeat(2)@
@hspacept(20)@ @lib.dec_to_str(value[1])@ @"*"@ @lib.dec_to_str(value[2])@ = @lib.check_fraction_simple(enum[1], denom[1])@  @"*"@  @lib.check_fraction_simple(enum[2], denom[2])@ 
@center@ = @ans@ = @lib.check_number(resround, 60)@
@vspace@
@/repeat@
            
              
     
          