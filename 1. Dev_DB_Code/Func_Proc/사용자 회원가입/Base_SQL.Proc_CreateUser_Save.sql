CREATE OR REPLACE PROCEDURE "Base_SQL"."Proc_CreateUser_Save"(
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
LANGUAGE plpgsql
AS $$
DECLARE
	"Var_Language" INT = 0;
	"Random_Word" VARCHAR(50);
	"Random_NicName" VARCHAR(100);
	"Random_Index" INT;
BEGIN
/*    
-- ************************************************************************************ --
Create Name : 사용자계정 생성_Save
Create Date : 2024-06-26
Create Emp : JayJun
Update Emp :
-- ************************************************************************************ --
*/

	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	-- TB_User 데이터 저장
	INSERT INTO "Base"."TB_User"
	(
		 "UserSeq"			-- 사용자 내부코드
		,"Email"			-- 이메일
		,"LoginPwd"			-- 비밀번호
		,"LoginPwdChgDate"	-- 비밀번호 최종 변경 일자
		,"APIKey"			-- API Key
		,"FromAPI"			-- API 원천		
		,"LoginStatus"		-- 로그인상태
		,"LoginFailCnt"		-- 로그인 실패 수
		,"CreateDate"		-- 가입일자
		,"Remark"			-- 비고
	)
	VALUES
	(
		 "InData_UserSeq"
		,"InData_Email"
		,"InData_LoginPwd"	
		,to_char(now(), 'YYYYMMDD')
		,"InData_APIKey"
		,"InData_FromAPI"
		,1001001 -- 정상진입
		,0
		,to_char(now(), 'YYYYMMDD')
		,NULL
	);
	
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--

	-- TB_UserInfo 데이터 저장
	INSERT INTO "Base"."TB_UserInfo"
	(
		 "UserSeq"
		,"UserName"		-- 사용자 이름
		,"Cellphone"    -- 전화번호
		,"CountrySeq"   -- 국적
		,"Gender"       -- 성별
		,"Birth"		-- 생년월일
		,"Remark"		-- 비고
	)
	VALUES
	(
		 "InData_UserSeq"
		,"InData_UserName"
		,"InData_Cellphone"
		,"InData_CountrySeq"
		,"InData_Gender"
		,"InData_BirthDt"
		,NULL
	);
	
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--

    -- 선택된 무작위 닉네임
    SELECT "NickName" INTO "Random_Word" FROM "Base"."Temp_NickName" ORDER BY random() LIMIT 1;
	"Random_NicName" := CONCAT("Random_Word", '_', to_char(now(), 'YYYYMMDDHH24MISS'));
	
	-- 언어 초기 셋팅
    IF "InData_CountrySeq" = 1 THEN
        "Var_Language" := 1; -- 한국어
    ELSE
        "Var_Language" := 2; -- 영어
    END IF;

	-- TB_UserState 데이터 저장
	INSERT INTO "Base"."TB_UserState"
	(
		 "UserSeq"
		,"NickName" -- 닉네임
		,"LanguageSeq" -- 언어내부코드
		,"ProfileImage" -- 프로필이미지
		,"Remark" -- 비고
	)
	VALUES
	(
		 "InData_UserSeq"
		,"Random_NicName"
		,"Var_Language"
		,NULL
		,NULL
	);
	
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
	-- TP_Amount 데이터 저장
	INSERT INTO "Amt"."TP_Amount"
	(
		 "UserSeq"
		,"CurrentAmt" -- 현재 잔액
		,"IsAutoCha" -- 자동 충전 설정 여부
		,"AutoLimitAmt" -- 최소 임계 금액 
		,"AutoPaymentSeq" -- 자동 충전 결제 내부코드
		,"AutoChaAmt" -- 자동 충전 금액
		,"Remark" -- 비고
	)
	VALUES
	(
		 "InData_UserSeq"
		,0
		,0 -- 자동 충전 비활성화
		,NULL
		,NULL
		,NULL
		,NULL
	);
	
	--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
END;
$$;
