Oboj deo figure zapisan razlomkom:

@repeat(3)@
@center@ \(\frac{1}{@denom@}\) = \
@center@ @lib.select_objects(x, y, type, "sum(result) == "..tostring(res), style)@
@/repeat@
