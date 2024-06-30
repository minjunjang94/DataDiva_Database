CREATE TABLE "Amt"."TP_Refund"
( 
   "UserSeq" VARCHAR(50) NOT NULL
  ,"RefundNo" VARCHAR(30) NOT NULL
  ,"RefundDateTime" TIMESTAMP	 NOT NULL
  ,"RefundAmt" INT	 NOT NULL
  ,"BankSeq" INT	 NOT NULL
  ,"BankNumber" VARCHAR(30)	 NOT NULL
  ,"RefundStatus" INT	 NOT NULL
  ,"RefundDateEndTime" TIMESTAMP	 NULL  
  ,"RefundReason" VARCHAR(200) NULL
  ,"Remark" VARCHAR(100) NULL
  ,CONSTRAINT TP_Refund_PK PRIMARY KEY ("UserSeq", "RefundNo")
  ,CONSTRAINT TP_Refund_FK FOREIGN KEY ("UserSeq") REFERENCES "Base"."TB_User"("UserSeq") ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN "Amt"."TP_Refund"."UserSeq" IS '사용자 내부코드';
COMMENT ON COLUMN "Amt"."TP_Refund"."RefundNo" IS '환불 신청 번호';
COMMENT ON COLUMN "Amt"."TP_Refund"."RefundDateTime" IS '환불 신청일';
COMMENT ON COLUMN "Amt"."TP_Refund"."RefundAmt" IS '신청 금액';
COMMENT ON COLUMN "Amt"."TP_Refund"."BankSeq" IS '환불 은행';
COMMENT ON COLUMN "Amt"."TP_Refund"."BankNumber" IS '환불 계좌 번호';
COMMENT ON COLUMN "Amt"."TP_Refund"."RefundStatus" IS '진행현황';
COMMENT ON COLUMN "Amt"."TP_Refund"."RefundDateEndTime" IS '환불 결과일';
COMMENT ON COLUMN "Amt"."TP_Refund"."RefundReason" IS '환불 거절 사유';
COMMENT ON COLUMN "Amt"."TP_Refund"."Remark" IS '비고';
