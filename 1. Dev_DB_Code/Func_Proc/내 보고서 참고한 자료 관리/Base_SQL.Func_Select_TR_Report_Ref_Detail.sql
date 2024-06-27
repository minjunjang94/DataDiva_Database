CREATE OR REPLACE FUNCTION "Base_SQL"."Func_Select_TR_Report_Ref_Detail"(
    "InData_UserSeq" VARCHAR(50) -- 사용자 내부코드
   ,"InData_ReportSeq" INT -- 보고서 내부코드
   ,"InData_RefSeq" INT -- 참고자료 내부코드
)
RETURNS TABLE (
    "ReportSeq" INT,
    "RefSeq" INT,
    "RefTitle" VARCHAR(200),
    "PDF"  VARCHAR(300),
    "Source"  VARCHAR(200),
    "Link" VARCHAR(200),
    "RefStatusCode" INT,
    "RefStatus"  VARCHAR(30),	
    "StartCheckTime" TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
/*    
-- ************************************************************************************ --
Create Name  : 내 보고서 참고한 자료 Detail Select
Create Date  : 2024-06-26
Create Emp   : JayJun
Update Emp   :
-- ************************************************************************************ --
*/

    -- 내 보고서 조회
    RETURN QUERY 
    SELECT
	    "InData_ReportSeq" AS "ReportSeq",
	    "InData_RefSeq" AS "RefSeq",
        A."RefTitle",
		C."PDF",
		C."Source",
		C."Link",
        A."RefStatus" AS "RefStatusCode",
		B."Remark" AS "RefStatus",
        A."StartCheckTime"
    FROM "Rpt"."TR_ReportRef" AS A
    LEFT JOIN "Base"."TB_Minor" AS B ON A."RefStatus" = B."MinorSeq"
	LEFT JOIN "Rpt"."TR_ReportRefDetail" AS C ON A."UserSeq" = C."UserSeq"
											  AND A."ReportSeq" = C."ReportSeq"
											  AND A."RefSeq" = C."RefSeq"
    WHERE A."UserSeq" = "InData_UserSeq"
	  AND A."ReportSeq" = "InData_ReportSeq"
	  AND A."RefSeq" = "InData_RefSeq";

END;
$$;

SELECT * FROM "Base_SQL"."Func_Select_TR_Report_Ref_Detail"('test_UserSeq0912843024', 2, 1);
