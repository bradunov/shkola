
Trditev:    
@if ind == 1@
@center@ @title[mod]@ @"x"@ je @choice@ od @point@,
@elif ind == 2@
@center@ @title[mod]@ @"x"@ je @choice@ od @point@,
@elif ind == 3@
@center@ @title[mod]@ @"x"@ ni @choice@ od @point@,
@elif ind == 4@
@center@ @title[mod]@ @"x"@ ni @choice@ od @point@,
@elif ind == 5@
@center@ @title[mod]@ @"x"@ je @choice@ od @numbl@ in @choice1@ od @numbd@, 
@elif ind == 6@
@center@ @title[mod]@ @"x"@ ni @choice@ od @numbl@ in @choice@ je od @numbd@ , 
@elif ind == 7@
@center@ @title[mod]@ @"x"@ ni @choice@ od @numbl@ in ni @choice1@ od @numbd@, 
@else@
@center@ @title[mod]@ @"x"@ je @choice@ od @numbl@ in ni @choice@ od @numbd@, 
@endif@   
zapišite (v naraščajočem vrstnem redu) v obliki 
@"(a)"@ neenačbe 
@center@ @ineq@,  
@"(b)"@ intervala, kamor spada rešitev 
@center@ @set@,  
@"(c)"@ pobarvajte območje na številski premici in zapišite meje
@center@ @mycanvas()@