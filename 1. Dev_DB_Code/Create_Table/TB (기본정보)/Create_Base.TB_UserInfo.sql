CREATE TABLE "Base"."TB_UserInfo"
( 
  "UserSeq"	VARCHAR(50)	NOT NULL
 ,"UserName"	VARCHAR(60)	NOT NULL
 ,"Cellphone"	VARCHAR(100)	NOT NULL
 ,"CountrySeq"	INT		NOT NULL
 ,"Gender"	INT		NOT NULL
 ,"Birth"	CHAR(8)	NOT NULL
 ,"Remark"	VARCHAR(100)	NULL	
 ,CONSTRAINT TB_UserInfo_PK PRIMARY KEY ("UserSeq")
 ,CONSTRAINT TB_UserInfo_FK FOREIGN KEY ("UserSeq") REFERENCES "Base"."TB_User"("UserSeq") ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN "Base"."TB_UserInfo"."UserSeq" IS '사용자 내부코드';
COMMENT ON COLUMN "Base"."TB_UserInfo"."UserName" IS '사용자 명';
COMMENT ON COLUMN "Base"."TB_UserInfo"."Cellphone" IS '전화번호';
COMMENT ON COLUMN "Base"."TB_UserInfo"."CountrySeq" IS '국가내부코드	';
COMMENT ON COLUMN "Base"."TB_UserInfo"."Gender" IS '성별';
COMMENT ON COLUMN "Base"."TB_UserInfo"."Birth" IS '생년월일';
COMMENT ON COLUMN "Base"."TB_UserInfo"."Remark" IS '비고';
