Rem Copyright (c) 1990 by Oracle Corporation
Rem NAME
REM    UTLSAMPL.SQL
Rem  FUNCTION
Rem  NOTES
Rem  MODIFIED
Rem	gdudey	   06/28/95 -  Modified for desktop seed database
Rem	glumpkin   10/21/92 -  Renamed from SQLBLD.SQL
Rem	blinden   07/27/92 -  Added primary and foreign keys to EMP and DEPT
Rem	rlim	   04/29/91 -	      change char to varchar2
Rem	mmoore	   04/08/91 -	      use unlimited tablespace priv
Rem	pritto	   04/04/91 -	      change SYSDATE to 13-JUL-87
Rem   Mendels	 12/07/90 - bug 30123;add to_date calls so language independent
Rem
rem
rem $Header: utlsampl.sql 7020100.1 94/09/23 22:14:24 cli Generic<base> $ sqlbld.sql
rem
SET TERMOUT OFF
SET ECHO OFF

rem CONGDON    Invoked in RDBMS at build time.	 29-DEC-1988
rem OATES:     Created: 16-Feb-83

rem 팀원 : 손정현, 이진의, 이진영, 정주영B, 조태익

GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT IDENTIFIED BY TIGER;
ALTER USER SCOTT DEFAULT TABLESPACE USERS;
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;
CONNECT SCOTT/TIGER


DROP TABLE PERSON_INFO;
CREATE TABLE PERSON_INFO(
	NO NUMBER(3),
	NAME VARCHAR2(20),
	AGE NUMBER(3),
	H_NAME VARCHAR2(20),
	INTEREST VARCHAR2(20),
	IDEA VARCHAR2(20)
	);
	
INSERT INTO PERSON_INFO VALUES 
	(1, '조태익', 29, 'COOK', 'BACK END', 'PLANT DIARY');	
INSERT INTO PERSON_INFO VALUES
	(2, '이진영', 23, 'EXERCISE', 'ANALYSING DATA', 'GPS_TO_DO');
INSERT INTO PERSON_INFO VALUES
	(3, '정주영', 31, 'GAME', 'BACK END', 'SPORTS DATA');
INSERT INTO PERSON_INFO VALUES
	(4, '이진의', 34, 'HIKING', 'ANALYSING DATA', 'SMOKING AREA NOTIFY');
INSERT INTO PERSON_INFO VALUES
	(5, '손정현', 28, 'HIKING', 'ANALYSING DATA', 'ALLERGY SEARCH APP');	

DROP TABLE PROJECT;
CREATE TABLE PROJECT(
	IDEA VARCHAR2(20),
	REQUIRMENT_LV VARCHAR2(20),
	ESSENTIAL_SKILLS VARCHAR2(20),
	ESTIMATED_TIME NUMBER(3)
	);
	
INSERT INTO PROJECT VALUES
	('SPORTS DATA', 'EASY', 'BIGDATA', 30);	
INSERT INTO PROJECT VALUES
	('VR GAME', 'HARD', 'VR', 140);
INSERT INTO PROJECT VALUES
	('ALLERGY SEARCH APP', 'MID', 'BIGDATA', 30);	
INSERT INTO PROJECT VALUES
	('PLANT DIARY', 'EASY', 'TIME DATA', 40);
INSERT INTO PROJECT VALUES
	('GPS_TO_DO', 'HARD', 'GPS', 150);
INSERT INTO PROJECT VALUES
	('SMOKING AREA NOTIFY', 'HARD', 'GPS', 180);


DROP TABLE HOBBY;
CREATE TABLE HOBBY(
    H_NAME VARCHAR2(30),
    H_CATE CHAR(2) CONSTRAINT CK_HOBBY CHECK (H_CATE IN ('I' ,'O'))
    ); 
    
INSERT INTO HOBBY VALUES 
	('HIKING','O');
INSERT INTO HOBBY VALUES 
	('COOK','I');
INSERT INTO HOBBY VALUES 	
	('EXERCISE','O');
INSERT INTO HOBBY VALUES 	
	('GAME','I');


COMMIT;




SET TERMOUT ON
SET ECHO ON
