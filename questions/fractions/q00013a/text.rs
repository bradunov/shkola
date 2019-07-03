@h1@ Obojite deo figure zapisan razlomkom  @h1@

@repeat(3)@
@center@ @h1@\(\frac{1}{@denom@}\)@/h1@
@center@ @lib.select_objects(x, y, type, "sum(result) == "..tostring(res), style)@
@/repeat@

