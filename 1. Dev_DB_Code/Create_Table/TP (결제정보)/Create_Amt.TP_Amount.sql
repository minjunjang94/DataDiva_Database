CREATE TABLE "Amt"."TP_Amount"
( 
   "UserSeq" VARCHAR(50) NOT NULL
  ,"CurrentAmt" INT	 NOT NULL
  ,"IsAutoCha" CHAR(1) NOT NULL
  ,"AutoLimitAmt" INT	 NULL
  ,"AutoPaymentSeq" INT	 NULL
  ,"AutoChaAmt" INT	 NULL
  ,"Remark" VARCHAR(100) NULL
  ,CONSTRAINT TB_User_PK PRIMARY KEY ("UserSeq")
);

COMMENT ON COLUMN "Amt"."TP_Amount"."UserSeq" IS '사용자 내부코드';
COMMENT ON COLUMN "Amt"."TP_Amount"."CurrentAmt" IS '현재 잔액';
COMMENT ON COLUMN "Amt"."TP_Amount"."IsAutoCha" IS '자동 충전 설정 여부';
COMMENT ON COLUMN "Amt"."TP_Amount"."AutoLimitAmt" IS '최소 임계 금액 ';
COMMENT ON COLUMN "Amt"."TP_Amount"."AutoPaymentSeq" IS '자동 충전 결제 내부코드';
COMMENT ON COLUMN "Amt"."TP_Amount"."AutoChaAmt" IS '자동 충전 금액';
COMMENT ON COLUMN "Amt"."TP_Amount"."Remark" IS '비고';
