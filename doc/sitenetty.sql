CREATE TABLE `dat_check_data` (
  `CHECK_NO` varchar(32) NOT NULL DEFAULT '',
  `CHECK_TYPE` varchar(1) DEFAULT NULL,
  `SITE_ID` varchar(32) DEFAULT NULL,
  `EQUIP_ID` varchar(32) DEFAULT NULL,
  `LINE` varchar(2) DEFAULT NULL,
  `VEHICLE_NO` varchar(12) DEFAULT NULL,
  `VEHICLE_TYPE` varchar(4) DEFAULT NULL,
  `AXLES` int(1) DEFAULT NULL,
  `TYRES` int(2) DEFAULT NULL,
  `CHECK_RESULT` varchar(1) DEFAULT NULL,
  `CHECK_BY` varchar(40) DEFAULT NULL,
  `CHECK_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `SPEED` double(10,0) DEFAULT NULL,
  `TOTAL` int(6) DEFAULT NULL,
  `DESC_INFO` varchar(200) DEFAULT NULL,
  `CREATE_BY` varchar(40) DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `UPDATE_BY` varchar(40) DEFAULT NULL,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `SYNC` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`CHECK_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;