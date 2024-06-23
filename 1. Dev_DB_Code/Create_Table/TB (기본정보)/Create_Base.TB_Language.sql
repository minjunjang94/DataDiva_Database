CREATE SEQUENCE "Base"."Sequence_TB_Language_LanguageSeq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
	START 1
	CACHE 1
	CYCLE;

CREATE TABLE "Base"."TB_Language"
( 

"LanguageSeq"		INT		NOT NULL DEFAULT nextval ('"Base"."Sequence_TB_Language_LanguageSeq"')					
,"LanguageName"		VARCHAR(150) 	NOT NULL		
,"LanguageEngName"	VARCHAR(150)	NOT NULL
,"Remark"			VARCHAR(100)	 NULL			
,CONSTRAINT TB_Language_PK PRIMARY KEY ("LanguageSeq")  
);

COMMENT ON COLUMN "Base"."TB_Language"."LanguageSeq" IS '언어내부코드';
COMMENT ON COLUMN "Base"."TB_Language"."LanguageName" IS '언어명';
COMMENT ON COLUMN "Base"."TB_Language"."LanguageEngName" IS '(영문)언어명';
COMMENT ON COLUMN "Base"."TB_Language"."Remark" IS '비고'; 




