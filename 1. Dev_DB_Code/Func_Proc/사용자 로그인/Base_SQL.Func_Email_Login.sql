CREATE OR REPLACE FUNCTION "Base_SQL"."Func_Email_Login"(
     "InData_Email"				VARCHAR(50)  		-- 이메일
	,"InData_LoginPwd"    		VARCHAR(300) 		-- 비밀번호
	,"InData_IPAddress"			VARCHAR(250)  		-- IP 주소
)
RETURNS JSON
LANGUAGE plpgsql
AS $$
DECLARE
	result JSON;
    "ErrorCheck" INT = 1111;
	"ResultMessage" VARCHAR(200) = '';
    "ResultUserSeq" VARCHAR(50) = '';
BEGIN
/*    
-- ************************************************************************************ --
Create Name	: 로그인_이메일_승인
Create Date	: 2024-06-26
Create Emp	: JayJun
Update Emp 	:
-- ************************************************************************************ --
*/

    -- Check
   CALL "Base_SQL"."Proc_Email_Login_Check"
	(
		 "InData_Email"
		,"InData_LoginPwd"
		,"InData_IPAddress"
		,"ErrorCheck"
		,"ResultMessage"
	);
		
    IF "ErrorCheck" = 9999 THEN
    result := json_build_object(
        'ErrorCheck', "ErrorCheck",
        'ResultMessage', "ResultMessage",
        'ResultUserSeq', "ResultUserSeq"
    );
	
   		RETURN result; -- 결과출력
   ELSE
        -- Update
        CALL "Base_SQL"."Proc_Email_Login_Update"
		(
		 	 "InData_Email"
			,"InData_LoginPwd"
			,"InData_IPAddress"
			,"ResultUserSeq" 
		);
   END IF;
  
    result := json_build_object(
        'ErrorCheck', "ErrorCheck",
        'ResultMessage', 'SuccessFully',
        'ResultUserSeq', "ResultUserSeq"
    );
	
   RETURN result; -- 결과출력
END;
$$;

SELECT "Base_SQL"."Func_Email_Login"('test_user145@naver.com', '2222', '1.12.13.100');
