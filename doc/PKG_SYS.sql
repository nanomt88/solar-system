CREATE OR REPLACE PACKAGE PKG_SYS AUTHID DEFINER IS

    /**************************************************************************
     -- Copyright 2013 TPRI. All Rights Reserved.
     -- Summary : ϵͳ�����
     -- Author  : ��ͨ���䲿�滮�о�Ժ���׺�׿��
     -- Since   : 2013-08-09
    **************************************************************************/

    /**************************************************************************
     -- Summary : �����α�
     -- return  : RET_REFCUR �����ز����α����ݣ�
    **************************************************************************/
    TYPE RET_REFCUR IS REF CURSOR;

    /**************************************************************************
     -- Summary : ����ʵʱ���ݣ��ο���ʱ���ݣ�
     -- Param   : P_TASK ��������
     -- Param   : P_TEXT ��־�ı�
     -- Param   : P_REF01 �ο��ֶ�01��Ĭ��NULL��
     -- Param   : P_REF02 �ο��ֶ�02��Ĭ��NULL��
     -- Param   : P_REF03 �ο��ֶ�03��Ĭ��NULL��
     -- Param   : P_REF04 �ο��ֶ�04��Ĭ��NULL��
     -- Param   : P_REF05 �ο��ֶ�05��Ĭ��NULL��
     -- Param   : P_REF06 �ο��ֶ�06��Ĭ��NULL��
     -- Param   : P_REF07 �ο��ֶ�07��Ĭ��NULL��
     -- Param   : P_REF08 �ο��ֶ�08��Ĭ��NULL��
     -- Param   : P_REF09 �ο��ֶ�09��Ĭ��NULL��
     -- Param   : P_REF10 �ο��ֶ�10��Ĭ��NULL��
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
     -- Summary : �����ļ�����
     -- Param   : P_DATE �ο�ʱ�䣨Ĭ��Ϊ��ǰʱ�䣩
     -- Param   : P_RET_REFCUR �����α��������
    **************************************************************************/
    PROCEDURE CLEAR_FILES(P_RET_REFCUR OUT RET_REFCUR);

END PKG_SYS;


CREATE OR REPLACE PACKAGE BODY PKG_SYS IS

    /**************************************************************************
     -- Summary : ����ʵʱ���ݣ��ο���ʱ���ݣ�
     -- Param   : P_TASK ��������
     -- Param   : P_TEXT ��־�ı�
     -- Param   : P_REF01 �ο��ֶ�01��Ĭ��NULL��
     -- Param   : P_REF02 �ο��ֶ�02��Ĭ��NULL��
     -- Param   : P_REF03 �ο��ֶ�03��Ĭ��NULL��
     -- Param   : P_REF04 �ο��ֶ�04��Ĭ��NULL��
     -- Param   : P_REF05 �ο��ֶ�05��Ĭ��NULL��
     -- Param   : P_REF06 �ο��ֶ�06��Ĭ��NULL��
     -- Param   : P_REF07 �ο��ֶ�07��Ĭ��NULL��
     -- Param   : P_REF08 �ο��ֶ�08��Ĭ��NULL��
     -- Param   : P_REF09 �ο��ֶ�09��Ĭ��NULL��
     -- Param   : P_REF10 �ο��ֶ�10��Ĭ��NULL��
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
     -- Summary : �����ļ�����
     -- Param   : P_DATE �ο�ʱ�䣨Ĭ��Ϊ��ǰʱ�䣩
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















