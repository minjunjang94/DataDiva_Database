CREATE OR REPLACE PROCEDURE "Base_SQL"."Proc_Email_Login_Check"(
     "InData_Email"				VARCHAR(50)  		-- 이메일
	,"InData_LoginPwd"    		VARCHAR(300) 		-- 비밀번호
	,"InData_IPAddress"			VARCHAR(250)  		-- IP 주소
	,INOUT "ErrorCheck" 		INT
	,INOUT "ResultMessage" 		VARCHAR(200)
)
LANGUAGE plpgsql
AS $$
DECLARE
	"Var_LoginFailCnt" INT = 0;
BEGIN
/*    
-- ************************************************************************************ --
Create Name	: 로그인_이메일_승인_Check
Create Date	: 2024-06-26
Create Emp	: JayJun
Update Emp 	:
-- ************************************************************************************ --
*/

	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	
	-- Check1 : "InData_Email"의 데이터가 동일한 기관 안에 "Base"."TB_User"."Email"에 존재하지 않으면 에러발생 --
    IF EXISTS (SELECT 1 FROM "Base"."TB_User" WHERE "Email" = "InData_Email")
	THEN
			RAISE NOTICE '[Check1 : 정상]';
	   		-- Check2 : "InData_Email"의 데이터가 동일한 기관 안에 "Base"."TB_User"."Email"에 존재하지만 해당 "Base"."TB_User".Login_Pwd에 InData_Login_Pwd이 틀리면 에러발생 --
	   		IF EXISTS (SELECT 1 FROM "Base"."TB_User" WHERE "Email" = "InData_Email" AND "LoginPwd" = "InData_LoginPwd")
	   		THEN
				RAISE NOTICE '[Check2 : 정상]';
			ELSE
				-- "Base"."TB_User"."LoginFailCnt" 컬럼의 값이 5가 초과될 경우 "Base"."TB_User"."LoginStatus"값이 '1001002[임시정지계정]' 으로 UPDATE
				"Var_LoginFailCnt"  = (SELECT "LoginFailCnt" FROM "Base"."TB_User" WHERE "Email" = "InData_Email");	
				IF 4 < "Var_LoginFailCnt"
				THEN
					UPDATE "Base"."TB_User"
				   	   SET "LoginStatus" = 1001002
					 WHERE "Email" = "InData_Email";
				ELSE
 					UPDATE "Base"."TB_User"
 				   	   SET "LoginFailCnt" = "Var_LoginFailCnt" + 1
 				   	 WHERE "Email" = "InData_Email";
				END IF;	
				
				-- 프로세스 종료 및 에러 메시지 출력 --
				"ErrorCheck" = 9999;
				"ResultMessage" = '패스워드가 일치하지 않습니다.';
				RAISE NOTICE '[Check2 : 에러] 패스워드가 일치하지 않습니다.';
				RETURN;
    		END IF;	
	ELSE
		-- 프로세스 종료 및 에러 메시지 출력 --     
		"ErrorCheck" = 9999;
		"ResultMessage" = '존재하지 않는 계정입니다.';
		RAISE NOTICE '[Check1 : 에러] 존재하지 않는 계정입니다.';
		RETURN;
		----------------------------------
    END IF;

	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	
	-- Check3 : 업데이트 할 경우 "Base"."TB_User"."LoginStatus" 의 값이 '1001002[임시정지계정]' 값일 경우 에러발생 --
    IF NOT 1001002 = (SELECT "LoginStatus" FROM "Base"."TB_User" 
					           				  WHERE "Email" = "InData_Email" AND "LoginPwd" = "InData_LoginPwd")
	THEN
		RAISE NOTICE '[Check3 : 정상]';
	ELSE
		-- 프로세스 종료 및 에러 메시지 출력 --     
		"ErrorCheck" = 9999;
		"ResultMessage" = '임시정지된 계정입니다.';
		RAISE NOTICE '[Check3 : 에러] 임시정지된 계정입니다.';
		RETURN;
		----------------------------------
    END IF;
	
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	
	-- Check4 : "Base"."TB_User"."LoginStatus" 의 값이 '1001003[휴면계정]' 값일 경우 에러발생 --
    IF NOT 1001003 = (SELECT "LoginStatus" FROM "Base"."TB_User" 
                                              WHERE "Email" = "InData_Email" AND "LoginPwd" = "InData_LoginPwd")
	THEN
		RAISE NOTICE '[Check7 : 정상]';
	ELSE
		-- 프로세스 종료 및 에러 메시지 출력 --     
		"ErrorCheck" = 9999;
		"ResultMessage" = '휴면계정입니다.';
		RAISE NOTICE '[Check4 : 에러] 휴면계정입니다.';
		RETURN;
		----------------------------------
    END IF;
	
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	
	-- Check5 : 업데이트 할 경우 "Base"."TB_User"."LoginStatus" 의 값이 '1001004[삭제계정]' 값일 경우 에러발생 --
    IF NOT 1001004 = (SELECT "LoginStatus" FROM "Base"."TB_User" 
						  					  WHERE "Email" = "InData_Email" AND "LoginPwd" = "InData_LoginPwd")
	THEN
		RAISE NOTICE '[Check8 : 정상]';
	ELSE
		-- 프로세스 종료 및 에러 메시지 출력 --     
		"ErrorCheck" = 9999;
		"ResultMessage" = '삭제가 예정된 계정입니다.';
		RAISE NOTICE '[Check5 : 에러] 삭제가 예정된 계정입니다.';
		RETURN;
		----------------------------------
    END IF;
	
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--

END;
$$;
