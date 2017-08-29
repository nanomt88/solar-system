drop table if exists DAT_CHECK_DATA;
drop table if exists MST_CODE;
drop table if exists MST_DIST;
drop table if exists MST_EQUIP;
drop table if exists MST_ORG;
drop table if exists MST_ORG_REF;
drop table if exists MST_SITE;
drop table if exists STA_CHECK_DAY;
drop table if exists STA_CHECK_PERIOD;
drop table if exists SYS_FILE;
drop table if exists SYS_FUNC;
drop table if exists SYS_LOG;
drop table if exists SYS_PARAM;
drop table if exists SYS_ROLE;
drop table if exists SYS_ROLE_FUNC;
drop table if exists SYS_TASK;
drop table if exists SYS_USER;

/*==============================================================*/
/* Table: DAT_CHECK_DATA                                        */
/*==============================================================*/
create table DAT_CHECK_DATA
(
   CHECK_NO             varchar(32) not null comment '检测单号',
   CHECK_TYPE           varchar(1) not null comment '检测类型',
   SITE_ID              varchar(32) not null comment '站点标识',
   EQUIP_ID             varchar(32) comment '设备标识',
   LINE                 varchar(2) comment '车道号',
   VEHICLE_NO           varchar(12) comment '车牌号',
   VEHICLE_TYPE         varchar(4) comment '车辆类型',
   AXLES                numeric(1,0) comment '轴数',
   TYRES                numeric(2,0) comment '轮胎数',
   CHECK_RESULT         varchar(1) not null comment '检测结果',
   CHECK_BY             varchar(40) comment '检测人员',
   CHECK_TIME           timestamp not null comment '检测时间',
   SPEED                numeric(5,2) comment '检测车速',
   LIMIT_TOTAL          numeric(6,0) comment '限制总重',
   OVER_TOTAL           numeric(6,0) comment '超限量',
   TOTAL                numeric(6,0) not null default 0 comment '检测车货总重(kg)',
   DESC_INFO            varchar(200) comment '备注',
   CREATE_BY            varchar(40) not null comment '创建人',
   CREATE_TIME          timestamp not null comment '创建时间',
   UPDATE_BY            varchar(40) not null comment '更新人',
   UPDATE_TIME          timestamp not null comment '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table DAT_CHECK_DATA comment '检测数据';

alter table DAT_CHECK_DATA add primary key (CHECK_NO);

/*==============================================================*/
/* Table: MST_CODE                                              */
/*==============================================================*/
create table MST_CODE
(
   TYPE                 varchar(40) not null comment '类型',
   CODE                 varchar(40) not null comment '代码',
   NAME                 varchar(100) not null comment '名称',
   ATTR01               varchar(200) comment '属性01',
   ATTR02               varchar(200) comment '属性02',
   ATTR03               varchar(200) comment '属性03',
   ATTR04               varchar(200) comment '属性04',
   ATTR05               varchar(200) comment '属性05',
   ATTR06               varchar(200) comment '属性06',
   ATTR07               varchar(200) comment '属性07',
   ATTR08               varchar(200) comment '属性08',
   ATTR09               varchar(200) comment '属性09',
   ATTR10               varchar(200) comment '属性10',
   ORDER_SEQ            numeric(6,0) comment '排序',
   EXPIRED              timestamp comment '过期时间',
   DESC_INFO            varchar(200) comment '备注',
   CREATE_BY            varchar(40) not null comment '创建人',
   CREATE_TIME          timestamp not null comment '创建时间',
   UPDATE_BY            varchar(40) not null comment '更新人',
   UPDATE_TIME          timestamp not null comment '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table MST_CODE comment '业务代码';

alter table MST_CODE add primary key (TYPE, CODE);

/*==============================================================*/
/* Table: MST_DIST                                              */
/*==============================================================*/
create table MST_DIST
(
   DIST_CODE            varchar(6) not null comment '行政区划代码',
   SJDM                 varchar(2) not null comment '省级代码',
   DSDM                 varchar(2) not null comment '地市代码',
   QXDM                 varchar(2) not null comment '区县代码',
   DIST_NAME            varchar(100) not null comment '行政区划名称',
   SJMC                 varchar(100) comment '省级名称',
   DSMC                 varchar(100) comment '地市名称',
   QXMC                 varchar(100) comment '区县名称',
   SHORT                varchar(40) comment '行政区划简称',
   LEAF                 varchar(1) not null comment '叶子结点',
   DESC_INFO            varchar(200) comment '备注',
   CREATE_BY            varchar(40) not null comment '创建人',
   CREATE_TIME          timestamp not null comment '创建时间',
   UPDATE_BY            varchar(40) not null comment '更新人',
   UPDATE_TIME          timestamp not null comment '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table MST_DIST comment '行政区划';

alter table MST_DIST add primary key (DIST_CODE);

/*==============================================================*/
/* Table: MST_EQUIP                                             */
/*==============================================================*/
create table MST_EQUIP
(
   EQUIP_ID             varchar(32) not null comment '设备标识',
   EQUIP_TYPE           varchar(1) not null comment '设备类型',
   EQUIP_STATUS         varchar(1) not null comment '设备状态',
   SITE_ID              varchar(32) not null comment '站点标识',
   MODEL                varchar(40) not null comment '设备型号',
   MAKER                varchar(40) not null comment '生产厂商',
   CONTACT              varchar(40) comment '联系人',
   TEL                  varchar(24) comment '联系电话',
   INST_DATE            timestamp comment '安装日期',
   CHECK_DATE           timestamp comment '检验日期',
   CHECK_LINE           varchar(1) comment '检验车道',
   LAST_IP              varchar(40) comment '最后传输IP',
   LAST_TIME            timestamp comment '最后数据时间',
   EXPIRED              timestamp comment '过期时间',
   DESC_INFO            varchar(200) comment '备注',
   CREATE_BY            varchar(40) not null comment '创建人',
   CREATE_TIME          timestamp not null comment '创建时间',
   UPDATE_BY            varchar(40) not null comment '更新人',
   UPDATE_TIME          timestamp not null comment '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table MST_EQUIP comment '设备';

alter table MST_EQUIP add primary key (EQUIP_ID);

/*==============================================================*/
/* Table: MST_ORG                                               */
/*==============================================================*/
create table MST_ORG
(
   ORG_ID               varchar(32) not null comment '机构标识',
   ORG_CODE             varchar(11) not null comment '机构代码',
   ORG_NAME             varchar(100) not null comment '机构名称',
   ORG_TYPE             varchar(2) not null comment '机构类型',
   DIST_CODE            varchar(6) not null comment '行政区划代码',
   PARENT_ID            varchar(32) comment '上级机构标识',
   CONTACT              varchar(40) comment '联系人',
   TEL                  varchar(24) comment '电话',
   FAX                  varchar(24) comment '传真',
   MAIL                 varchar(100) comment '邮件',
   ADDRESS              varchar(100) comment '地址',
   POSTCODE             varchar(20) comment '邮编',
   LEAF                 varchar(1) not null comment '叶子结点',
   EXPIRED              timestamp comment '过期时间',
   DESC_INFO            varchar(200) comment '备注',
   CREATE_BY            varchar(40) not null comment '创建人',
   CREATE_TIME          timestamp not null comment '创建时间',
   UPDATE_BY            varchar(40) not null comment '更新人',
   UPDATE_TIME          timestamp not null comment '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table MST_ORG comment '管理机构';

alter table MST_ORG add primary key (ORG_ID);

/*==============================================================*/
/* Table: MST_ORG_REF                                           */
/*==============================================================*/
create table MST_ORG_REF
(
   ORG_ID               varchar(32) not null comment '机构标识',
   PARENT_ID            varchar(32) not null comment '上级机构标识'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table MST_ORG_REF comment '管理机构关系';

alter table MST_ORG_REF add primary key (ORG_ID, PARENT_ID);

/*==============================================================*/
/* Table: MST_SITE                                              */
/*==============================================================*/
create table MST_SITE
(
   SITE_ID              varchar(32) not null comment '站点标识',
   SITE_NAME            varchar(40) not null comment '站点名称',
   SITE_TYPE            varchar(1) not null comment '代码分类：路线类型[LXLX]',
   DIST_CODE            varchar(6) comment '行政区划代码',
   ORG_ID               varchar(32) not null comment '机构标识',
   MASTER               varchar(40) comment '站长',
   LINE1                numeric(2,0) not null comment '初检车道数',
   LINE2                numeric(2,0) comment '复检车道数',
   PARKS                numeric(2,0) comment '停车卸货场数',
   TOTAL_AREA           numeric(5,1) comment '总占地面积(平米)',
   SITE_IMG             varchar(1000) comment '站点图片',
   TEL                  varchar(24) comment '联系电话',
   BUILD_DATE           timestamp comment '建站日期',
   EXPIRED              timestamp comment '过期时间',
   DESC_INFO            varchar(200) comment '备注',
   CREATE_BY            varchar(40) not null comment '创建人',
   CREATE_TIME          timestamp not null comment '创建时间',
   UPDATE_BY            varchar(40) not null comment '更新人',
   UPDATE_TIME          timestamp not null comment '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table MST_SITE comment '站点';

alter table MST_SITE add primary key (SITE_ID);

alter table MST_SITE add unique AK_MST_SITE_01 (SITE_NAME);

/*==============================================================*/
/* Table: STA_CHECK_DAY                                         */
/*==============================================================*/
create table STA_CHECK_DAY
(
   YEAR                 numeric(4,0) not null comment '年份',
   SITE_ID              varchar(32) not null comment '站点标识',
   CHECK_DAY            timestamp not null comment '检测日期',
   CHECK_COUNT          numeric(10,0) comment '检测车辆数',
   OVER_COUNT           numeric(10,0) comment '超限车辆数',
   OVER_TOTAL           numeric(10,0) comment '超限量(kg)',
   BIG_OVER_COUNT       numeric(10,0) comment '百吨王车辆数',
   ZS_2                 numeric(10,0) comment '2轴',
   ZS_3                 numeric(10,0) comment '3轴',
   ZS_4                 numeric(10,0) comment '4轴',
   ZS_5                 numeric(10,0) comment '5轴',
   ZS_6                 numeric(10,0) comment '6轴',
   ZS_6YS               numeric(10,0) comment '6轴以上',
   CXL55YS              numeric(10,0) comment '超限量55吨以上',
   CX0_10               numeric(10,0) comment '超限0-10%',
   CX10_30              numeric(10,0) comment '超限10-30%',
   CX30_60              numeric(10,0) comment '超限30-60%',
   CX60_100             numeric(10,0) comment '超限60-100%',
   CX100_               numeric(10,0) comment '超限大于100%',
   UPDATE_BY            varchar(40) not null comment '更新人',
   UPDATE_TIME          timestamp not null comment '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table STA_CHECK_DAY comment '检测日数据';

/*==============================================================*/
/* Table: STA_CHECK_PERIOD                                      */
/*==============================================================*/
create table STA_CHECK_PERIOD
(
   YEAR                 numeric(4,0) not null comment '年份',
   SITE_ID              varchar(32) not null comment '站点标识',
   PERIOD_TYPE          varchar(1) not null comment '周期类型',
   PERIOD               numeric(4,0) not null comment '周期',
   CHECK_COUNT          numeric(10,0) comment '检测车辆数',
   OVER_COUNT           numeric(10,0) comment '超限车辆数',
   OVER_TOTAL           numeric(10,0) comment '超限量(kg)',
   BIG_OVER_COUNT       numeric(10,0) comment '百吨王车辆数',
   ZS_2                 numeric(10,0) comment '2轴',
   ZS_3                 numeric(10,0) comment '3轴',
   ZS_4                 numeric(10,0) comment '4轴',
   ZS_5                 numeric(10,0) comment '5轴',
   ZS_6                 numeric(10,0) comment '6轴',
   ZS_6YS               numeric(10,0) comment '6轴以上',
   CXL55YS              numeric(10,0) comment '超限量55吨以上',
   CX0_10               numeric(10,0) comment '超限0-10%',
   CX10_30              numeric(10,0) comment '超限10-30%',
   CX30_60              numeric(10,0) comment '超限30-60%',
   CX60_100             numeric(10,0) comment '超限60-100%',
   CX100_               numeric(10,0) comment '超限大于100%',
   UPDATE_BY            varchar(40) not null comment '更新人',
   UPDATE_TIME          timestamp not null comment '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table STA_CHECK_PERIOD comment '检测周期数据';


/*==============================================================*/
/* Table: SYS_FILE                                              */
/*==============================================================*/
create table SYS_FILE
(
   `KEY`                  varchar(32) not null comment '文件键值',
   TYPE                 varchar(10) not null comment '文件分类',
   NAME                 varchar(80) not null comment '文件名称',
   EXT                  varchar(8) comment '文件扩展名',
   BYTES                numeric(12,0) not null comment '文件大小',
   DATA_PATH            varchar(200) not null comment '文件数据存储路径',
   DATA_GROUP           varchar(10) comment '文件数据存储组',
   EXPIRED              timestamp comment '过期时间',
   DESC_INFO            varchar(200) comment '备注',
   UPDATE_BY            varchar(40) not null comment '更新人',
   UPDATE_TIME          timestamp not null comment '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table SYS_FILE comment '系统文件';

alter table SYS_FILE add primary key (`KEY`);




/*==============================================================*/
/* Table: SYS_FUNC                                              */
/*==============================================================*/
create table SYS_FUNC
(
   FUNC_CODE            varchar(40) not null comment '功能代码',
   FUNC_NAME            varchar(40) comment '功能名称',
   FUNC_TYPE            varchar(40) comment '功能类型',
   FUNC_PATH            varchar(40) comment '功能路径',
   ORDER_SEQ            numeric(10,0) comment '排序',
   DISABLE_FLAH         varchar(1) comment '禁用标记',
   DESC_INFO            varchar(200) comment '备注',
   CREATE_BY            varchar(40) not null comment '创建人',
   CREATE_TIME          timestamp not null comment '创建时间',
   UPDATE_BY            varchar(40) not null comment '更新人',
   UPDATE_TIME          timestamp not null comment '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table SYS_FUNC comment '系统功能';

alter table SYS_FUNC add primary key (FUNC_CODE);

/*==============================================================*/
/* Table: SYS_LOG                                               */
/*==============================================================*/
create table SYS_LOG
(
   LOG_TASK             varchar(100) not null comment '日志任务',
   LOG_TIME             timestamp not null comment '日志时间',
   LOG_TEXT             varchar(1000) not null comment '日志内容',
   REF01                varchar(200) comment '参考01',
   REF02                varchar(200) comment '参考02',
   REF03                varchar(200) comment '参考03',
   REF04                varchar(200) comment '参考04',
   REF05                varchar(200) comment '参考05',
   REF06                varchar(200) comment '参考06',
   REF07                varchar(200) comment '参考07',
   REF08                varchar(200) comment '参考08',
   REF09                varchar(200) comment '参考09',
   REF10                varchar(200) comment '参考10'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table SYS_LOG comment '系统日志';

/*==============================================================*/
/* Table: SYS_PARAM                                             */
/*==============================================================*/
create table SYS_PARAM
(
   PARAM_CODE           varchar(40) not null comment '参数代码',
   PARAM_NAME           varchar(40) comment '参数名',
   PARAM_VALUE          varchar(40) comment '参数值',
   DESC_INFO            varchar(200) comment '备注',
   CREATE_BY            varchar(40) not null comment '创建人',
   CREATE_TIME          timestamp not null comment '创建时间',
   UPDATE_BY            varchar(40) not null comment '更新人',
   UPDATE_TIME          timestamp not null comment '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table SYS_PARAM comment '系统参数';

alter table SYS_PARAM add primary key (PARAM_CODE);

/*==============================================================*/
/* Table: SYS_ROLE                                              */
/*==============================================================*/
create table SYS_ROLE
(
   ROLE_CODE            varchar(40) not null comment '角色代码',
   ROLE_NAME            varchar(40) comment '角色名称',
   DISABLE_FLAG         varchar(1) comment '禁用标记',
   DESC_INFO            varchar(200) comment '备注',
   CREATE_BY            varchar(40) not null comment '创建人',
   CREATE_TIME          timestamp not null comment '创建时间',
   UPDATE_BY            varchar(40) not null comment '更新人',
   UPDATE_TIME          timestamp not null comment '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table SYS_ROLE comment '系统角色';

alter table SYS_ROLE add primary key (ROLE_CODE);

/*==============================================================*/
/* Table: SYS_ROLE_FUNC                                         */
/*==============================================================*/
create table SYS_ROLE_FUNC
(
   ROLE_CODE            varchar(40) not null comment '角色代码',
   FUNC_CODE            varchar(40) not null comment '功能代码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table SYS_ROLE_FUNC comment '系统角色功能';

alter table SYS_ROLE_FUNC add primary key (ROLE_CODE, FUNC_CODE);

/*==============================================================*/
/* Table: SYS_TASK                                              */
/*==============================================================*/
create table SYS_TASK
(
   TASK_CODE            varchar(40) not null comment '任务代码',
   TASK_NAME            varchar(100) not null comment '任务名称',
   LAST_TIME            timestamp comment '最后执行时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table SYS_TASK comment '系统任务';

alter table SYS_TASK add unique AK_SYS_TASK_01 (TASK_CODE);

/*==============================================================*/
/* Table: SYS_USER                                              */
/*==============================================================*/
create table SYS_USER
(
   USER_ID              varchar(40) not null comment '用户ID',
   PASSWORD             varchar(128) not null comment '密码',
   USER_NAME            varchar(40) not null comment '用户名',
   ROLE_CODE            varchar(40) comment '角色代码',
   ORG_ID               varchar(32) comment '机构标识',
   EMAIL                varchar(40) comment '邮件',
   LOGIN_COUNT          numeric(10,0) comment '登陆次数',
   LAST_LOGIN_TIME      timestamp comment '最后登陆时间',
   LAST_LOGIN_IP        varchar(40) comment '最后登陆客户端',
   DISABLE_FLAG         varchar(1) comment '禁用标记',
   DESC_INFO            varchar(200) comment '备注',
   CREATE_BY            varchar(40) not null comment '创建人',
   CREATE_TIME          timestamp not null comment '创建时间',
   UPDATE_BY            varchar(40) not null comment '更新人',
   UPDATE_TIME          timestamp not null comment '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

alter table SYS_USER comment '系统用户';

alter table SYS_USER add primary key (USER_ID);

alter table SYS_USER add unique AK_SYS_USER_01 (USER_NAME);
