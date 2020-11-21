select count(*) as total_sites from cse532.site as sites, cse532.counties as counties 
where
db2gse.st_within(sites.geolocation, counties.shape) = 1
and
counties.county_name = 'Suffolk'
and
counties.statefp='36';  