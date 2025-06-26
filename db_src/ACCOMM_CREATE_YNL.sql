drop table if exists ACCOMMODATION_CATEGORY_L2;
-- 카테고리, 숙소, 객실, 리뷰, 숙소 이미지, 숙소 정보, 리뷰 이미지, 객실 이미지, 객실 침대
CREATE TABLE `ACCOMMODATION_CATEGORY_L2` (
                                             `ACCOMMODATION_CATEGORY_L2_ID` INT    primary key,
                                             `ACCOMMODATION_CATEGORY_L2_NAME`   VARCHAR(30)    NOT NULL,
                                             `ACCOMMODATION_CATEGORY_L2_DETAIL` VARCHAR(30)    NULL,
                                             `CREATED_AT`   DATETIME   NULL,
                                             `CREATED_BY`   INT    NULL,
                                             `UPDATED_AT`   DATETIME   NULL,
                                             `UPDATED_BY`   INT    NULL
);

drop table if exists ACCOMMODATION_CATEGORY_L1;

CREATE TABLE `ACCOMMODATION_CATEGORY_L1` (
                                             `ACCOMMODATION_CATEGORY_L1_ID` INT    primary key,
                                             `ACCOMMODATION_CATEGORY_L1_NAME`   VARCHAR(10)    NOT NULL,
                                             `ACCOMMODATION_CATEGORY_L1_DETAIL` VARCHAR(30)    NULL,
                                             `CREATED_AT`   DATETIME   NULL,
                                             `CREATED_BY`   INT    NULL,
                                             `UPDATED_AT`   DATETIME   NULL,
                                             `UPDATED_BY`   INT    NULL
);

drop table if exists ACCOMMODATION_CATEGORY_L3;

CREATE TABLE `ACCOMMODATION_CATEGORY_L3` (
                                             `ACCOMMODATION_CATEGORY_L3_ID` INT    primary key,
                                             `ACCOMMODATION_CATEGORY_L3_NAME`   VARCHAR(30)    NOT NULL,
                                             `ACCOMMODATION_CATEGORY_L3_DETAIL` VARCHAR(30)    NULL,
                                             `CREATED_AT`   DATETIME   NULL,
                                             `CREATED_BY`   INT    NULL,
                                             `UPDATED_AT`   DATETIME   NULL,
                                             `UPDATED_BY`   INT    NULL
);

drop table if exists ACCOMMODATION;

CREATE TABLE `ACCOMMODATION` (
                                 `ACCOMMODATION_ID`  INT    primary key,
                                 `ACCOMMODATION_CATEGORY_L1_ID` INT    NULL,
                                 `ACCOMMODATION_CATEGORY_L2_ID` INT    NULL,
                                 `ACCOMMODATION_CATEGORY_L3_ID` INT    NULL,
                                 `ACCOMMODATION_NAME`   VARCHAR(50)    NOT NULL,
                                 `ACCOMMODATION_STATUS` TINYINT    NOT NULL,
                                 `CLICK_VIEWS`  INT    NULL,
                                 `RATING`   VARCHAR(30)    NULL,
                                 `PROVINCE_NAME`    VARCHAR(20)    NOT NULL,
                                 `DISTRICT_NAME`    VARCHAR(20)    NOT NULL,
                                 `ROAD_NAME`    VARCHAR(30)    NOT NULL,
                                 `BUILDING_NUMBER`  INT    NULL,
                                 `BUILDING_SUB_NUMBER`  INT    NULL,
                                 `CREATED_AT`   DATETIME   NULL,
                                 `UPDATED_AT`   DATETIME   NULL,
                                 `CREATED_BY`   INT    NULL,
                                 `UPDATED_BY`   INT    NULL
);

drop table if exists ROOM;

CREATE TABLE ROOM (
                      ROOM_ID INT PRIMARY KEY,
                      ACCOMMODATION_ID INT NOT NULL,
                      ROOM_STATUS VARCHAR(10),
                      IS_AVAILABLE TINYINT,
                      PRICE INT,
                      ROOM_CATEGORY VARCHAR(30),
                      ROOM_SELECT VARCHAR(10),
                      ROOM_NAME VARCHAR(100),
                      CHECKIN_TIME TIME,
                      CHECKOUT_TIME TIME,
                      BASIC_INFO TEXT,
                      FACILITY_SERVICE_INFO TEXT,
                      ROOM_SIZE INT,
                      ROOM_COUNT INT,
                      IS_USE_POLICY_NEEDED TINYINT,
                      VIEW VARCHAR(30),
                      STANDARD_CAPACITY INT,
                      MAXIMUM_CAPACITY INT,
                      BED_COUNT INT,
                      CREATED_AT DATETIME,
                      CREATED_BY INT,
                      UPDATED_AT DATETIME,
                      UPDATED_BY INT,
                      CHECKIN_DATE DATE,
                      CHECKOUT_DATE DATE
);

drop table if exists REVIEW;

CREATE TABLE `REVIEW` (
                          `REVIEW_ID`   INT    primary key,
                          `ACCOMMODATION_ID`    INT    NOT NULL,
                          `REVIEW_DETAIL`   TEXT   NOT NULL,
                          `REVIEW_SCORE`    INT    NOT NULL,
                          `CREATED_AT`  DATETIME   NULL,
                          `UPDATED_AT`  DATETIME   NULL
);

drop table if exists ACCOMMODATION_IMAGE;

CREATE TABLE `ACCOMMODATION_IMAGE` (
                                       `ACCOMMODATION_IMAGE_ID` INT    NOT NULL,
                                       `ACCOMMODATION_ID`   INT    NOT NULL,
                                       `IS_IN_USE`  TINYINT    NOT NULL,
                                       `PRIORITY`   INT    NULL,
                                       `IS_THUMBNAIL`   TINYINT    NOT NULL,
                                       `ACCOMMODATION_IMAGE_FILE_PATH`  TEXT   NULL,
                                       `ACCOMMODATION_IMAGE_TYPE`   VARCHAR(100)   NULL,
                                       `ACCOMMODATION_IMAGE_FILE_SIZE`  INT    NULL,
                                       `ACCOMMODATION_IMAGE_WIDTH`  INT    NULL,
                                       `ACCOMMODATION_IMAGE_HEIGHT` INT    NULL,
                                       `CREATED_AT` DATETIME   NULL,
                                       `CREATED_BY` INT    NULL,
                                       `UPDATED_AT` DATETIME   NULL,
                                       `UPDATED_BY` INT    NULL
);

drop table if exists ACCOMMODATION_INFO;

CREATE TABLE `ACCOMMODATION_INFO` (
                                      `ACCOMMODATION_INFO_ID`     INT PRIMARY KEY,
                                      `ACCOMMODATION_ID`          INT NOT NULL,
                                      `IS_PARKING_AVAILABLE`      TINYINT,
                                      `IS_PICKUP_AVAILABLE`       TINYINT,
                                      `DESCRIPTION`               TEXT,
                                      `GUIDE_LINE`                TEXT,
                                      `RESERVE_NOTICE`           TEXT,
                                      `SUMMARY_REVIEW`            TEXT,
                                      `DIRECTIONS`                TEXT,
                                      `CREATED_AT`                DATETIME,
                                      `CREATED_BY`                INT,
                                      `UPDATED_AT`                DATETIME,
                                      `UPDATED_BY`                INT,
                                      FOREIGN KEY (`ACCOMMODATION_ID`) REFERENCES `ACCOMMODATION`(`ACCOMMODATION_ID`)
);


drop table if exists REVIEW_IMAGE;
CREATE TABLE REVIEW_IMAGE (
                              REVIEW_IMAGE_ID     INT PRIMARY KEY,
                              REVIEW_ID           INT NOT NULL,
                              FILE_PATH           TEXT,
                              SORT_ORDER          INT,
                              FILE_SIZE           INT,
                              USAGE_IMAGE         TINYINT,
                              LENGTH              INT,
                              WIDTH               INT,
                              IS_THUMBNAIL        TINYINT,
                              REVIEW_IMAGE_TYPE   VARCHAR(10),
                              CREATED_AT          DATETIME,
                              CREATED_BY          INT,
                              UPDATED_AT          DATETIME,
                              UPDATED_BY          INT,
                              FOREIGN KEY (REVIEW_ID) REFERENCES REVIEW(REVIEW_ID)
);

drop table if exists ROOM_IMAGE;
CREATE TABLE ROOM_IMAGE (
                            ROOM_IMAGE_ID INT PRIMARY KEY,
                            ROOM_ID INT,
                            IS_IN_USE TINYINT,
                            PRIORITY INT,
                            IS_THUMBNAIL TINYINT,
                            ROOM_IMAGE_FILE_PATH TEXT,
                            ROOM_IMAGE_TYPE VARCHAR(30),
                            ROOM_IMAGE_FILE_SIZE INT,
                            ROOM_IMAGE_LENGTH INT,
                            ROOM_IMAGE_WIDTH INT,
                            CREATED_AT DATETIME,
                            CREATED_BY INT,
                            UPDATED_AT DATETIME,
                            UPDATED_BY INT,
                            foreign key (ROOM_ID) references ROOM(ROOM_ID)
);

drop table if exists ROOM_BED;
CREATE TABLE ROOM_BED (
                          BED_ID INT PRIMARY KEY,
                          ROOM_ID INT,
                          BED_TYPE VARCHAR(30),
                          BED_COUNT INT,
                          CREATED_AT DATETIME,
                          CREATED_BY INT,
                          UPDATED_AT DATETIME,
                          UPDATED_BY INT,
                          foreign key (ROOM_ID) references ROOM(ROOM_ID)
);