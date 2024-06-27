CREATE OR REPLACE FUNCTION "Base_SQL"."Func_Insert_TR_Report"(
     "InData_UserSeq" VARCHAR(50) -- 사용자 내부코드
	,"InData_Title" VARCHAR(200) -- 제목
	,"InData_SubjectType" INT -- 주제 분류
	,"InData_Keyword1" VARCHAR(50) -- 키워드1
	,"InData_Keyword2" VARCHAR(50) -- 키워드2
	,"InData_Keyword3" VARCHAR(50) -- 키워드3
	,"InData_Keyword4" VARCHAR(50) -- 키워드4
	,"InData_Keyword5" VARCHAR(50) -- 키워드5
	,"InData_IsOpen" CHAR(1) -- 공개 여부
	,"InData_PDF" 	VARCHAR(300) -- PDF 파일 경로
	,"InData_Report" TEXT -- 보고서 내용
	,"InData_Summary" TEXT -- AI 요약 내용
)
RETURNS TABLE (
    "ErrorCheck" INT,
    "Status" TEXT,
    "Message" TEXT,
    "ReportSeq" INT
)
LANGUAGE plpgsql
AS $$
DECLARE
	"Var_ReportSeq" INT = 0;
    "Var_DateTime" VARCHAR(30) = '';
BEGIN
/*    
-- ************************************************************************************ --
Create Name	: 내 보고서 정보 Insert
Create Date		: 2024-06-16
Create Emp		: JayJun
Update Emp 	:
-- ************************************************************************************ --
*/

    "Var_DateTime" = (SELECT TO_CHAR(NOW(), 'YYYY/MM/DD HH24:MI:SS'));

	-- Var_ReportSeq 값 생성
    EXECUTE format($f$
		SELECT COALESCE(MAX("ReportSeq") + 1, 1) AS MAX_ReportSeq FROM "Rpt"."TR_Report" WHERE "UserSeq" = %L;
    $f$, "InData_UserSeq")
	INTO "Var_ReportSeq";

    -- 보고서 정보 Insert
    EXECUTE format($f$
		INSERT INTO "Rpt"."TR_Report" ("UserSeq", "ReportSeq", "Title", "SubjectType", "Keyword1", "Keyword2", "Keyword3", "Keyword4", "Keyword5", "IsOpen", "PDF", "CreateDateTime") 
		VALUES (%L, %L, %L, %L, %L, %L, %L, %L, %L, %L, %L, %L);
    $f$, "InData_UserSeq", "Var_ReportSeq", "InData_Title", "InData_SubjectType", "InData_Keyword1", "InData_Keyword2", "InData_Keyword3", "InData_Keyword4", "InData_Keyword5", "InData_IsOpen", "InData_PDF", "Var_DateTime");
	
    -- 보고서 내용 정보 Insert
    EXECUTE format($f$
		INSERT INTO "Rpt"."TR_ReportDetail" ("UserSeq", "ReportSeq", "Report") 
		VALUES (%L, %L, %L);
    $f$, "InData_UserSeq", "Var_ReportSeq", "InData_Report");

    -- 보고서 AI 요약 정보 Insert
    EXECUTE format($f$
		INSERT INTO "Rpt"."TR_ReportAiSummary" ("UserSeq", "ReportSeq", "Summary") 
		VALUES (%L, %L, %L);
    $f$, "InData_UserSeq", "Var_ReportSeq", "InData_Summary");

    -- 성공 메시지 반환
    RETURN QUERY SELECT
        1111 AS "ErrorCheck",
        'success' AS "Status",
        '내 보고서 Insert 완료' AS "Message",
        "Var_ReportSeq" AS "ReportSeq";
 
END;
$$;

SELECT * FROM "Base_SQL"."Func_Insert_TR_Report"('test_UserSeq0912843024', '내 보고서 테스트', 2001004, '키워드1', '키워드2', '', '', '', '1', '/PDF/TEST.pdf', '대표대표 글', '보고서 본문입니다. 그러합니다.', 'AI 요약문 입니다. 그러합니다.');