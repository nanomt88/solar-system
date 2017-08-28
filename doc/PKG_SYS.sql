CREATE OR REPLACE PACKAGE PKG_SYS AUTHID DEFINER IS

    /**************************************************************************
     -- Copyright 2013 TPRI. All Rights Reserved.
     -- Summary : 系统处理包
     -- Author  : 交通运输部规划研究院（白贺卓）
     -- Since   : 2013-08-09
    **************************************************************************/

    /**************************************************************************
     -- Summary : 参照游标
     -- return  : RET_REFCUR （返回参照游标数据）
    **************************************************************************/
    TYPE RET_REFCUR IS REF CURSOR;

    /**************************************************************************
     -- Summary : 生成实时数据（参考临时数据）
     -- Param   : P_TASK 任务名称
     -- Param   : P_TEXT 日志文本
     -- Param   : P_REF01 参考字段01（默认NULL）
     -- Param   : P_REF02 参考字段02（默认NULL）
     -- Param   : P_REF03 参考字段03（默认NULL）
     -- Param   : P_REF04 参考字段04（默认NULL）
     -- Param   : P_REF05 参考字段05（默认NULL）
     -- Param   : P_REF06 参考字段06（默认NULL）
     -- Param   : P_REF07 参考字段07（默认NULL）
     -- Param   : P_REF08 参考字段08（默认NULL）
     -- Param   : P_REF09 参考字段09（默认NULL）
     -- Param   : P_REF10 参考字段10（默认NULL）
    **************************************************************************/
    PROCEDURE PUT_LOG
    (
        P_TASK IN VARCHAR2,
        P_TEXT IN VARCHAR2,
        P_REF01 IN VARCHAR2 DEFAULT NULL,
        P_REF02 IN VARCHAR2 DEFAULT NULL,
        P_REF03 IN VARCHAR2 DEFAULT NULL,
        P_REF04 IN VARCHAR2 DEFAULT NULL,
        P_REF05 IN VARCHAR2 DEFAULT NULL,
        P_REF06 IN VARCHAR2 DEFAULT NULL,
        P_REF07 IN VARCHAR2 DEFAULT NULL,
        P_REF08 IN VARCHAR2 DEFAULT NULL,
        P_REF09 IN VARCHAR2 DEFAULT NULL,
        P_REF10 IN VARCHAR2 DEFAULT NULL
    );
    
    /**************************************************************************
     -- Summary : 清理文件数据
     -- Param   : P_DATE 参考时间（默认为当前时间）
     -- Param   : P_RET_REFCUR 参照游标输出参数
    **************************************************************************/
    PROCEDURE CLEAR_FILES(P_RET_REFCUR OUT RET_REFCUR);

END PKG_SYS;


CREATE OR REPLACE PACKAGE BODY PKG_SYS IS

    /**************************************************************************
     -- Summary : 生成实时数据（参考临时数据）
     -- Param   : P_TASK 任务名称
     -- Param   : P_TEXT 日志文本
     -- Param   : P_REF01 参考字段01（默认NULL）
     -- Param   : P_REF02 参考字段02（默认NULL）
     -- Param   : P_REF03 参考字段03（默认NULL）
     -- Param   : P_REF04 参考字段04（默认NULL）
     -- Param   : P_REF05 参考字段05（默认NULL）
     -- Param   : P_REF06 参考字段06（默认NULL）
     -- Param   : P_REF07 参考字段07（默认NULL）
     -- Param   : P_REF08 参考字段08（默认NULL）
     -- Param   : P_REF09 参考字段09（默认NULL）
     -- Param   : P_REF10 参考字段10（默认NULL）
    **************************************************************************/
    PROCEDURE PUT_LOG
    (
        P_TASK IN VARCHAR2,
        P_TEXT IN VARCHAR2,
        P_REF01 IN VARCHAR2 DEFAULT NULL,
        P_REF02 IN VARCHAR2 DEFAULT NULL,
        P_REF03 IN VARCHAR2 DEFAULT NULL,
        P_REF04 IN VARCHAR2 DEFAULT NULL,
        P_REF05 IN VARCHAR2 DEFAULT NULL,
        P_REF06 IN VARCHAR2 DEFAULT NULL,
        P_REF07 IN VARCHAR2 DEFAULT NULL,
        P_REF08 IN VARCHAR2 DEFAULT NULL,
        P_REF09 IN VARCHAR2 DEFAULT NULL,
        P_REF10 IN VARCHAR2 DEFAULT NULL
    ) IS
    BEGIN
        INSERT INTO SYS_LOG
            (LOG_TASK,
             LOG_TIME,
             LOG_TEXT,
             REF01,
             REF02,
             REF03,
             REF04,
             REF05,
             REF06,
             REF07,
             REF08,
             REF09,
             REF10)
        VALUES
            (SUBSTR(P_TASK, 1, 100),
             SYSTIMESTAMP,
             SUBSTR(P_TEXT, 1, 500),
             SUBSTR(P_REF01, 1, 100),
             SUBSTR(P_REF02, 1, 100),
             SUBSTR(P_REF03, 1, 100),
             SUBSTR(P_REF04, 1, 100),
             SUBSTR(P_REF05, 1, 100),
             SUBSTR(P_REF06, 1, 100),
             SUBSTR(P_REF07, 1, 100),
             SUBSTR(P_REF08, 1, 100),
             SUBSTR(P_REF09, 1, 100),
             SUBSTR(P_REF10, 1, 100));
    END PUT_LOG;

    /**************************************************************************
     -- Summary : 清理文件数据
     -- Param   : P_DATE 参考时间（默认为当前时间）
    **************************************************************************/
    PROCEDURE CLEAR_FILES(P_RET_REFCUR OUT RET_REFCUR) IS
        V_DATE TIMESTAMP := SYSTIMESTAMP;
        CURSOR CUR_EXPIRED_FILE IS
            SELECT KEY FROM SYS_FILE WHERE EXPIRED < V_DATE;
        V_EXPIRED_FILE CUR_EXPIRED_FILE%ROWTYPE;
    BEGIN
        OPEN P_RET_REFCUR FOR SELECT DATA_PATH FROM SYS_FILE WHERE EXPIRED < V_DATE;
        FOR V_EXPIRED_FILE IN CUR_EXPIRED_FILE LOOP
            DELETE FROM SYS_FILE WHERE KEY = V_EXPIRED_FILE.KEY;
            COMMIT;
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            PUT_LOG(P_TASK  => 'PKG_SYS.CLEAR_FILES',
                    P_TEXT  => 'EXCEPTION : [' || SQLCODE || ']' || SQLERRM,
                    P_REF01 => TO_CHAR(V_DATE, 'YYYY-MM-DD HH24:MI:SS.FF'));
            COMMIT;
    END CLEAR_FILES;

END PKG_SYS;















