INSERT INTO cse532.site (
	name, 
	address1, 
	address2, 
	city, 
	state, 
	zipCode, 
	country,  
	Geolocation)
SELECT  
	name, 
	address1, 
	address2, 
	city, 
	state, 
	zipCode, 
	country,  
	db2gse.st_point(longitude, latitude, 1) 
	FROM cse532.siteoriginal;

reorg table cse532.site;