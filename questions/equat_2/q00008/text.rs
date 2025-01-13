
@if ind == 1@
Kada se neki broj pomnoži sa \(\frac{@enum@}{@denom@}\), dobijeni proizvod je za @numb@ @comp[sign]@ od tog broja.
@else@
Kada se neki broj podeli sa \(\frac{@enum@}{@denom@}\), dobijeni količnik je za @numb@ @comp[sign]@ od tog broja.
@endif@
Koji je to broj? 

@vspace@
@center@ To je broj @lib.check_number(result,30)@. 