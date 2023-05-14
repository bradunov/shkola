Skala označuje temperature v @"°C"@ v krajih A, @"B"@ in @"H"@  

@center@ @mycanvas()@

Temperatura v kraju 
@center@ A je @lib.check_number(tempA,20)@@"°C"@, @hspacept(3)@ @"B"@ je @lib.check_number(tempB,20)@@"°C"@, @hspacept(3)@ @"H"@ je @lib.check_number(tempH,20)@@"°C"@.
@center@ V katerem kraju je najhladneje? @hspacept(3)@ @lib.check_string_case("A",15)@
@vspace@
Razlika temperatur krajev 
@center@ A in @"B"@ je @lib.check_number(tempAmB,15)@@"°C"@, @hspacept(6)@ @"B"@ in @"H"@ je @lib.check_number(tempBmH,15)@@"°C"@, 
@center@ A in @"H"@ je @lib.check_number(tempAmH,15)@@"°C"@. 
@vspace@
Če temperatura v kraju
@center@ A naraste za @difA@@"°C"@ @hspacept(3)@ bo znašala @lib.check_number(tempAr,20)@@"°C"@, 
@center@ @"H"@ pade za @difH@@"°C"@ @hspacept(3)@ bo znašala @lib.check_number(tempHf,20)@@"°C"@.