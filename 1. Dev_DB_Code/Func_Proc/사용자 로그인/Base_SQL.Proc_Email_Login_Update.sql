CREATE OR REPLACE PROCEDURE "Base_SQL"."Proc_Email_Login_Update"(
     "InData_Email"				VARCHAR(50)  		-- 이메일
	,"InData_LoginPwd"    		VARCHAR(300) 		-- 비밀번호
	,"InData_IPAddress"			VARCHAR(250)  		-- IP 주소
	,INOUT "ResultUserSeq" 		VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
DECLARE
	"Var_UserSeq" VARCHAR(50) = '';
BEGIN
/*    
-- ************************************************************************************ --
Create Name	: 로그인_이메일_승인_Update
Create Date	: 2024-06-26
Create Emp	: JayJun
Update Emp 	:
-- ************************************************************************************ --
*/

	"Var_UserSeq" := (SELECT "UserSeq" FROM "Base"."TB_User" WHERE "Email" = "InData_Email" AND "LoginPwd" = "InData_LoginPwd");

	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	-- TB_User 데이터 업데이트
	UPDATE "Base"."TB_User"
	   SET  "LoginStatus"   = 1001001 	-- 정상적으로 로그인 완료한 경우 [1001001(정상진입)] 으로 UPDATE
		   ,"LoginFailCnt"	= 0			-- 로그인 실패 수
	 WHERE "UserSeq" = "Var_UserSeq";
	
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
		
	-- "Base"."TB_UserLoginLog" 데이터 저장
	INSERT INTO "Base"."TB_UserLoginLog"
	(
		 "UserSeq"
		,"LoginDateTime" 
		,"IPAddress"
	)
	VALUES 
	(
		 "Var_UserSeq" 		-- 로그인 사용자 "UserSeq"
		,now()				-- 현재 시간
		,"InData_IPAddress"
	);	
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--

	-- 사용자 정보 전달 --
	"ResultUserSeq" = "Var_UserSeq";
END;
$$;