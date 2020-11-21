select 
cse532.site.name, cast( db2gse.st_astext(cse532.site.geolocation) AS varchar(32) )   as location_wkt, db2gse.st_distance(cse532.site.geolocation, db2gse.st_point(-72.993983, 40.824369,1),'STATUTE MILE') as distance
from cse532.site
WHERE db2gse.ST_Contains(db2gse.ST_Buffer(db2gse.ST_POINT(-72.993983, 40.824369, 1), 10, 'STATUTE MILE'), cse532.site.geolocation) = 1
ORDER BY distance
limit 3
;




 