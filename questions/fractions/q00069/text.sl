
Izrazite večjo mero, dano z decimalnim številom, s pomočjo ulomka in manjše mere.

@repeat(5)@
@center@ @lib.dec_to_str(res_dec)@ @measure1[ITEM]@ @hspacept(3)@ = @hspacept(3)@ \
    @lib.check_fraction_condition(condition, false, nil, solution)@ @measure1[ITEM]@ @hspacept(3)@ = @hspacept(3)@ \
    @lib.check_number(result,25)@ @measure2[ITEM]@ 
@/repeat@