PROMPT FITNESSGROUND 자료입력시작

SET FEEDBACK ON;
SET DEFINE ON;

-- 유저 테이블
DROP TABLE TB_USER CASCADE CONSTRAINTS;
PROMPT DROPPING TB_USER TABLE..

-- 헬스장 테이블
DROP TABLE TB_GYM CASCADE CONSTRAINTS;
PROMPT DROPPING TB_GYM TABLE..

-- 헬스장 일정 테이블
DROP TABLE TB_GYM_SCHEDULE CASCADE CONSTRAINTS;
PROMPT DROPPING TB_GYM_SCHEDULE TABLE..

-- 헬스장 후기 테이블
DROP TABLE TB_GYM_COMMENT CASCADE CONSTRAINTS;
PROMPT DROPPING TB_GYM_COMMENT TABLE..

-- 운동법 동영상 테이블
DROP TABLE TB_VIDEO_BOARD CASCADE CONSTRAINTS;
PROMPT DROPPING TB_VIDEO_BOARD TABLE..

-- 운동법 동영상 댓글 테이블
DROP TABLE TB_VB_COMMENT CASCADE CONSTRAINTS;
PROMPT DROPPING TB_VB_COMMENT TABLE..

-- 커뮤니티 게시판(운동하자)
DROP TABLE TB_MEETING_BOARD CASCADE CONSTRAINTS;
PROMPT DROPPING TB_MEETING_BOARD TABLE..

-- 커뮤니티 게시판 댓글(운동하자)
DROP TABLE TB_MB_COMMENT CASCADE CONSTRAINTS;
PROMPT DROPPING TB_MB_COMMENT TABLE..

-- 커뮤니티 게시판(후기, QNA)
DROP TABLE TB_COM_BOARD CASCADE CONSTRAINTS;
PROMPT DROPPING TB_COM_BOARD TABLE..

-- 커뮤니티 게시판 댓글(후기, QNA)
DROP TABLE TB_CB_COMMENT CASCADE CONSTRAINTS;
PROMPT DROPPING TB_CB_COMMENT TABLE..

-- 마이페이지 스케줄러 테이블
DROP TABLE TB_MYPAGE_SCHEDULE CASCADE CONSTRAINTS;
PROMPT DROPPING TB_MYPAGE_SCHEDULE TABLE..

-- 문의하기 테이블
DROP TABLE TB_QNA CASCADE CONSTRAINTS;
PROMPT DROPPING TB_QNA TABLE..

-- 좋아요 테이블
DROP TABLE TB_LIKE CASCADE CONSTRAINTS;
PROMPT DROPPING TB_LIKE TABLE..




-- 유저 테이블 생성
PROMPT CREATING USER TABLE..
CREATE TABLE TB_USER(
  USER_NO NUMBER CONSTRAINT PK_USER PRIMARY KEY,
  EMAIL VARCHAR2(30) NOT NULL,
  PWD VARCHAR2(4000) NOT NULL,
  NAME VARCHAR2(30) NOT NULL,
  NICKNAME VARCHAR2(30) NOT NULL,
  PHONE VARCHAR2(20) NOT NULL,
  USER_LEVEL NUMBER DEFAULT 0,
  DELETE_DATE DATE DEFAULT NULL,
  TMPPWD_TF NUMBER DEFAULT 0,
  ORIGINAL_IMAGE VARCHAR2(4000),
  RENAME_IMAGE VARCHAR2(4000)
);
COMMENT ON COLUMN TB_USER.USER_NO IS '유저번호';
COMMENT ON COLUMN TB_USER.EMAIL IS '이메일';
COMMENT ON COLUMN TB_USER.PWD IS '비밀번호';
COMMENT ON COLUMN TB_USER.NAME IS '이름';
COMMENT ON COLUMN TB_USER.NICKNAME IS '닉네임';
COMMENT ON COLUMN TB_USER.PHONE IS '전화번호';
COMMENT ON COLUMN TB_USER.USER_LEVEL IS '권한 0=일반/1=사업자/2=관리자';
COMMENT ON COLUMN TB_USER.DELETE_DATE IS '삭제예정일';
COMMENT ON COLUMN TB_USER.TMPPWD_TF IS '임시비밀번호 여부';
COMMENT ON COLUMN TB_USER.ORIGINAL_IMAGE IS '원래 이미지명';
COMMENT ON COLUMN TB_USER.RENAME_IMAGE IS '바뀐 이미지명';


-- 헬스장 테이블 생성
PROMPT CREATING GYM TABLE..
CREATE TABLE TB_GYM(
  GYM_NO NUMBER CONSTRAINT PK_GYM PRIMARY KEY,
  GYM_NAME VARCHAR2(60) NOT NULL, -- 30에서 60으로 수정
  ORIGINAL_IMAGE VARCHAR2(4000),
  RENAME_IMAGE VARCHAR2(4000),
  OP_TIME VARCHAR2(100) NOT NULL,
  TEL VARCHAR2(30) NOT NULL,
  PHONE VARCHAR2(30) NOT NULL,
  PRICE VARCHAR2(500),
  CATEGORY VARCHAR2(100) NOT NULL,
  DESCRIPTION VARCHAR(4000),
  LOCATION VARCHAR2(100) NOT NULL,
  USER_NO NUMBER NOT NULL,
  DELETE_DATE DATE DEFAULT NULL,
  APPROVAL_STATE NUMBER DEFAULT 0
);
COMMENT ON COLUMN TB_GYM.GYM_NO IS '헬스장번호';
COMMENT ON COLUMN TB_GYM.GYM_NAME IS '헬스장이름';
COMMENT ON COLUMN TB_GYM.ORIGINAL_IMAGE IS '원래 이미지 이름';
COMMENT ON COLUMN TB_GYM.RENAME_IMAGE IS '바뀐 이미지 이름';
COMMENT ON COLUMN TB_GYM.OP_TIME IS '헬스장 운영시간';
COMMENT ON COLUMN TB_GYM.TEL IS '헬스장번호';
COMMENT ON COLUMN TB_GYM.PHONE IS '핸드폰번호';
COMMENT ON COLUMN TB_GYM.PRICE IS '월회비';
COMMENT ON COLUMN TB_GYM.CATEGORY IS '헬스 카테고리';
COMMENT ON COLUMN TB_GYM.DESCRIPTION IS '헬스장 소개';
COMMENT ON COLUMN TB_GYM.LOCATION IS '헬스장 위치';
COMMENT ON COLUMN TB_GYM.USER_NO IS '사업자 번호';
COMMENT ON COLUMN TB_GYM.DELETE_DATE IS '삭제 예정일';
COMMENT ON COLUMN TB_GYM.APPROVAL_STATE IS '헬스장등록 승인여부';

ALTER TABLE TB_GYM
  ADD CONSTRAINT FK1_GYM FOREIGN KEY(USER_NO) REFERENCES TB_USER;

 
-- 헬스장 일정 테이블 생성
PROMPT CREATING GYM_SCHEDULE TABLE..
CREATE TABLE TB_GYM_SCHEDULE(
  GS_NO NUMBER CONSTRAINT PK_GS PRIMARY KEY,
  GYM_NO NUMBER NOT NULL,
  DAY_TIME DATE NOT NULL,
  TITLE VARCHAR2(20) NOT NULL
);
COMMENT ON COLUMN TB_GYM_SCHEDULE.GS_NO IS '헬스장 일정 번호';
COMMENT ON COLUMN TB_GYM_SCHEDULE.GYM_NO IS '헬스장 번호';
COMMENT ON COLUMN TB_GYM_SCHEDULE.DAY_TIME IS '헬스장 일정';
COMMENT ON COLUMN TB_GYM_SCHEDULE.TITLE IS '헬스장 일정 이름';

ALTER TABLE TB_GYM_SCHEDULE
  ADD CONSTRAINT FK1_GS FOREIGN KEY(GYM_NO) REFERENCES TB_GYM;
  
  
-- 헬스장 후기 테이블 생성
PROMPT CREATING GYM_COMMENT TABLE..
CREATE TABLE TB_GYM_COMMENT(
  GC_NO NUMBER CONSTRAINT PK_GC PRIMARY KEY,
  GYM_NO NUMBER NOT NULL,
  CONTENT VARCHAR2(1000) NOT NULL,
  RATING NUMBER NOT NULL,
  ORIGINAL_IMAGE VARCHAR2(4000),
  RENAME_IMAGE VARCHAR2(4000)
);
COMMENT ON COLUMN TB_GYM_COMMENT.GC_NO IS '헬스장 후기 번호';
COMMENT ON COLUMN TB_GYM_COMMENT.GYM_NO IS '헬스장 번호';
COMMENT ON COLUMN TB_GYM_COMMENT.CONTENT IS '헬스장 후기 내용';
COMMENT ON COLUMN TB_GYM_COMMENT.RATING IS '헬스장 후기 별점';
COMMENT ON COLUMN TB_GYM_COMMENT.ORIGINAL_IMAGE IS '원래 이미지 이름';
COMMENT ON COLUMN TB_GYM_COMMENT.RENAME_IMAGE IS '바뀐 이미지 이름';

ALTER TABLE TB_GYM_COMMENT
  ADD CONSTRAINT FK1_GC FOREIGN KEY(GYM_NO) REFERENCES TB_GYM;
  
  
-- 운동법 동영상 테이블 생성
PROMPT CREATING VIDEO_BOARD TABLE...
CREATE TABLE TB_VIDEO_BOARD(
  V_NO NUMBER CONSTRAINT PK_VB PRIMARY KEY,
  TITLE VARCHAR2(300) NOT NULL,
  CONTENT VARCHAR2(4000) NOT NULL,
  CATEGORY1 VARCHAR2(100) NOT NULL,
  CATEGORY2 VARCHAR2(100) NOT NULL,
  URL VARCHAR2(4000) NOT NULL,
  READCOUNT NUMBER DEFAULT 0
);
COMMENT ON COLUMN TB_VIDEO_BOARD.V_NO IS '운동법 번호';
COMMENT ON COLUMN TB_VIDEO_BOARD.TITLE IS '운동법 이름';
COMMENT ON COLUMN TB_VIDEO_BOARD.CONTENT IS '운동법 내용';
COMMENT ON COLUMN TB_VIDEO_BOARD.CATEGORY1 IS '운동법 분류1';
COMMENT ON COLUMN TB_VIDEO_BOARD.CATEGORY2 IS '운동법 분류2';
COMMENT ON COLUMN TB_VIDEO_BOARD.URL IS '동영상 URL';
COMMENT ON COLUMN TB_VIDEO_BOARD.READCOUNT IS '조회수';


-- 운동법 동영상 댓글 테이블 생성
PROMPT CREATING VB_COMMENT TABLE...
CREATE TABLE TB_VB_COMMENT(
  VB_NO NUMBER CONSTRAINT PK_VBC PRIMARY KEY,
  V_NO NUMBER NOT NULL,
  USER_NO NUMBER NOT NULL,
  CONTENT VARCHAR2(1000) NOT NULL,
  REPLY_DATE DATE DEFAULT SYSDATE
);
COMMENT ON COLUMN TB_VB_COMMENT.VB_NO IS '운동법 댓글 번호';
COMMENT ON COLUMN TB_VB_COMMENT.V_NO IS '운동법 번호';
COMMENT ON COLUMN TB_VB_COMMENT.USER_NO IS '작성자';
COMMENT ON COLUMN TB_VB_COMMENT.CONTENT IS '댓글 내용';
COMMENT ON COLUMN TB_VB_COMMENT.REPLY_DATE IS '작성일자';

ALTER TABLE TB_VB_COMMENT
  ADD CONSTRAINT FK1_VBC FOREIGN KEY(V_NO) REFERENCES TB_VIDEO_BOARD;
ALTER TABLE TB_VB_COMMENT
  ADD CONSTRAINT FK2_VBC FOREIGN KEY(USER_NO) REFERENCES TB_USER;
  

-- 커뮤니티 게시판(운동모임) 테이블 생성
PROMPT CREATING MEETING_BOARD TABLE...
CREATE TABLE TB_MEETING_BOARD(
  MB_NO NUMBER CONSTRAINT PK_MB PRIMARY KEY,
  USER_NO NUMBER,
  TITLE VARCHAR2(200) NOT NULL,
  CONTENT VARCHAR2(4000) NOT NULL,
  MEETING_DATE DATE,
  UPLOAD_DATE DATE DEFAULT SYSDATE,
  READCOUNT NUMBER DEFAULT 0
);
COMMENT ON COLUMN TB_MEETING_BOARD.MB_NO IS '운동모임 게시글 번호';
COMMENT ON COLUMN TB_MEETING_BOARD.USER_NO IS '작성자';
COMMENT ON COLUMN TB_MEETING_BOARD.TITLE IS '게시글 제목';
COMMENT ON COLUMN TB_MEETING_BOARD.CONTENT IS '게시글 내용';
COMMENT ON COLUMN TB_MEETING_BOARD.MEETING_DATE IS '모임날짜';
COMMENT ON COLUMN TB_MEETING_BOARD.UPLOAD_DATE IS '작성일자';
COMMENT ON COLUMN TB_MEETING_BOARD.READCOUNT IS '조회수';

ALTER TABLE TB_MEETING_BOARD
  ADD CONSTRAINT FK1_MB FOREIGN KEY(USER_NO) REFERENCES TB_USER;
  

-- 커뮤니티 게시판(운동모임) 댓글 테이블 생성
PROMPT CREATING MB_COMMENT TABLE...
CREATE TABLE TB_MB_COMMENT(
  MBC_NO NUMBER CONSTRAINT PK_MBC PRIMARY KEY,
  MB_NO NUMBER NOT NULL, 
  CONTENT VARCHAR2(1000) NOT NULL,
  USER_NO NUMBER NOT NULL,
  REPLY_DATE DATE DEFAULT SYSDATE
);
COMMENT ON COLUMN TB_MB_COMMENT.MBC_NO IS '운동모임 게시판 댓글 번호';
COMMENT ON COLUMN TB_MB_COMMENT.MB_NO IS '운동모임 게시글 번호';
COMMENT ON COLUMN TB_MB_COMMENT.CONTENT IS '댓글 내용';
COMMENT ON COLUMN TB_MB_COMMENT.USER_NO IS '작성자';
COMMENT ON COLUMN TB_MB_COMMENT.REPLY_DATE IS '작성일자';

ALTER TABLE TB_MB_COMMENT
  ADD CONSTRAINT FK1_MBC FOREIGN KEY(MB_NO) REFERENCES TB_MEETING_BOARD;
ALTER TABLE TB_MB_COMMENT
  ADD CONSTRAINT FK2_MBC FOREIGN KEY(USER_NO) REFERENCES TB_USER;
  

-- 커뮤니티 게시판(후기,QNA) 테이블 생성
PROMPT CREATING COM_BOARD TABLE...
CREATE TABLE TB_COM_BOARD(
  CB_NO NUMBER CONSTRAINT PK_CB PRIMARY KEY,
  USER_NO NUMBER,
  TITLE VARCHAR2(200) NOT NULL,
  CONTENT VARCHAR2(4000) NOT NULL,
  BOARD_PROPERTY NUMBER,
  UPLOAD_DATE DATE DEFAULT SYSDATE,
  READCOUNT NUMBER DEFAULT 0
);
COMMENT ON COLUMN TB_COM_BOARD.CB_NO IS '커뮤니티게시글 번호';
COMMENT ON COLUMN TB_COM_BOARD.USER_NO IS '작성자';
COMMENT ON COLUMN TB_COM_BOARD.TITLE IS '게시글 제목';
COMMENT ON COLUMN TB_COM_BOARD.CONTENT IS '게시글 내용';
COMMENT ON COLUMN TB_COM_BOARD.BOARD_PROPERTY IS '게시판특성 0=후기/1=QNA';
COMMENT ON COLUMN TB_COM_BOARD.UPLOAD_DATE IS '작성일자';
COMMENT ON COLUMN TB_COM_BOARD.READCOUNT IS '조회수';

ALTER TABLE TB_COM_BOARD
  ADD CONSTRAINT FK1_CB FOREIGN KEY(USER_NO) REFERENCES TB_USER;


-- 커뮤니티 게시판(후기,QNA) 댓글 테이블 생성
PROMPT CREATING CB_COMMENT TABLE...
CREATE TABLE TB_CB_COMMENT(
  CBC_NO NUMBER CONSTRAINT PK_CBC PRIMARY KEY,
  CB_NO NUMBER NOT NULL,
  USER_NO NUMBER NOT NULL,
  CONTENT VARCHAR2(1000) NOT NULL,
  REPLY_DATE DATE DEFAULT SYSDATE
);
COMMENT ON COLUMN TB_CB_COMMENT.CBC_NO IS '커뮤니티게시판 댓글 번호';
COMMENT ON COLUMN TB_CB_COMMENT.CB_NO IS '커뮤니티게시글 번호';
COMMENT ON COLUMN TB_CB_COMMENT.USER_NO IS '작성자';
COMMENT ON COLUMN TB_CB_COMMENT.CONTENT IS '댓글 내용';
COMMENT ON COLUMN TB_CB_COMMENT.REPLY_DATE IS '작성일자';

ALTER TABLE TB_CB_COMMENT
  ADD CONSTRAINT FK1_CBC FOREIGN KEY(CB_NO) REFERENCES TB_COM_BOARD;
ALTER TABLE TB_CB_COMMENT
  ADD CONSTRAINT FK2_CBC FOREIGN KEY(USER_NO) REFERENCES TB_USER;
  

-- 마이페이지 스케줄 테이블 생성
PROMPT CREATING MYPAGE_SCHEDULE TABLE...
CREATE TABLE TB_MYPAGE_SCHEDULE(
  S_NO NUMBER CONSTRAINT PK_MS PRIMARY KEY,
  V_NO NUMBER,
  USER_NO NUMBER NOT NULL,
  CONTENT VARCHAR2(100) NOT NULL,
  UPLOAD_DATE DATE NOT NULL
);
COMMENT ON COLUMN TB_MYPAGE_SCHEDULE.S_NO IS '마이페이지일정 번호';
COMMENT ON COLUMN TB_MYPAGE_SCHEDULE.V_NO IS '운동법 번호';
COMMENT ON COLUMN TB_MYPAGE_SCHEDULE.USER_NO IS '유저번호';
COMMENT ON COLUMN TB_MYPAGE_SCHEDULE.CONTENT IS '내용';
COMMENT ON COLUMN TB_MYPAGE_SCHEDULE.UPLOAD_DATE IS '날짜';

ALTER TABLE TB_MYPAGE_SCHEDULE
  ADD CONSTRAINT FK1_MS FOREIGN KEY(V_NO) REFERENCES TB_VIDEO_BOARD;
ALTER TABLE TB_MYPAGE_SCHEDULE
  ADD CONSTRAINT FK2_MS FOREIGN KEY(USER_NO) REFERENCES TB_USER ON DELETE CASCADE;
  

-- 문의하기 테이블 생성
PROMPT CREATING QNA TABLE...
CREATE TABLE TB_QNA(
  Q_NO NUMBER CONSTRAINT PK_Q PRIMARY KEY,
  SENDER NUMBER NOT NULL,
  RECEIVER NUMBER NOT NULL,
  TITLE VARCHAR2(100) NOT NULL,
  CONTENT VARCHAR2(4000) NOT NULL,
  ORIGINAL_FILENAME VARCHAR2(4000),
  RENAME_FILENAME VARCHAR2(4000),
  WRITE_DATE DATE DEFAULT SYSDATE,
  Q_LEVEL NUMBER DEFAULT 0,
  REF_NO NUMBER NOT NULL
);
COMMENT ON COLUMN TB_QNA.Q_NO IS '문의하기 번호';
COMMENT ON COLUMN TB_QNA.SENDER IS '보낸이';
COMMENT ON COLUMN TB_QNA.RECEIVER IS '받는이';
COMMENT ON COLUMN TB_QNA.TITLE IS '문의하기제목';
COMMENT ON COLUMN TB_QNA.CONTENT IS '문의하기내용';
COMMENT ON COLUMN TB_QNA.ORIGINAL_FILENAME IS '원래 파일 이름';
COMMENT ON COLUMN TB_QNA.RENAME_FILENAME IS '바뀔 파일 이름';
COMMENT ON COLUMN TB_QNA.WRITE_DATE IS '작성일자';
COMMENT ON COLUMN TB_QNA.Q_LEVEL IS '글레벨';
COMMENT ON COLUMN TB_QNA.REF_NO IS '참조글번호';

ALTER TABLE TB_QNA
  ADD CONSTRAINT FK1_Q FOREIGN KEY(SENDER) REFERENCES TB_USER(USER_NO);
ALTER TABLE TB_QNA
  ADD CONSTRAINT FK2_Q FOREIGN KEY(RECEIVER) REFERENCES TB_USER(USER_NO);
ALTER TABLE TB_QNA
  ADD CONSTRAINT FK3_Q FOREIGN KEY(REF_NO) REFERENCES TB_QNA(Q_NO);
  
  
-- 좋아요 테이블 생성
PROMPT CREATING LIKE TABLE...
CREATE TABLE TB_LIKE(
  V_NO NUMBER NOT NULL,
  USER_NO NUMBER NOT NULL,
  CATEGORY1 VARCHAR2(100) NOT NULL,
  CATEGORY2 VARCHAR2(100) NOT NULL,
  LIKE_DATE DATE DEFAULT SYSDATE
);
COMMENT ON COLUMN TB_LIKE.V_NO IS '운동법 번호';
COMMENT ON COLUMN TB_LIKE.USER_NO IS '좋아요를 누른 회원 번호';
COMMENT ON COLUMN TB_LIKE.CATEGORY1 IS '운동법 카테고리1';
COMMENT ON COLUMN TB_LIKE.CATEGORY2 IS '운동법 카테고리2';
COMMENT ON COLUMN TB_LIKE.LIKE_DATE IS '좋아요를 누른 날짜';

ALTER TABLE TB_LIKE
  ADD CONSTRAINT FK1_L FOREIGN KEY(V_NO) REFERENCES TB_VIDEO_BOARD;
ALTER TABLE TB_LIKE
  ADD CONSTRAINT FK2_L FOREIGN KEY(USER_NO) REFERENCES TB_USER;
  
------------- 시퀀스 생성 ----------------
PROMPT SEQUENCE 생성시작..
-- 유저 시퀀스 --
DROP SEQUENCE USER_SEQ;
CREATE SEQUENCE USER_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCACHE
ORDER;

-- 헬스장 시퀀스 --
DROP SEQUENCE GYM_SEQ;
CREATE SEQUENCE GYM_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCACHE
ORDER;

-- 헬스장 일정 시퀀스 --
DROP SEQUENCE GS_SEQ;
CREATE SEQUENCE GS_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCACHE
ORDER;

-- 헬스장 후기 시퀀스 --
DROP SEQUENCE GC_SEQ;
CREATE SEQUENCE GC_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCACHE
ORDER;
  
-- 마이페이지 스케줄 시퀀스 --
DROP SEQUENCE MS_SEQ;
CREATE SEQUENCE MS_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCACHE
ORDER;

-- 운동법 동영상 시퀀스 --
DROP SEQUENCE VB_SEQ;
CREATE SEQUENCE VB_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCACHE
ORDER;

-- 운동법 동영상 댓글 시퀀스 --
DROP SEQUENCE VBC_SEQ;
CREATE SEQUENCE VBC_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCACHE
ORDER;

-- 문의하기 시퀀스 --
DROP SEQUENCE QNA_SEQ;
CREATE SEQUENCE QNA_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCACHE
ORDER;

-- 운동모임 게시판 시퀀스 --
DROP SEQUENCE MB_SEQ;
CREATE SEQUENCE MB_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCACHE
ORDER;

-- 운동모임 게시판 댓글 시퀀스 --
DROP SEQUENCE MBC_SEQ;
CREATE SEQUENCE MBC_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCACHE
ORDER;

-- 커뮤니티 게시판(QNA, 후기) 시퀀스 --
DROP SEQUENCE CB_SEQ;
CREATE SEQUENCE CB_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCACHE
ORDER;

-- 커뮤니티 게시판(QNA, 후기) 댓글 시퀀스 --
DROP SEQUENCE CBC_SEQ;
CREATE SEQUENCE CBC_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCACHE
ORDER;
PROMPT SEQUENCE 생성 끝...
-- 시퀀스 생성 종료 --

-- 샘플데이터 삽입 --
INSERT INTO TB_USER VALUES(USER_SEQ.NEXTVAL, 'ADMIN', '$2a$10$Fr8KsAskrldajwgHTaOvWeMfMhbamOVTQ9.1S2LN9M01g67zzd2im', '관리자', '관리자', '010-8366-3828', 2, NULL, 0, NULL, NULL);
INSERT INTO TB_USER VALUES(USER_SEQ.NEXTVAL, 'user11@iei.or.kr', '$2a$10$UWJxBhRjk8rH4CTKattaEOfkcKX20nYKrsImhve/0OLfrRipPRrwG', '양동균', '양뚝', '010-8366-3828', 1, NULL, 0, NULL, NULL);
INSERT INTO TB_USER VALUES(USER_SEQ.NEXTVAL, 'wltjs1796@naver.com', '$2a$10$sghg6nmqBwt1d54SlM0ZfubV5NjS1Iur.59X1.2FF09oWZlNqGnty', '윤지선', '지선짱', '010-6243-6597', 0, NULL, 0, NULL, NULL);
INSERT INTO TB_MYPAGE_SCHEDULE VALUES(MS_SEQ.NEXTVAL, NULL, 3, '운동 스케줄 1', SYSDATE-1);
INSERT INTO TB_MYPAGE_SCHEDULE VALUES(MS_SEQ.NEXTVAL, NULL, 3, '운동 스케줄 2', SYSDATE-1);
INSERT INTO TB_MYPAGE_SCHEDULE VALUES(MS_SEQ.NEXTVAL, NULL, 3, '운동 스케줄 3', SYSDATE-1);
INSERT INTO TB_MYPAGE_SCHEDULE VALUES(MS_SEQ.NEXTVAL, NULL, 3, '운동 스케줄 4', SYSDATE);
--TB_VIDEO_BOARD (요가)샘플데이터 
INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'이유주의 "VINYASA YOGA" 18회 요가를 통한 다이어트 live 방송 by헬스티비+헬스tv','이유주의 "VINYASA YOGA" 18회 요가를 통한 다이어트 live 방송 by헬스티비+헬스tv','요가','다이어트','-O8CI32TpgI',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'이유주의 "VINYASA YOGA" 17회 요가를 통한 다이어트 live 방송 by헬스티비+헬스tv','이유주의 "VINYASA YOGA" 17회 요가를 통한 다이어트 live 방송 by헬스티비+헬스tv','요가','다이어트','HuRgTZf7MlE',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'이유주의 "VINYASA YOGA" 16회 요가를 통한 다이어트 live 방송 by헬스티비,+헬스tv','이유주의 "VINYASA YOGA" 16회 요가를 통한 다이어트 live 방송 by헬스티비,+헬스tv','요가','다이어트','ZOvINmqdL3k',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'이유주의 "VINYASA YOGA" 15회 요가를 통한 다이어트 live 방송 by헬스티비,+헬스tv','이유주의 "VINYASA YOGA" 15회 요가를 통한 다이어트 live 방송 by헬스티비,+헬스tv','요가','다이어트','Tph3Q7eV-Mg',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'이유주의 "VINYASA YOGA" 14회 요가를 통한 다이어트 live 방송 by헬스티비','이유주의 "VINYASA YOGA" 14회 요가를 통한 다이어트 live 방송 by헬스티비','요가','다이어트','tcAmTQ0Cw9o',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'이유주의 "VINYASA YOGA" 13회 요가를 통한 다이어트 live 방송 by헬스티비','이유주의 "VINYASA YOGA" 13회 요가를 통한 다이어트 live 방송 by헬스티비','요가','다이어트','pZBYuBqR2sE',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'이유주의 "VINYASA YOGA" 12회 요가를 통한 다이어트 live 방송 by헬스티비','이유주의 "VINYASA YOGA" 12회 요가를 통한 다이어트 live 방송 by헬스티비','요가','다이어트','2OJMTZeH1ag',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'이유주의 "VINYASA YOGA" 10회 요가를 통한 다이어트 live 방송 by 헬스티','이유주의 "VINYASA YOGA" 10회 요가를 통한 다이어트 live 방송 by 헬스티','요가','다이어트','_E41vfKM2x8',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'이유주의 "VINYASA YOGA" 9회 요가를 통한 다이어트 live 방송 by 헬스티비','이유주의 "VINYASA YOGA" 9회 요가를 통한 다이어트 live 방송 by 헬스티비','요가','다이어트','j7EC5Z2asIk',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'이유주의 VINYASA YOGA 8회 요가를 통한 다이어트 live 방송','이유주의 VINYASA YOGA 8회 요가를 통한 다이어트 live 방송','요가','다이어트','Qftmd4y_hmQ',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'yoga challenge + physical exercise 7th by healthtv','yoga challenge + physical exercise 7th by healthtv','요가','다이어트','AM6n3o3ApGc',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'yoga workout + yoga challenge 6th','yoga workout + yoga challenge 6th','요가','다이어트','tzYwdV1YaoA',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'vinyasa yoga + yoga challenge 5th','vinyasa yoga + yoga challenge 5th','요가','다이어트','mAaX8k6ySqs',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'휘트니스모델 심으뜸 + 요가강사 이유주 의 콜라보 방송 "JU-DDEUM"','휘트니스모델 심으뜸 + 요가강사 이유주 의 콜라보 방송 "JU-DDEUM"','요가','다이어트','mnN3RYQd6Ss',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'이유주의 "VINYASA YOGA" 4회 요가를 통한 다이어트 live 방송 by 헬스티비 HTV Healthtv','이유주의 "VINYASA YOGA" 4회 요가를 통한 다이어트 live 방송 by 헬스티비 HTV Healthtv','요가','다이어트','9rd00PcCzU4',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'이유주의 "VINYASA YOGA" 3회 요가를 통한 다이어트 live 방송 by 헬스티비 HTV Healthtv','이유주의 "VINYASA YOGA" 3회 요가를 통한 다이어트 live 방송 by 헬스티비 HTV Healthtv','요가','다이어트','yCeOneYaH_8',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'vinyasa + physical exercise 2회','vinyasa + physical exercise 2회','요가','다이어트','Ftf2oA-3CYM',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'VINYASA YOGA + pilates 1st','VINYASA YOGA + pilates 1st','요가','다이어트','rqKg1UGqBBE',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'이유주의 "VINYASA YOGA" 20회 요가를 통한 다이어트 live 방송 by헬스티비+헬스tv','이유주의 "VINYASA YOGA" 20회 요가를 통한 다이어트 live 방송 by헬스티비+헬스tv','요가','다이어트','R8E1YwxIC6g',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'이유주의 "VINYASA YOGA" 21회 요가를 통한 다이어트 live 방송 by헬스티비+헬스tv','이유주의 "VINYASA YOGA" 21회 요가를 통한 다이어트 live 방송 by헬스티비+헬스tv','요가','다이어트','5XU6b3p4oM8',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'이유주의 "VINYASA YOGA" 22회 요가를 통한 다이어트 live 방송 by헬스티비+헬스tv','이유주의 "VINYASA YOGA" 22회 요가를 통한 다이어트 live 방송 by헬스티비+헬스tv','요가','다이어트','uaQwJVPAz7c',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]초보자를 위한 빈야사 요가 - 블럭','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/1nWbJv 반갑습니다. 요가 강사 EVA입니다. 초보자분들에게 블럭은 정말 유용한 도구입니다. 하지만 정작 그 쓰임새를 잘 알지 못하시는데요 이번 영상은 블럭을 이용한 가장 기본적인 영상입니다. 이 영상을 바탕으로 블럭을 활용하는데 도움이 되었으면 합니다.','요가','빈야사','03ydrIQxeK4',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]애플힙을 위한 강력한 두번째 빈야사 요가 - 난이도가 조금 있어요','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/1nWbJv 반갑습니다. 요가 강사 EVA입니다. 여러분!!!!!! 여러분!!!!!! 하하하....T^T 여러분은 오늘 사시나무 떨듯이 떠는 저를 보게 되실 겁니다. 왜이러지;;; 오늘 이상하게 너무 힘들고 몸이 떨리네요. 촬영시간은 기상 후 3시간 정도 후인데 제가 아무것도 안먹었거든요. 그래서 그런지 오늘은 이상하게 덜덜거리네요. 참고하시면서 봐주시길 바라면서 오늘은 애플힙 영상 두번째로 더 강력한 시퀀스를 준비했습니다. 저번 영상에서 집중도가 조금 떨어진거 같은 느낌을 받아 이번에는 완전 집중을 했습니다. 불탈지도 몰라요. 조심하세요~_~ 그리고 동작 난이도가 조금 있습니다. 힘드신분들은 손을 짚은 상태로 하시면 되요. 영상 해보시면 뭔소린지 아실 겁니다. 그럼 지금 바로 시작합니다.','요가','빈야사','GXECrcR-tDc',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]30분 애플힙을 위한 빈야사 요가','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/1nWbJv 반갑습니다. 요가 강사 EVA입니다. 이번 영상은 애플힙을 위한 영상입니다. 제가 시퀀스를 짤때는 힙에 집중해서 만들었는데 찍다보니까 후반부에 생각만치 엉덩이가 불타지 않터라고요. 그러므로!!! 최대한 힙에 집중해서 동작을 하세요. 해보면 아시겠지만 힙에 집중을 하였으나 다른곳에 움직임 역시 넘쳐난다는것을 기억하시면서 지금 바로 시작합니다.','요가','빈야사','BUqB9xoIjLU',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]트라이포드 해드스탠드에서 점프백-차투랑가-빈야사 전환','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/1nWbJv 반갑습니다. 요가 강사 EVA입니다. 이번 영상은 트라이포드 해드스탠드에서 점프백-차투랑가-빈야사 전환하는 방법에 관한 영상입니다. 단단한 차투랑가와 해드스탠드가 가능하시다면 충분히 가능하십니다. 주저말고 도전하세요.','요가','빈야사','qcEOThGHY9Y',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]23분 새로운 로우런지를 만나는 빈야사 요가','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/1nWbJv 반갑습니다. 요가 강사 EVA입니다. 제가 뭐에 씌었는지 편집을 엉망으로 해서 다시 올립니다. 배가 너무 고팠나봐요~_~ 로우런지의 다양한 변형동작으로 시퀀스를 구성했습니다. 난이도가 조금있다는건 안비밀! 즐거운 수련되시길 바랍니다. 아참!!!!! 고등학교 후배분이 댓글을 남겨주셨는데 감사합니다. 하지만 이름은 쓰지 말아주세요 ㅠㅜ 왠지 민망해요 하하','요가','빈야사','9B7QnpaGZhc',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]중급자를 위한 24분 빈야사 요가','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/1nWbJv 반갑습니다. 요가 강사 EVA입니다. 이번 영상은 오랫만에 중급자 영상을 준비했습니다. 하지만 중급자 영상이라고 해서 전부 어려운 동작을 하는 것이 아니고 타겟동작이 레벨이 있는 것이고 하나씩 쌓아가든 기본 동작으로 타겟포즈까지 간다는것 기억하시면서 준비 되셨다면 지금 바로 시작합니다.','요가','빈야사','S1MZ2MbVsG8',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]21분 초보자를 위한 빈야사 요가 - 트라이앵글','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/반갑습니다. 요가 강사 EVA입니다. 이번 영상은 초보자 분들을 위한 영상입니다. 요가를 많이 접하신분들도 고관절의 밖으로 회전에 집중하시면서 트리코나아사나의 변형과 바른 정렬을 수련하기에 좋은 시퀀스라 생각합니다. 땀이 장난이 아닙니다 하하 준비되셨으면 바로 시작합니다.','요가','빈야사','m_cgE75m5Og',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]옆구리살 제거 빈야사 요가','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/1nWbJv 반갑습니다. 요가 강사 EVA입니다. 이번 영상은 많은 여성분들의 고민인 옆구리살을 줄이는데 도움이 되는 영상을 준비했습니다. 지금 바로 시작할께요','요가','빈야사','BO3V1MVtuqM',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]겨날 제거 빈야사 요가','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/1nWbJv 반갑습니다. 요가 강사 EVA입니다. 이번 영상은 슬림한 팔라인을 위한 빈야사 요가입니다. 지금 바로 시작하세요.','요가','빈야사','5qdJSM2NuD4',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]64분 빈야사 요가','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/1nWbJv 반갑습니다. 요가 강사 EVA입니다. 이번 영상 역시 개인교습 영상입니다. 64분 풀 시퀀스 빈야사 요가 지금 함께하세요','요가','빈야사','m9jwDWZh-j4',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]30분 디톡스 빈야사 요가 30min detox vinyasa yoga','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/1nWbJv 반갑습니다. 요가 강사 EVA입니다. 이번 영상은 디톡스를 주제로 시퀀스를 준비했습니다. 30분 영상중 선자세가 많은 부분을 차지하여 에너지 소모 역시 엄청나게 될것입니다. 지금 바로 시작합니다.','요가','빈야사','i7IbvLzCmjo',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]중급자를 위한 버드 오브 파라다이스 빈야사 요가 Bird of Paradise vinyasa yoga','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/1nWbJv 반갑습니다. 요가 강사 EVA입니다. 이번 영상은 고관절의 유연성이 많이 필요한 버드 오브 파라다이스를 주제로 한 빈야사 요가입니다. 지금 버드 오브 파라다이스에 도전해 보세요.','요가','빈야사','8ZjrAEqoYX8',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]15분 당신의 심장을 뛰게 할 초보자를 위한 빈야사 요가 15min cardio vinyasa yoga for beginners','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/1nWbJv 반갑습니다. 요가 강사 EVA입니다. 이번 영상은 초보자를 위한 영상입니다. 빈야사만 변경하신다면 중급이상 분들도 즐겁게 수련하실 수 있는 시퀀스 입니다. 테이블탑의 새로운 변형과 반복적인 움직임으로 여러분의 심장을 뛰게 할 것입니다. 준비되셨나요? 바로 시작합니다.','요가','빈야사','8LM6W3G5Bns',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]15분 중급자를 위한 댄스포즈 빈야사 요가 15min natarajasana vinyasa yoga','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/1nWbJv 반갑습니다. 요가 강사 EVA입니다. 이번 영상은 가슴열기와 약간의 트위스트가 포함된 빈야사 플로우입니다. 타겟포즈는 나타라자사나, 댄스포즈 입니다. 준비되셨나요? 바로 시작합니다.','요가','빈야사','JEYWv1p8G5Y',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]하체의 힘이 코어의 힘! 초보자를 위한 코어 빈야사 요가 core vinyasa yoga for beginner','반갑습니다. 요가 강사 EVA입니다. 이번 영상은 블럭을 이용하여 빈야사를 수련합니다. 하체의 힘이 코어의 힘 임을 다시 한번 기억하시면서 즐거운 수련되시기 바랍니다.','요가','빈야사','-v8ezWv7zu8',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]시르샤사나를 위한 10분 빈야사요가 10min vinyasa yoga for sirsiasana','반갑습니다. 요가 강사 EVA입니다. 이번 영상은 시르샤아사나 해드스텐드를 준비하는 빈야사 입니다. 어깨를 모아주고 전굴로 자세를 유지합니다. 그것에만 그치지 않고 앞으로만 굽혔던 상체를 펴는 동작까지 포함했습니다. 준비되셨나요? 바로 시작할께요','요가','빈야사','lv5QEThEO6I',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]중급자를 위한 내 몸에 활력을 주는 19분 빈야사 요가 19 min energizing vinyasa yoga','반갑습니다. 요가 강사 EVA입니다. 이번 영상은 중급자를 위한 19분 빈야사 요가입니다. 이번 시퀀스에는 박카사나 점프백이 포함되어 있는데 점프백에 아주 간단히 팁을 알려드렸습니다. 너무 별거아니지만 딱 맞는 팁입니다. 하하;;; 또한 박카사나 점프백 빈야사를 제외하고는 전부 플랭크 차투랑가 푸쉬업 다운독의 변형된 빈야사로 플로우를 진행했습니다. 많은 팔힘이 요구됩니다. 준비되셨나요? 바로 시작합니다.','요가','빈야사','eSWZbJJkzvQ',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]더 유연한 몸을 위한 16분 빈야사 요가 16min vinyasa yoga for flexibility','반갑습니다. 요가 강사 EVA입니다. 오늘은 하체의 유연성에 도움이 되는 시퀀스를 준비했습니다. 긴말 필요없겠죠? 바로 시작합니다.','요가','빈야사','U7socaRfnf8',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]중급자를 위한 트위스트와 암발란스 빈야사 요가 twist + arm balance vinyasa yoga','반갑습니다. 요가 강사 EVA입니다. 이번 영상은 트위스트와 아주 간단한 암발란스가 포함된 빈야사 요가입니다. 초보자 분들은 암발란스 동작에서 발을 바닥에서 띄우지 않고 자세를 유지하셔도 좋습니다. 매트 준비되셨나요 바로 시작합시다^^','요가','빈야사','TcPzxobF2KQ',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]17분 데일리 빈야사 요가 Daily vinyasa yoga','반갑습니다. 요가 강사 EVA입니다. 이번 영상은 매일 꾸준히 수련하시면 근력과 유연성을 모두잡을수 있는 시퀀스로 준비했습니다. 전체적으로 부담없는 아사나들로 구성했습니다. 준비되셨나요? 바로 시작합니다.','요가','빈야사','xHlTj9b9hBY',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]초보자를 위한 26분 숩타쿠루마사나 빈야사 요가','반갑습니다. 요가 강사 EVA입니다. 특별히 시퀀스 제목을 숩타쿠루마사나라고 쓰긴했지만 이 영상은 앞전의 중급자의 시퀀스를 초보자의 시퀀스로 바꾸어 천천히 진행하며 기본적인 자세의 설명을 추가로 하여 처음 요가를 접하셔도 충분히 수련하실수 있도록 만들어보았습니다. 덧붙여 동영상별 레벨에 대해 말씀드리자면 뭔가 확실한 구분선을 가지고 이건 초보자용 이건 중급자용 이건 고급자용으로 나누면 좋겠지만 직접 수련을 하고 가르치다 보니 여러가지 고려해야할 사항들이 있어 명확한 구분이 쉽지 않습니다. 외국과는 조금 다른 요가에 대한 생각정도 라고 간단히 쓰겠습니다. 또한 제가 도전적인 자세를 좋아라해서 난이도 있는 자세를 주제로 수업을 해봤는데요 많은 시간 티칭 해본 결과 어려운거 해봐야 좋아하시는 분들이 몇몇 없으시더라고요....흠흠;;; 하지만 정확한 것은 초보자용은 진짜 초보자들이 하실수 있게 찍었습니다. 또한 요가 경험이 어느정도 있더라도 나의 자세를 좀더 정렬에 집중해서 수련하고 싶을때 초보자용으로 수련하시면 도움이 되실 겁니다. 특별히 쿠루마사나 같은 경우는 매우 도전적인 자세라 앞에 중급자 이상이란 말을 붙였습니다. 그러니까 초보자라고 쓴건 진짜 초보자용이고 나머지는 요가를 어느정도 수련하신분들이 하시면 좋은 영상입니다. 그렇다고 초보자가 다른 영상을 수련할수 없는 것은 아닙니다. 아;;;; 제가 옆에서 알려드리고 싶은맘이 ... 하하 블럭과 스트랩을 기본으로 요가 도구를 사용하시면 초보자분들도 모든 영상을 하실수 있습니다. 이건 시간이 지나면 다 아실테니 앞으로 꾸준히 같이 수련해보시길 바랍니다. 말이 길었네요. 준비되셨다면 지금 바로 시작합니다.','요가','빈야사','AQDAqlMLER8',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA] 17분 파워 빈야사 요가','반갑습니다. 요가 강사 EVA입니다. 오늘은 힘이 넘치는 시퀀스를 준비했습니다. 많은 활동적인 아사나가 포함되어 있습니다. 준비되셨나요? 바로 시작합니다.','요가','빈야사','pei_YV6atvg',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]중급자 이상을 위한 숩타쿠루마사나 + 쿠루마사나 빈야사 요가','반갑습니다. 요가 강사 EVA입니다. 오늘은 중급자 이상을 위한 빈야사를 준비했습니다. 숩타쿠루마사나와 쿠루마사나는 허리에 아주 깊은 전굴이 일어납니다. 허리 부상에 주의하시면서 천천히 같이 수련해 보시길 바랍니다.','요가','빈야사','bwWHjlehJGo',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]건강한 허리를 위한 빈야사 요가 2.','반갑습니다. 요가 강사 EVA입니다. 이번 영상 역시 건강한 허리를 위한 빈야사입니다. 첫번째 영상과 연결해서 수련하셔도 좋습니다 그럼 바로 시작하세요^^','요가','빈야사','lrx9i2fZFm0',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]건강한 허리를 위한 빈야사 요가 1.','반갑습니다. 요가 강사 EVA입니다. 이번 동영상은 건강한 허리를 위한 빈야사 요가를 준비했습니다. 많은 사람들이 허리통증을 겪을때 허리를 비틀거나 꺽는 동작을 합니다. 이것은 상태를 악화시킬뿐 전혀 도움이 되지 않습니다. 통증이 심할때는 휴식을 취하시고 통증이 어느 정도 완화되었을때 허리근력강화 동작을 꾸준히 해주신다면 허리통증없는 건강한 생활을 하실수 있습니다. 준비되셨나요? 바로 시작합니다.','요가','빈야사','EWm26T7x-zg',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]강한! 슬림한! 균형잡힌! 하체를 위한 빈야사 요가','반갑습니다. 요가 강사 EVA입니다. 이번 영상은 하체강화를 위한 빈야사입니다. 다른 말이 필요할까요? 바로 시작하시면 됩니다.^^','요가','빈야사','FX3FqWw2KC0',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]강한! 슬림한! 균형잡힌! 상체를 위한 빈야사 요가','반갑습니다. 요가 강사 EVA입니다. 이번영상은 상체를 단단! 슬림하게 만들어주는 빈야사로 준비했습니다. 바로 시작하세요! 이곳은 3월 4월 5월이 가장 덥습니다. 제가 있는 곳은 소음이 심한 곳이라 창문을 닫고 촬영하며 좋은 장비를 갖추어 촬영하는 것이 아니라 에어컨와 선풍기도 사용하지 않고 촬영을 합니다.(소음이 심할까봐요^^;) 땀도 많이 흘리고 숨소리도 많이 거친부분 이해해주시길 바랍니다.','요가','빈야사','9EWGqVs--kQ',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA] 요가 빈야사에 대하여(for 초보자)','반갑습니다. 요가 강사 EVA입니다. 이번에는 빈야사에 대하여 다루어봤습니다. 이미 다른 동영상에서 여러번 소개를 했지만 아직 잘모르시는 분들을 위해 따로 동영상을 준비했습니다. 초보자분들이 차투랑가 단다사나, 업워드페이싱독을 하기엔 무리가 있지요. 그런분들을 위해 쉬운버전의 모디퐈이 차투랑가, 로우코브라 등을 소개합니다.','요가','빈야사','gDI2nKKWFY8',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]하누만아사나를 위한 20분 빈야사 요가','반갑습니다. 요가 강사 EVA입니다. 오늘은 하누만아사나를 위한 빈야사를 준비했습니다. 흔히 다리찢기라고 하죠? 차근차근 준비해서 하누만아사나를 완성하는 시퀀스. 블럭만 있으시면 초보자분들도 충분히 도전하실수 있습니다. 자 지금 바로 시작합니다.','요가','빈야사','yGe3bx2qKrA',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]튼튼한 척추를 위한 18분 빈야사 요가 ver.2','반갑습니다. 요가 강사 EVA입니다. 저번 시간에 이어 오늘도 튼튼한 척추를 위한 시퀀스를 마련했습니다. 원래는 두개의 시퀀스가 연결된 것인데 인터넷 사정상 길면 업로딩이 잘안되서 하나의 시퀀스를 두개로 만들었습니다. 여러분은 두개를 같이 수련하시면 좋으실겁니다.^^ 준비되셨으면 지금바로 시작하세요.','요가','빈야사','G1l51wugMXw',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]튼튼한 척추를 위한 17분 빈야사 요가','안녕하세요. 요가 강사 EVA입니다. 척추를 감싸고 있는 많은 근육들을 강화하여 척추를 더 단단하게 잡아주게 하고 늘림으로 척추의 유연성을 도모하여 척추 건강에 도움이 되는 시퀀스를 만들어봤습니다. 허리에서 일어나는 백밴딩이 아닌 흉추과 요추가 만나는 부분에서의 백밴딩을 집중하여 노려보세요^^ 허리는 나의 척추가 그리고 근육들이 튼튼해진 다음에 하는 도전적인 수련이라는 것을 항상 기억하시기 바랍니다. 지금 바로 시작합니다.','요가','빈야사','jiUXOhDCiFI',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]내몸의 체온을 빨리 올리는 퀵히트 quick heat 13분 빈야사 요가','안녕하세요 요가 강사 EVA입니다. 오늘은 짧은 시간에 몸의 체온이 확 올라갈 만한 시퀀스를 준비했습니다. 매일 하는 아사나도 방법을 조금 바꾸면 전혀 다른 근육이 쓰이는데요 전 이런게 재미있습니다 하하. 저만 그런가요+_+ 여튼 자 이제 시작합니다','요가','빈야사','aBxUmn1iL5U',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]내 몸의 정렬을 찾는 19분 빈야사 요가','반갑습니다. 요가 강사 EVA입니다. 오늘은 블럭을 이용하여 몸의 정확한 정렬을 찾는 19분 빈야사요가 시퀀스입니다. 요즘 요가블럭 저렴하죠? 유연성이 부족하신분 초보준들은 블럭이 아주 유용합니다. 하지만 블럭이 없으시더라도 충분히 즐길수 있으니 걱정은 마시고요 지금 바로 시작합니다^^','요가','빈야사','OAYCQr6uzxc',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]이글포즈를 위한 10분 빈야사 요가','반갑습니다 요가 강사 EVA입니다. 오늘은 이글포즈 가루다아사나를 주제로 빈야사요가를 해보겠습니다 균형을 잘잡기 위해서는 아사나의 많은 반복과 다리근력이 필요합니다 전...연습을 게을리한탓인지 자꾸 흔들리네요 하하하하....더 열심히 수련하겠습니다! 매트 준비되셨죠?? 지금 바로 시작하세요','요가','빈야사','XpjBIXK_b1Q',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]20분 초보자를 위한 빈야사 요가','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/1nWbJv 요가 초보자들을 위한 빈야사 요가 입니다. 매트만 있다면 간편하게 시작하실수 있습니다.','요가','빈야사','9gzi2VVswwo',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]중급자이상을 위한 빈야사 요가, vinyasayoga','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/1nWbJv 차투랑가단다사나-업독-다운독이 포함된 빈야사 입니다. 우리나라 여성분들은 근력이 약해서 요가 를 오래 수련하신분들을 제외하고 이 빈야사를 정확히 하시는 분들이 많지 않습니다. 또한 힘든걸 싫어하십니다. ㅠ.ㅜ 어쩌죠?ㅋㅋ 아니 왜죠??? 누구한테 묻는지;;;; 만일 정확한 빈야사 구사가 힘드시다면 쉬운버전으로 같이 해보셔도 좋을거 같습니다. 매트준비되셨으면 지금 바로 시작하세요.','요가','빈야사','X7gywDrrsPk',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]16분 슬림벅지를 위한 빈야사 요가','구독! 좋아요! 많이 부탁드립니다. 구독은 클릭▶https://goo.gl/1nWbJv 슬림한 허벅지를 위한 빈야사 요가입니다. 허벅지 앞,뒤,안 전체 근육을 움직이고 이완시켜 날씬한 허벅지 라인에 도전해보세요^^','요가','빈야사','qtFQRdeI5HY',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]두번째 초보자를 위한 빈야사 요가','초보자를 위한 빈야사 요가 두번째 입니다. 역시 매트만 준비하세요.','요가','빈야사','TU_Bygb2570',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVAYOGA]슬림옆구리 빈야사,하이런지트위스트빈야사, 사이드밴드+트위스트 ver.2','하이런지 트위스트 빈야사 시퀀스의 또 다른 버전입니다. 즐거운 수련되세요~_~','요가','빈야사','JGlX-7nJoXQ',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]가슴+어깨 열기 빈야사 요가','가슴열기 그리고 어깨열기를 위한 빈야사 요가 입니다. 차투랑가 업독 다운독이 포함된 빈야사입니다. 초보이신 분들은 쉬운 빈야사로 플로우를 이어가세요. 만일 힘드시다면 빈야사할때 차투랑가 대신 곧바로 다운독 그후 플로우를 이어가셔도 좋습니다. 즐거운 수련되세요^^','요가','빈야사','SBCN4iE-TN0',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]초보자를 위한 골반열기 빈야사 요가','초보자 분들도 쉽게 따라 하실수 있는 빈야사 요가입니다. 이번 시퀀스의 주제는 바로 고관절 열기^^ 다리를 양옆으로 심하게 넓히는 것이 아닌 초보들도 쉽게 하실수 있는 선자세에서의 골반열기 입니다. 지금 시작합니다.','요가','빈야사','DmZzizTvbbs',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]15분 디톡스 빈야사 요가','트위스트 동작이 포함된 빈야사 요가, 내 몸의 독소를 제거한다! 15분 빈야사요가 함께하세요^^','요가','빈야사','oxPTnv2QJ2Y',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]박카사나를 위한 빈야사 요가','도전적인 자세인 박카사나를 위한 빈야사 요가입니다. 조금 난이도가 있는 동작이지만 재미있게 수련해보아요^^','요가','빈야사','_RtBNOuvQh0',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVA YOGA]슬림옆구리 빈야사 요가,하이런지트위스트 빈야사, 사이드밴드+트위스트 ver.1','하이런지 트위스트를 이용한 빈야사 요가 시퀀스 입니다. 힘차게 시작합니다.','요가','빈야사','sjbQRstRNC8',0);

INSERT INTO TB_VIDEO_BOARD VALUES(vb_seq.nextval,'[EVAYOGA]바시스타아사나 사이드플랭크를 위한 빈야사 요가','바시스타아사나, 사이드플랭크로 도달하는 빈야사 요가 입니다. 이 아사나는 복부강화에 아주 효과적입니다. 특히 옆구리에 아주 많은 힘이 필요합니다. 지금 부터 시작합니다.','요가','빈야사','gTG1MbgxVB0',0);
-- TB_GYM 샘플 데이터
INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE) 
VALUES (gym_seq.nextval, '우노 휘트니스클럽', NULL, NULL, 'AM 06:00', '02-790-6776', '010-1234-5678', NULL, '피트니스', NULL, '서울특별시 용산구 보광동 260-8번지 지상3층', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE) 
VALUES (gym_seq.nextval, 'AK운동맞춤센터', NULL, NULL, 'AM 06:00', '02-777-3579', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 용산동2가 23번지', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE) 
VALUES (gym_seq.nextval, '웰니스짐', NULL, NULL, 'AM 06:00', '02-795-9966', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 이태원동 226-3번지 지하1층', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE) 
VALUES (gym_seq.nextval, '그랜드 남여헬스클럽', NULL, NULL, 'AM 06:00', '02-795-5511', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 보광동 216-96번지', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE) 
VALUES (gym_seq.nextval, '동국 스포츠', NULL, NULL, 'AM 06:00', '02-715-5588', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 원효로4가 142-1번지 2.3층', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE) 
VALUES (gym_seq.nextval, '한강헬스', NULL, NULL, 'AM 06:00', '02-795-9333', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 이촌동 300-15번지', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '그램 휘트니스', NULL, NULL, 'AM 06:00', '02-794-6010', '010-1234-5678', NULL, '피트니스', NULL, '서울특별시 용산구 한남동 657-201번지', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, 'J헬스클럽', NULL, NULL, 'AM 06:00', '02-796-5176', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 한남동 631-5번지 4층', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, 'B AND B 휘트니스', NULL, NULL, 'AM 06:00', '02-794-5600', '010-1234-5678', NULL, '피트니스', NULL, '서울특별시 용산구 이태원동 21-1번지 태광빌딩 207호', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '스카이 휘트니스클럽', NULL, NULL, 'AM 06:00', '02-797-3993', '010-1234-5678', NULL, '피트니스', NULL, '서울특별시 용산구 남영동 127-1번지 3층', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '상떼휘트니스', NULL, NULL, 'AM 06:00', '02-778-7496', '010-1234-5678', NULL, '피트니스', NULL, '서울특별시 용산구 동자동 22-3번지 지하1층', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '해밀톤 휘트니스센터', NULL, NULL, 'AM 06:00', '02-6393-1375', '010-1234-5678', NULL, '피트니스', NULL, '서울특별시 용산구 이태원동 116-1번지 지하2층', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '드래곤힐스파휘트니스클럽', NULL, NULL, 'AM 06:00', '02-792-0002', '010-1234-5678', NULL, '피트니스', NULL, '서울특별시 용산구 한강로3가 40-713번지 4층', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '엠파이어휘트니스', NULL, NULL, 'AM 06:00', '02)705-0039', '010-1234-5678', NULL, '피트니스', NULL, '서울특별시 용산구 한강로3가 16-85번지 GS한강 에클라트(지하1층)', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '한남레포츠종합타운', NULL, NULL, 'AM 06:00', '02)793-6394', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 한남동 96-3번지 신성미소시티 지하1층', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '태영헬스', NULL, NULL, 'AM 06:00', '02-703-6377', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 청파동3가 111-9번지 캠퍼스프라자 4층', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '몽키짐휘트니스', NULL, NULL, 'AM 06:00', '02-3215-8200', '010-1234-5678', NULL, '피트니스', NULL, '서울특별시 용산구 한강로2가 2-8번지', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '와이짐', NULL, NULL, 'AM 06:00', '02-797-7304', '010-1234-5678', NULL, '헬스장', NULL, '서울특별시 용산구 이촌동 300-18번지 유일빌딩 지하1층', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '킴스짐헬스크럽', NULL, NULL, 'AM 06:00', '02-749-9995', '010-1234-5678', NULL, '헬스장', NULL, '서울특별시 용산구 이태원동 124-3번지 지하1층', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, 'Studio-X-Fitness', NULL, NULL, 'AM 06:00', '02-123-4567', '010-1234-5678', NULL, '피트니스', NULL, '서울특별시 용산구 이태원동 651번지', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, 'With Gym', NULL, NULL, 'AM 06:00', '02-749-9690', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 한남동 653-95번지 2층', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '센티넬 크로스핏 한남', NULL, NULL, 'AM 06:00', '02-6431-0802', '010-1234-5678', NULL, '크로스핏', NULL, '서울특별시 용산구 한남동 635-1번지 지하1층', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '동서 골프and휘트니스', NULL, NULL, 'AM 06:00', '02-714-2011', '010-1234-5678', NULL, '피트니스', NULL, '서울특별시 용산구 청파동1가 180-24번지', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '위너핏PT스튜디오', NULL, NULL, 'AM 06:00', '02-792-1031', '010-1234-5678', NULL, '피트니스', NULL, '서울특별시 용산구 남영동 61-4번지', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '스포짐', NULL, NULL, 'AM 06:00', '02-701-0011', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 문배동 40-31번지 ', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '프라이빗 웰니스', NULL, NULL, 'AM 06:00', '02-123-4567', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 한남동 740-1번지 ', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, 'H 퍼스널트레이닝', NULL, NULL, 'AM 06:00', '02-123-4567', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 한남동 79-3번지 ', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '반트짐', NULL, NULL, 'AM 06:00', '02-123-4567', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 이촌동 302-52번지 ', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, 'Fit In Cool', NULL, NULL, 'AM 06:00', '02-123-4567', '010-2662-0828', NULL, '피트니스', NULL, '서울특별시 용산구 한남동 657-45번지', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '팀레드', NULL, NULL, 'AM 06:00', '02-703-8378', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 원효로1가 39-6번지', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, 'wunderbar GYM', NULL, NULL, 'AM 06:00', '02-790-7175', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 이촌동 300-27번지 307호', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '리복 크로스핏 센티널 원', NULL, NULL, 'AM 06:00', '02-790-0801', '010-1234-5678', NULL, '크로스핏', NULL, '서울특별시 용산구 한남동 76-42번지', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, 'Fit Club', null, null, 'AM 06:00', '02-123-4567', '010-1234-5678', NULL, '피트니스', NULL, '서울특별시 용산구 이태원동 646-204번지', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '유(U)PT', NULL, NULL, 'AM 06:00', '02-796-7978', '010-1234-5678', NULL, '피트니스', NULL, '서울특별시 용산구 한남동 261-6번지', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, 'Beautiful Evolution', NULL, NULL, 'AM 06:00', '02-123-4567', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 보광동 216-88번지', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '에스퍼스널트레이닝', NULL, NULL, 'AM 06:00', '02-797-0324', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 용산동5가 24-1번지', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, 'PENTACLE', NULL, NULL, 'AM 06:00', '02-727-5000', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 동자동 12번지', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '레브트레이닝', NULL, NULL, 'AM 06:00', '02-796-9600', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 한남동 1-307번지', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '스포벡', NULL, NULL, 'AM 06:00', '02-123-4567', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 갈월동 101-45번지', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '와가짐', NULL, NULL, 'AM 06:00', '070-4794-6591', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 이촌동 300-301번지', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '시크모어 웰니스 스튜디오', NULL, NULL, 'AM 06:00', '02-792-1710', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 한남동 722-3번지 은성빌딩 2층', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '패스트앤슬로우 컨설팅그룹', NULL, NULL, 'AM 06:00', '02-123-4567', '010-8664-1340', NULL, '헬스', NULL, '서울특별시 용산구 갈월동 69-109번지', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '서울체대입시', NULL, NULL, 'AM 06:00', '02-797-6530', '010-1234-5678', NULL, '체대입시', NULL, '서울특별시 용산구 남영동 17-1번지', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '칼라퍼스널트레이닝', NULL, NULL, 'AM 06:00', '02-711-4013', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 원효로1가 39-10번지', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '랜스앤제이 퍼스널 트레이닝 스튜디오', NULL, NULL, 'AM 06:00', '02-749-7498', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 한남동 258번지 ', 2, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '유즈웰(USEWELL)', NULL, NULL, 'AM 06:00', '02-749-2260', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 한남동 72-1번지 ', 3, NULL, DEFAULT);

INSERT INTO TB_GYM (GYM_NO, GYM_NAME, ORIGINAL_IMAGE, RENAME_IMAGE, OP_TIME, TEL, PHONE, PRICE, CATEGORY, DESCRIPTION, LOCATION, USER_NO, DELETE_DATE, APPROVAL_STATE)
VALUES (gym_seq.nextval, '제이 스튜디오', NULL, NULL, 'AM 06:00', '02-792-8281', '010-1234-5678', NULL, '헬스', NULL, '서울특별시 용산구 보광동 217-21번지 ', 2, NULL, DEFAULT);

COMMIT;

-- 회원탈퇴 프로시저 생성 --
PROMPT 회원탈퇴 프로시저 생성...
CREATE OR REPLACE PROCEDURE DEL_USER_PROCEDURE
IS
BEGIN
  DELETE FROM TB_USER 
  WHERE  to_char(DELETE_DATE,'rr/MM/dd')=to_char(sysdate, 'rr/MM/dd');
  COMMIT;
END;
/

-- 회원탈퇴 잡 스케줄러 실행 -- 
PROMPT 회원탈퇴 잡 스케줄러 실행....
DECLARE
   J_NO NUMBER;
BEGIN
   DBMS_JOB.SUBMIT (
      J_NO,
      'DEL_USER_PROCEDURE;',
      SYSDATE,
      'TRUNC(SYSDATE + 1) + 5 / 24',
      FALSE
   );
END;
/
  
COMMIT;

PROMPT FITNESSGORUND 자료입력 끝...