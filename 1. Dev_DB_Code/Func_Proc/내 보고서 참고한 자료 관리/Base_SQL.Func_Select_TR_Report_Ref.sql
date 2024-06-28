CREATE OR REPLACE FUNCTION "Base_SQL"."Func_Select_TR_Report_Ref"(
    "InData_UserSeq" VARCHAR(50) -- 사용자 내부코드
	,"InData_ReportSeq" INT -- 보고서 내부코드
)
RETURNS TABLE (
    "ReportSeq" INT,
    "RefSeq" INT,
    "RefTitle" VARCHAR(200),
    "RefStatusCode" INT,
    "RefStatus"  VARCHAR(30),
    "StartCheckTime" TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
/*    
-- ************************************************************************************ --
Create Name  : 내 보고서 참고한 자료 Select
Create Date  : 2024-06-26
Create Emp   : JayJun
Update Emp   :
-- ************************************************************************************ --
*/

    -- 내 보고서 조회
    RETURN QUERY 
    SELECT
	    "InData_ReportSeq" AS "ReportSeq",
	    A."RefSeq" AS "RefSeq",
        A."RefTitle",
        A."RefStatus" AS "RefStatusCode",
		B."Remark" AS "RefStatus",
        A."StartCheckTime"
    FROM "Rpt"."TR_ReportRef" AS A
    LEFT JOIN "Base"."TB_Minor" AS B ON A."RefStatus" = B."MinorSeq"
    WHERE A."UserSeq" = "InData_UserSeq"
	     AND A."ReportSeq" = "InData_ReportSeq"
	ORDER BY A."StartCheckTime" ASC;

END;
$$;

SELECT * FROM "Base_SQL"."Func_Select_TR_Report_Ref"('test_UserSeq0912843024', 2);
