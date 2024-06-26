CREATE TABLE "Rpt"."TR_ReportDetail"
( 
   "UserSeq" VARCHAR(50) NOT NULL
  ,"ReportSeq" INT NOT NULL
  ,"Report" TEXT NOT NULL
  ,"Remark" VARCHAR(100) NULL
  ,CONSTRAINT TR_ReportDetail_PK PRIMARY KEY ("UserSeq", "ReportSeq")
  ,CONSTRAINT TR_ReportDetail_FK FOREIGN KEY ("UserSeq") REFERENCES "Base"."TB_User"("UserSeq") ON DELETE CASCADE ON UPDATE CASCADE
  ,CONSTRAINT TR_ReportDetail_FK2 FOREIGN KEY ("UserSeq", "ReportSeq") REFERENCES "Rpt"."TR_Report"("UserSeq", "ReportSeq") ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN "Rpt"."TR_ReportDetail"."UserSeq" IS '사용자 내부코드';
COMMENT ON COLUMN "Rpt"."TR_ReportDetail"."ReportSeq" IS '보고서 내부코드';
COMMENT ON COLUMN "Rpt"."TR_ReportDetail"."Report" IS '보고서 내용';
COMMENT ON COLUMN "Rpt"."TR_ReportDetail"."Remark" IS '비고';
