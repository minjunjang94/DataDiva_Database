CREATE TABLE "Base"."TB_Major"
( 
"MajorSeq"		INT		NOT NULL				
,"MajorName"		VARCHAR(40)	NOT NULL		
,"Remark"	VARCHAR(100)	NULL			
,CONSTRAINT TB_Major_PK PRIMARY KEY ("MajorSeq")  
);

COMMENT ON COLUMN "Base"."TB_Major"."MajorSeq" IS 'Major Seq';
COMMENT ON COLUMN "Base"."TB_Major"."MajorName" IS 'Major 명';
COMMENT ON COLUMN "Base"."TB_Major"."Remark" IS '비고';
 
 
