Izračunaj pretvaranjem decimalnog števila v ulomek. Zapiši rezultat v obliki ulomka in decimalnega števila.

@repeat(3)@
@hspacept(20)@ @lib.dec_to_str(value[1])@ @sign@ @lib.dec_to_str(value[2])@   =
@center@  @lib.check_fraction_simple(enum[1], denom[1])@ @sign@ @lib.check_fraction_simple(enum[2], denom[2])@  = @ans@   =   @lib.check_number(result, 50)@
@/repeat@