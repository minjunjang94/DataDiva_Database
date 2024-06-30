CREATE OR REPLACE FUNCTION "Base_SQL"."Func_Apply_TP_Refund"(
      "InData_UserSeq" VARCHAR(50) -- 사용자 내부코드
	 ,"InData_RefundAmt"	INT	 -- 신청 금액
	 ,"InData_BankSeq"	INT	 -- 환불 은행
	 ,"InData_BankNumber"	VARCHAR(30)	 -- 환불 계좌 번호
)
RETURNS TABLE (
    "ErrorCheck" INT,
    "Status" TEXT,
    "Message" TEXT,
    "RefundNo" VARCHAR(30)
)
LANGUAGE plpgsql
AS $$
DECLARE
	"Var_Check1" INT = 0;
	"Var_Check2" INT = 0;
    "Var_DateTime" VARCHAR(30) = '';
	"Var_RefundNo" VARCHAR(30) = '';
BEGIN
/*    
-- ************************************************************************************ --
Create Name	: 환불 내역 정보 Apply
Create Date		: 2024-06-28
Create Emp		: JayJun
Update Emp 	:
-- ************************************************************************************ --
*/

    -- Check0 : InData_RefundAmt 값이 0일 경우 에러 발생
    IF "InData_RefundAmt" = 0 THEN
        RETURN QUERY SELECT
            9999 AS "ErrorCheck",
            'fail' AS "Status",
            '환불 금액은 0보다 커야 합니다.' AS "Message",
            ''::VARCHAR(30) AS "RefundNo";
        RETURN;
    END IF;

    -- Check1 : "Amt"."TP_Amount"의 현재 잔액이 환불 금액보다 적으면 에러발생 --
    EXECUTE format($f$
        SELECT CASE WHEN EXISTS (
            SELECT 1
            FROM "Amt"."TP_Amount" 
            WHERE "UserSeq" = %L AND "CurrentAmt" < %L
        ) THEN 1 ELSE 0 END
    $f$, "InData_UserSeq", "InData_RefundAmt")
    INTO "Var_Check1";

   	IF '0' = "Var_Check1" THEN
    	RAISE NOTICE '[Check1 : 정상]';
    ELSE
    	-- 프로세스 종료 및 에러 메시지 출력 --
    	RETURN QUERY SELECT
        	9999 AS "ErrorCheck",
        	'fail' AS "Status",
        	'현재 잔액보다 많은 금액을 환불신청할 수 없습니다.' AS "Message",
        	''::VARCHAR(30) AS "RefundNo";
    	RETURN;
    END IF;		

    -- Check2 : 환불 진행 중인 건이 있을 경우 에러발생 --
    EXECUTE format($f$
        SELECT CASE WHEN EXISTS (
			SELECT 1 FROM "Amt"."TP_Refund" WHERE "UserSeq" = %L AND "RefundStatus" = 2003001 -- 환불 진행중
        ) THEN 1 ELSE 0 END
    $f$, "InData_UserSeq")
    INTO "Var_Check2";

   	IF '0' = "Var_Check2" THEN
    	RAISE NOTICE '[Check2 : 정상]';
    ELSE
    	-- 프로세스 종료 및 에러 메시지 출력 --
    	RETURN QUERY SELECT
        	9999 AS "ErrorCheck",
        	'fail' AS "Status",
        	'환불 진행 중인 건이 있습니다. 진행된 건이 마무리 된 뒤에 환불 요청을 할 수 있습니다.' AS "Message",
        	''::VARCHAR(30)  AS "RefundNo";
    	RETURN;
    END IF;	

    "Var_DateTime" = (SELECT TO_CHAR(NOW(), 'YYYY/MM/DD HH24:MI:SS'));

	-- Var_RefundNo 값 생성
    EXECUTE format($f$
		SELECT CONCAT('R', TO_CHAR(NOW(), 'YYYYMMDD'), '-', RIGHT(%L, 3), TO_CHAR(NOW(), 'HH24MISS'))
    $f$, "InData_UserSeq")
	INTO "Var_RefundNo";

    -- 환불 내역 정보 Insert
    EXECUTE format($f$
		INSERT INTO "Amt"."TP_Refund" ("UserSeq", "RefundNo", "RefundDateTime", "RefundAmt", "BankSeq", "BankNumber", "RefundStatus") 
		VALUES (%L, %L, %L, %L, %L, %L, 2003001);
    $f$, "InData_UserSeq", "Var_RefundNo", "Var_DateTime", "InData_RefundAmt", "InData_BankSeq", "InData_BankNumber");
	
    -- 현재 잔액 - 환불 신청 금액 
    EXECUTE format($f$
		UPDATE "Amt"."TP_Amount"
		SET "CurrentAmt" = "CurrentAmt" - %L
		WHERE "UserSeq" = %L;
    $f$, "InData_RefundAmt", "InData_UserSeq");	
	

    -- 성공 메시지 반환
    RETURN QUERY SELECT
        1111 AS "ErrorCheck",
        'success' AS "Status",
        '환불 Apply 완료' AS "Message",
        "Var_RefundNo" AS "RefundNo";
END;
$$;

SELECT * FROM "Base_SQL"."Func_Apply_TP_Refund"('test_UserSeq0912843024', 13000, 1, '1002985135329');