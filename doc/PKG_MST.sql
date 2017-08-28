CREATE OR REPLACE PACKAGE PKG_MST AUTHID DEFINER IS
    /**************************************************************************
     -- Copyright 2013 TPRI. All Rights Reserved.
     -- Summary : ������Ϣ�����
     -- Author  : ��ͨ���䲿�滮�о�Ժ���׺�׿��
     -- Since   : 2013-04-26
    **************************************************************************/

    -- ϵͳ���񣺻���������
    C_TASK_CACHE_MST_ORG CONSTANT VARCHAR2(13) := 'CACHE_MST_ORG';

    /**************************************************************************
     -- Summary : �������ɹ��������ϵ����
    **************************************************************************/
    PROCEDURE REGEN_ORG_REF;

END PKG_MST;

CREATE OR REPLACE PACKAGE BODY PKG_MST IS

    /**************************************************************************
     -- Summary : �������ɹ��������ϵ����
    **************************************************************************/
    PROCEDURE REGEN_ORG_REF IS
         TYPE IDX_ORGID_TABLE IS TABLE OF VARCHAR2(32) INDEX BY BINARY_INTEGER; --���������
         V_ORGID_LIST IDX_ORGID_TABLE;   --���������ͱ��� 
         V_I BINARY_INTEGER;   --����һ��ineger���� ����ѭ������
    BEGIN
         DELETE FROM MST_ORG_REF;  --ɾ��ȫ��
         --װ�����ݵ������ͱ�����ȥ
         SELECT ORG_ID BULK COLLECT INTO V_ORGID_LIST FROM MST_ORG  
                START WITH PARENT_ID IS NULL
                CONNECT BY PRIOR ORG_ID = PARENT_ID;
         --ȡ�õ�һ������ֵ
         V_I := V_ORGID_LIST.FIRST;    
         WHILE V_I IS NOT NULL LOOP
               DECLARE 
                    V_ORGID MST_ORG.ORG_ID%TYPE := V_ORGID_LIST(V_I);
                    --����һ���α�
                    CURSOR CUR_ORG_TREE IS
                           SELECT * FROM MST_ORG
                                    START WITH ORG_ID = V_ORGID     
                                    CONNECT BY PRIOR ORG_ID = PARENT_ID;
                    V_OT CUR_ORG_TREE%ROWTYPE;
               BEGIN
                    -- FORѭ��
                    FOR V_OT IN CUR_ORG_TREE LOOP
                        --DBMS_OUTPUT.PUT_LINE('V_D :' || V_DEPTID);
                        --DBMS_OUTPUT.PUT_LINE('V_DT:' || V_DT.DEPT_ID); 
                        INSERT INTO MST_ORG_REF VALUES(V_OT.ORG_ID, V_ORGID);
                    END LOOP;       
               END; 
               -- ���±���                
               V_I := V_ORGID_LIST.NEXT(V_I);                 
         END LOOP;         
    END;

END PKG_MST;
