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

--1번 
DROP TABLE PERSON_INFO;
CREATE TABLE PERSON_INFO(
	NO NUMBER(3),
	NAME VARCHAR2(20),
	AGE NUMBER(3),
	H_NAME VARCHAR2(20),
	INTEREST VARCHAR2(20),
	IDEA VARCHAR2(20)
	);
	
INSERT ALL
	INTO PERSON_INFO VALUES(1, '조태익', 29, 'COOK', 'BACK END', 'PLANT DIARY')
	INTO PERSON_INFO VALUES(2, '이진영', 23, 'EXERCISE', 'ANALYSING DATA', 'GPS_TO_DO')
	INTO PERSON_INFO VALUES(3, '정주영', 31, 'GAME', 'BACK END', 'SPORTS DATA')
 	INTO PERSON_INFO VALUES(4, '이진의', 34, 'HIKING', 'ANALYSING DATA', 'SMOKING AREA NOTIFY')
	INTO PERSON_INFO VALUES(5, '손정현', 28, 'HIKING', 'ANALYSING DATA', 'ALLERGY SEARCH APP')
SELECT * FROM DUAL;

DROP TABLE PROJECT;
CREATE TABLE PROJECT(
	IDEA VARCHAR2(20),
	REQUIRMENT_LV VARCHAR2(20),
	ESSENTIAL_SKILLS VARCHAR2(20),
	ESTIMATED_TIME NUMBER(3)
	);
	
INSERT ALL 
	INTO PROJECT VALUES('SPORTS DATA', 'EASY', 'BIGDATA', 30)
	INTO PROJECT VALUES('VR GAME', 'HARD', 'VR', 140)
	INTO PROJECT VALUES('ALLERGY SEARCH APP', 'MID', 'BIGDATA', 30)
	INTO PROJECT VALUES('PLANT DIARY', 'EASY', 'TIME DATA', 40)
	INTO PROJECT VALUES('GPS_TO_DO', 'HARD', 'GPS', 150)
	INTO PROJECT VALUES('SMOKING AREA NOTIFY', 'HARD', 'GPS', 180)
SELECT * FROM DUAL;



DROP TABLE HOBBY;
CREATE TABLE HOBBY(
    H_NAME VARCHAR2(30),
    H_CATE CHAR(2) CONSTRAINT CK_HOBBY CHECK (H_CATE IN ('I' ,'O'))
    ); 
    
INSERT ALL 
	INTO HOBBY VALUES('HIKING','O')
	INTO HOBBY VALUES('COOK','I')
	INTO HOBBY VALUES('EXERCISE','O')
	INTO HOBBY VALUES('GAME','I')
SELECT * FROM DUAL;

--2. 
ALTER TABLE PERSON_INFO ADD CONSTRAINT pk_PERSON_INFO_NO primary KEY (NO);
ALTER TABLE HOBBY ADD CONSTRAINT pk_HOBBY_H_NAME primary KEY (H_NAME);
ALTER TABLE PROJECT ADD CONSTRAINT pk_PROJECT_IEDA primary KEY (IDEA);

ALTER TABLE PERSON_INFO ADD CONSTRAINT fk_PERSON_INFO_H_NAME foreign key (H_NAME) references HOBBY(H_NAME);
ALTER TABLE PERSON_INFO ADD CONSTRAINT fk_PERSON_INFO_IDEA foreign key (IDEA) references PROJECT(IDEA);

--3. PROJECT 테이블에는 6개의 데이터가 들어 있다. 이 중 5명의 조원들에게 선택 받은 IDEA는 5개이다. 이때 조원들에게 선택받지 못한 아이디어를
-- JOIN을 이용하여 출력하라. 
select project.idea
from project
left join person_info
on project.idea = person_info.idea
where person_info.idea is NULL;

-- 강의시간에 배웠던방법
SELECT PROJECT.IDEA 
FROM PROJECT,PERSON_INFO
where PROJECT.idea  =  PERSON_INFO.IDEA(+) and PERSON_INFO.IDEA IS NULL;


--4.
CREATE OR REPLACE PROCEDURE ADD_IDEA(
	N_IDEA PROJECT.IDEA%TYPE,
	N_REQ PROJECT.REQUIRMENT_LV%TYPE,
	N_ESS PROJECT.ESSENTIAL_SKILLS%TYPE,
	N_EST PROJECT.ESTIMATED_TIME%TYPE)
IS 
BEGIN
	INSERT INTO PROJECT 
	VALUES (N_IDEA, N_REQ , N_ESS , N_EST );

end;
/





--5.
create or replace function makestar(v_NAME PERSON_INFO.NAME%type)
return varchar2
is 
	v_IDEA PROJECT.IDEA%type;
	v_NUMBER number(3);
	v_STAR varchar2(20) := '';
begin
	select IDEA, length(IDEA)
		into v_IDEA, v_NUMBER
	from PERSON_INFO
	where NAME = v_NAME;

	for i in 1..v_number loop
		v_STAR := v_STAR || '*';
	end loop;
	
	return v_STAR;
end;
/
select NAME, H_NAME, makestar('조태익') as IDEA from dual, PERSON_INFO WHERE NAME = '조태익';

SET TERMOUT ON
SET ECHO ON
