CREATE TABLE "Rpt"."TR_Report"
( 
   "UserSeq" VARCHAR(50) NOT NULL
  ,"ReportSeq" INT	 NOT NULL
  ,"Title" VARCHAR(200) NOT NULL
  ,"SubjectType" INT	 NOT NULL
  ,"Keyword" VARCHAR(50) NOT NULL
  ,"IsOpen" CHAR(1) NOT NULL
  ,"PDF" VARCHAR(300) NULL
  ,"MainComment" VARCHAR(300) NULL
  ,"Remark" VARCHAR(100) NULL
  ,CONSTRAINT TR_Report_PK PRIMARY KEY ("UserSeq", "ReportSeq")
  ,CONSTRAINT TR_Report_FK FOREIGN KEY ("UserSeq") REFERENCES "Base"."TB_User"("UserSeq") ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN "Rpt"."TR_Report"."UserSeq" IS '사용자 내부코드';
COMMENT ON COLUMN "Rpt"."TR_Report"."ReportSeq" IS '보고서 내부코드';
COMMENT ON COLUMN "Rpt"."TR_Report"."Title" IS '제목';
COMMENT ON COLUMN "Rpt"."TR_Report"."SubjectType" IS '주제 분류';
COMMENT ON COLUMN "Rpt"."TR_Report"."Keyword" IS '키워드';
COMMENT ON COLUMN "Rpt"."TR_Report"."IsOpen" IS '공개 여부';
COMMENT ON COLUMN "Rpt"."TR_Report"."PDF" IS 'PDF 파일 경로';
COMMENT ON COLUMN "Rpt"."TR_Report"."MainComment" IS '댓글 대표 글';
COMMENT ON COLUMN "Rpt"."TR_Report"."Remark" IS '비고';
