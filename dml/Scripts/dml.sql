CREATE SEQUENCE SEQ_ZOO;
CREATE SEQUENCE SEQ_ANIMAL;

CREATE TABLE TBL_ZOO(
   ID NUMBER CONSTRAINT PK_ZOO PRIMARY KEY,
   ZOO_NAME VARCHAR2(1000),
   ZOO_ADDRESS VARCHAR2(1000),
   ZOO_ADDRESS_DETAIL VARCHAR2(1000),
   ZOO_MAX_ANIMAL NUMBER DEFAULT 0
);

CREATE TABLE TBL_ANIMAL(
   ID NUMBER CONSTRAINT PK_ANIMAL PRIMARY KEY,
   ANIMAL_NAME VARCHAR2(1000),
   ANIMAL_TYPE VARCHAR2(1000) NOT NULL,
   ANIMAL_AGE NUMBER DEFAULT 0,
   ANIMAL_HEIGHT NUMBER(10, 5),
   ANIMAL_WEIGHT NUMBER(10, 5),
   ZOO_ID NUMBER NOT NULL,
   CONSTRAINT FK_ANIMAL_ZOO FOREIGN KEY(ZOO_ID)
   REFERENCES TBL_ZOO(ID)
);

INSERT 
INTO TBL_ZOO(ID, ZOO_NAME, ZOO_ADDRESS, ZOO_ADDRESS_DETAIL, ZOO_MAX_ANIMAL)
VALUES(SEQ_ZOO.NEXTVAL, '에버랜드', '경기도 용인시', '에버랜드', 20);


INSERT 
INTO TBL_ZOO
VALUES(SEQ_ZOO.NEXTVAL, '서울대공원', '경기도 과천시', '주암동', 3);


INSERT 
INTO TBL_ANIMAL
VALUES(SEQ_ANIMAL.NEXTVAL,'사자','사돌이', 5, 123.45, 500.13, 1);

INSERT INTO TBL_ANIMAL
VALUES(SEQ_ANIMAL.NEXTVAL,'호랑이','호돌이', 12, 234.56, 500.13, 1);

INSERT INTO TBL_ANIMAL
VALUES(SEQ_ANIMAL.NEXTVAL,'고양이','나비', 5, 56.78, 500.13, 2);

SELECT *
FROM TBL_ZOO
WHERE ZOO_MAX_ANIMAL > 5;

/*
 * 동물원 중에서
 * */

UPDATE TBL_ANIMAL
SET ANIMAL_AGE = ANIMAL_AGE + 1
WHERE ZOO_ID = 1;


DELETE FROM TBL_ANIMAL
WHERE ZOO_ID=2;

SELECT * FROM TBL_ANIMAL 

/* ===============================================================*/

CREATE TABLE TBL_MEMBER(
   ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE NOT NULL,
   MEMBER_PASSWORD VARCHAR2(255) NOT NULL,
   MEMBER_NAME VARCHAR2(255) NOT NULL,
   MEMBER_ADDRESS VARCHAR2(255) NOT NULL,
   MEMBER_EMAIL VARCHAR2(255),
   MEMBER_BIRTH DATE
);

CREATE TABLE TBL_PRODUCT(
   ID NUMBER CONSTRAINT PK_PRODUCT PRIMARY KEY,
   PRODUCT_NAME VARCHAR2(255) NOT NULL,
   PRODUCT_PRICE NUMBER DEFAULT 0,
   PRODUCT_STOCK NUMBER DEFAULT 0
);

CREATE TABLE TBL_ORDER(
   ID NUMBER CONSTRAINT PK_ORDER PRIMARY KEY,
   ORDER_DATE DATE DEFAULT SYSDATE,
   MEMBER_ID NUMBER,
   PRODUCT_ID NUMBER,
   CONSTRAINT FK_ORDER_MEMBER FOREIGN KEY(MEMBER_ID)
   REFERENCES TBL_MEMBER(ID),
   CONSTRAINT FK_ORDER_PRODUCT FOREIGN KEY(PRODUCT_ID)
   REFERENCES TBL_PRODUCT(ID)
);

/*각 테이블에 3개 이상씩 정보를 추가하고, 조회한다.*/
/* DATE 형식에 년,월,일 만 추가한다면, ''문자열로 추가*/
/* DATE 형식을 원하는 형식으로 추가할 때에는 TO_DATE()를 사용해서 추가한다.*/
CREATE SEQUENCE SEQ_MEMBER;
CREATE SEQUENCE SEQ_PRODUCT;
CREATE SEQUENCE SEQ_ORDER;
TO_DATE('2000-12-04 10:30:30','YYYY-MM-DD HH:MI:SS') FROM DUAL;
INSERT INTO TBL_MEMBER
VALUES(SEQ_MEMBER.NEXTVAL, 'QWER1', 'qwer1234', '김승균', '서울', 'ksk@gmail.com', TO_DATE('1998-12-04 10:30:30','YYYY-MM-DD HH:MI:SS'));

INSERT INTO TBL_MEMBER
VALUES(SEQ_MEMBER.NEXTVAL, 'QWER2', 'qwer2345', '허세웅', '서울', 'hsw@naver.com', TO_DATE('1999-12-04 10:30:30','YYYY-MM-DD HH:MI:SS'));

INSERT INTO TBL_MEMBER
VALUES(SEQ_MEMBER.NEXTVAL, 'QWER3', 'qwer3456', '한지수', '서울', 'hjs@daum.net', TO_DATE('2001-12-04 10:30:30','YYYY-MM-DD HH:MI:SS'));

INSERT INTO TBL_PRODUCT
VALUES(SEQ_PRODUCT.NEXTVAL, '모니터', 320000, 12);

INSERT INTO TBL_PRODUCT
VALUES(SEQ_PRODUCT.NEXTVAL, '마우스', 70000, 35);

INSERT INTO TBL_PRODUCT
VALUES(SEQ_PRODUCT.NEXTVAL, '키보드', 150000, 20);

INSERT INTO TBL_ORDER
(ID, MEMBER_ID, PRODUCT_ID)
VALUES(SEQ_ORDER.NEXTVAL, 2, 1);

INSERT INTO TBL_ORDER
(ID, MEMBER_ID, PRODUCT_ID)
VALUES(SEQ_ORDER.NEXTVAL, 1, 3);

INSERT INTO TBL_ORDER
(ID, MEMBER_ID, PRODUCT_ID)
VALUES(SEQ_ORDER.NEXTVAL, 3, 2);

/*
 1번 주문의 상품을 1번 상품으로 수정
 * */

UPDATE TBL_ORDER SET PRODUCT_ID = 1 WHERE ID = 1;
SELECT * FROM TBL_ORDER;



UPDATE TBL_PRODUCT SET PRODUCT_PRICE = PRODUCT_PRICE * 1.1;

SELECT * FROM TBL_PRODUCT 

/*
 * 3번 주문 삭제
 * 2번 상품 삭제
 * */

DELETE FROM TBL_ORDER WHERE ID=3;
DELETE FROM TBL_PRODUCT WHERE ID=2;
/*
 * AS(Alias): 별칭
 * 
 * 컬럼명 혹은 테이블명 뒤에 한 칸 띄어쓰고 별칭을 작성할 수 있다.
 * AS는 SELECT절에서만 사용가능하기 때문에 헷갈린다면, 항상 AS는 생략한다.
 * 만약 별칭을 키워드나 띄어쓰기가 포함된 문자열로 구성해야 할 때에는 ""(쌍따옴표)를 감싸준다.
 * 
 * SELECT 절: AS 사용 가능
 * FROM 절: AS 사용 불가
 * 
 * */

/* ===============================================================*/


/*****************************************************************/
CREATE SEQUENCE SEQ_OWNER;
CREATE TABLE TBL_OWNER(
   ID NUMBER CONSTRAINT PK_OWNER PRIMARY KEY,
   OWNER_NAME VARCHAR2(255) NOT NULL,
   OWNER_AGE NUMBER,
   OWNER_PHONE VARCHAR2(255) NOT NULL,
   OWNER_ADDRESS VARCHAR2(255)
);

CREATE SEQUENCE SEQ_PET;
CREATE TABLE TBL_PET(
   ID NUMBER CONSTRAINT PK_PET PRIMARY KEY,
   PET_ILL_NAME VARCHAR2(255),
   PET_NAME VARCHAR2(255),
   PET_AGE NUMBER,
   WEIGHT NUMBER(4, 2),
   OWNER_ID NUMBER,
   CONSTRAINT FK_PET_OWNER FOREIGN KEY(OWNER_ID)
   REFERENCES TBL_OWNER(ID)
);

INSERT INTO TBL_OWNER
(ID, OWNER_NAME, OWNER_AGE, OWNER_PHONE, OWNER_ADDRESS)
VALUES(SEQ_OWNER.NEXTVAL, '한동석', 20, '01012341234', '경기도');
INSERT INTO TBL_OWNER
(ID, OWNER_NAME, OWNER_AGE, OWNER_PHONE, OWNER_ADDRESS)
VALUES(SEQ_OWNER.NEXTVAL, '홍길동', 37, '01087879898', '서울');
INSERT INTO TBL_OWNER
(ID, OWNER_NAME, OWNER_AGE, OWNER_PHONE, OWNER_ADDRESS)
VALUES(SEQ_OWNER.NEXTVAL, '이순신', 50, '01044445555', '대구');

SELECT * FROM TBL_OWNER;

INSERT INTO TBL_PET
(ID, PET_ILL_NAME, PET_NAME, PET_AGE, WEIGHT, OWNER_ID)
VALUES(SEQ_PET.NEXTVAL, '장염', '뽀삐', 4, 10.45, 1);
INSERT INTO TBL_PET
(ID, PET_ILL_NAME, PET_NAME, PET_AGE, WEIGHT, OWNER_ID)
VALUES(SEQ_PET.NEXTVAL, '감기', '달구', 12, 14.25, 1);
INSERT INTO TBL_PET
(ID, PET_ILL_NAME, PET_NAME, PET_AGE, WEIGHT, OWNER_ID)
VALUES(SEQ_PET.NEXTVAL, '탈골', '댕댕', 7, 8.46, 1);
INSERT INTO TBL_PET
(ID, PET_ILL_NAME, PET_NAME, PET_AGE, WEIGHT, OWNER_ID)
VALUES(SEQ_PET.NEXTVAL, '염좌', '쿠키', 11, 5.81, 2);
INSERT INTO TBL_PET
(ID, PET_ILL_NAME, PET_NAME, PET_AGE, WEIGHT, OWNER_ID)
VALUES(SEQ_PET.NEXTVAL, '충치', '바둑', 1, 3.47, 3);

SELECT * FROM TBL_PET;


/* 몸무게가 8kg 미만인 반려동물들의 주인에게 모두 전화*/
/*SELECT MEMBER_NAME, PRODUCT_NAME
FROM TBL_MEMBER M JOIN TBL_ORDER O
ON M.ID = O.MEMBER_ID
JOIN TBL_PRODUCT P
ON O.PRODUCT_ID = P.ID;*/

SELECT PET_NAME, O.*
FROM TBL_OWNER O  
JOIN TBL_PET P
ON O.ID = P.OWNER_ID AND P.WEIGHT < 8;

SELECT * FROM TBL_OWNER 

/* 이순신이 키우는 반려동물의 병명 조회*/

SELECT O.OWNER_NAME, P.PET_NAME, P.PET_ILL_NAME
FROM TBL_OWNER O
JOIN TBL_PET P
ON O.ID = P.OWNER_ID AND O.OWNER_NAME ='이순신'

/* 5살 초과 반려동물 주인 정보 전체 조회*/

SELECT P.PET_NAME, O.*
FROM TBL_OWNER O
JOIN TBL_PET P
ON O.ID = P.OWNER_ID AND P.PET_AGE > 5;

/*
 * CONCATENATION: 연결
 * 
 * "안" + "녕: JAVA
 * '안' || '녕': ORACLE 
 * */
SELECT OWNER_NAME || '님의 반려동물은 ' ||  P.PET_NAME || '입니다.' 소개
FROM TBL_OWNER O JOIN TBL_PET P
ON O.ID = P.OWNER_ID;

/*
 * LIKE: 포함된 문자열 값을 찾고, 문자의 개수도 제한을 줄 수 있다.
 *
 * %: 모든 것
 * _: 글자 수
 * 
 * 예시
 * '%A'   : A로 끝나는 모든 값
 * 'A%'   : A로 시작하는 모든 값
 * 'A__': A로 시작하면서 3글자인 값
 * '_A'   : A로 끝나면서 2글자인 값
 * '%A%': A가 포함된 값 
 * 
 * */

SELECT * FROM TBL_PET
WHERE PET_NAME NOT LIKE '_삐';

SELECT * FROM TBL_PET
WHERE PET_NAME LIKE '%삐%';

/* '뽀'가 포함된 반려동물의 주인 정보 조회*/
/* 0101234로 시작하는 주인의 반려동물 전체 조회*/
/* 병명에 염이 들어가있지 않은 반려동물 전체 + 주인 이름*/

SELECT O.* FROM TBL_PET P
JOIN TBL_OWNER O 
ON O.ID = P.OWNER_ID AND P.PET_NAME LIKE '%뽀%';

SELECT P.* FROM TBL_PET P
JOIN TBL_OWNER O 
ON O.ID = P.OWNER_ID AND O.OWNER_PHONE  LIKE '0101234%';

SELECT O.OWNER_NAME, P.* FROM TBL_PET P
JOIN TBL_OWNER O 
ON O.ID = P.OWNER_ID AND P.PET_ILL_NAME NOT LIKE '%염%';

/************************************************************************************/
CREATE SEQUENCE SEQ_KINDERGARTEN;
CREATE SEQUENCE SEQ_PARENT;
CREATE SEQUENCE SEQ_CHILD;
CREATE SEQUENCE SEQ_FIELD_TRIP;
CREATE SEQUENCE SEQ_FILE;
CREATE SEQUENCE SEQ_MEMBER;
CREATE SEQUENCE SEQ_FIELD_TRIP_FILE;
CREATE SEQUENCE SEQ_APPLY;

CREATE TABLE TBL_KINDERGARTEN(
	ID NUMBER CONSTRAINT PK_KINDERGARTEN PRIMARY KEY,
	KINDERGARTEN_NAME VARCHAR2(255),
	KINDERGARTEN_ADDRESS VARCHAR2(255)
);
CREATE TABLE TBL_PARENT(
	ID NUMBER CONSTRAINT PK_PARENT PRIMARY KEY,
	PARENT_NAME VARCHAR2(255) NOT NULL,
	PARENT_ADDRESS VARCHAR2(255) NOT NULL,
	PARENT_PHONE VARCHAR2(255) NOT NULL,
	PARENT_GENDER VARCHAR2(1000) DEFAULT '선택 안함'
);

CREATE TABLE TBL_CHILD(
	ID NUMBER CONSTRAINT PK_CHILD PRIMARY KEY,
	CHILD_NAME VARCHAR2(255) NOT NULL,
	CHILD_AGE NUMBER NOT NULL,
	CHILD_GENDER VARCHAR2(1000) DEFAULT '여아',
	CHILD_ID NUMBER,
	CONSTRAINT FK_CHILD_PARENT FOREIGN KEY(CHILD_ID)
	REFERENCES TBL_PARENT(ID)
);

CREATE TABLE TBL_FIELD_TRIP(
	ID NUMBER CONSTRAINT PK_FIELD_TRIP PRIMARY KEY,
	FIELD_TRIP_TITLE VARCHAR2(255),
	FIELD_TRIP_CONTENT VARCHAR2(255),
	KINDERGARTEN_ID NUMBER,
	CONSTRAINT FK_FIELD_TRIP_KINDERGARTEN FOREIGN KEY(KINDERGARTEN_ID)
	REFERENCES TBL_KINDERGARTEN(ID)
);

CREATE TABLE TBL_FILE(
	ID NUMBER CONSTRAINT PK_FILE PRIMARY KEY,
	FILE_NAME VARCHAR2(255),
	FILE_PATH VARCHAR2(255),
	FILE_SIZE NUMBER
);

CREATE TABLE TBL_FIELD_TRIP_FILE(
	ID NUMBER CONSTRAINT PK_FIELD_DRIP_FILE PRIMARY KEY,
	FIELD_TRIP_ID NUMBER NOT NULL,
	CONSTRAINT FK_FIELD_TRIP_FILE_FIELD_TRIP FOREIGN KEY(FIELD_TRIP_ID)
	REFERENCES TBL_FIELD_TRIP(ID),
	CONSTRAINT FK_FIELD_TRIP_FILE_FILE FOREIGN KEY(ID)
	REFERENCES TBL_FILE(ID)
);

CREATE TABLE TBL_MEMBER(
	ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
	MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE NOT NULL,
	MEMBER_PASSWORD VARCHAR2(255) NOT NULL,
	MEMBER_NAME VARCHAR2(255) NOT NULL,
	MEMBER_ADDRESS VARCHAR2(255) NOT NULL,
	MEMBER_EMAIL VARCHAR2(255),
	MEMBER_BIRTH DATE,
	KINDERGARTEN_ID NUMBER,
	CONSTRAINT FK_MEMBER_KINDERGARTEN FOREIGN KEY(KINDERGARTEN_ID)
	REFERENCES TBL_KINDERGARTEN(ID)
);

CREATE TABLE TBL_APPLY(
	ID NUMBER CONSTRAINT PK_APPLY PRIMARY KEY,
	CHILD_ID NUMBER NOT NULL,
	FIELD_TRIP_ID NUMBER NOT NULL,
	CONSTRAINT FK_APPLY_CHILD FOREIGN KEY(CHILD_ID)
	REFERENCES TBL_CHILD(ID),
	CONSTRAINT FK_APPLY_FIELD_TRIP FOREIGN KEY(FIELD_TRIP_ID)
	REFERENCES TBL_FIELD_TRIP(ID)
);

INSERT INTO TBL_PARENT
(ID, PARENT_NAME, PARENT_ADDRESS, PARENT_PHONE)
VALUES(SEQ_PARENT.NEXTVAL, '한동석', '경기도', '01012341234');
INSERT INTO TBL_PARENT
(ID, PARENT_NAME, PARENT_ADDRESS, PARENT_PHONE)
VALUES(SEQ_PARENT.NEXTVAL, '홍길동', '서울', '01012341235');
INSERT INTO TBL_PARENT
(ID, PARENT_NAME, PARENT_ADDRESS, PARENT_PHONE)
VALUES(SEQ_PARENT.NEXTVAL, '이순신', '대구', '01012345654');
INSERT INTO TBL_PARENT
(ID, PARENT_NAME, PARENT_ADDRESS, PARENT_PHONE)
VALUES(SEQ_PARENT.NEXTVAL, '장보고', '광주', '01012845234');

SELECT * FROM TBL_PARENT;

INSERT INTO TBL_CHILD
(ID, CHILD_NAME, CHILD_AGE, CHILD_GENDER, CHILD_ID)
VALUES(SEQ_CHILD.NEXTVAL, '또치', 5, '남아', 2);
INSERT INTO TBL_CHILD
(ID, CHILD_NAME, CHILD_AGE, CHILD_ID)
VALUES(SEQ_CHILD.NEXTVAL, '둘리', 7, 2);
INSERT INTO TBL_CHILD
(ID, CHILD_NAME, CHILD_AGE, CHILD_GENDER, CHILD_ID)
VALUES(SEQ_CHILD.NEXTVAL, '도너', 4, '남아', 1);
INSERT INTO TBL_CHILD
(ID, CHILD_NAME, CHILD_AGE, CHILD_GENDER, CHILD_ID)
VALUES(SEQ_CHILD.NEXTVAL, '마이콜', 4, '남아', 3);
INSERT INTO TBL_CHILD
(ID, CHILD_NAME, CHILD_AGE, CHILD_ID)
VALUES(SEQ_CHILD.NEXTVAL, '짱구', 5, 4);
INSERT INTO TBL_CHILD
(ID, CHILD_NAME, CHILD_AGE, CHILD_ID)
VALUES(SEQ_CHILD.NEXTVAL, '짱아', 5, 4);
INSERT INTO TBL_CHILD
(ID, CHILD_NAME, CHILD_AGE, CHILD_GENDER, CHILD_ID)
VALUES(SEQ_CHILD.NEXTVAL, '신형만', 12, '남아', 2);

SELECT * FROM TBL_CHILD;

INSERT INTO TBL_KINDERGARTEN
(ID, KINDERGARTEN_NAME, KINDERGARTEN_ADDRESS)
VALUES(SEQ_KINDERGARTEN.NEXTVAL, '병설유치원', '경기도 고양시');
INSERT INTO TBL_KINDERGARTEN
(ID, KINDERGARTEN_NAME, KINDERGARTEN_ADDRESS)
VALUES(SEQ_KINDERGARTEN.NEXTVAL, '파랑새유치원', '서울시 강남구');
INSERT INTO TBL_KINDERGARTEN
(ID, KINDERGARTEN_NAME, KINDERGARTEN_ADDRESS)
VALUES(SEQ_KINDERGARTEN.NEXTVAL, '불교유치원', '경기도 고양시');
INSERT INTO TBL_KINDERGARTEN
(ID, KINDERGARTEN_NAME, KINDERGARTEN_ADDRESS)
VALUES(SEQ_KINDERGARTEN.NEXTVAL, '세화유치원', '경기도 고양시');
INSERT INTO TBL_KINDERGARTEN
(ID, KINDERGARTEN_NAME, KINDERGARTEN_ADDRESS)
VALUES(SEQ_KINDERGARTEN.NEXTVAL, '대명유치원', '경기도 고양시');

SELECT * FROM TBL_KINDERGARTEN;

INSERT INTO TBL_FIELD_TRIP(ID, FIELD_TRIP_TITLE, FIELD_TRIP_CONTENT, KINDERGARTEN_ID)
VALUES(SEQ_FIELD_TRIP.NEXTVAL, '어서와 매미농장', '매미 잡자 어서와', 1);
INSERT INTO TBL_FIELD_TRIP(ID, FIELD_TRIP_TITLE, FIELD_TRIP_CONTENT, KINDERGARTEN_ID)
VALUES(SEQ_FIELD_TRIP.NEXTVAL, '아이스크림 빨리 먹기 대회', '아이스크림 누가 더 잘먹나', 3);
INSERT INTO TBL_FIELD_TRIP(ID, FIELD_TRIP_TITLE, FIELD_TRIP_CONTENT, KINDERGARTEN_ID)
VALUES(SEQ_FIELD_TRIP.NEXTVAL, '고구마 심기', '고구마가 왕 커요', 2);
INSERT INTO TBL_FIELD_TRIP(ID, FIELD_TRIP_TITLE, FIELD_TRIP_CONTENT, KINDERGARTEN_ID)
VALUES(SEQ_FIELD_TRIP.NEXTVAL, '숭어 얼음 낚시', '숭어 잡자 추워도 참아', 4);
INSERT INTO TBL_FIELD_TRIP(ID, FIELD_TRIP_TITLE, FIELD_TRIP_CONTENT, KINDERGARTEN_ID)
VALUES(SEQ_FIELD_TRIP.NEXTVAL, '커피 체험 공장', '커비 빈 객체화', 4);
INSERT INTO TBL_FIELD_TRIP(ID, FIELD_TRIP_TITLE, FIELD_TRIP_CONTENT, KINDERGARTEN_ID)
VALUES(SEQ_FIELD_TRIP.NEXTVAL, '치즈 제작하기', '여기 치즈 저기 치즈 전부 다 치즈', 4);
INSERT INTO TBL_FIELD_TRIP(ID, FIELD_TRIP_TITLE, FIELD_TRIP_CONTENT, KINDERGARTEN_ID)
VALUES(SEQ_FIELD_TRIP.NEXTVAL, '동물 타보기', '이리야!', 2);

SELECT * FROM TBL_FIELD_TRIP;

INSERT INTO TBL_APPLY
(ID, CHILD_ID, FIELD_TRIP_ID)
VALUES(SEQ_APPLY.NEXTVAL, 1, 1);
INSERT INTO TBL_APPLY
(ID, CHILD_ID, FIELD_TRIP_ID)
VALUES(SEQ_APPLY.NEXTVAL, 2, 2);
INSERT INTO TBL_APPLY
(ID, CHILD_ID, FIELD_TRIP_ID)
VALUES(SEQ_APPLY.NEXTVAL, 3, 6);
INSERT INTO TBL_APPLY
(ID, CHILD_ID, FIELD_TRIP_ID)
VALUES(SEQ_APPLY.NEXTVAL, 4, 7);
INSERT INTO TBL_APPLY
(ID, CHILD_ID, FIELD_TRIP_ID)
VALUES(SEQ_APPLY.NEXTVAL, 1, 5);
INSERT INTO TBL_APPLY
(ID, CHILD_ID, FIELD_TRIP_ID)
VALUES(SEQ_APPLY.NEXTVAL, 2, 3);
INSERT INTO TBL_APPLY
(ID, CHILD_ID, FIELD_TRIP_ID)
VALUES(SEQ_APPLY.NEXTVAL, 5, 7);
INSERT INTO TBL_APPLY
(ID, CHILD_ID, FIELD_TRIP_ID)
VALUES(SEQ_APPLY.NEXTVAL, 6, 6);
INSERT INTO TBL_APPLY
(ID, CHILD_ID, FIELD_TRIP_ID)
VALUES(SEQ_APPLY.NEXTVAL, 4, 1);
INSERT INTO TBL_APPLY
(ID, CHILD_ID, FIELD_TRIP_ID)
VALUES(SEQ_APPLY.NEXTVAL, 4, 5);
INSERT INTO TBL_APPLY
(ID, CHILD_ID, FIELD_TRIP_ID)
VALUES(SEQ_APPLY.NEXTVAL, 7, 3);

SELECT * FROM TBL_APPLY;


/*집계 함수
 * 
 * 평균 AVG()
 * 최대값 MAX()
 * 최소값 MIN()
 * 총 합 SUM()
 * 개수 COUNT()
 * 
 * */
SELECT ROUND(AVG(WEIGHT), 2) AVERAGE_WEIGHT FROM TBL_PET;
SELECT MAX(WEIGHT) FROM TBL_PET;
SELECT MIN(WEIGHT) FROM TBL_PET;
SELECT SUM(WEIGHT) FROM TBL_PET;
SELECT COUNT(*) FROM TBL_PET;

/*GROUP BY: ~별*/
SELECT PET_ILL_NAME, COUNT(*) FROM TBL_PET
GROUP BY PET_ILL_NAME;

SELECT * FROM TBL_PET;

/*실행 순서*/
/*FROM -> JOIN -> ON -> WHERE -> GROUP BY -> SELECT*/

/*주인별 동물병원에 등록한 반려동물 마리 수 조회*/
SELECT OWNER_ID, COUNT(*) FROM TBL_PET
GROUP BY OWNER_ID;

/*반려동물의 병명별 반려동물 평균 나이와 그 주인들 중 가장 나이가 많은 주인 나이 조회*/
SELECT PET_ILL_NAME, AVG(PET_AGE) , MAX(OWNER_AGE)
FROM TBL_OWNER O JOIN TBL_PET P
ON O.ID = P.OWNER_ID
GROUP BY P.PET_ILL_NAME;

/*가장 인기있는(지원을 많이 한) 체험학습의 지원자 수를 조회한다.*/
SELECT MAX(COUNT(*)) FROM TBL_APPLY
GROUP BY FIELD_TRIP_ID;

/*신청한 체험학습별 아이들의 평균 나이 조회*/
SELECT FIELD_TRIP_ID, AVG(C.CHILD_AGE)
FROM TBL_CHILD C JOIN TBL_APPLY A
ON C.ID = A.CHILD_ID
GROUP BY FIELD_TRIP_ID;

/*부모들의 평균 자녀 수*/
SELECT AVG(COUNT(*)) FROM TBL_CHILD
GROUP BY PARENT_ID;

/*각 유치원들의 체험학습 진행 건수*/
SELECT KINDERGARTEN_ID, COUNT(*) FROM TBL_FIELD_TRIP
GROUP BY KINDERGARTEN_ID;

/*유치원들의 평균 체험학습 진행 건수*/
SELECT AVG(COUNT(*)) FROM TBL_FIELD_TRIP
GROUP BY KINDERGARTEN_ID;

/*각 유치원들의 체험학습 지원 건수*/
SELECT KINDERGARTEN_ID, COUNT(A.FIELD_TRIP_ID) 
FROM TBL_FIELD_TRIP F JOIN TBL_APPLY A
ON F.ID = A.FIELD_TRIP_ID
GROUP BY KINDERGARTEN_ID;

CREATE SEQUENCE SEQ_MEMBER;
CREATE SEQUENCE SEQ_LIKE;

CREATE TABLE TBL_MEMBER(
	ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
	MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE NOT NULL,
	MEMBER_PASSWORD VARCHAR2(255) NOT NULL,
	MEMBER_NAME VARCHAR2(255) NOT NULL,
	MEMBER_ADDRESS VARCHAR2(255) NOT NULL,
	MEMBER_EMAIL VARCHAR2(255),
	MEMBER_BIRTH DATE
);

CREATE TABLE TBL_LIKE(
	ID NUMBER CONSTRAINT PK_LIKE PRIMARY KEY,
	LIKE_RECEIVER NUMBER NOT NULL,
	LIKE_SENDER NUMBER NOT NULL,
	CONSTRAINT FK_LIKE_MEMBER_RECEIVER FOREIGN KEY(LIKE_RECEIVER)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_LIKE_MEMBER_SENDER FOREIGN KEY(LIKE_SENDER)
	REFERENCES TBL_MEMBER(ID)
);

/*2. 정보 추가*/
INSERT INTO TBL_MEMBER
(ID, MEMBER_ID, MEMBER_PASSWORD, MEMBER_NAME, MEMBER_ADDRESS, MEMBER_EMAIL, MEMBER_BIRTH)
VALUES(SEQ_MEMBER.NEXTVAL, 'hds', '1234', '한동석', '경기도', 'test1@gami.com', '2000-12-04');
INSERT INTO TBL_MEMBER
(ID, MEMBER_ID, MEMBER_PASSWORD, MEMBER_NAME, MEMBER_ADDRESS, MEMBER_EMAIL, MEMBER_BIRTH)
VALUES(SEQ_MEMBER.NEXTVAL, 'hgd', '1111', '홍길동', '서울', 'test2@gami.com', '1900-11-04');
INSERT INTO TBL_MEMBER
(ID, MEMBER_ID, MEMBER_PASSWORD, MEMBER_NAME, MEMBER_ADDRESS, MEMBER_EMAIL, MEMBER_BIRTH)
VALUES(SEQ_MEMBER.NEXTVAL, 'lss', '2222', '이순신', '대구', 'test3@gami.com', '1800-07-04');
INSERT INTO TBL_MEMBER
(ID, MEMBER_ID, MEMBER_PASSWORD, MEMBER_NAME, MEMBER_ADDRESS, MEMBER_EMAIL, MEMBER_BIRTH)
VALUES(SEQ_MEMBER.NEXTVAL, 'jbg', '3333', '장보고', '청주', 'test4@gami.com', '2010-08-04');

SELECT * FROM TBL_MEMBER;

INSERT INTO TBL_LIKE
(ID, LIKE_RECEIVER, LIKE_SENDER)
VALUES(SEQ_LIKE.NEXTVAL, 1, 2);
INSERT INTO TBL_LIKE
(ID, LIKE_RECEIVER, LIKE_SENDER)
VALUES(SEQ_LIKE.NEXTVAL, 1, 3);
INSERT INTO TBL_LIKE
(ID, LIKE_RECEIVER, LIKE_SENDER)
VALUES(SEQ_LIKE.NEXTVAL, 1, 4);
INSERT INTO TBL_LIKE
(ID, LIKE_RECEIVER, LIKE_SENDER)
VALUES(SEQ_LIKE.NEXTVAL, 2, 2);
INSERT INTO TBL_LIKE
(ID, LIKE_RECEIVER, LIKE_SENDER)
VALUES(SEQ_LIKE.NEXTVAL, 2, 1);
INSERT INTO TBL_LIKE
(ID, LIKE_RECEIVER, LIKE_SENDER)
VALUES(SEQ_LIKE.NEXTVAL, 3, 4);
INSERT INTO TBL_LIKE
(ID, LIKE_RECEIVER, LIKE_SENDER)
VALUES(SEQ_LIKE.NEXTVAL, 3, 2);

SELECT * FROM TBL_LIKE;

/*회원 별 좋아요 수 조회하기(이름까지 조회)*/
SELECT * FROM TBL_LIKE;

SELECT MEMBER_ID, COUNT(*) 
FROM TBL_MEMBER M JOIN TBL_LIKE L
ON M.ID = LIKE_RECEIVER
GROUP BY LIKE_RECEIVER, MEMBER_ID;

/*회원 별 좋아요 수가 3보다 작은 것만 조회하기*/
SELECT MEMBER_NAME, COUNT(*) 
FROM TBL_MEMBER M JOIN TBL_LIKE L
ON M.ID = LIKE_RECEIVER
GROUP BY LIKE_RECEIVER, MEMBER_NAME
HAVING COUNT(*) < 3;

SELECT MEMBER_NAME, LIKE_COUNT
FROM
(
	SELECT MEMBER_NAME, COUNT(*) LIKE_COUNT
	FROM TBL_MEMBER M JOIN TBL_LIKE L
	ON M.ID = LIKE_RECEIVER
	GROUP BY LIKE_RECEIVER, MEMBER_NAME
)
WHERE LIKE_COUNT < 3;

/*
 * ORDER BY : 정렬
 * 
 * ASC : 오름차순(생략 가능)
 * DESC : 내림차순
 * 
 * 
 * SQL 실행 순서
 * 
 * FROM > JOIN > ON > WHERE > GROUP BY > HAVING > SELECT > ORDER BY
 * 
 * 
 * */




/*
 * 서브 쿼리
 * 
 * 메인 쿼리 안에 또 다른 쿼리를 작성하는 문법.
 * FROM절 : 인라인 뷰
 * WHERE절 : 서브 쿼리
 * SELECT절 : 스칼라 서브 쿼리
 * */

/* 좋아요가 가장 많은 회원 정보 조회*/
/* 회원 정보 조회 */
/* 좋아요가 가장 많음. */
/* 좋아요를 조회*/


SELECT * FROM TBL_MEMBER
WHERE ID =
(
   SELECT LIKE_RECEIVER
   FROM TBL_LIKE
   GROUP BY LIKE_RECEIVER
   HAVING COUNT(LIKE_SENDER) = 
   (
      SELECT MAX(COUNT(LIKE_SENDER)) 
      FROM TBL_LIKE
      GROUP BY LIKE_RECEIVER
   )
);

SELECT * FROM TBL_MEMBER M1
JOIN (
   SELECT LIKE_RECEIVER, COUNT(LIKE_SENDER) LIKE_COUNT
   FROM TBL_LIKE
   GROUP BY LIKE_RECEIVER
) M2
ON M1.ID = M2.LIKE_RECEIVER 
AND
LIKE_COUNT = 
(
   SELECT MAX(COUNT(LIKE_SENDER)) 
   FROM TBL_LIKE
   GROUP BY LIKE_RECEIVER
);

/* 지역별 평균 나이와 전체 평균 나이 조회*/
/*
 * 멤버들 지역 조회 / 나이 조회
 * */

SELECT MEMBER_ADDRESS, MEMBER_AGE, 
(
SELECT AVG(MEMBER_AGE)
FROM(SELECT ROUND((SYSDATE - MEMBER_BIRTH)/365) MEMBER_AGE FROM TBL_MEMBER)
) AVERAGE_AGE 
FROM TBL_MEMBER M1
JOIN (
SELECT ID, ROUND((SYSDATE - MEMBER_BIRTH)/365) MEMBER_AGE FROM TBL_MEMBER
) M2
ON M1.ID = M2.ID;



/* 전체 평균 나이*/
SELECT MEMBER_ADDRESS, AVG(ROUND((SYSDATE - MEMBER_BIRTH) / 365, 0)) AGE,
(
   SELECT AVG(ROUND((SYSDATE - MEMBER_BIRTH) / 365, 0))
   FROM TBL_MEMBER
) AVERAGE_AGE
FROM TBL_MEMBER
GROUP BY MEMBER_ADDRESS;

/*=============================================================================================================*/
CREATE TABLE TBL_ORDER(
   ID NUMBER CONSTRAINT PK_ORDER PRIMARY KEY,
   PRODUCT_NAME VARCHAR2(1000) NOT NULL,
   PRODUCT_PRICE NUMBER DEFAULT 0,
   MEMBER_AGE NUMBER
);

INSERT INTO TBL_ORDER
VALUES(1, '지우개', 1000, 20);
INSERT INTO TBL_ORDER
VALUES (2, '지우개', 3000, 30);
INSERT INTO TBL_ORDER
VALUES (3, '지우개', 4000, 40);
INSERT INTO TBL_ORDER
VALUES (4, '지우개', 1000, 40);
INSERT INTO TBL_ORDER
VALUES (5, '지우개', 5000, 20);
INSERT INTO TBL_ORDER
VALUES (6, '지우개', 2000, 20);
INSERT INTO TBL_ORDER
VALUES (7, '지우개', 5000, 30);
INSERT INTO TBL_ORDER
VALUES (8, '지우개', 9000, 30);
INSERT INTO TBL_ORDER
VALUES (9, '지우개', 2000, 50);
INSERT INTO TBL_ORDER
VALUES (10, '지우개', 1000, 10);

SELECT * FROM TBL_ORDER;

/* 20대 중에서 구매 가격이 2000원을 넘는 주문번호, 상품가격, 연령 조회*/

/* 20대 조회*/

SELECT ID,PRODUCT_PRICE ,MEMBER_AGE  FROM TBL_ORDER O
WHERE FLOOR(O.MEMBER_AGE/10)=2 AND O.PRODUCT_PRICE  > 2000;

/*20대 조회*/
SELECT * FROM TBL_ORDER WHERE FLOOR(MEMBER_AGE/10)=2;
/* 2000원 초과 조회*/
SELECT * FROM TBL_ORDER WHERE PRODUCT_PRICE > 2000;


SELECT ID,PRODUCT_PRICE,MEMBER_AGE 
FROM
(
SELECT * FROM TBL_ORDER WHERE FLOOR(MEMBER_AGE/10)=2 /* BETWEEN A AND B 이상 이하*/
)
WHERE PRODUCT_PRICE > 2000;

/* A=B OR A=C
 * 
 * 
 * A IN(B,C) A가 B 또는 C 일때, TRUE, B,C에는 서브쿼리도 들어갈 수 있음.
 * 
 * */

/* 상품 가격이 2000원이 넘는 상품의 결과로 ID조회, 이 ID로 MEMBER_AGE 조회 */

SELECT ID FROM TBL_ORDER WHERE PRODUCT_PRICE > 2000;

SELECT MEMBER_AGE
FROM TBL_ORDER O
WHERE O.ID IN(SELECT ID FROM TBL_ORDER WHERE PRODUCT_PRICE > 2000);

/*==========================================================================*/

/****************************************************************/
CREATE SEQUENCE SEQ_USER;

CREATE TABLE TBL_USER(
   ID NUMBER CONSTRAINT PK_USER PRIMARY KEY,
   USER_ID VARCHAR2(1000) UNIQUE NOT NULL,
   USER_PW VARCHAR2(1000) NOT NULL,
   USER_ADDRESS VARCHAR2(1000),
   USER_EMAIL VARCHAR2(1000) UNIQUE NOT NULL,
   USER_BIRTH DATE
);

CREATE SEQUENCE SEQ_POST;

CREATE TABLE TBL_POST(
   ID NUMBER CONSTRAINT PK_POST PRIMARY KEY,
   POST_TITLE VARCHAR2(1000) NOT NULL,
   POST_CONTENT VARCHAR2(1000) NOT NULL,
   POST_CREATED_DATE DATE DEFAULT CURRENT_TIMESTAMP,
   USER_ID NUMBER,
   CONSTRAINT FK_POST_USER FOREIGN KEY(USER_ID)
   REFERENCES TBL_USER(ID)
);

CREATE SEQUENCE SEQ_REPLY;

CREATE TABLE TBL_REPLY(
   ID NUMBER CONSTRAINT PK_REPLY PRIMARY KEY,
   REPLY_CONTENT VARCHAR2(1000) NOT NULL,
   USER_ID NUMBER,
   POST_ID NUMBER,
   CONSTRAINT FK_REPLY_USER FOREIGN KEY(USER_ID)
   REFERENCES TBL_USER(ID),
   CONSTRAINT FK_REPLY_POST FOREIGN KEY(POST_ID)
   REFERENCES TBL_POST(ID)
);


INSERT INTO TBL_USER
VALUES(SEQ_USER.NEXTVAL, 'hds1234', '1234', '서울시 강남구', 'tedhan1204@gmail.com', '2000-12-04');
INSERT INTO TBL_USER
VALUES(SEQ_USER.NEXTVAL, 'lss9999', '9999', '경기도 남양주시', 'lss1234@gmail.com', '1999-01-04');
INSERT INTO TBL_USER
VALUES(SEQ_USER.NEXTVAL, 'hgd1222', '9999', '경기도 남양주시', 'hgd1222@gmail.com', '1999-01-04');

SELECT * FROM TBL_USER;

INSERT INTO TBL_POST(ID, POST_TITLE, POST_CONTENT, USER_ID)
VALUES(SEQ_POST.NEXTVAL, '테스트 제목1', '테스트 내용1', 1);
INSERT INTO TBL_POST(ID, POST_TITLE, POST_CONTENT, USER_ID)
VALUES(SEQ_POST.NEXTVAL, '테스트 제목2', '테스트 내용2', 1);
INSERT INTO TBL_POST(ID, POST_TITLE, POST_CONTENT, USER_ID)
VALUES(SEQ_POST.NEXTVAL, '테스트 제목3', '테스트 내용3', 2);

SELECT * FROM TBL_POST;

INSERT INTO TBL_REPLY
VALUES(SEQ_REPLY.NEXTVAL, '댓글 테스트1', 1, 1);
INSERT INTO TBL_REPLY
VALUES(SEQ_REPLY.NEXTVAL, '댓글 테스트2', 2, 2);
INSERT INTO TBL_REPLY
VALUES(SEQ_REPLY.NEXTVAL, '댓글 테스트1', 2, 3);
INSERT INTO TBL_REPLY
VALUES(SEQ_REPLY.NEXTVAL, '댓글 테스트1', 1, 3);
INSERT INTO TBL_REPLY
VALUES(SEQ_REPLY.NEXTVAL, '댓글 테스트1', 3, 3);

SELECT * FROM TBL_REPLY;

/* 댓글 작성자 중 게시글을 등록한 회원 조회 */
/*
 * 댓글 작성자 조회
 * 
 * 게시글 등록한 회원 조회
 * */
/* 글 작성자는 1,2*/


SELECT DISTINCT P.USER_ID FROM TBL_POST P;
SELECT DISTINCT R.USER_ID FROM TBL_REPLY R;

SELECT *
FROM TBL_USER U WHERE U.ID IN(SELECT R.USER_ID FROM TBL_REPLY R
WHERE R.USER_ID IN(SELECT P.USER_ID FROM TBL_POST P)
)
;


SELECT DISTINCT R.USER_ID FROM TBL_REPLY R
WHERE R.USER_ID IN(SELECT DISTINCT P.USER_ID FROM TBL_POST P);


SELECT * FROM TBL_PARENT;
SELECT * FROM TBL_CHILD;
SELECT * FROM TBL_KINDERGARTEN;
SELECT * FROM TBL_FIELD_TRIP;
SELECT * FROM TBL_APPLY;


/* 참가자 수가 가장 적은 체험학습의 제목과 내용 조회*/
SELECT FIELD_TRIP_TITLE, FIELD_TRIP_CONTENT,FIELD_TRIP_COUNT FROM TBL_FIELD_TRIP M1
JOIN(
SELECT FIELD_TRIP_ID, COUNT(FIELD_TRIP_ID) FIELD_TRIP_COUNT FROM TBL_APPLY
GROUP BY FIELD_TRIP_ID 
) M2
/* 체험학습 내용 + 체험학습 참가자수 가져옴 */
ON M1.ID = M2.FIELD_TRIP_ID
AND FIELD_TRIP_COUNT =
(
SELECT MIN(COUNT(FIELD_TRIP_ID))
FROM TBL_APPLY
GROUP BY FIELD_TRIP_ID
);

/* 그 중 참가자 수가 최솟값(1)과 같은 것만 골라냄.*/



SELECT FIELD_TRIP_ID, COUNT(FIELD_TRIP_ID) FIELD_TRIP_COUNT FROM TBL_APPLY
GROUP BY FIELD_TRIP_ID 
/* 중복 없이 참가자 있는 체험학습 ID 가져옴.*/

SELECT MIN(COUNT(FIELD_TRIP_ID))
FROM TBL_APPLY
GROUP BY FIELD_TRIP_ID

/* 최소 지원자는 1명*/


/* 평균 참가자수(반올림) 보다 많은 체험학습의 제목과 내용 조회*/

SELECT FIELD_TRIP_TITLE, FIELD_TRIP_CONTENT,FIELD_TRIP_COUNT, 
(
	SELECT ROUND(AVG(COUNT(FIELD_TRIP_ID))) AVG
	FROM TBL_APPLY
	GROUP BY FIELD_TRIP_ID
) AVERAGE_COUNT 
	FROM TBL_FIELD_TRIP M1
	JOIN
	(
		SELECT FIELD_TRIP_ID, COUNT(FIELD_TRIP_ID) FIELD_TRIP_COUNT FROM TBL_APPLY
		GROUP BY FIELD_TRIP_ID 
	) M2
	ON M1.ID = M2.FIELD_TRIP_ID
	AND FIELD_TRIP_COUNT >
	(
		SELECT ROUND(AVG(COUNT(FIELD_TRIP_ID))) AVG
		FROM TBL_APPLY
		GROUP BY FIELD_TRIP_ID
	);




SELECT ROUND(AVG(COUNT(FIELD_TRIP_ID))) AVG
FROM TBL_APPLY
GROUP BY FIELD_TRIP_ID;


SELECT * FROM TBL_FIELD_TRIP
WHERE ID IN
(
   SELECT FIELD_TRIP_ID
   FROM TBL_APPLY
   GROUP BY FIELD_TRIP_ID
   /* 참가자가 있는 체험학습 ID를 중복없이 가져옴*/
   HAVING COUNT(ID) >
   (
      SELECT ROUND(AVG(COUNT(*)),0) AVG
		FROM TBL_APPLY
		GROUP BY FIELD_TRIP_ID
   )
);

SELECT ROUND(AVG(COUNT(*))) AVG
		FROM TBL_APPLY
		GROUP BY FIELD_TRIP_ID
/* 반올림한 평균*/

SELECT * FROM TBL_APPLY;
SELECT * FROM TBL_FIELD_TRIP;


/*트랜잭션 예시*/
SELECT * FROM TBL_MEMBER;

UPDATE TBL_MEMBER
SET MEMBER_ID = 'test'
WHERE ID = 1;

COMMIT;
ROLLBACK;


/*체험학습을 2개 이상 신청한 아이의 부모 이름, 아이번호와 이름과 지원한 횟수 조회
단, 모든 부모의 이름 조회*/
SELECT * FROM TBL_APPLY

/* 각 어린이가 신청한 횟수*/
SELECT CHILD_ID, COUNT(CHILD_ID) TRIP_COUNT FROM TBL_APPLY
GROUP BY CHILD_ID;  

SELECT P.ID, P.PARENT_NAME, C.CHILD_NAME, C.ID, C.CHILD_ID FROM TBL_PARENT P LEFT OUTER JOIN TBL_CHILD C
ON P.ID = C.CHILD_ID 
LEFT OUTER JOIN (
SELECT CHILD_ID, COUNT(CHILD_ID) TRIP_COUNT FROM TBL_APPLY
GROUP BY CHILD_ID
) M2
ON C.ID = M2.CHILD_ID
WHERE TRIP_COUNT >= 2



SELECT P.ID, P.PARENT_NAME, M3.CHILD_ID FROM TBL_PARENT P LEFT OUTER JOIN(
SELECT C.CHILD_ID FROM TBL_CHILD C 
LEFT OUTER JOIN (
SELECT CHILD_ID, COUNT(CHILD_ID) TRIP_COUNT FROM TBL_APPLY
GROUP BY CHILD_ID
) M2
ON C.ID = M2.CHILD_ID
WHERE TRIP_COUNT >= 2
) M3
ON P.ID = M3.CHILD_ID



SELECT P.ID, P.PARENT_NAME, M3.CHILD_ID, M3.CHILD_NAME, M3.TRIP_COUNT FROM TBL_PARENT P 
LEFT OUTER JOIN(
SELECT C.ID, C.CHILD_NAME, C.CHILD_ID, TRIP_COUNT  FROM TBL_CHILD C 
JOIN (
SELECT CHILD_ID, COUNT(CHILD_ID) TRIP_COUNT FROM TBL_APPLY
GROUP BY CHILD_ID
) M2
/* 아이의 ID(C.ID) 와 신청 횟수 전체*/
ON C.ID = M2.CHILD_ID
WHERE TRIP_COUNT >= 2
) M3
/* 아이의 ID(C.ID), 이름, 부모님 ID(P.ID = C.CHILD_ID), 지원 횟수 */
ON P.ID = M3.CHILD_ID



SELECT P.ID, P.PARENT_NAME, M3.C_NUMBER, M3.CHILD_NAME, NVL(M3.TRIP_COUNT, 0) FROM TBL_PARENT P 
LEFT OUTER JOIN(
SELECT C.ID C_NUMBER, C.CHILD_NAME, C.CHILD_ID, TRIP_COUNT  FROM TBL_CHILD C 
JOIN (
SELECT CHILD_ID, COUNT(CHILD_ID) TRIP_COUNT FROM TBL_APPLY
GROUP BY CHILD_ID
HAVING COUNT(CHILD_ID) >= 2
) M2
/* 아이의 ID(C.ID) 와 신청 횟수 전체*/
ON C.ID = M2.CHILD_ID
) M3
/* 아이의 ID(C.ID), 이름, 부모님 ID(P.ID = C.CHILD_ID), 지원 횟수 */
ON P.ID = M3.CHILD_ID
ORDER BY ID;


CREATE VIEW VIEW_APPLY_COUNT AS
(
SELECT P.ID, P.PARENT_NAME, M3.C_NUMBER, M3.CHILD_NAME, NVL(M3.TRIP_COUNT, 0) APPLY_COUNT FROM TBL_PARENT P 
LEFT OUTER JOIN(
SELECT C.ID C_NUMBER, C.CHILD_NAME, C.CHILD_ID, TRIP_COUNT  FROM TBL_CHILD C 
JOIN (
SELECT CHILD_ID, COUNT(CHILD_ID) TRIP_COUNT FROM TBL_APPLY
GROUP BY CHILD_ID
HAVING COUNT(CHILD_ID) >= 2
) M2
ON C.ID = M2.CHILD_ID
) M3
ON P.ID = M3.CHILD_ID
);







