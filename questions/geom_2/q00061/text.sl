@vspace@                                
@center@ @mycanvas()@
Dopolni trditve o podobnosti trikotnikov  @name[1]@,  @name[2]@,  @name[3]@ in  @name[4]@ na sliki (razdeli oznake z vejico, če jih je več). Vpiši, na podlagi katerega pravila o podobnosti to sledi.
@"r\(\small_1\) \(\small\neq\) r\(\small_2\)"@ 
@center@ @trian@@name[1]@ @eq@ @trian@@lib.check_string_case(name[2], 60)@ @hspacept(10)@ pravilo @lib.check_one_option_dropdown(rule, rule[2])@
@center@ @trian@@name[3]@ @eq@ @trian@@lib.check_string_case(name[4], 60)@  @hspacept(10)@ pravilo @lib.check_one_option_dropdown(rule,rule[1])@
@vspace@
@"r\(\small_1\) = r\(\small_2\)"@ @hspacept(20)@  @trian@@name[1]@ @eq@ @trian@@lib.check_string_case(reply,100,ans)@