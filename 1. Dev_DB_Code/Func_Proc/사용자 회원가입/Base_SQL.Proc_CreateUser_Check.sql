CREATE OR REPLACE PROCEDURE "Base_SQL"."Proc_CreateUser_Check"(
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
	,INOUT "ErrorCheck" 		INT
	,INOUT "ResultMessage" 	VARCHAR(200)
)
LANGUAGE plpgsql
AS $$
BEGIN
/*    
-- ************************************************************************************ --
Create Name : 사용자계정 생성_Check
Create Date : 2024-06-26
Create Emp : JayJun
Update Emp :
-- ************************************************************************************ --
*/

	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	-- Check1 : InData_APIKey의 값이 존재하지 않을 때, 반드시 InData_Email, InData_LoginPwd 의 값이 존재 해야한다. --
    IF COALESCE("InData_APIKey", '') = '' THEN
        IF COALESCE("InData_Email", '') = '' OR COALESCE("InData_LoginPwd", '') = '' THEN
		    -- 프로세스 종료 및 에러 메시지 출력 --    
            "ErrorCheck" := 9999;
            "ResultMessage" := 'APIKey값이 존재하지 않을 때, 반드시 이메일과 패스워드가 존재 해야합니다.';
            RAISE NOTICE '[Check1 : 에러] APIKey값이 존재하지 않을 때, 반드시 이메일과 패스워드가 존재 해야합니다.';
            RETURN;
        END IF;
    END IF;	
	
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	
	-- Check1-1 : InData_APIKey의 값이 존재할 때, 반드시 InData_FromAPI 의 값이 존재 해야한다. --
    IF COALESCE("InData_APIKey", '') <> '' THEN
        IF COALESCE("InData_FromAPI", 0) = 0 THEN
		    -- 프로세스 종료 및 에러 메시지 출력 --    
            "ErrorCheck" := 9999;
            "ResultMessage" := 'APIKey값이 존재할 때, FromAPI(API 원천) 값이 입력되어야 합니다.';
            RAISE NOTICE '[Check1-1 : 에러] APIKey값이 존재할 때, FromAPI(API 원천) 값이 입력되어야 합니다.';
            RETURN;
        END IF;
    END IF;		
	
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	
	-- Check2 : 저장할 경우 신규 InData_Email의 값이 Base.TB_User.Email 데이터의 동일한 값이 존재할 경우 에러발생 --
    IF EXISTS (SELECT 1 FROM "Base"."TB_User" WHERE "Email" = "InData_Email") THEN
        -- 프로세스 종료 및 에러 메시지 출력 --     
        "ErrorCheck" := 9999;
        "ResultMessage" := '동일한 이메일 계정이 존재합니다.';
        RAISE NOTICE '[Check2 : 에러] 동일한 이메일 계정이 존재합니다.';
        RETURN; 
    END IF;
	
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	
END;
$$;
