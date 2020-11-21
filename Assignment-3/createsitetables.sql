
DROP TABLE cse532.siteoriginal;
DROP TABLE cse532.site;

CREATE TABLE cse532.siteoriginal(
    name VARCHAR(250), 
    address1 VARCHAR(250), 
    address2 VARCHAR(250), 
    city varchar(50), 
    state CHAR(4),
    zipcode INT,
    country CHAR(4),
    latitude DECIMAL(8,6),
    longitude DECIMAL(8,6)
);

CREATE TABLE cse532.site(
    name VARCHAR(250), 
    address1 VARCHAR(250), 
    address2 VARCHAR(250), 
    city varchar(50), 
    state CHAR(4),
    zipcode INT,
    country CHAR(4),
    geolocation DB2GSE.ST_POINT
);

!db2se register_spatial_column spatialQ
-tableSchema      cse532
-tableName        site
-columnName       geolocation
-srsName          nad83_srs_1
;


