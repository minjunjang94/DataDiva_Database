CREATE TABLE "Rpt"."TR_Report"
( 
   "UserSeq" VARCHAR(50) NOT NULL
  ,"ReportSeq" INT	 NOT NULL
  ,"Title" VARCHAR(200) NOT NULL
  ,"SubjectType" INT	 NOT NULL
  ,"Keyword1" VARCHAR(50) NOT NULL
  ,"Keyword2" VARCHAR(50) NULL
  ,"Keyword3" VARCHAR(50) NULL
  ,"Keyword4" VARCHAR(50) NULL
  ,"Keyword5" VARCHAR(50) NULL
  ,"IsOpen" CHAR(1) NOT NULL
  ,"PDF" VARCHAR(300) NULL
  ,"MainComment" VARCHAR(300) NULL
  ,"CreateDateTime" TIMESTAMP NOT NULL
  ,"Remark" VARCHAR(100) NULL
  ,CONSTRAINT TR_Report_PK PRIMARY KEY ("UserSeq", "ReportSeq")
  ,CONSTRAINT TR_Report_FK FOREIGN KEY ("UserSeq") REFERENCES "Base"."TB_User"("UserSeq") ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN "Rpt"."TR_Report"."UserSeq" IS '사용자 내부코드';
COMMENT ON COLUMN "Rpt"."TR_Report"."ReportSeq" IS '보고서 내부코드';
COMMENT ON COLUMN "Rpt"."TR_Report"."Title" IS '제목';
COMMENT ON COLUMN "Rpt"."TR_Report"."SubjectType" IS '주제 분류';
COMMENT ON COLUMN "Rpt"."TR_Report"."Keyword1" IS '키워드1';
COMMENT ON COLUMN "Rpt"."TR_Report"."Keyword2" IS '키워드2';
COMMENT ON COLUMN "Rpt"."TR_Report"."Keyword3" IS '키워드3';
COMMENT ON COLUMN "Rpt"."TR_Report"."Keyword4" IS '키워드4';
COMMENT ON COLUMN "Rpt"."TR_Report"."Keyword5" IS '키워드5';
COMMENT ON COLUMN "Rpt"."TR_Report"."IsOpen" IS '공개 여부';
COMMENT ON COLUMN "Rpt"."TR_Report"."PDF" IS 'PDF 파일 경로';
COMMENT ON COLUMN "Rpt"."TR_Report"."MainComment" IS '댓글 대표 글';
COMMENT ON COLUMN "Rpt"."TR_Report"."CreateDateTime" IS '생성일자';
COMMENT ON COLUMN "Rpt"."TR_Report"."Remark" IS '비고';
