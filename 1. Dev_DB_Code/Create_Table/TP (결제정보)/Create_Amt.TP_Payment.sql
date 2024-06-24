CREATE TABLE "Amt"."TP_Payment"
( 
   "UserSeq" VARCHAR(50) NOT NULL
  ,"PaymentSeq" INT	 NOT NULL
  ,"IsMainPayment" CHAR(1) NOT NULL
  ,"PaymentNetwork" VARCHAR(30) NOT NULL
  ,"CardNumber" CHAR(8) NOT NULL
  ,"VP_Year" CHAR(2) NOT NULL
  ,"VP_Month" CHAR(2) NOT NULL
  ,"CVC" INT	 NOT NULL
  ,"Card_PW" CHAR(2) NOT NULL
  ,"CardAlias" VARCHAR(20) NOT NULL
  ,"IsAgreement" CHAR(1) NOT NULL
  ,"Remark" VARCHAR(100) NULL
  ,CONSTRAINT TP_Payment_PK PRIMARY KEY ("UserSeq", "PaymentSeq")
  ,CONSTRAINT TP_Payment_FK FOREIGN KEY ("UserSeq") REFERENCES "Base"."TB_User"("UserSeq") ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN "Amt"."TP_Payment"."UserSeq" IS '사용자 내부코드';
COMMENT ON COLUMN "Amt"."TP_Payment"."PaymentSeq" IS '결제 내부코드';
COMMENT ON COLUMN "Amt"."TP_Payment"."IsMainPayment" IS '메인 결제 수단 여부';
COMMENT ON COLUMN "Amt"."TP_Payment"."PaymentNetwork" IS '결제 네트워크';
COMMENT ON COLUMN "Amt"."TP_Payment"."CardNumber" IS '카드 번호';
COMMENT ON COLUMN "Amt"."TP_Payment"."VP_Year" IS '유효기간_년';
COMMENT ON COLUMN "Amt"."TP_Payment"."VP_Month" IS '유효기간_월';
COMMENT ON COLUMN "Amt"."TP_Payment"."CVC" IS 'CVC번호';
COMMENT ON COLUMN "Amt"."TP_Payment"."Card_PW" IS '비밀번호(앞 2자리)';
COMMENT ON COLUMN "Amt"."TP_Payment"."CardAlias" IS '카드 별칭';
COMMENT ON COLUMN "Amt"."TP_Payment"."IsAgreement" IS '카드사 개인정보 제 3차 제공 동의 여부';
COMMENT ON COLUMN "Amt"."TP_Payment"."Remark" IS '비고';
