CREATE OR REPLACE FUNCTION "Base_SQL"."Func_Update_TR_Report"(
     "InData_UserSeq" VARCHAR(50) -- 사용자 내부코드
	,"InData_ReportSeq" INT -- 보고서 내부코드
	,"InData_Title" VARCHAR(200) -- 제목
	,"InData_SubjectType" INT -- 주제 분류
	,"InData_Keyword1" VARCHAR(50) -- 키워드1
	,"InData_Keyword2" VARCHAR(50) -- 키워드2
	,"InData_Keyword3" VARCHAR(50) -- 키워드3
	,"InData_Keyword4" VARCHAR(50) -- 키워드4
	,"InData_Keyword5" VARCHAR(50) -- 키워드5
	,"InData_IsOpen" CHAR(1) -- 공개 여부
	,"InData_PDF" 	VARCHAR(300) -- PDF 파일 경로
	,"InData_MainComment" VARCHAR(300)  -- 댓글 대표 글
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
	"Var_Check" INT = 0;
BEGIN
/*    
-- ************************************************************************************ --
Create Name	: my news 기사 정보 Update
Create Date		: 2024-04-16
Create Emp		: JayJun
Update Emp 	:
-- ************************************************************************************ --
*/

    EXECUTE format($f$
        SELECT CASE WHEN EXISTS (
        		SELECT 1 FROM "Rpt"."TR_ReportAiSummary" WHERE "UserSeq" = %L AND "ReportSeq" = %L
            ) THEN 1 ELSE 0 END;
    $f$, "InData_UserSeq", "InData_ReportSeq")
    INTO "Var_Check";

    -- Check1 : 업데이트할 데이터 존재여부 --
   	IF '1' = "Var_Check" THEN
    	RAISE NOTICE '[Check1 : 정상]';
    ELSE
        -- 프로세스 종료 및 에러 메시지 출력 --
        RETURN QUERY SELECT 9999 AS "ErrorCheck", 'error' AS "Status", '업데이트할 데이터가 존재하지 않습니다.' AS "Message", "InData_ReportSeq" AS "ReportSeq";
        RETURN;
    END IF;	
	
    -- 보고서 정보  Update
    EXECUTE format($f$
		UPDATE "Rpt"."TR_Report"
		   SET "Title" = %L,
				  "SubjectType" = %L,
				  "Keyword1" = %L,
				  "Keyword2" = %L,
				  "Keyword3" = %L,
				  "Keyword4" = %L,
				  "Keyword5" = %L,
				  "IsOpen" = %L,
				  "PDF" = %L,
				  "MainComment" = %L
		 WHERE "UserSeq" = %L
		      AND "ReportSeq" = %L;
	$f$, "InData_Title", "InData_SubjectType", "InData_Keyword1", "InData_Keyword2", "InData_Keyword3", "InData_Keyword4", "InData_Keyword5", "InData_IsOpen", "InData_PDF", "InData_MainComment", "InData_UserSeq", "InData_ReportSeq");

    -- 보고서 내용 정보  Update	
	EXECUTE format($f$	
		UPDATE "Rpt"."TR_ReportDetail"
		   SET "Report" = 	%L   
		 WHERE "UserSeq" = %L
		      AND "ReportSeq" = %L;	
    $f$, "InData_Report", "InData_UserSeq", "InData_ReportSeq");

    -- 보고서 AI 요약 정보  Update	
	EXECUTE format($f$	
		UPDATE "Rpt"."TR_ReportAiSummary"
		   SET "Summary" = 	%L   
		 WHERE "UserSeq" = %L
		      AND "ReportSeq" = %L;	
    $f$, "InData_Summary", "InData_UserSeq", "InData_ReportSeq");

    -- 성공 메시지 반환
    RETURN QUERY SELECT
        1111 AS "ErrorCheck",
        'success' AS "Status",
        '보고서 정보 Update 완료' AS "Message",
        "InData_ReportSeq" AS "ReportSeq";
END;
$$;

SELECT * FROM "Base_SQL"."Func_Update_TR_Report"('test_UserSeq0912843024', 2, '내 보고서 테스트22', 2001004, '키워드122', '키워드222', '', '', '', '1', '/PDF/TEST.pdf', '대표대표 글22', '보고서 본문입니다. 그러합니다.22', 'AI 요약문 입니다. 그러합니다.22');