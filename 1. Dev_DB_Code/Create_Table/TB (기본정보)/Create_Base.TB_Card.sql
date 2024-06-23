CREATE TABLE "Base"."TB_Card"
( 
 "CardSeq" INT NOT NULL
,"CardName" VARCHAR(100) NOT NULL
,"CardNo" INT NOT NULL
,"Remark" VARCHAR(100) NULL
,CONSTRAINT TB_Card_PK PRIMARY KEY ("CardSeq")  
);

COMMENT ON COLUMN "Base"."TB_Card"."CardSeq" IS '은행 내부코드';	
COMMENT ON COLUMN "Base"."TB_Card"."CardName" IS '은행 명칭';	
COMMENT ON COLUMN "Base"."TB_Card"."CardNo" IS '고유 코드번호';
COMMENT ON COLUMN "Base"."TB_Card"."Remark" IS '비고';	
