CREATE TABLE "Amt"."TP_ChrHistory"
( 
   "UserSeq" VARCHAR(50) NOT NULL
  ,"ChrNo" VARCHAR(30) NOT NULL
  ,"PaymentSeq" INT	 NOT NULL
  ,"ChrAmt" INT	 NOT NULL
  ,"ChrDateTime" TIMESTAMP	 NOT NULL
  ,"Remark" VARCHAR(100) NULL
  ,CONSTRAINT TP_ChrHistory_PK PRIMARY KEY ("UserSeq", "ChrNo")
  ,CONSTRAINT TP_ChrHistory_FK FOREIGN KEY ("UserSeq") REFERENCES "Base"."TB_User"("UserSeq") ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN "Amt"."TP_ChrHistory"."UserSeq" IS '사용자 내부코드';
COMMENT ON COLUMN "Amt"."TP_ChrHistory"."ChrNo" IS '청구서 번호';
COMMENT ON COLUMN "Amt"."TP_ChrHistory"."PaymentSeq" IS '결제 내부코드';
COMMENT ON COLUMN "Amt"."TP_ChrHistory"."ChrAmt" IS '결제 금액';
COMMENT ON COLUMN "Amt"."TP_ChrHistory"."ChrDateTime" IS '결제일';
COMMENT ON COLUMN "Amt"."TP_ChrHistory"."Remark" IS '비고';
