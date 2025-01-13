
@if ind == 1@
Katero število naj se doda številu @factor[2]@ za pridobitev števila @value@?
@elif ind == 2@
Katero število naj se odšteje od števila @factor[2]@ za pridobitev števila @value@?
@elif ind == 3@
Kateremu številu naj se doda število @factor[2]@ za pridobitev števila @value@?
@else@
Od katerega števila naj se odšteje število @factor[2]@ za pridobitev števila @value@?
@endif@
Katero enačbo boš uporabil za izračun iskanega števila? Obarvaj krog ob pravilnem odgovoru.
@center@ @lib.check_one_option_radio(reply,index-1,true)@ 
@vspace@
Reši enačbo.
@center@   x = @lib.check_number(factor[1],40)@