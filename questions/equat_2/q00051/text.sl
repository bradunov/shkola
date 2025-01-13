
Trditev 
@if ind == 1@
@center@ število @"x"@ je negativno,
@elif ind == 2@
@center@ število @"x"@ je pozitivno,
@elif ind == 3@
@center@ število @"x"@ je nenegativno,
@elif ind == 4@
@center@ število @"x"@ je negativno in veće je od @numbl@,
@elif ind == 5@
@center@ število @"x"@ ni manjše od @numbl@ in ni pozitivno, 
@elif ind == 6@
@center@ število @"x"@ je nenegativno in manjše je od @numbd@, 
@elif ind == 7@
@center@ število @"x"@ je pozitivno in ni večje od @numbd@, 
@else@
@center@ število @"x"@ je nenegativno in ni večje od @numbd@, 
@endif@ 
zapiši (v naraščajočem vrstnem redu) v obliki 
@"(a)"@ neenačbe 
@center@ @ineq@,  
@"(b)"@ intervala, kamor spada rešitev 
@center@ @set@,  
@"(c)"@ obarvaj območje na številski premici in zapiši meje
@center@ @mycanvas()@