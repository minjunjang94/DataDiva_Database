CREATE TABLE "Rpt"."TR_ReportRef"
( 
   "UserSeq" VARCHAR(50) NOT NULL
  ,"ReportSeq" INT	 NOT NULL
  ,"RefSeq" INT	 NOT NULL
  ,"RefTitle" VARCHAR(200) NOT NULL
  ,"StartCheckTime" TIMESTAMP NOT NULL
  ,"EndCheckTime" TIMESTAMP NULL
  ,"RefStatus" INT	 NOT NULL
  ,"Remark" VARCHAR(100) NULL
  ,CONSTRAINT TR_ReportRef_PK PRIMARY KEY ("UserSeq", "ReportSeq", "RefSeq")
  ,CONSTRAINT TR_ReportRef_FK FOREIGN KEY ("UserSeq") REFERENCES "Base"."TB_User"("UserSeq") ON DELETE CASCADE ON UPDATE CASCADE
  ,CONSTRAINT TR_ReportRef_FK2 FOREIGN KEY ("UserSeq", "ReportSeq") REFERENCES "Rpt"."TR_Report"("UserSeq", "ReportSeq") ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN "Rpt"."TR_ReportRef"."UserSeq" IS '사용자 내부코드';
COMMENT ON COLUMN "Rpt"."TR_ReportRef"."ReportSeq" IS '보고서 내부코드';
COMMENT ON COLUMN "Rpt"."TR_ReportRef"."RefSeq" IS '참고자료 내부코드';
COMMENT ON COLUMN "Rpt"."TR_ReportRef"."RefTitle" IS '자료 제목';
COMMENT ON COLUMN "Rpt"."TR_ReportRef"."StartCheckTime" IS '심사 신청 일자';
COMMENT ON COLUMN "Rpt"."TR_ReportRef"."EndCheckTime" IS '심사 완료 일자';
COMMENT ON COLUMN "Rpt"."TR_ReportRef"."RefStatus" IS '등록심사 현황';
COMMENT ON COLUMN "Rpt"."TR_ReportRef"."Remark" IS '비고';
