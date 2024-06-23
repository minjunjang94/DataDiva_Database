CREATE TABLE "Base"."TB_Bank"
( 
 "BankSeq" INT NOT NULL
,"BankName" VARCHAR(100) NOT NULL
,"CodeNo" INT NOT NULL
,"SwiftCodeNo" VARCHAR(50) NOT NULL
,"Remark" VARCHAR(100) NULL
,CONSTRAINT TB_Bank_PK PRIMARY KEY ("BankSeq")  
);

COMMENT ON COLUMN "Base"."TB_Bank"."BankSeq" IS '은행 내부코드';	
COMMENT ON COLUMN "Base"."TB_Bank"."BankName" IS '은행 명칭';	
COMMENT ON COLUMN "Base"."TB_Bank"."CodeNo" IS '고유 코드번호';	
COMMENT ON COLUMN "Base"."TB_Bank"."SwiftCodeNo" IS 'Swift 코드 번호';	
COMMENT ON COLUMN "Base"."TB_Bank"."Remark" IS '비고';	