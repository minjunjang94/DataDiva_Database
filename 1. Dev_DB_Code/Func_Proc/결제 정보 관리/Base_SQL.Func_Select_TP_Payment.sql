CREATE OR REPLACE FUNCTION "Base_SQL"."Func_Select_TP_Payment"(
    "InData_UserSeq" VARCHAR(50) -- 사용자 내부코드
)
RETURNS TABLE (
    "UserSeq" VARCHAR(50),
	"PaymentSeq" INT,
	"IsMainPayment" CHAR(1),
	"PaymentNetwork" VARCHAR(30),
	"CardNumber" VARCHAR(20),
	"VP_Year" CHAR(2),
	"VP_Month" CHAR(2),
	"CVC" INT,
	"Card_PW" CHAR(2),
	"CardAlias" VARCHAR(20),
	"IsAgreement" CHAR(1)
)
LANGUAGE plpgsql
AS $$
BEGIN
/*    
-- ************************************************************************************ --
Create Name	: 결제 정보 Select
Create Date  : 2024-06-26
Create Emp   : JayJun
Update Emp   :
-- ************************************************************************************ --
*/

    -- 내 보고서 조회
    RETURN QUERY 
    SELECT
        A."UserSeq",
		A."PaymentSeq",
        A."IsMainPayment",
		A."PaymentNetwork",
		A."CardNumber",
		A."VP_Year",
		A."VP_Month",
		A."CVC",
		A."Card_PW",
		A."CardAlias",
		A."IsAgreement"
    FROM "Amt"."TP_Payment" AS A
    WHERE A."UserSeq" = "InData_UserSeq"
	ORDER BY A."PaymentSeq" ASC;

END;
$$;

SELECT * FROM "Base_SQL"."Func_Select_TP_Payment"('test_UserSeq0912843024');
