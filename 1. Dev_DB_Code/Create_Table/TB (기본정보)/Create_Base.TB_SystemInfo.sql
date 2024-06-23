CREATE SEQUENCE "Base"."Sequence_TB_SystemInfo_SysInfoSeq"
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999999
	START 1
	CACHE 1
	CYCLE;

CREATE TABLE "Base"."TB_SystemInfo"
( 
"SysInfoSeq" INT		NOT NULL DEFAULT nextval ('"Base"."Sequence_TB_SystemInfo_SysInfoSeq"')		
,"SysInfoType" INT		NOT NULL
,"SysInfoPost" VARCHAR(3000)	NOT NULL
,"Remark" VARCHAR(100)	NULL	
,CONSTRAINT TB_SystemInfo_PK PRIMARY KEY ("SysInfoSeq")  
);
 
COMMENT ON COLUMN "Base"."TB_SystemInfo"."SysInfoSeq"  IS '시스템 정보 내부코드';
COMMENT ON COLUMN "Base"."TB_SystemInfo"."SysInfoType"  IS '시스템 정보 타입';
COMMENT ON COLUMN "Base"."TB_SystemInfo"."SysInfoPost"  IS '시스템 정보 내용';
COMMENT ON COLUMN "Base"."TB_SystemInfo"."Remark"  IS '비고';
 
