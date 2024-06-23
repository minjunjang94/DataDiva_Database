CREATE TABLE "Base"."TB_Country"
( 

"CountrySeq"		INT		NOT NULL				
,"CountryName"		VARCHAR(150)	NOT NULL		
,"CountryEngName"	VARCHAR(150)	NOT NULL			
,"Abbreviation1"	VARCHAR(50)	NOT NULL			
,"Abbreviation2"	VARCHAR(50)	NOT NULL			
,"PhoneCode"		VARCHAR(50)	NOT NULL				
,"Remark"			VARCHAR(100)	NULL			
,CONSTRAINT TB_Country_PK PRIMARY KEY ("CountrySeq")  

	
);

COMMENT ON COLUMN "Base"."TB_Country"."CountrySeq" IS '국가내부코드';
COMMENT ON COLUMN "Base"."TB_Country"."CountryName" IS '국가한글명';
COMMENT ON COLUMN "Base"."TB_Country"."CountryEngName" IS '국가영문명';
COMMENT ON COLUMN "Base"."TB_Country"."Abbreviation1" IS '국가약명1';
COMMENT ON COLUMN "Base"."TB_Country"."Abbreviation2" IS '국가약명2'; 
COMMENT ON COLUMN "Base"."TB_Country"."PhoneCode" IS '국가전화코드';
COMMENT ON COLUMN "Base"."TB_Country"."Remark" IS '비고';

