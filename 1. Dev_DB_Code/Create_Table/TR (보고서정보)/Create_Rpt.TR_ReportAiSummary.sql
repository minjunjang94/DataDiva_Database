CREATE TABLE "Rpt"."TR_ReportAiSummary"
( 
   "UserSeq" VARCHAR(50) NOT NULL
  ,"ReportSeq" INT	 NOT NULL
  ,"Summary" TEXT	 NOT NULL
  ,"Remark" VARCHAR(100) NULL
  ,CONSTRAINT TR_ReportAiSummary_PK PRIMARY KEY ("UserSeq", "ReportSeq")
  ,CONSTRAINT TR_ReportAiSummary_FK FOREIGN KEY ("UserSeq") REFERENCES "Base"."TB_User"("UserSeq") ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN "Rpt"."TR_ReportAiSummary"."UserSeq" IS '사용자 내부코드';
COMMENT ON COLUMN "Rpt"."TR_ReportAiSummary"."ReportSeq" IS '보고서 내부코드';
COMMENT ON COLUMN "Rpt"."TR_ReportAiSummary"."Summary" IS 'AI 요약 내용';
COMMENT ON COLUMN "Rpt"."TR_ReportAiSummary"."Remark" IS '비고';
