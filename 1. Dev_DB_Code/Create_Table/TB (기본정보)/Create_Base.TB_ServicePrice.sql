CREATE TABLE "Base"."TB_ServicePrice"
( 
 "ServiceCode" INT NOT NULL		
,"ServiceName" VARCHAR(150) NOT NULL		
,"Price" INT NOT NULL		
,"Remark" VARCHAR(100) NULL					
,CONSTRAINT TB_ServicePrice_PK PRIMARY KEY ("ServiceCode")  
);

COMMENT ON COLUMN "Base"."TB_ServicePrice"."ServiceCode" IS '서비스 코드';	
COMMENT ON COLUMN "Base"."TB_ServicePrice"."ServiceName" IS '서비스 명칭';	
COMMENT ON COLUMN "Base"."TB_ServicePrice"."Price" IS '가격';	
COMMENT ON COLUMN "Base"."TB_ServicePrice"."Remark" IS '비고';	
