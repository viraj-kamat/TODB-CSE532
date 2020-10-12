DROP PROCEDURE CUMULATIVEHISTOGRAM@
create or replace type intArray as integer array[100]@ 
CREATE PROCEDURE CUMULATIVEHISTOGRAM(IN binstart INTEGER, IN binend INTEGER,IN numbins INTEGER)
  LANGUAGE SQL
  BEGIN
    DECLARE SQLSTATE CHAR(5) DEFAULT '00000';
    DECLARE binrange FLOAT;
    DECLARE counter INTEGER;
    DECLARE emp_sal INTEGER;
    DECLARE numbinsArr intArray;
    DECLARE binstartArr intArray;
    DECLARE binendArr intArray;
    DECLARE binFreqArr intArray;
    DECLARE binBelong INTEGER;
    DECLARE total INTEGER;
    DECLARE c CURSOR FOR SELECT SALARY from EMPLOYEE where salary > binstart order by salary asc;
    SET binrange = (binend-binstart)/numbins;
    SET counter = 1;
    SET total = 0;
    WHILE (counter <= numbins) DO 
        SET numbinsArr[counter] = counter;
        SET binstartArr[counter] = CAST(binstart as INTEGER) ;
        SET binendArr[counter] = CAST(binstart+binrange*counter as INTEGER) ;
        SET binFreqArr[counter] = 0;
        SET counter = counter+1; 
    END WHILE;    
    SET counter = 1;
    OPEN c;
    FETCH FROM c INTO emp_sal;
    WHILE(SQLSTATE = '00000' ) DO
        set binBelong = (emp_sal - binstart) / binrange + 1;
        SET binFreqArr[binBelong] = binFreqArr[binBelong] + 1;
        set total = total + 1;
        FETCH FROM c INTO emp_sal;
    END WHILE;
    SET counter = 2;
    WHILE counter <= numbins DO
        SET binFreqArr[counter] = binFreqArr[counter] + binFreqArr[counter-1];
        SET counter = counter+1;
    END WHILE;
    SET counter = 1;
    ---WHILE counter <= numbins DO
        ---SET binFreqArr[counter] = binFreqArr[counter]/total;
        --SET counter = counter+1;
    ---END WHILE;
    CLOSE c;
    CREATE TABLE CUMULATIVEHIST 
        (binstart INTEGER NOT NULL,
        binend INTEGER NOT NULL,
        frequency INTEGER NOT NULL);
    SET counter = 1;
    WHILE counter <= numbins DO
        INSERT INTO CUMULATIVEHIST VALUES
            (binstartArr[counter],
            binendArr[counter],
            binFreqArr[counter]);
        SET counter = counter + 1;
    END WHILE;
  END@
  
call CUMULATIVEHISTOGRAM(30000, 170000, 10)@
SELECT * FROM CUMULATIVEHIST@
DROP TABLE CUMULATIVEHIST@

