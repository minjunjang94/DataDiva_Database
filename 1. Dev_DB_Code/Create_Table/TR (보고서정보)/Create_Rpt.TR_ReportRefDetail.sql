CREATE TABLE "Rpt"."TR_ReportRefDetail"
( 
   "UserSeq" VARCHAR(50) NOT NULL
  ,"ReportSeq" INT	 NOT NULL
  ,"RefSeq" INT	 NOT NULL
  ,"Source" VARCHAR(200) NOT NULL
  ,"PDF" VARCHAR(300) NOT NULL
  ,"Link" VARCHAR(200) NOT NULL
  ,"Remark" VARCHAR(100) NULL
  ,CONSTRAINT TR_ReportRefDetail_PK PRIMARY KEY ("UserSeq", "ReportSeq", "RefSeq")
  ,CONSTRAINT TR_ReportRefDetail_FK FOREIGN KEY ("UserSeq") REFERENCES "Base"."TB_User"("UserSeq") ON DELETE CASCADE ON UPDATE CASCADE
  ,CONSTRAINT TR_ReportRefDetail_FK2 FOREIGN KEY ("UserSeq", "ReportSeq") REFERENCES "Rpt"."TR_Report"("UserSeq", "ReportSeq") ON DELETE CASCADE ON UPDATE CASCADE
  ,CONSTRAINT TR_ReportRefDetail_FK3 FOREIGN KEY ("UserSeq", "ReportSeq", "RefSeq") REFERENCES "Rpt"."TR_ReportRef"("UserSeq", "ReportSeq", "RefSeq") ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN "Rpt"."TR_ReportRefDetail"."UserSeq" IS '사용자 내부코드';
COMMENT ON COLUMN "Rpt"."TR_ReportRefDetail"."ReportSeq" IS '보고서 내부코드';
COMMENT ON COLUMN "Rpt"."TR_ReportRefDetail"."RefSeq" IS '참고자료 내부코드';
COMMENT ON COLUMN "Rpt"."TR_ReportRefDetail"."Source" IS '출처';
COMMENT ON COLUMN "Rpt"."TR_ReportRefDetail"."PDF" IS 'PDF 파일 경로';
COMMENT ON COLUMN "Rpt"."TR_ReportRefDetail"."Link" IS '출처 링크';
COMMENT ON COLUMN "Rpt"."TR_ReportRefDetail"."Remark" IS '비고';
