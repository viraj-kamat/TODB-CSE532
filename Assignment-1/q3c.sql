select buyer_state, buyer_county, buyer_zip, RANK() OVER ( ORDER BY TOTAL_NORMALIZED_DOSAGE/POPULATION DESC  ) AS TOP_ZIPS FROM ( 
	select bpills.buyer_county, bpills.buyer_state, bpills.buyer_zip, bpills.TOTAL_NORMALIZED_DOSAGE, bzip.irs_estimated_population_2015 AS POPULATION from (
		select  bpills.buyer_county, bpills.buyer_state,sum(bpills.mme*bpills.DOSAGE_UNIT) as TOTAL_NORMALIZED_DOSAGE, bpills.buyer_zip
			from cse532.dea as bpills
		group by buyer_state,buyer_county,buyer_zip
		order by buyer_state,buyer_county,buyer_zip ) as bpills
	INNER JOIN cse532.zip as bzip 
	ON bpills.buyer_zip = bzip.zip
	and bzip.irs_estimated_population_2015 > 0
) LIMIT 10