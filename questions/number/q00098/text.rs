U svako polje upiši po jednu od datih cifara, tako da dobiješ tačno oduzimanje:

@repeat(2)@

@vspace@
@center@ @task[1]@, @hspace@ @task[2]@, @hspace@ @task[3]@, @hspace@ @task[4]@, @hspace@ @task[5]@, @hspace@ @task[6]@, @hspace@ @task[7]@

@center@ @lib.check_number(term[1])@ @lib.check_number(term[2])@ @lib.check_number(term[3])@ @hspace@  -  @hspace@ @lib.check_number(value)@ @hspace@ = @hspace@  @lib.check_number(result[1])@ @lib.check_number(result[2])@ @lib.check_number(result[3])@ 

@vspace@
@/repeat@



