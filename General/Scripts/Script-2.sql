
-- 아이디, 비밀번호, 이름, 이메일, 가입일
CREATE TABLE KH_MEMBER(
	MEMBER_ID VARCHAR2(10) PRIMARY KEY, 
	MEMBER_PW VARCHAR2(20) NOT NULL,
	MEMBER_NAME VARCHAR2(15) NOT NULL,
	EMAIL VARCHAR2(50),
	ENDOLLDATE DATE DEFAULT SYSDATE
);

INSERT INTO KH_MEMBER VALUES
('admin',  1234, '짱구', 'kh01@kh.com', DEFAULT);
INSERT INTO KH_MEMBER VALUES
('user01', 1234, '맹구', 'kh02@kh.com', DEFAULT);
INSERT INTO KH_MEMBER VALUES
('user02', 1234, '유리', 'kh03@kh.com', DEFAULT);

SELECT * FROM KH_MEMBER;





CREATE SEQUENCE SEQ_KH_BOARD;

CREATE TABLE KH_BOARD(
 	BOARD_NO NUMBER PRIMARY KEY,
 	BOARD_CATEGORY VARCHAR2(20) NOT NULL,
 	BOARD_WRITER VARCHAR2(20) REFERENCES KH_MEMBER,
 	BOARD_TITLE VARCHAR2(300) NOT NULL,
 	BOARD_CONTENT VARCHAR2(4000) NOT NULL,
 	COUNT NUMBER DEFAULT 0,
 	CREATE_DATE DATE DEFAULT SYSDATE
);

SELECT * FROM  KH_BOARD;


ALTER TABLE KH_MEMBER MODIFY MEMBER_PW VARCHAR2(60);

UPDATE 	
		KH_MEMBER 
	SET 	
		MEMBER_PW = '$2a$10$SlVRwvdiRJoQd/BYTcWcieUpxx.g8yM1O87TQCDMAZd/lB5yMN7IC';

COMMIT;

SELECT *FROM  KH_MEMBER ;



-- 게시글용 테이블 구현하기
-- 파일첨부 기능 구현할 것 + 댓글 기등 구현할 것

-- 글번호
 -- 글 제목
 -- 작성자
 -- 조회수
 -- 작성일 


CREATE TABLE TB_SPRING_BOARD(
	BOARD_NO NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
	BOARD_TITLE VARCHAR2(200) NOT NULL,
	BOARD_CONTENT VARCHAR2(4000) NOT NULL,
	BOARD_WRITER VARCHAR2(10) NOT NULL REFERENCES KH_MEMBER,
	COUNT NUMBER DEFAULT 0 NOT NULL,
	CREATE_DATE TIMESTAMP DEFAULT SYSDATE NOT NULL,
	CHANGE_NAME VARCHAR2(200),
  STATUS CHAR(1) DEFAULT 'Y' CHECK (STATUS IN ('Y', 'N'))
);




DROP TABLE TB_SPRING_BOARD;
INSERT INTO TB_SPRING_BOARD(BOARD_TITLE, BOARD_WRITER)
VALUES('첫 번째 글', 'admin');

SELECT * FROM TB_SPRING_BOARD;

	-- PK(식별값)
	-- 작성자
	-- 내용
	-- 작성일
	-- 어떤 게시글에 달려있는가

CREATE TABLE TB_REPLY(
	
	REPLY_NO NUMBER PRIMARY KEY,
	REPLY_WRITER VARCHAR(10) NOT NULL REFERENCES KH_MEMBER,
	REPLY_CONTENT VARCHAR2(500) NOT NULL,
	CREATE_DATE DATE DEFAULT SYSDATE,
	REF_BOARD_NO NUMBER NOT NULL REFERENCES TB_SPRING_BOARD
);

DROP TABLE TB_REPLY;
CREATE SEQUENCE SEQ_RNO;

INSERT INTO TB_REPLY
VALUES (SEQ_RNO.NEXTVAL, 'admin', '할루', SYSDATE, 21);

COMMIT;


SELECT	
			BOARD_NO boardNo
		, BOARD_TITLE boardTitle
		, BOARD_CONTENT boardContent
		,	BOARD_WRITER boardWriter
		, TB_SPRING_BOARD.CREATE_DATE createDate
		, CHANGE_NAME changeName
		,	REPLY_WRITER replyWriter
		, REPLY_NO replyNo
		, REPLY_CONTENT replyContent
		, REF_BOARD_NO refBoardNo
		, TB_REPLY.CREATE_DATE	createDate
		
	FROM
			TB_SPRING_BOARD
	JOIN
		TB_REPLY ON (BOARD_NO = REF_BOARD_NO)
	
	WHERE 
		BOARD_NO = 2;


SELECT 
	BOARD_NO,
	BOARD_TITLE,
	BOARD_WRITER
FROM	
	TB_SPRING_BOARD 
WHERE 	STATUS='Y'
	
	AND 
		-- BOARD_WRITER ='admin'
		-- BOARD_WRITER LIKE '%ad%'
		-- BOARD_TITLE LIKE '%마%'
		BOARD_CONTENT  LIKE '%하%'
ORDER
   BY 	BOARD_NO 	DESC;


SELECT * FROM TB_SPRING_BOARD ;


-----------------------------------------------

CREATE TABLE TB_COMMENTS(
	CONTENT VARCHAR2(1000) NOT NULL,
	CREATE_DATE DATE DEFAULT SYSDATE,
	UC_SEQ NUMBER NOT NULL
)




































