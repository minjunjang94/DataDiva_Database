CREATE TABLE "Base"."TB_UserLoginLog"
( 
  "UserSeq"					VARCHAR(50)					NOT NULL	
  ,"LoginDateTime"     		TIMESTAMP			NOT NULL	
  ,"IPAddress"			    VARCHAR(150)		NOT NULL	
  ,"Remark"				    VARCHAR(100)		NULL	
  ,CONSTRAINT TB_UserLoginLog_FK FOREIGN KEY ("UserSeq") REFERENCES "Base"."TB_User"("UserSeq") ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN "Base"."TB_UserLoginLog"."UserSeq" IS '사용자 내부코드';
COMMENT ON COLUMN "Base"."TB_UserLoginLog"."LoginDateTime" IS '로그인시간';
COMMENT ON COLUMN "Base"."TB_UserLoginLog"."IPAddress" IS 'IP 주소';
COMMENT ON COLUMN "Base"."TB_UserLoginLog"."Remark" IS '비고';