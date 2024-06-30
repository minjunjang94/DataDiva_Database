CREATE OR REPLACE FUNCTION "Base_SQL"."Func_Success_TP_Refund"(
    "InData_UserSeq" VARCHAR(50) -- 사용자 내부코드
   ,"InData_RefundNo" VARCHAR(30) -- 환불 신청 번호
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
	"Var_Check" INT = 0;
    "Var_DateTime" VARCHAR(30) = '';
BEGIN
/*    
-- ************************************************************************************ --
Create Name	: 환불 내역 정보 Success
Create Date	: 2024-06-30
Create Emp		: JayJun
Update Emp 	:
-- ************************************************************************************ --
*/
    "Var_DateTime" = (SELECT TO_CHAR(NOW(), 'YYYY/MM/DD HH24:MI:SS'));
	
    EXECUTE format($f$
        SELECT CASE WHEN EXISTS (
        		SELECT 1 FROM "Amt"."TP_Refund" WHERE "UserSeq" = %L AND "RefundNo" = %L
            ) THEN 1 ELSE 0 END;
    $f$, "InData_UserSeq", "InData_RefundNo")
    INTO "Var_Check";

  
    IF '1' = "Var_Check" THEN
		RAISE NOTICE '[Check1 : 정상]';
	ELSE
		-- 프로세스 종료 및 에러 메시지 출력 --
        RETURN QUERY SELECT
            9999 AS "ErrorCheck",
            'fail' AS "Status",
            '환불 신청 내역이 존재하지 않습니다.' AS "Message",
            ''::VARCHAR(30) AS "RefundNo";
		RETURN;
	END IF;	

    -- Check2 : 환불 신청 상태가 환불 완료된 건일 경우
    IF 2003001 <> (SELECT A."RefundStatus" FROM "Amt"."TP_Refund" AS A WHERE A."UserSeq" = "InData_UserSeq" AND A."RefundNo" = "InData_RefundNo") THEN
        RETURN QUERY SELECT
            9999 AS "ErrorCheck",
            'fail' AS "Status",
            '환불 진행이 완료된 건입니다.' AS "Message",
            "InData_RefundNo"::VARCHAR(30) AS "RefundNo";
        RETURN;
    END IF;
	
    --  "Amt"."TP_Refund" 상태 Update
    EXECUTE format($f$
		UPDATE "Amt"."TP_Refund"
		   SET "RefundStatus" = 2003001, -- 환불 승인
		       "Remark" = '환불 승인 완료되었습니다.',
			   "RefundDateEndTime" = %L
		 WHERE "UserSeq" = %L
		   AND "RefundNo" = %L;
	$f$, "Var_DateTime", "InData_UserSeq", "InData_RefundNo");

    -- 성공 메시지 반환
    RETURN QUERY SELECT
        1111 AS "ErrorCheck",
        'success' AS "Status",
        '환불 승인 완료했습니다.' AS "Message",
        "InData_RefundNo"::VARCHAR(30) AS "RefundNo";
END;
$$;

SELECT * FROM "Base_SQL"."Func_Success_TP_Refund"('test_UserSeq0912843024', 'R20240630-024182358');