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
	NAME VARCHAR2(30),
	AGE INTEGER(3),
	HOBBY VARCHAR2(30),
	INTEREST VARCHAR2(30)
	);
	
INSERT INTO BROADCAST VALUES 
	(1, '조태익', 29, 'cook', 'back end');
	
INSERT INTO BROADCAST VALUES
	(2, '이진영', 23, 'exercise', 'Analyze Data');
INSERT INTO BROADCAST VALUES
	(3, '정주영', 31, 'game', 'back end');


COMMIT;

SET TERMOUT ON
SET ECHO ON
