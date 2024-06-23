CREATE TABLE "Base"."TB_User"
( 
	 "UserSeq"	VARCHAR(50)	NOT NULL
	,"Email"    VARCHAR(100)    NOT NULL
	,"LoginPwd"    VARCHAR(300)    NULL
	,"LoginPwdChgDate"    CHAR(8)    NULL
	,"APIKey"    VARCHAR(500)    NULL
	,"FromAPI"    INT	    NOT NULL
	,"LoginStatus"    INT	    NOT NULL
	,"LoginFailCnt"    INT	    NOT NULL
	,"CreateDate"    CHAR(8)    NOT NULL
	,"Remark"    VARCHAR(100)    NULL		
    ,CONSTRAINT TB_User_PK PRIMARY KEY ("UserSeq")
);

COMMENT ON COLUMN "Base"."TB_User"."UserSeq" IS '사용자 내부코드';
COMMENT ON COLUMN "Base"."TB_User"."Email" IS '이메일';
COMMENT ON COLUMN "Base"."TB_User"."LoginPwd" IS '비밀번호';
COMMENT ON COLUMN "Base"."TB_User"."LoginPwdChgDate" IS '비밀번호 최종 변경 일자';
COMMENT ON COLUMN "Base"."TB_User"."APIKey" IS 'API Key';
COMMENT ON COLUMN "Base"."TB_User"."FromAPI" IS 'API 원천';
COMMENT ON COLUMN "Base"."TB_User"."LoginStatus" IS '로그인상태';
COMMENT ON COLUMN "Base"."TB_User"."LoginFailCnt" IS '로그인 실패 수';
COMMENT ON COLUMN "Base"."TB_User"."CreateDate" IS '가입일자';
COMMENT ON COLUMN "Base"."TB_User"."Remark" IS '비고';
