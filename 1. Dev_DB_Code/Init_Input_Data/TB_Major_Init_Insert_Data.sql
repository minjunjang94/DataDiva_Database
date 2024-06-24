/*
TB_Major_Init_Insert_Data
Create Date : 2024-06-24
Create Emp  : JayJun
Update Emp  :
*/

DELETE FROM "Base"."TB_Major";

-- @@@@@ "Base"."TB_Major"."MajorSeq" 1000 @@@@@ --
INSERT INTO "Base"."TB_Major" ("MajorSeq","MajorName","Remark") VALUES (1001,'LoginStatus' ,'로그인상태');
INSERT INTO "Base"."TB_Major" ("MajorSeq","MajorName","Remark") VALUES (1002,'FromAPI' ,'API 원천');
INSERT INTO "Base"."TB_Major" ("MajorSeq","MajorName","Remark") VALUES (1003,'Gender' ,'성별');
INSERT INTO "Base"."TB_Major" ("MajorSeq","MajorName","Remark") VALUES (1004,'SysInfoType' ,'시스템 정보 타입');


-- @@@@@ "Base"."TB_Major"."MajorSeq" 2000 @@@@@ --
INSERT INTO "Base"."TB_Major" ("MajorSeq","MajorName","Remark") VALUES (2001, 'SubjectType', '주제 분류');
INSERT INTO "Base"."TB_Major" ("MajorSeq","MajorName","Remark") VALUES (2002, 'RefStatus', '등록심사 현황');
