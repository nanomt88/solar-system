
DROP TABLE IF EXISTS MST_CODE ;

DROP TABLE IF EXISTS MST_DIST ;

DROP TABLE IF EXISTS MST_EQUIP ;

DROP TABLE IF EXISTS MST_ORG ;

DROP TABLE IF EXISTS MST_ORG_REF ;

DROP TABLE IF EXISTS MST_SITE ;

/*==============================================================*/
/* Table: MST_CODE                                              */
/*==============================================================*/
create table MST_CODE 
(
   ID                   INT(11)             NOT NULL AUTO_INCREMENT COMMENT '自然主键',
   TYPE                 VARCHAR(40)         not null,
   CODE                 VARCHAR(40)         not null,
   NAME                 VARCHAR(100)        not null,
   ATTR01               VARCHAR(200),
   ATTR02               VARCHAR(200),
   ATTR03               VARCHAR(200),
   ATTR04               VARCHAR(200),
   ATTR05               VARCHAR(200),
   ATTR06               VARCHAR(200),
   ATTR07               VARCHAR(200),
   ATTR08               VARCHAR(200),
   ATTR09               VARCHAR(200),
   ATTR10               VARCHAR(200),
   ORDER_SEQ            DECIMAL(6),
   EXPIRED              TIMESTAMP,
   DESC_INFO            VARCHAR(200),
   CREATE_BY            VARCHAR(40)          not null,
   CREATE_TIME          TIMESTAMP            not null,
   UPDATE_BY            VARCHAR(40)          not null,
   UPDATE_TIME          TIMESTAMP            not null,
   PRIMARY KEY (`ID`),
   UNIQUE KEY K_MST_CODE (TYPE, CODE)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

/*==============================================================*/
/* Table: MST_DIST                                              */
/*==============================================================*/
create table MST_DIST
(
   ID                   INT(11)             NOT NULL AUTO_INCREMENT COMMENT '自然主键',
   DIST_CODE            VARCHAR(6)          not null,
   SJDM                 VARCHAR(2)          not null,
   DSDM                 VARCHAR(2)          not null,
   QXDM                 VARCHAR(2)          not null,
   DIST_NAME            VARCHAR(100)        not null,
   SJMC                 VARCHAR(100),
   DSMC                 VARCHAR(100),
   QXMC                 VARCHAR(100),
   SHORT                VARCHAR(40),
   LEAF                 VARCHAR(1)          not null,
   DESC_INFO            VARCHAR(200),
   CREATE_BY            VARCHAR(40)         not null,
   CREATE_TIME          TIMESTAMP           not null,
   UPDATE_BY            VARCHAR(40)         not null,
   UPDATE_TIME          TIMESTAMP           not null,
   PRIMARY KEY (`ID`),
   UNIQUE KEY _MST_CODE (DIST_CODE)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

/*==============================================================*/
/* Table: MST_EQUIP                                             */
/*==============================================================*/
create table MST_EQUIP 
(
   ID                   INT(11)             NOT NULL AUTO_INCREMENT COMMENT '自然主键',
   EQUIP_ID             VARCHAR(32)         not null,
   EQUIP_TYPE           VARCHAR(1)          not null,
   EQUIP_STATUS         VARCHAR(1)          not null,
   SITE_ID              VARCHAR(32)         not null,
   MODEL                VARCHAR(40)         not null,
   MAKER                VARCHAR(40)         not null,
   CONTACT              VARCHAR(40),
   TEL                  VARCHAR(24),
   INST_DATE            TIMESTAMP,
   CHECK_DATE           TIMESTAMP,
   CHECK_LINE           VARCHAR(1),
   LAST_IP              VARCHAR(40),
   LAST_TIME            TIMESTAMP,
   EXPIRED              TIMESTAMP,
   DESC_INFO            VARCHAR(200),
   CREATE_BY            VARCHAR(40)         not null,
   CREATE_TIME          TIMESTAMP            not null,
   UPDATE_BY            VARCHAR(40)         not null,
   UPDATE_TIME          TIMESTAMP            not null,
   PRIMARY KEY (`ID`),
   UNIQUE KEY UK_MST_EQUIP (EQUIP_ID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

/*==============================================================*/
/* Table: MST_ORG                                               */
/*==============================================================*/
create table MST_ORG
(
   ID                   INT(11)             NOT NULL AUTO_INCREMENT COMMENT '自然主键',
   ORG_ID               VARCHAR(32)         not null,
   ORG_CODE             VARCHAR(11)         not null,
   ORG_NAME             VARCHAR(100)        not null,
   ORG_TYPE             VARCHAR(2)          not null,
   DIST_CODE            VARCHAR(6)          not null,
   PARENT_ID            VARCHAR(32),
   CONTACT              VARCHAR(40),
   TEL                  VARCHAR(24),
   FAX                  VARCHAR(24),
   MAIL                 VARCHAR(100),
   ADDRESS              VARCHAR(100),
   POSTCODE             VARCHAR(20),
   LEAF                 VARCHAR(1)          not null,
   EXPIRED              TIMESTAMP,
   DESC_INFO            VARCHAR(200),
   CREATE_BY            VARCHAR(40)         not null,
   CREATE_TIME          TIMESTAMP            not null,
   UPDATE_BY            VARCHAR(40)         not null,
   UPDATE_TIME          TIMESTAMP            not null,
   PRIMARY KEY (`ID`),
   UNIQUE KEY K_MST_ORG (ORG_ID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

/*==============================================================*/
/* Table: MST_ORG_REF                                           */
/*==============================================================*/
create table MST_ORG_REF 
(
   ID                   INT(11)             NOT NULL AUTO_INCREMENT COMMENT '自然主键',
   ORG_ID               VARCHAR(32)         not null,
   PARENT_ID            VARCHAR(32)         not null,
   PRIMARY KEY (`ID`),
   UNIQUE KEY UK_MST_ORG_REF (ORG_ID, PARENT_ID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

/*==============================================================*/
/* Table: MST_SITE                                              */
/*==============================================================*/
create table MST_SITE 
(
   ID                   INT(11)             NOT NULL AUTO_INCREMENT COMMENT '自然主键',
   SITE_ID              VARCHAR(32)         not null,
   SITE_NAME            VARCHAR(40)         not null,
   SITE_TYPE            VARCHAR(1)          not null COMMENT '代码分类：路线类型[LXLX]',
   DIST_CODE            VARCHAR(6),
   ORG_ID               VARCHAR(32)         not null,
   MASTER               VARCHAR(40),
   LINE1                DECIMAL(2)          not null,
   LINE2                DECIMAL(2),
   PARKS                DECIMAL(2),
   TOTAL_AREA           DECIMAL(5,1),
   SITE_IMG             VARCHAR(1000),
   TEL                  VARCHAR(24),
   BUILD_DATE           TIMESTAMP,
   EXPIRED              TIMESTAMP,
   DESC_INFO            VARCHAR(200),
   CREATE_BY            VARCHAR(40)         not null,
   CREATE_TIME          TIMESTAMP           not null,
   UPDATE_BY            VARCHAR(40)         not null,
   UPDATE_TIME          TIMESTAMP           not null,
   PRIMARY KEY (`ID`),
   UNIQUE KEY PK_MST_SITE (SITE_ID),
   UNIQUE KEY UK_MST_SITE_NAME (SITE_NAME)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;


DROP TABLE IF EXISTS DAT_CHECK_DATA ;

/*==============================================================*/
/* Table: DAT_CHECK_DATA                                        */
/*==============================================================*/
create table DAT_CHECK_DATA
(
   ID                   INT(11)             NOT NULL AUTO_INCREMENT COMMENT '自然主键',
   CHECK_NO             VARCHAR(32)         not null,
   CHECK_TYPE           VARCHAR(1)          not null,
   SITE_ID              VARCHAR(32)         not null,
   EQUIP_ID             VARCHAR(32),
   LINE                 VARCHAR(2),
   VEHICLE_NO           VARCHAR(12),
   VEHICLE_TYPE         VARCHAR(4),
   AXLES                DECIMAL(1),
   TYRES                DECIMAL(2),
   CHECK_RESULT         VARCHAR(1)          not null,
   CHECK_BY             VARCHAR(40),
   CHECK_TIME           TIMESTAMP           not null,
   SPEED                DECIMAL(5,2),
   LIMIT_TOTAL          DECIMAL(6),
   OVER_TOTAL           DECIMAL(6),
   TOTAL                DECIMAL(6)          default 0 not null,
   DESC_INFO            VARCHAR(200),
   CREATE_BY            VARCHAR(40)         not null,
   CREATE_TIME          TIMESTAMP           not null,
   UPDATE_BY            VARCHAR(40)         not null,
   UPDATE_TIME          TIMESTAMP           not null,
   PRIMARY KEY (`ID`),
   UNIQUE KEY UK_DAT_CHECK_DATA (CHECK_NO)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;