CREATE OR REPLACE FUNCTION "Base_SQL"."Func_Delete_TR_Report_Ref"(
     "InData_UserSeq" VARCHAR(50) -- 사용자 내부코드
	,"InData_ReportSeq" INT -- 보고서 내부코드
	,"InData_RefSeq" INT -- 참고자료 내부코드
)
RETURNS TABLE (
    "ErrorCheck" INT,
    "Status" TEXT,
    "Message" TEXT,
    "ReportSeq" INT,
	"RefSeq" INT
)
LANGUAGE plpgsql
AS $$
BEGIN
/*    
-- ************************************************************************************ --
Create Name	: 내 보고서 참고한 자료 Delete
Create Date	: 2024-06-27
Create Emp		: JayJun
Update Emp 	:
-- ************************************************************************************ --
*/

    -- {기관약명}.TA_Emp 및 Base.TB_User 데이터 삭제
    EXECUTE format($f$
		DELETE FROM "Rpt"."TR_ReportRef" WHERE "UserSeq" = %L AND "ReportSeq" = %L AND "RefSeq" = %L;
    $f$, "InData_UserSeq", "InData_ReportSeq", "InData_RefSeq");

    -- 성공 메시지 반환
    RETURN QUERY SELECT
        1111 AS "ErrorCheck",
        'success' AS "Status",
        '내 보고서 참고한 자료가 삭제되었습니다..' AS "Message",
        "InData_ReportSeq" AS "ReportSeq",
        "InData_RefSeq" AS "RefSeq";
END;
$$;

SELECT * FROM "Base_SQL"."Func_Delete_TR_Report_Ref"('test_UserSeq0912843024', 2, 1);