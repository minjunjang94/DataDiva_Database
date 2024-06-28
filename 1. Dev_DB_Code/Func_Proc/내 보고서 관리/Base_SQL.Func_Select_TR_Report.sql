CREATE OR REPLACE FUNCTION "Base_SQL"."Func_Select_TR_Report"(
    "InData_UserSeq" VARCHAR(50) -- 사용자 내부코드
)
RETURNS TABLE (
    "UserSeq" VARCHAR(50),
	"ReportSeq" INT,
    "Title" VARCHAR(200),
    "SubjectTypeCode" INT,
    "SubjectType" VARCHAR(30),
    "IsOpenCode" CHAR(1),
    "IsOpen" VARCHAR(10)
)
LANGUAGE plpgsql
AS $$
BEGIN
/*    
-- ************************************************************************************ --
Create Name  : 내 보고서 정보 Select
Create Date  : 2024-06-26
Create Emp   : JayJun
Update Emp   :
-- ************************************************************************************ --
*/

    -- 내 보고서 조회
    RETURN QUERY 
    SELECT
        A."UserSeq",
		A."ReportSeq",
        A."Title",
        A."SubjectType" AS "SubjectTypeCode",
        B."Remark" AS "SubjectType",
        A."IsOpen" AS "IsOpenCode",
        CASE
            WHEN A."IsOpen" = '1' THEN CAST('공개' AS VARCHAR(10))
            ELSE CAST('비공개' AS VARCHAR(10))
        END AS "IsOpen"
    FROM "Rpt"."TR_Report" AS A
    LEFT JOIN "Base"."TB_Minor" AS B ON A."SubjectType" = B."MinorSeq"
    WHERE A."UserSeq" = "InData_UserSeq"
	ORDER BY A."CreateDateTime" ASC;

END;
$$;

SELECT * FROM "Base_SQL"."Func_Select_TR_Report"('test_UserSeq0912843024');
