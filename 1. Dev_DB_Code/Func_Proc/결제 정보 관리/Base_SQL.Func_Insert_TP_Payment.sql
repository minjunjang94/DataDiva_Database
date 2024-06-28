CREATE OR REPLACE FUNCTION "Base_SQL"."Func_Insert_TP_Payment"(
     "InData_UserSeq"	VARCHAR(50)  -- 사용자 내부코드
	,"InData_PaymentNetwork"	VARCHAR(30)  -- 결제 네트워크
	,"InData_CardNumber"	VARCHAR(20)  -- 카드 번호
	,"InData_VP_Year"	CHAR(2)  -- 유효기간_년
	,"InData_VP_Month"	CHAR(2)  -- 유효기간_월
	,"InData_CVC"	INT	  -- CVC번호
	,"InData_Card_PW"	CHAR(2)  -- 비밀번호(앞 2자리)
	,"InData_CardAlias"	VARCHAR(20)  -- 카드 별칭
	,"InData_IsAgreement"	CHAR(1)  -- 카드사 개인정보 제 3차 제공 동의 여부
)
RETURNS TABLE (
    "ErrorCheck" INT,
    "Status" TEXT,
    "Message" TEXT,
    "PaymentSeq" INT
)
LANGUAGE plpgsql
AS $$
DECLARE
	"Var_PaymentSeq" INT = 0;
	"Var_Check" INT = 0;
BEGIN
/*    
-- ************************************************************************************ --
Create Name	: 결제 정보 Insert
Create Date		: 2024-06-28
Create Emp		: JayJun
Update Emp 	:
-- ************************************************************************************ --
*/

    EXECUTE format($f$
        SELECT CASE WHEN EXISTS (
        		SELECT 1 FROM "Amt"."TP_Payment" WHERE "UserSeq" = %L AND "CardNumber" = %L
            ) THEN 1 ELSE 0 END;
    $f$, "InData_UserSeq", "InData_CardNumber")
    INTO "Var_Check";

    -- Check1 : 동일한 CardNumber 데이터 존재여부 --
   	IF '0'= "Var_Check" THEN
    	RAISE NOTICE '[Check1 : 정상]';
    ELSE
    	-- 프로세스 종료 및 에러 메시지 출력 --
    	RETURN QUERY SELECT
        	9999 AS "ErrorCheck",
        	'fail' AS "Status",
        	'동일한 카드가 이미 등록되어 있습니다.' AS "Message",
        	0 AS "PaymentSeq";
    	RETURN;
    END IF;	

	-- Var_PaymentSeq 값 생성
    EXECUTE format($f$
		SELECT COALESCE(MAX("PaymentSeq") + 1, 1) AS MAX_ReportSeq FROM "Amt"."TP_Payment" WHERE "UserSeq" = %L;
    $f$, "InData_UserSeq")
	INTO "Var_PaymentSeq";

    -- 결제 정보  Insert
    EXECUTE format($f$
		INSERT INTO "Amt"."TP_Payment" ("UserSeq","PaymentSeq","IsMainPayment","PaymentNetwork","CardNumber","VP_Year","VP_Month","CVC","Card_PW","CardAlias","IsAgreement") 
		VALUES (%L, %L, '0', %L, %L, %L, %L, %L, %L, %L, %L);
    $f$, "InData_UserSeq", "Var_PaymentSeq", "InData_PaymentNetwork", "InData_CardNumber", "InData_VP_Year", "InData_VP_Month", "InData_CVC", "InData_Card_PW", "InData_CardAlias", "InData_IsAgreement");

    -- 성공 메시지 반환
    RETURN QUERY SELECT
        1111 AS "ErrorCheck",
        'success' AS "Status",
        '결제 정보 Insert 완료' AS "Message",
        "Var_PaymentSeq" AS "PaymentSeq";
 
END;
$$;

SELECT * FROM "Base_SQL"."Func_Insert_TP_Payment"('test_UserSeq0912843024', 'Master', '123123132', '12', '23', 777, '12', 'testCard', '1');
