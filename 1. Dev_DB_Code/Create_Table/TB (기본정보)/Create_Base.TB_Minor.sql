CREATE TABLE "Base"."TB_Minor"
( 
"MinorSeq"		INT		NOT NULL 	
,"MajorSeq"		INT 	NOT NULL		
,"MinorName"	VARCHAR(80)	NOT NULL
,"Remark"	VARCHAR(100)	 NULL			
,CONSTRAINT TB_Minor_PK PRIMARY KEY ("MinorSeq")  
,CONSTRAINT TB_Minor_FK FOREIGN KEY ("MajorSeq") REFERENCES "Base"."TB_Major"("MajorSeq") ON DELETE CASCADE ON UPDATE CASCADE);

COMMENT ON COLUMN "Base"."TB_Minor"."MinorSeq" IS 'Minor Seq';
COMMENT ON COLUMN "Base"."TB_Minor"."MajorSeq" IS 'Major Seq';
COMMENT ON COLUMN "Base"."TB_Minor"."MinorName" IS 'Minor 명';
COMMENT ON COLUMN "Base"."TB_Minor"."Remark" IS '비고';