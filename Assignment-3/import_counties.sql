!erase counties.msg;

DROP TABLE cse532.counties;
  
 CREATE TABLE  cse532.counties(
  STATEFP		VARCHAR(  2) NOT NULL,
  COUNTYFP      VARCHAR(  3) NOT NULL,
  COUNTYNS      VARCHAR(  8),
  GEOID  		VARCHAR(  5),
  COUNTY_NAME   VARCHAR(100) NOT NULL,
  NAMELSAD      VARCHAR(100),
  LSAD   		VARCHAR(  2),
  CLASSFP       VARCHAR(  2),
  MTFCC  		VARCHAR(  5),
  CSAFP  		VARCHAR(  3),
  METDIVFP      VARCHAR(  5),
  FUNCSTAT      VARCHAR(  1),
  INTPTLON      VARCHAR( 12),
  SHAPE          db2gse.st_multipolygon,
  PRIMARY KEY(STATEFP, COUNTYFP)
 ); 

 
!db2se import_shape spatialQ
-fileName         C:\\Users\\viraj\\Desktop\\TODB-CSE532\\Assignment-3\\tl_2015_us_county\\tl_2015_us_county.shp
-inputAttrColumns N(STATEFP,COUNTYFP,COUNTYNS,GEOID,NAME,NAMELSAD,CLASSFP,MTFCC,CSAFP,METDIVFP,FUNCSTAT,INTPTLON)
-srsName          nad83_srs_1
-tableSchema      cse532
-tableName        counties
-tableAttrColumns   STATEFP,COUNTYFP,COUNTYNS,GEOID,COUNTY_NAME,NAMELSAD,CLASSFP,MTFCC,CSAFP,METDIVFP,FUNCSTAT,INTPTLON
-createTableFlag  0
-spatialColumn    shape
-typeSchema       db2gse
-typeName         st_multipolygon
-messagesFile     counties.msg
-client 1
;

!db2se register_spatial_column spatialQ
-tableSchema      cse532
-tableName        counties
-columnName       shape
-srsName          nad83_srs_1
;

