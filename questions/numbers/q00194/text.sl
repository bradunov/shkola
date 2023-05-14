V tovarni avtomobilov je bilo proizvedenih @total@ avtomobilov. Prodanih je bilo @sold@.
@vspace@
Koliko avtomobilov je ostalo? @hspacept(10)@ @lib.check_number(value,30)@
@vspace@
Koliko bi avtomobilov ostalo, če bi bilo proizvedenih @diff@ več in prodanih @diff@ več?
@center@ (@lib.check_number(total,30)@ + @lib.check_number(diff,30)@) - (@lib.check_number(sold,30)@ + @lib.check_number(diff,30)@) = @lib.check_number(value,30)@
@vspace@
Koliko bi avtomobilov ostalo, če bi bilo proizvedenih @diff@ manj in prodanih @diff@ manj?
@center@ (@lib.check_number(total,30)@ - @lib.check_number(diff,30)@) - (@lib.check_number(sold,30)@ - @lib.check_number(diff,30)@) = @lib.check_number(value,30)@