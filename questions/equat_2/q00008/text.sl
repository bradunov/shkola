
@if ind == 1@
Ko se nekaj število pomnoži s \(\frac{@enum@}{@denom@}\), dobimo produkt ki je za @numb@ @comp[sign]@ od tega števila.
@else@
Ko se nekaj število deli sa \(\frac{@enum@}{@denom@}\), dobimo količnik ki je za @numb@ @comp[sign]@ od tega števila.
@endif@
Katero število je to?

@vspace@
@center@ To je število @lib.check_number(result,30)@.