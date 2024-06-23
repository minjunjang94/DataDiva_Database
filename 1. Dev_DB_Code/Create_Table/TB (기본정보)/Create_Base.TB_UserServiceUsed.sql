CREATE TABLE "Base"."TB_UserServiceUsed"
( 
   "UserSeq" VARCHAR(50) NOT NULL
  ,"UsedDateTime" TIMESTAMP NOT NULL
  ,"ServiceCode" INT NOT NULL
 ,"Remark"	VARCHAR(100)	NULL	
 ,CONSTRAINT TB_UserServiceUsed_PK PRIMARY KEY ("UserSeq")
 ,CONSTRAINT TB_UserServiceUsed_FK FOREIGN KEY ("UserSeq") REFERENCES "Base"."TB_User"("UserSeq") ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN "Base"."TB_UserServiceUsed"."UserSeq" IS '사용자 내부코드';
COMMENT ON COLUMN "Base"."TB_UserServiceUsed"."UsedDateTime" IS '이용 시간';
COMMENT ON COLUMN "Base"."TB_UserServiceUsed"."ServiceCode" IS '서비스 코드';
COMMENT ON COLUMN "Base"."TB_UserServiceUsed"."Remark" IS '비고';

