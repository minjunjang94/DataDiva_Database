CREATE TABLE "Base"."TB_UserState"
( 
  "UserSeq" VARCHAR(50) NOT NULL
  ,"NickName" VARCHAR(200) NOT NULL
  ,"LanguageSeq" INT NOT NULL
  ,"ProfileImage" VARCHAR(300) NULL
 ,"Remark"	VARCHAR(100)	NULL	
 ,CONSTRAINT TB_UserState_PK PRIMARY KEY ("UserSeq")
 ,CONSTRAINT TB_UserState_FK FOREIGN KEY ("UserSeq") REFERENCES "Base"."TB_User"("UserSeq") ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN "Base"."TB_UserState"."UserSeq" IS '사용자 내부코드';
COMMENT ON COLUMN "Base"."TB_UserState"."NickName" IS '닉네임';
COMMENT ON COLUMN "Base"."TB_UserState"."LanguageSeq" IS '언어내부코드';
COMMENT ON COLUMN "Base"."TB_UserState"."ProfileImage" IS '프로필이미지	';
COMMENT ON COLUMN "Base"."TB_UserState"."Remark" IS '비고';

