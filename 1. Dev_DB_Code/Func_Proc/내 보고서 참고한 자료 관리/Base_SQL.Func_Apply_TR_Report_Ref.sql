CREATE OR REPLACE FUNCTION "Base_SQL"."Func_Apply_TR_Report_Ref"(
     "InData_UserSeq" VARCHAR(50) -- 사용자 내부코드
	,"InData_ReportSeq" INT -- 보고서 내부코드
	,"InData_RefTitle" VARCHAR(200) -- 자료 제목
	,"InData_Source" VARCHAR(200) -- 출처
	,"InData_PDF" VARCHAR(300) -- PDF 파일 경로
	,"InData_Link" VARCHAR(200) -- 출처 링크
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
DECLARE
	"Var_RefSeq" INT = 0;
    "Var_DateTime" VARCHAR(30) = '';
BEGIN
/*    
-- ************************************************************************************ --
Create Name	: 내 보고서 참고한 자료 Apply
Create Date	: 2024-06-27
Create Emp		: JayJun
Update Emp 	:
-- ************************************************************************************ --
*/

    "Var_DateTime" = (SELECT TO_CHAR(NOW(), 'YYYY/MM/DD HH24:MI:SS'));

	-- Var_RefSeq 값 생성
    EXECUTE format($f$
		SELECT COALESCE(MAX("RefSeq") + 1, 1) AS MAX_RefSeq FROM "Rpt"."TR_ReportRef" WHERE "UserSeq" = %L AND "ReportSeq" = %L;
    $f$, "InData_UserSeq", "InData_ReportSeq")
	INTO "Var_RefSeq";

    -- 보고서 참고 자료 정보 Insert
    EXECUTE format($f$
		INSERT INTO "Rpt"."TR_ReportRef" ("UserSeq", "ReportSeq", "RefSeq", "RefTitle", "StartCheckTime", "RefStatus") 
		VALUES (%L, %L, %L, %L, %L, 2002001);
    $f$, "InData_UserSeq", "InData_ReportSeq", "Var_RefSeq", "InData_RefTitle", "Var_DateTime");
		
    -- 보고서 참고 자료 내용 정보 Insert
    EXECUTE format($f$
		INSERT INTO "Rpt"."TR_ReportRefDetail" ("UserSeq", "ReportSeq", "RefSeq", "Source", "PDF", "Link") 
		VALUES (%L, %L, %L, %L, %L, %L);
    $f$, "InData_UserSeq", "InData_ReportSeq", "Var_RefSeq", "InData_Source", "InData_PDF", "InData_Link");

    -- 성공 메시지 반환
    RETURN QUERY SELECT
        1111 AS "ErrorCheck",
        'success' AS "Status",
        '내 보고서 Insert 완료' AS "Message",
        "InData_ReportSeq" AS "ReportSeq",
        "Var_RefSeq" AS "RefSeq";
END;
$$;

SELECT * FROM "Base_SQL"."Func_Apply_TR_Report_Ref"('test_UserSeq0912843024', 2, '테스트 자료 제목', '테스트 출처출처', 'TEST PDF파일경로', 'wwerwerewr');