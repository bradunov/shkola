@h1@Oboj deo figure zapisan razlomkom @/h1@

@repeat(3)@
@center@ \(\frac{1}{@denom@}\) = \
@center@ @lib.select_objects(x, y, type, "sum(result) == "..tostring(res), style)@
@/repeat@
