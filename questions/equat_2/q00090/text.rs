                                               
Tvrđenje:   
@if ind == 1@
@center@ @title[mod]@ @"x"@ je @choice@ od @point@,
@elif ind == 2@
@center@ @title[mod]@ @"x"@ je @choice@ od @point@,
@elif ind == 3@
@center@ @title[mod]@ @"x"@ nije @choice@ od @point@,
@elif ind == 4@
@center@ @title[mod]@ @"x"@ nije @choice@ od @point@,
@elif ind == 5@
@center@ @title[mod]@ @"x"@ je @choice@ od @numbl@ i @choice1@ i @numbd@, 
@elif ind == 6@
@center@ @title[mod]@ @"x"@ nije @choice@ od @numbl@ i @choice@ je od @numbd@ , 
@elif ind == 7@
@center@ @title[mod]@ @"x"@ nije @choice@ od @numbl@ i nije @choice1@ od @numbd@, 
@else@
@center@ @title[mod]@ @"x"@ je @choice@ od @numbl@ i nije @choice@ od @numbd@, 
@endif@
zapiši (u rastućem redosledu)  u obliku 
@"(a)"@ nejednakosti 
@center@ @ineq@,  
@"(b)"@ intervala kome pripada rešenje 
@center@ @set@,  
@"(c)"@ oboj oblast na brojevnoj pravoj (i graničnu tačku ako ova pripada oblasti) i upiši granice
@center@ @mycanvas()@
         