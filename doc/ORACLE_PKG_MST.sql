CREATE OR REPLACE PACKAGE PKG_MST AUTHID DEFINER IS
    /**************************************************************************
     -- Copyright 2013 TPRI. All Rights Reserved.
     -- Summary : 基础信息处理包
     -- Author  : 交通运输部规划研究院（白贺卓）
     -- Since   : 2013-04-26
    **************************************************************************/

    -- 系统任务：缓存管理机构
    C_TASK_CACHE_MST_ORG CONSTANT VARCHAR2(13) := 'CACHE_MST_ORG';

    /**************************************************************************
     -- Summary : 重新生成管理机构关系数据
    **************************************************************************/
    PROCEDURE REGEN_ORG_REF;

END PKG_MST;

CREATE OR REPLACE PACKAGE BODY PKG_MST IS

    /**************************************************************************
     -- Summary : 重新生成管理机构关系数据
    **************************************************************************/
    PROCEDURE REGEN_ORG_REF IS
         TYPE IDX_ORGID_TABLE IS TABLE OF VARCHAR2(32) INDEX BY BINARY_INTEGER; --定义表类型
         V_ORGID_LIST IDX_ORGID_TABLE;   --声明表类型变量 
         V_I BINARY_INTEGER;   --声明一个ineger变量 用于循环控制
    BEGIN
         DELETE FROM MST_ORG_REF;  --删除全表
         --装载数据到表类型变量中去
         SELECT ORG_ID BULK COLLECT INTO V_ORGID_LIST FROM MST_ORG  
                START WITH PARENT_ID IS NULL
                CONNECT BY PRIOR ORG_ID = PARENT_ID;
         --取得第一个索引值
         V_I := V_ORGID_LIST.FIRST;    
         WHILE V_I IS NOT NULL LOOP
               DECLARE 
                    V_ORGID MST_ORG.ORG_ID%TYPE := V_ORGID_LIST(V_I);
                    --声明一个游标
                    CURSOR CUR_ORG_TREE IS
                           SELECT * FROM MST_ORG
                                    START WITH ORG_ID = V_ORGID     
                                    CONNECT BY PRIOR ORG_ID = PARENT_ID;
                    V_OT CUR_ORG_TREE%ROWTYPE;
               BEGIN
                    -- FOR循环
                    FOR V_OT IN CUR_ORG_TREE LOOP
                        --DBMS_OUTPUT.PUT_LINE('V_D :' || V_DEPTID);
                        --DBMS_OUTPUT.PUT_LINE('V_DT:' || V_DT.DEPT_ID); 
                        INSERT INTO MST_ORG_REF VALUES(V_OT.ORG_ID, V_ORGID);
                    END LOOP;       
               END; 
               -- 向下遍历                
               V_I := V_ORGID_LIST.NEXT(V_I);                 
         END LOOP;         
    END;

END PKG_MST;
