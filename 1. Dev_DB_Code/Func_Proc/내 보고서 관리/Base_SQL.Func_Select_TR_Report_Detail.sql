CREATE OR REPLACE FUNCTION "Base_SQL"."Func_Select_TR_Report_Detail"(
    "InData_UserSeq" VARCHAR(50) -- 사용자 내부코드
   ,"InData_ReportSeq" INT -- 보고서 내부코드
)
RETURNS TABLE (
	 "Title" VARCHAR(200) -- 제목
    ,"SubjectTypeCode" INT
    ,"SubjectType" VARCHAR(30)
	,"Keyword1" VARCHAR(50) -- 키워드1
	,"Keyword2" VARCHAR(50) -- 키워드2
	,"Keyword3" VARCHAR(50) -- 키워드3
	,"Keyword4" VARCHAR(50) -- 키워드4
	,"Keyword5" VARCHAR(50) -- 키워드5
    ,"IsOpenCode" CHAR(1)
    ,"IsOpen" VARCHAR(10)
	,"PDF" 	VARCHAR(300) -- PDF 파일 경로
	,"MainComment" VARCHAR(300)  -- 댓글 대표 글
	,"Report" TEXT -- 보고서 내용
	,"Summary" TEXT -- AI 요약 내용
)
LANGUAGE plpgsql
AS $$
BEGIN
/*    
-- ************************************************************************************ --
Create Name  : 내 보고서 내용 정보 Select
Create Date  : 2024-06-26
Create Emp   : JayJun
Update Emp   :
-- ************************************************************************************ --
*/

    -- 내 보고서 조회
    RETURN QUERY 
    SELECT
		 A."Title" -- 제목
        ,A."SubjectType" AS "SubjectTypeCode"
        ,B."Remark" AS "SubjectType"
		,A."Keyword1" -- 키워드1
		,A."Keyword2" -- 키워드2
		,A."Keyword3" -- 키워드3
		,A."Keyword4" -- 키워드4
		,A."Keyword5" -- 키워드5
    	,A."IsOpen" AS "IsOpenCode"
    	,CASE
            WHEN A."IsOpen" = '1' THEN CAST('공개' AS VARCHAR(10))
            ELSE CAST('비공개' AS VARCHAR(10))
         END AS "IsOpen"
		,A."PDF" -- PDF 파일 경로
		,A."MainComment" -- 댓글 대표 글
		,C."Report" -- 보고서 내용
		,D."Summary" -- AI 요약 내용	
    FROM "Rpt"."TR_Report" AS A
    LEFT JOIN "Base"."TB_Minor" AS B ON A."SubjectType" = B."MinorSeq"
	LEFT JOIN "Rpt"."TR_ReportDetail" AS C ON C."UserSeq" = A."UserSeq"
										  AND C."ReportSeq" = A."ReportSeq"
	LEFT JOIN "Rpt"."TR_ReportAiSummary" AS D ON D."UserSeq" = A."UserSeq"
										     AND D."ReportSeq" = A."ReportSeq"
    WHERE A."UserSeq" = "InData_UserSeq"
	  AND A."ReportSeq" = "InData_ReportSeq";

END;
$$;

SELECT * FROM "Base_SQL"."Func_Select_TR_Report_Detail"('test_UserSeq0912843024', 1);
