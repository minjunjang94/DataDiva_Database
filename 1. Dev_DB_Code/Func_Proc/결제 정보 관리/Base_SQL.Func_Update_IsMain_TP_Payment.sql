CREATE OR REPLACE FUNCTION "Base_SQL"."Base_SQL.Func_Update_IsMain_TP_Payment"(
    "InData_UserSeq" VARCHAR(50) -- 사용자 내부코드
   ,"InData_PaymentSeq" INT -- 결제 내부코드
   ,"InData_IsMainPayment" CHAR(1) -- 메인 결제 수단 여부
)
RETURNS TABLE (
    "ErrorCheck" INT,
    "Status" TEXT,
    "Message" TEXT,
    "PaymentSeq" INT,
	"IsMainPayment" CHAR(1)
)
LANGUAGE plpgsql
AS $$
DECLARE
	"Var_Check" INT = 0;
BEGIN
/*    
-- ************************************************************************************ --
Create Name	: 결제 정보 메인 카드 Update
Create Date	: 2024-06-26
Create Emp		: JayJun
Update Emp 	:
-- ************************************************************************************ --
*/

    EXECUTE format($f$
        SELECT CASE WHEN EXISTS (
        		SELECT 1 FROM "Amt"."TP_Payment" WHERE "UserSeq" = %L AND  "IsMainPayment" = '1'
            ) THEN 1 ELSE 0 END;
    $f$, "InData_UserSeq", "InData_PaymentSeq")
    INTO "Var_Check";

  
    IF '1' = "InData_IsMainPayment" THEN
		IF '0' = "Var_Check" THEN
			RAISE NOTICE '[Check1 : 정상]';
		ELSE
			-- 프로세스 종료 및 에러 메시지 출력 --
			RETURN QUERY SELECT 9999 AS "ErrorCheck", 'error' AS "Status", '메인 카드로 등록되어 있는 카드가 존재합니다.' AS "Message", "InData_PaymentSeq" AS "PaymentSeq", "InData_IsMainPayment" AS "IsMainPayment";
			RETURN;
		END IF;	
	ELSE
		RAISE NOTICE '[Check2 : 정상]';
	END IF;		
	
    -- 결제 정보 메인 카드  Update
    EXECUTE format($f$
		UPDATE "Amt"."TP_Payment"
		   SET "IsMainPayment" = %L
		 WHERE "UserSeq" = %L
		   AND "PaymentSeq" = %L;
	$f$, "InData_IsMainPayment", "InData_UserSeq", "InData_PaymentSeq");

    -- 성공 메시지 반환
    RETURN QUERY SELECT
        1111 AS "ErrorCheck",
        'success' AS "Status",
        '보고서 정보 Update 완료' AS "Message",
        "InData_PaymentSeq" AS "PaymentSeq",
		"InData_IsMainPayment" AS "IsMainPayment";
END;
$$;

SELECT * FROM "Base_SQL"."Base_SQL.Func_Update_IsMain_TP_Payment"('test_UserSeq0912843024', 3, '1');