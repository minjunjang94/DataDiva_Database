/*
TB_Minor_Init_Insert_Data
Create Date : 2024-06-24 
Create Emp  : JayJun
Update Emp  :
*/

DELETE FROM "Base"."TB_Minor";

-- @@@@@ "Base"."TB_Minor"."MajorSeq" 1000 @@@@@ --
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (1001001,1001,'Normal Entry', '정상진입');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (1001002,1001,'Temporary suspension account', '임시정지계정');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (1001003,1001,'Dormant account', '휴면계정');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (1001004,1001,'Delete account', '삭제계정');
																																											            
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (1002001,1002,'Naver', '네이버');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (1002002,1002,'Kakao', '카카오');
																																												        
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (1003001,1003,'Male', '남성');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (1003002,1003,'Female', '여성');
																																													    
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (1004001,1004,'Terms and Policies', '약관 및 정책');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (1004002,1004,'Update history', '업데이트 기록');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (1004003,1004,'About Us', '회사 소개');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (1004004,1004,'Creator', '만든이');


-- @@@@@ "Base"."TB_Minor"."MajorSeq" 2000 @@@@@ --
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (2001001,2001,'Agriculture_Fisheries_Marine', '농수해양');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (2001002,2001,'Art_Physical', '예술체육');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (2001003,2001,'Complex_Studies', '복합학');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (2001004,2001,'Engineering', '공학');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (2001005,2001,'Humanities', '인문학');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (2001006,2001,'Medicine', '의약학');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (2001007,2001,'Natural_Science', '자연과학');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (2001008,2001,'Social_Science', '사회과학');
																																											            
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (2002001,2002,'Under review', '심사 중');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (2002002,2002,'Approval', '등록 완료');
INSERT INTO "Base"."TB_Minor" ("MinorSeq","MajorSeq","MinorName","Remark") VALUES (2002003,2002,'Refuse', '등록 거절');

