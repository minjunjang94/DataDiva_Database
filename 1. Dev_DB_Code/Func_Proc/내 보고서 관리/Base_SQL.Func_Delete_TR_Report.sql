CREATE OR REPLACE FUNCTION "Base_SQL"."Func_Delete_TR_Report"(
    "InData_UserSeq" VARCHAR(50) -- 사용자 내부코드
   ,"InData_ReportSeq" INT -- 보고서 내부코드
)
RETURNS TABLE (
    "ErrorCheck" INT,
    "ResultMessage" VARCHAR(200)
)
LANGUAGE plpgsql
AS $$
DECLARE
	"Var_Check" INT = 0;
BEGIN
/*    
-- ************************************************************************************ --
Create Name	: 내 보고서 정보 Delete
Create Date	: 2024-06-26
Create Emp		: JayJun
Update Emp 	:
-- ************************************************************************************ --
*/

    EXECUTE format($f$
        SELECT CASE WHEN EXISTS (
        		SELECT 1 FROM "Rpt"."TR_Report" WHERE "UserSeq" = %L AND "ReportSeq" = %L
            ) THEN 1 ELSE 0 END;
    $f$, "InData_UserSeq", "InData_ReportSeq")
    INTO "Var_Check";


    -- Check1 : 삭제할 데이터 존재여부 --
   	IF '1' = "Var_Check" THEN
    	RAISE NOTICE '[Check1 : 정상]';
    ELSE
    	-- 프로세스 종료 및 에러 메시지 출력 --
    	RETURN QUERY SELECT 9999, '삭제할 데이터가 존재하지 않습니다.'::VARCHAR(200);
    	RETURN;
    END IF;	

    -- 데이터 삭제
    EXECUTE format($f$
		DELETE FROM "Rpt"."TR_Report" WHERE "UserSeq" = %L AND "ReportSeq" = %L;
    $f$, "InData_UserSeq", "InData_ReportSeq");

    -- 성공 메시지 반환
    RETURN QUERY SELECT 1111, '내 보고서 정보 삭제 완료'::VARCHAR(200);
END;
$$;

select * from  "Base_SQL"."Func_Delete_TR_Report" ('test_UserSeq0912843024', '1');