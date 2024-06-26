CREATE OR REPLACE FUNCTION "Base_SQL"."Func_CreateUser"(
	 "InData_UserSeq"			VARCHAR(50) 		-- 사용자 내부코드	 
	,"InData_Email"				VARCHAR(100) 		-- 이메일
	,"InData_LoginPwd"			VARCHAR(300) 		-- 비밀번호
	,"InData_APIKey"			VARCHAR(500) 		-- API Key
	,"InData_FromAPI"			INT			 		-- API 원천
	,"InData_UserName"			VARCHAR(60)			-- 사용자 이름
	,"InData_BirthDt"			CHAR(8)				-- 생년월일
	,"InData_Gender"			INT					-- 성별
	,"InData_CountrySeq"		INT					-- 국가내부코드
	,"InData_Cellphone"			VARCHAR(100)		-- 전화번호
)
RETURNS "Base_SQL"."ErrorCheckResult"
LANGUAGE plpgsql
AS $$
DECLARE
    result "Base_SQL"."ErrorCheckResult";
    "ErrorCheck" INT = 1111;
	"ResultMessage" VARCHAR(200) = '';
BEGIN
/*    
-- ************************************************************************************ --
Create Name : 사용자계정 생성
Create Date : 2024-06-26
Create Emp : JayJun
Update Emp :
-- ************************************************************************************ --
*/

    -- Check
    CALL "Base_SQL"."Proc_CreateUser_Check"
		(
			 "InData_UserSeq"	
			,"InData_Email"		
			,"InData_LoginPwd"	
			,"InData_APIKey"	
			,"InData_FromAPI"	
			,"InData_UserName"	
			,"InData_BirthDt"	
			,"InData_Gender"	
			,"InData_CountrySeq"
			,"InData_Cellphone"	
			,"ErrorCheck"
			,"ResultMessage"
		);
		
    IF "ErrorCheck" = 9999 THEN
	    result."ErrorCheck" := "ErrorCheck";
   		result."ResultMessage" := "ResultMessage";
	
   		RETURN result; -- 결과출력
    ELSE
        CALL "Base_SQL"."Proc_CreateUser_Save"
 		(
 			 "InData_UserSeq"	
 			,"InData_Email"		
 			,"InData_LoginPwd"	
 			,"InData_APIKey"	
 			,"InData_FromAPI"	
 			,"InData_UserName"	
 			,"InData_BirthDt"	
 			,"InData_Gender"	
 			,"InData_CountrySeq"
 			,"InData_Cellphone"	
 		);
   END IF;

   result."ErrorCheck" := "ErrorCheck";
   result."ResultMessage" := 'SuccessFully';
	
   RETURN result; -- 결과출력
END;
$$;

SELECT "Base_SQL"."Func_CreateUser"('test_UserSeq0912843024','test_user145@naver.com', '2222', 'APIKey_123123', 1002001, '동글이', '20240601', 1003001, 1, '01012345678');