Oboj del figure zapisan z ulomkom:

@repeat(3)@
@center@ \(\frac{@brojnik@}{@imenovalec@}\) @hspace@ @hspace@ @lib.select_objects(6, 3,"table","sum(result) == "..tostring(barva), style, sln)@
@/repeat@

Razvrsti ulomke od najmanjega do največjega:
@center@ \
   @lib.check_fraction_condition(is_ok[indices[1]], false, nil, solution[indices[1]])@ \(\leq\) \
   @lib.check_fraction_condition(is_ok[indices[2]], false, nil, solution[indices[2]])@ \(\leq\) \
   @lib.check_fraction_condition(is_ok[indices[3]], false, nil, solution[indices[3]])@