@if ind == 1@
Katero število je treba dodati k številu @term@ da bi dobili številko @value@?
@elif ind == 2@
Katero število je treba odšteti od števila @term@ da bi dobili številko @value@?
@elif ind == 3@
Kateremu številu je treba dodati število @term@ da bi dobili številko @value@?
@else@
Od katerega števila je treba odšteti število @term@ da bi dobili številko @value@?
@endif@



@vspace@
S katero enačbo boste izračunali iskano število? Pobarvajte kroglico ob pravilnem odgovoru.
@vspace@
@center@ @lib.check_one_option_radio(answ,ind-1,true)@ 
@vspace@
Rešite enačbo.
@center@   x = @lib.check_number(solution,40)@