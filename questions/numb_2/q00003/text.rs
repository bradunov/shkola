
Skala označava temperature u @"°C"@ u mestima A, @"B"@ i @"H"@  

@center@ @mycanvas()@

Temperatura u mestu 
@center@ A je @lib.check_number(tempA,20)@@"°C"@, @hspacept(3)@ @"B"@ je @lib.check_number(tempB,20)@@"°C"@, @hspacept(3)@ @"H"@ je @lib.check_number(tempH,20)@@"°C"@.
@center@ U kom mestu je najhladnije? @hspacept(3)@ @lib.check_string_case("A",15)@
@vspace@
Razlika temperatura mesta 
@center@ A i @"B"@ je @lib.check_number(tempAmB,15)@@"°C"@, @hspacept(6)@ @"B"@ i @"H"@ je @lib.check_number(tempBmH,15)@@"°C"@, 
@center@ A i @"H"@ je @lib.check_number(tempAmH,15)@@"°C"@. 
@vspace@
Ako temperatura u mestu
@center@ A poraste za @difA@@"°C"@ @hspacept(3)@ ona će  biti @lib.check_number(tempAr,20)@@"°C"@, 
@center@ @"H"@ opadne za @difH@@"°C"@ @hspacept(3)@ ona će  biti @lib.check_number(tempHf,20)@@"°C"@.                    