drop schema if exists jdi;
create schema jdi;
USE JDI;

DROP TABLE IF EXISTS `ACCOMMODATION_CATEGORY_L2`;

CREATE TABLE `ACCOMMODATION_CATEGORY_L2` (
                                             `ACCOMMODATION_CATEGORY_L2_ID`	INT	NOT NULL,
                                             `ACCOMMODATION_CATEGORY_L2_NAME`	VARCHAR(30)	NOT NULL,
                                             `ACCOMMODATION_CATEGORY_L2_DETAIL`	VARCHAR(30)	NULL,
                                             `CREATED_AT`	DATETIME	NULL,
                                             `CREATED_BY`	INT	NULL,
                                             `UPDATED_AT`	DATETIME	NULL,
                                             `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `LOGIN_LOG`;

CREATE TABLE `LOGIN_LOG` (
                             `LOG_ID`	INT	NOT NULL,
                             `CUSTOMER_ID`	INT	NOT NULL,
                             `LOGIN_TYPE`	VARCHAR(10)	NULL,
                             `LOGIN_AT`	DATETIME	NULL,
                             `LOGOUT_AT`	DATETIME	NULL,
                             `IS_SUCCESS`	TINYINT	NULL,
                             `FAIL_CAUSE`	TEXT	NULL,
                             `IP_ADDRESS`	VARCHAR(20)	NULL
);

DROP TABLE IF EXISTS `CUSTOMER_STATUS_HISTORY`;

CREATE TABLE `CUSTOMER_STATUS_HISTORY` (
                                           `CUSTOMER_STATUS_HISTORY_ID`	INT	NOT NULL,
                                           `CUSTOMER_ID`	INT	NOT NULL,
                                           `BEFORE_CUSTOMER_STATUS_ID`	INT	NULL,
                                           `AFTER_CUSTOMER_STATUS_ID`	INT	NULL,
                                           `CHANGED_AT`	DATETIME	NOT NULL,
                                           `CAUSE`	VARCHAR(100)	NULL
);

DROP TABLE IF EXISTS `QNA`;

CREATE TABLE QNA (
                     QNA_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                     CUSTOMER_ID INT NOT NULL,
                     ADMIN_ID INT NULL,  -- 답변한 관리자 ID
                     TITLE VARCHAR(100) NOT NULL,
                     CONTENT TEXT NOT NULL,
                     STATUS VARCHAR(20) NOT NULL,  -- 미답변 / 답변완료 / 비활성화 등
                     IS_SECRET TINYINT NOT NULL DEFAULT 0,  -- 1이면 비밀글
                     POSTED_AT DATETIME NOT NULL,
                     ANSWER_CONTENT TEXT NULL,
                     ANSWERED_AT DATETIME NULL,
                     UPDATED_AT DATETIME NULL
);


DROP TABLE IF EXISTS `CUSTOMER`;

CREATE TABLE `CUSTOMER` (
                            `CUSTOMER_ID`	INT	NOT NULL,
                            `CUSTOMER_STATUS_ID`	INT	NOT NULL,
                            `CUSTOMER_LOGIN_ID`	VARCHAR(30) NULL,
                            `CUSTOMER_PASSWORD`	VARCHAR(100)	NULL,
                            `POINT`	INT	NULL,
                            `CUSTOMER_NAME`	VARCHAR(30)	NOT NULL,
                            `JOINED_AT`	DATETIME	NOT NULL,
                            `CUSTOMER_GENDER`	CHAR	NULL,
                            `CUSTOMER_TEL`	CHAR(20)	NOT NULL,
                            `CUSTOMER_AGE`	INT	NULL,
                            `CUSTOMER_JOB`	VARCHAR(30)	NULL,
                            `CUSTOMER_EMAIL`	VARCHAR(100)	NULL,
                            `GRADE_ID`	INT	NULL,
                            `GRADE_EXPIRE_DATE`	DATETIME	NULL,
                            `IS_MARKETING_USE_AGREED`	TINYINT	NOT NULL,
                            `UPDATED_AT`	DATETIME	NULL,
                            `UPDATED_BY`	INT	NULL,
                            `CREATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `ACCOMMODATION_CATEGORY_L1`;

CREATE TABLE `ACCOMMODATION_CATEGORY_L1` (
                                             `ACCOMMODATION_CATEGORY_L1_ID`	INT	NOT NULL,
                                             `ACCOMMODATION_CATEGORY_L1_NAME`	VARCHAR(10)	NOT NULL,
                                             `ACCOMMODATION_CATEGORY_L1_DETAIL`	VARCHAR(30)	NULL,
                                             `CREATED_AT`	DATETIME	NULL,
                                             `CREATED_BY`	INT	NULL,
                                             `UPDATED_AT`	DATETIME	NULL,
                                             `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `ACCOMMODATION_HISTORY`;

CREATE TABLE `ACCOMMODATION_HISTORY` (
                                         `HISTORY_ID`	INT	NOT NULL,
                                         `ADMIN_ID`	INT	NULL,
                                         `ACCOMMODATION_ID`	INT	NOT NULL,
                                         `MODIFIED_AT`	DATETIME	NOT NULL,
                                         `FIELD_NAME`	VARCHAR(30)	NULL,
                                         `BEFORE_VALUE`	TEXT	NULL,
                                         `AFTER_VALUE`	TEXT	NULL,
                                         `CAUSE`	TEXT	NULL
);

DROP TABLE IF EXISTS `COMPANION`;

CREATE TABLE `COMPANION` (
                             `COMPANION_ID`	INT	NOT NULL,
                             `COMPANION_NAME`	VARCHAR(30)	NOT NULL,
                             `COMPANION_TEL`	CHAR(20)	NOT NULL,
                             `RESERVE_ID`	INT	NOT NULL,
                             `CREATED_AT`	DATETIME	NULL,
                             `CREATED_BY`	INT	NULL,
                             `UPDATED_AT`	DATETIME	NULL,
                             `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `ROLE_PRIVILEGE`;

CREATE TABLE `ROLE_PRIVILEGE` (
                                  `PRIVILEGE_ID`	INT	NOT NULL,
                                  `ROLE_ID`	INT	NOT NULL
);

DROP TABLE IF EXISTS `DEPARTMENT`;

CREATE TABLE `DEPARTMENT` (
                              `DEPT_ID`	INT	NOT NULL,
                              `DEPT_NAME`	VARCHAR(30)	NOT NULL,
                              `CREATED_AT`	DATETIME	NULL,
                              `CREATED_BY`	INT	NULL,
                              `UPDATED_AT`	DATETIME	NULL,
                              `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `SELLER`;

CREATE TABLE `SELLER` (
                          `SELLER_ID`	INT	NOT NULL,
                          `SELLER_STATUS_ID`	INT	NULL,
                          `SELLER_BUSINESS_NUM`	VARCHAR(30)	NOT NULL,
                          `SELLER_NAME`	VARCHAR(30)	NOT NULL,
                          `REP_NAME`	VARCHAR(30)	NULL,
                          `REP_TEL`	CHAR(20)	NULL,
                          `REP_EMAIL`	VARCHAR(30)	NULL,
                          `SELLER_ADDRESS`	TEXT	NULL,
                          `SELLER_TEL`	CHAR(20)	NULL,
                          `SELLER_DETAIL`	TEXT	NULL,
                          `CREATED_BY`	INT	NULL,
                          `CREATED_AT`	DATETIME	NULL,
                          `UPDATED_BY`	INT	NULL,
                          `UPDATED_AT`	DATETIME	NULL
);

DROP TABLE IF EXISTS `ACCOMMODATION_INFO`;

CREATE TABLE `ACCOMMODATION_INFO` (
                                      `ACCOMMODATION_INFO_ID`	INT	NOT NULL,
                                      `ACCOMMODATION_ID`	INT	NOT NULL,
                                      `IS_PARKING_AVAILABLE`	TINYINT	NOT NULL,
                                      `IS_PICKUP_AVAILABLE`	TINYINT	NOT NULL,
                                      `DESCRIPTION`	TEXT	NULL,
                                      `GUIDE_LINE`	TEXT	NULL,
                                      `RESERVE_NOTICE`	TEXT	NULL,
                                      `SUMMARY_REVIEW`	TEXT	NULL,
                                      `DIRECTIONS`	TEXT	NULL,
                                      `CREATED_AT`	DATETIME	NULL,
                                      `CREATED_BY`	INT	NULL,
                                      `UPDATED_AT`	DATETIME	NULL,
                                      `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `POLICY`;

CREATE TABLE `POLICY` (
                          `POLICY_ID`	INT	NOT NULL,
                          `POLICY_TYPE`	VARCHAR(30)	NULL,
                          `POLICY_NAME`	VARCHAR(30)	NOT NULL,
                          `POLICY_CONTENT`	TEXT	NULL,
                          `CREATED_AT`	DATETIME	NULL,
                          `CREATED_BY`	INT	NULL,
                          `UPDATED_AT`	DATETIME	NULL,
                          `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `ACCOMMODATION_IMAGE`;

CREATE TABLE `ACCOMMODATION_IMAGE` (
                                       `ACCOMMODATION_IMAGE_ID`	INT	NOT NULL,
                                       `ACCOMMODATION_ID`	INT	NOT NULL,
                                       `IS_IN_USE`	TINYINT	NOT NULL,
                                       `PRIORITY`	INT	NULL,
                                       `IS_THUMBNAIL`	TINYINT	NOT NULL,
                                       `ACCOMMODATION_IMAGE_FILE_PATH`	TEXT	NULL,
                                       `ACCOMMODATION_IMAGE_TYPE`	VARCHAR(100)	NULL,
                                       `ACCOMMODATION_IMAGE_FILE_SIZE`	INT	NULL,
                                       `ACCOMMODATION_IMAGE_WIDTH`	INT	NULL,
                                       `ACCOMMODATION_IMAGE_HEIGHT`	INT	NULL,
                                       `CREATED_AT`	DATETIME	NULL,
                                       `CREATED_BY`	INT	NULL,
                                       `UPDATED_AT`	DATETIME	NULL,
                                       `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `ROLE`;

CREATE TABLE `ROLE` (
                        `ROLE_ID`	INT	NOT NULL,
                        `ROLE_IS_AVAILABLE`	TINYINT	NOT NULL,
                        `ROLE_NAME`	VARCHAR(30)	NOT NULL,
                        `ROLE_DESCRIPTION`	TEXT	NULL,
                        `CREATED_AT`	DATETIME	NULL,
                        `CREATED_BY`	INT	NULL,
                        `UPDATED_AT`	DATETIME	NULL,
                        `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `REVIEW`;

CREATE TABLE `REVIEW` (
                          `REVIEW_ID`	INT	NOT NULL,
                          `WRITER`	INT	NOT NULL,
                          `ACCOMMODATION_ID`	INT	NOT NULL,
                          `RESERVE_ID`	INT	NOT NULL,
                          `REVIEW_DETAIL`	TEXT	NOT NULL,
                          `REVIEW_SCORE`	INT	NOT NULL,
                          `CREATED_AT`	DATETIME	NULL,
                          `UPDATED_AT`	DATETIME	NULL
);

DROP TABLE IF EXISTS `EVENT`;

CREATE TABLE `EVENT` (
                         `EVENT_ID`	INT	NOT NULL,
                         `EVENT_NAME`	VARCHAR(50)	NOT NULL,
                         `EVENT_TYPE`	VARCHAR(30)	NULL,
                         `EVENT_DETAIL`	VARCHAR(200)	NULL,
                         `START_AT`	DATETIME	NULL,
                         `END_AT`	DATETIME	NULL,
                         `PROMO_CODE`	VARCHAR(100)	NULL,
                         `CREATED_AT`	DATETIME	NULL,
                         `CREATED_BY`	INT	NULL,
                         `UPDATED_AT`	DATETIME	NULL,
                         `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `ACTION_CRUD`;

CREATE TABLE `ACTION_CRUD` (
                               `ACTION_ID`	INT	NOT NULL,
                               `ACTION_NAME`	VARCHAR(10)	NOT NULL,
                               `CRUD_TYPE`	VARCHAR(10)	NULL,
                               `ACTION_DETAIL`	TEXT	NULL,
                               `CREATED_AT`	DATETIME	NULL,
                               `CREATED_BY`	INT	NULL,
                               `UPDATED_AT`	DATETIME	NULL,
                               `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `PAYMENT_STATUS`;

CREATE TABLE `PAYMENT_STATUS` (
                                  `PAYMENT_STATUS_ID`	INT	NOT NULL,
                                  `PAYMENT_STATUS_NAME`	VARCHAR(10)	NOT NULL,
                                  `CREATED_AT`	DATETIME	NULL,
                                  `CREATED_BY`	INT	NULL,
                                  `UPDATED_AT`	DATETIME	NULL,
                                  `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `CUSTOMER_STATUS`;

CREATE TABLE `CUSTOMER_STATUS` (
                                   `CUSTOMER_STATUS_ID`	INT	NOT NULL,
                                   `CUSTOMER_STATUS_NAME`	VARCHAR(10)	NOT NULL,
                                   `CREATED_BY`	INT	NULL,
                                   `CREATED_AT`	DATETIME	NULL,
                                   `UPDATED_BY`	INT	NULL,
                                   `UPDATED_AT`	DATETIME	NULL
);

DROP TABLE IF EXISTS `USER_COUPON`;

CREATE TABLE `USER_COUPON` (
                               `CUSTOMER_ID`	INT	NOT NULL,
                               `COUPON_ID`	INT	NOT NULL,
                               `IS_USED`	TINYINT	NOT NULL,
                               `RESERVE_ID`	INT	NULL,
                               `ISSUED_AT`	DATETIME	NOT NULL,
                               `USED_AT`	DATETIME	NULL
);

DROP TABLE IF EXISTS `RESERVE_STATUS`;

CREATE TABLE `RESERVE_STATUS` (
                                  `RESERVE_STATUS_ID`	INT	NOT NULL,
                                  `RESERVE_STATUS_NAME`	VARCHAR(10)	NOT NULL,
                                  `CREATED_AT`	DATETIME	NULL,
                                  `CREATED_BY`	INT	NULL,
                                  `UPDATED_AT`	DATETIME	NULL,
                                  `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `ROOM_HISTORY`;

CREATE TABLE `ROOM_HISTORY` (
                                `HISTORY_ID`	INT	NOT NULL,
                                `ROOM_ID`	INT	NOT NULL,
                                `MODIFIER`	INT	NULL,
                                `MODIFIED_AT`	DATETIME	NOT NULL,
                                `FIELD_NAME`	VARCHAR(30)	NULL,
                                `BEFORE_VALUE`	TEXT	NULL,
                                `AFTER_VALUE`	TEXT	NULL,
                                `CAUSE`	TEXT	NULL
);

DROP TABLE IF EXISTS `PAYMENT_OPTION_BENEFIT`;

CREATE TABLE `PAYMENT_OPTION_BENEFIT` (
                                          `PAYMENT_OPTION_BENEFIT_ID`	INT	NOT NULL,
                                          `PAYMENT_OPTION_ID`	INT	NOT NULL,
                                          `PAYMENT_OPTION_BENEFIT_STATUS_ID`	INT	NOT NULL,
                                          `PAYMENT_OPTION_BENEFIT_NAME`	VARCHAR(30)	NOT NULL,
                                          `BENEFIT_DETAIL`	TEXT	NOT NULL,
                                          `BENEFIT_TARGET`	VARCHAR(30)	NULL,
                                          `EXPIRE_AT`	DATETIME	NULL,
                                          `IS_EXPIRED`	INT	NOT NULL,
                                          `CREATED_AT`	DATETIME	NULL,
                                          `CREATED_BY`	INT	NULL,
                                          `UPDATED_AT`	DATETIME	NULL,
                                          `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `ADMIN`;

CREATE TABLE `ADMIN` (
                         `ADMIN_ID`	INT	NOT NULL,
                         `DEPT_ID`	INT	NULL,
                         `ROLE_ID`	INT	NULL,
                         `ROLE_GRANT_DATE`	DATETIME	NULL,
                         `ADMIN_NAME`	VARCHAR(30)	NOT NULL,
                         `ADMIN_TEL`	CHAR(20)	NOT NULL,
                         `ADMIN_EMAIL`	VARCHAR(50)	NOT NULL,
                         `ADMIN_PASSWORD`	VARCHAR(50)	NOT NULL,
                         `CREATED_AT`	DATETIME	NULL,
                         `UPDATED_AT`	DATETIME	NULL,
                         `CREATED_BY`	INT	NULL,
                         `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `PRICE_POLICY_HISTORY`;

CREATE TABLE `PRICE_POLICY_HISTORY` (
                                        `HISTORY_ID`	INT	NOT NULL,
                                        `PRICE_POLICY_ID`	INT	NOT NULL,
                                        `ADMIN_ID`	INT	NULL,
                                        `FIELD_NAME`	VARCHAR(30)	NULL,
                                        `BEFORE_VALUE`	TEXT	NULL,
                                        `AFTER_VALUE`	TEXT	NULL,
                                        `CHANGED_AT`	DATETIME	NOT NULL,
                                        `CAUSE`	TEXT	NULL
);

DROP TABLE IF EXISTS `ACCOMMODATION_POLICY`;

CREATE TABLE `ACCOMMODATION_POLICY` (
                                        `POLICY_ID`	INT	NOT NULL,
                                        `ACCOMMODATION_ID`	INT	NOT NULL,
                                        `IS_ACTIVE`	TINYINT	NOT NULL
);

DROP TABLE IF EXISTS `REVIEW_IMAGE`;

CREATE TABLE `REVIEW_IMAGE` (
                                `REVIEW_IMAGE_ID`	INT	NOT NULL,
                                `REVIEW_ID`	INT	NOT NULL,
                                `FILE_PATH`	TEXT	NULL,
                                `SORT_ORDER`	INT	NULL,
                                `FILE_SIZE`	INT	NULL,
                                `USAGE_IMAGE`	TINYINT	NOT NULL,
                                `LENGTH`	INT	NULL,
                                `WIDTH`	INT	NULL,
                                `IS_THUMBNAIL`	TINYINT	NOT NULL,
                                `REVIEW_IMAGE_TYPE`	VARCHAR(10)	NULL,
                                `CREATED_AT`	DATETIME	NULL,
                                `CREATED_BY`	INT	NULL,
                                `UPDATED_AT`	DATETIME	NULL,
                                `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `CUSTOMER_INQUIRY`;

CREATE TABLE `CUSTOMER_INQUIRY` (
                                    `INQUIRY_ID`	INT	NOT NULL,
                                    `CUSTOMER_ID`	INT	NOT NULL,
                                    `INQUIRY_STATUS`	VARCHAR(10)	NULL,
                                    `INQUIRY_TYPE`	VARCHAR(10)	NULL,
                                    `INQUIRY_TITLE`	VARCHAR(50)	NOT NULL,
                                    `INQUIRY_DETAIL`	TEXT	NOT NULL,
                                    `REGISTERED_AT`	DATETIME	NOT NULL,
                                    `SATISFACTION_SCORE`	INT	NULL,
                                    `CREATED_AT`	DATETIME	NULL,
                                    `CREATED_BY`	INT	NULL,
                                    `UPDATED_AT`	DATETIME	NULL,
                                    `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `ACCOMMODATION_WISHLIST`;

CREATE TABLE `ACCOMMODATION_WISHLIST` (
                                          `ACCOMMODATION_ID`	INT	NOT NULL,
                                          `CUSTOMER_ID`	INT	NOT NULL,
                                          `CREATED_AT`	DATETIME	NULL,
                                          `UPDATED_AT`	DATETIME	NULL,
                                          `CREATED_BY`	INT	NULL,
                                          `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `PRIVILEGE`;

CREATE TABLE `PRIVILEGE` (
                             `PRIVILEGE_ID`	INT	NOT NULL,
                             `RESOURCE_ID`	INT	NOT NULL,
                             `ACTION_ID`	INT	NOT NULL,
                             `PRIVILEGE_NAME`	VARCHAR(10)	NOT NULL,
                             `PRIVILEGE_DETAIL`	TEXT	NULL,
                             `IS_AVAILABLE`	TINYINT	NOT NULL,
                             `CREATED_AT`	DATETIME	NULL,
                             `CREATED_BY`	INT	NULL,
                             `UPDATED_AT`	DATETIME	NULL,
                             `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `NOTICE`;

CREATE TABLE `NOTICE` (
                          `NOTICE_ID`	INT	NOT NULL,
                          `WRITER_ADMIN_ID`	INT	NOT NULL,
                          `NOTICE_STATUS`	VARCHAR(10)	NULL,
                          `IS_NEED_PIN`	TINYINT	NOT NULL,
                          `PRIORITY`	INT	DEFAULT 99 NOT NULL,
                          `NOTICE_TITLE`	VARCHAR(50)	NOT NULL,
                          `NOTICE_DETAIL`	TEXT	NOT NULL,
                          `POSTED_AT`	DATETIME	NOT NULL,
                          `NOTICE_TARGET`	VARCHAR(10)	NULL,
                          `UPDATED_AT`	DATETIME	NULL,
                          `UPDATED_BY`	INT	NULL,
                          `IS_MAIN`       TINYINT NOT NULL DEFAULT 0,
                          `VIEW_COUNT`    INT DEFAULT 0

);
DROP TABLE IF EXISTS `FAQ`;

CREATE TABLE `FAQ` (
                       `FAQ_ID`            INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  -- FAQ 고유 ID
                       `WRITER_ADMIN_ID`   INT NOT NULL,                             -- 작성 관리자 ID (외래키 제외)
                       `FAQ_STATUS`        VARCHAR(10) NULL,                         -- 상태값 (예: ACT, NOACT 등)
                       `FAQ_CATEGORY`      VARCHAR(30) NOT NULL,                     -- 카테고리 (예: 국내숙소, 회원 등)
                       `FAQ_TITLE`         VARCHAR(100) NOT NULL,                    -- 질문 제목
                       `FAQ_CONTENT`       TEXT NOT NULL,                            -- 답변 내용
                       `POSTED_AT`         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 작성일
                       `UPDATED_AT`        DATETIME NULL,                            -- 수정일
                       `UPDATED_BY`        INT NULL,                                 -- 수정 관리자 ID (외래키 제외)
                       `VIEW_COUNT`        INT DEFAULT 0                             -- 조회수
);

DROP TABLE IF EXISTS `RESERVE_AGREEMENT`;

CREATE TABLE `RESERVE_AGREEMENT` (
                                     `RESERVE_AGREEMENT_ID`	INT	NOT NULL,
                                     `RESERVE_AGREEMENT_NAME`	VARCHAR(10)	NOT NULL,
                                     `AGREEMENT_DETAIL`	TEXT	NOT NULL,
                                     `IS_MANDATORY`	TINYINT	NOT NULL,
                                     `IS_EFFECTIVE`	TINYINT	NOT NULL,
                                     `CREATED_AT`	DATETIME	NULL,
                                     `CREATED_BY`	INT	NULL,
                                     `UPDATED_AT`	DATETIME	NULL,
                                     `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `ADMIN_HISTORY`;

CREATE TABLE `ADMIN_HISTORY` (
                                 `ADMIN_HISTORY_ID`	INT	NOT NULL,
                                 `ADMIN_ID`	INT	NOT NULL,
                                 `BEFORE_ROLE_ID`	INT	NULL,
                                 `AFTER_ROLE_ID`	INT	NULL,
                                 `CHANGED_AT`	DATETIME	NOT NULL,
                                 `CAUSE`	TEXT	NULL
);

DROP TABLE IF EXISTS `ROOM_IMAGE`;

CREATE TABLE `ROOM_IMAGE` (
                              `ROOM_IMAGE_ID`	INT	NOT NULL,
                              `ROOM_ID`	INT	NOT NULL,
                              `IS_IN_USE`	TINYINT	NOT NULL,
                              `PRIORITY`	INT	NULL,
                              `IS_THUMBNAIL`	TINYINT	NOT NULL,
                              `ROOM_IMAGE_FILE_PATH`	TEXT	NULL,
                              `ROOM_IMAGE_TYPE`	VARCHAR(30)	NULL,
                              `ROOM_IMAGE_FILE_SIZE`	INT	NULL,
                              `ROOM_IMAGE_LENGTH`	INT	NULL,
                              `ROOM_IMAGE_WIDTH`	INT	NULL,
                              `CREATED_AT`	DATETIME	NULL,
                              `CREATED_BY`	INT	NULL,
                              `UPDATED_AT`	DATETIME	NULL,
                              `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `POINT_DETAIL`;

CREATE TABLE `POINT_DETAIL` (
                                `POINT_DETAIL_ID`	INT	NOT NULL,
                                `CUSTOMER_ID`	INT	NOT NULL,
                                `EVENT_ID`	INT	NOT NULL,
                                `CANCEL_ORIGINAL_DETAIL_ID`	INT	NULL,
                                `ACCRUAL_ORIGINAL_DETAIL_ID`	INT	NULL,
                                `STATUS`	VARCHAR(10)	NOT NULL,
                                `TRANSACTION_POINT`	INT	NULL,
                                `TRANSACTION_AT`	DATETIME	NOT NULL,
                                `EXPIRE_AT`	DATETIME	NULL
);

DROP TABLE IF EXISTS `PAY_OPT_BEN_STAT`;

CREATE TABLE `PAY_OPT_BEN_STAT` (
                                    `PAYMENT_OPTION_BENEFIT_STATUS_ID`	INT	NOT NULL,
                                    `PAYMENT_OPTION_BENEFIT_STATUS_NAME`	VARCHAR(10)	NOT NULL,
                                    `CREATED_AT`	DATETIME	NULL,
                                    `CREATED_BY`	INT	NULL,
                                    `UPDATED_AT`	DATETIME	NULL,
                                    `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `ACCOMMODATION`;

CREATE TABLE `ACCOMMODATION` (
                                 `ACCOMMODATION_ID`	INT	NOT NULL,
                                 `SELLER_ID`	INT	NOT NULL,
                                 `ADMIN_ID`	INT	NOT NULL,
                                 `ACCOMMODATION_CATEGORY_L1_ID`	INT	NULL,
                                 `ACCOMMODATION_CATEGORY_L2_ID`	INT	NULL,
                                 `ACCOMMODATION_CATEGORY_L3_ID`	INT	NULL,
                                 `ACCOMMODATION_NAME`	VARCHAR(50)	NOT NULL,
                                 `ACCOMMODATION_STATUS`	TINYINT	NOT NULL,
                                 `CLICK_VIEWS`	INT	NULL,
                                 `RATING`	VARCHAR(30)	NULL,
                                 `PROVINCE_NAME`	VARCHAR(10)	NOT NULL,
                                 `DISTRICT_NAME`	VARCHAR(10)	NOT NULL,
                                 `ROAD_NAME`	VARCHAR(30)	NOT NULL,
                                 `BUILDING_NUMBER`	INT	NULL,
                                 `BUILDING_SUB_NUMBER`	INT	NULL,
                                 `CREATED_AT`	DATETIME	NULL,
                                 `UPDATED_AT`	DATETIME	NULL,
                                 `CREATED_BY`	INT	NULL,
                                 `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `RESERVE_STATUS_HISTORY`;

CREATE TABLE `RESERVE_STATUS_HISTORY` (
                                          `RESERVE_STATUS_HISTORY_ID`	INT	NOT NULL,
                                          `RESERVE_ID`	INT	NOT NULL,
                                          `BEFORE_RESERVE_STATUS_ID`	INT	NULL,
                                          `AFTER_RESERVE_STATUS_ID`	INT	NULL,
                                          `CHANGED_AT`	DATETIME	NOT NULL,
                                          `CAUSE`	VARCHAR(30)	NULL
);

DROP TABLE IF EXISTS `SETTLEMENT`;

CREATE TABLE `SETTLEMENT` (
                              `SETTLEMENT_ID`	INT	NOT NULL,
                              `COMMISSION_POLICY_ID`	INT	NOT NULL,
                              `PAYMENT_ID`	INT	NOT NULL,
                              `SETTLEMENT_STATUS_ID`	INT	NOT NULL,
                              `SETTLEMENT_PRICE`	INT	NOT NULL,
                              `SETTLEMENT_DATE`	DATETIME	NOT NULL,
                              `CREATED_AT`	DATETIME	NULL,
                              `CREATED_BY`	INT	NULL,
                              `UPDATED_AT`	DATETIME	NULL,
                              `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `PRICE_POLICY`;

CREATE TABLE `PRICE_POLICY` (
                                `PRICE_POLICY_ID`	INT	NOT NULL,
                                `ACCOMMODATION_ID`	INT	NOT NULL,
                                `PRICE_POLICY_NAME`	VARCHAR(50)	NOT NULL,
                                `PRICE_RATE_100`	INT	NULL,
                                `PRIORITY`	INT	NULL,
                                `DAYOFWEEK_EFFECTIVE_BIT`	CHAR(7)	NULL,
                                `SEASON_START_AT`	DATETIME	NULL,
                                `SEASON_END_AT`	DATETIME	NULL,
                                `IS_HOLIDAY_POLICY`	TINYINT	NOT NULL,
                                `CREATED_AT`	DATETIME	NULL,
                                `CREATED_BY`	INT	NULL,
                                `UPDATED_AT`	DATETIME	NULL,
                                `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `CUSTOMER_BENEFIT_HISTORY`;

CREATE TABLE `CUSTOMER_BENEFIT_HISTORY` (
                                            `CUSTOMER_BENEFIT_HISTORY_ID`	INT	NOT NULL,
                                            `BENEFIT_ID`	INT	NOT NULL,
                                            `CUSTOMER_ID`	INT	NOT NULL,
                                            `CREATED_AT`	DATETIME	NULL,
                                            `CREATED_BY`	INT	NULL,
                                            `UPDATED_AT`	DATETIME	NULL,
                                            `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `ROOM_BED`;

CREATE TABLE `ROOM_BED` (
                            `BED_ID`	INT	NOT NULL,
                            `ROOM_ID`	INT	NOT NULL,
                            `BED_TYPE`	VARCHAR(30)	NULL,
                            `BED_COUNT`	INT	NULL,
                            `CREATED_AT`	DATETIME	NULL,
                            `CREATED_BY`	INT	NULL,
                            `UPDATED_AT`	DATETIME	NULL,
                            `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `SELLER_STATUS`;

CREATE TABLE `SELLER_STATUS` (
                                 `SELLER_STATUS_ID`	INT	NOT NULL,
                                 `SELLER_STATUS_NAME`	VARCHAR(50)	NOT NULL,
                                 `CREATED_BY`	INT	NULL,
                                 `CREATED_AT`	DATETIME	NULL,
                                 `UPDATED_BY`	INT	NULL,
                                 `UPDATED_AT`	DATETIME	NULL
);

DROP TABLE IF EXISTS `PAY_OPT_STAT`;

CREATE TABLE `PAY_OPT_STAT` (
                                `PAYMENT_OPTION_STATUS_ID`	INT	NOT NULL,
                                `PAYMENT_OPTION_STATUS_NAME`	VARCHAR(10)	NOT NULL,
                                `CREATED_AT`	DATETIME	NULL,
                                `CREATED_BY`	INT	NULL,
                                `UPDATED_AT`	DATETIME	NULL,
                                `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `PAY_OPT_STAT_HIST`;

CREATE TABLE `PAY_OPT_STAT_HIST` (
                                     `PAYMENT_OPTION_STATUS_HISTORY_ID`	INT	NOT NULL,
                                     `PAYMENT_OPTION_ID`	INT	NOT NULL,
                                     `BEFORE_PAYMENT_OPTION_STATUS_ID`	INT	NULL,
                                     `AFTER_PAYMENT_OPTION_STATUS_ID`	INT	NULL,
                                     `CHANGED_AT`	DATETIME	NOT NULL,
                                     `CAUSE`	VARCHAR(50)	NULL
);

DROP TABLE IF EXISTS `SETTLEMENT_STATUS`;

CREATE TABLE `SETTLEMENT_STATUS` (
                                     `SETTLEMENT_STATUS_ID`	INT	NOT NULL,
                                     `SETTLEMENT_STATUS_NAME`	VARCHAR(10)	NOT NULL,
                                     `CREATED_AT`	DATETIME	NULL,
                                     `CREATED_BY`	INT	NULL,
                                     `UPDATED_AT`	DATETIME	NULL,
                                     `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `RESERVE_AGREEMENT_VERIFY`;

CREATE TABLE `RESERVE_AGREEMENT_VERIFY` (
                                            `RESERVE_AGREEMENT_ID`	INT	NOT NULL,
                                            `RESERVE_ID`	INT	NOT NULL,
                                            `IS_AGREE`	TINYINT	NOT NULL,
                                            `CREATED_AT`	DATETIME	NULL,
                                            `CREATED_BY`	INT	NULL,
                                            `UPDATED_AT`	DATETIME	NULL,
                                            `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `ACCOMMODATION_FACILITY`;

CREATE TABLE `ACCOMMODATION_FACILITY` (
                                          `ACCOMMODATION_ID`	INT	NOT NULL,
                                          `FACILITY_ID`	INT	NOT NULL
);

DROP TABLE IF EXISTS `PAYMENT_STATUS_HISTORY`;

CREATE TABLE `PAYMENT_STATUS_HISTORY` (
                                          `PAYMENT_STATUS_HISTORY_ID`	INT	NOT NULL,
                                          `PAYMENT_ID`	INT	NOT NULL,
                                          `BEFORE_PAYMENT_STATUS_ID`	INT	NULL,
                                          `AFTER_PAYMENT_STATUS_ID`	INT	NULL,
                                          `CHANGED_AT`	DATETIME	NOT NULL,
                                          `CAUSE`	VARCHAR(50)	NULL
);

DROP TABLE IF EXISTS `SELLER_STATUS_HISTORY`;

CREATE TABLE `SELLER_STATUS_HISTORY` (
                                         `SELLER_STATUS_HISTORY_ID`	INT	NOT NULL,
                                         `SELLER_ID`	INT	NOT NULL,
                                         `BEFORE_SELLER_STATUS_CODE`	INT	NULL,
                                         `AFTER_SELLER_STATUS_CODE`	INT	NULL,
                                         `CHANGED_AT`	DATETIME	NOT NULL,
                                         `CAUSE`	TEXT	NULL
);

DROP TABLE IF EXISTS `ROOM`;

CREATE TABLE `ROOM` (
                        `ROOM_ID`	INT	NOT NULL,
                        `ACCOMMODATION_ID`	INT	NOT NULL,
                        `ROOM_STATUS`	VARCHAR(10)	NULL,
                        `IS_AVAILABLE`	TINYINT	NOT NULL,
                        `PRICE`	INT	NOT NULL,
                        `ROOM_CATEGORY`	VARCHAR(30)	NULL,
                        `ROOM_SELECT`	VARCHAR(10)	NULL,
                        `ROOM_NAME`	VARCHAR(100)	NOT NULL,
                        `CHECKIN_TIME`	TIME	NULL,
                        `CHECKOUT_TIME`	TIME	NULL,
                        `CHECKIN_DATE` DATE NULL,
                        `CHECKOUT_DATE` DATE NULL,
                        `BASIC_INFO`	TEXT	NULL,
                        `FACILITY_SERVICE_INFO`	TEXT	NULL,
                        `ROOM_SIZE`	INT	NULL,
                        `ROOM_COUNT`	INT	NULL,
                        `IS_USE_POLICY_NEEDED`	TINYINT	NOT NULL,
                        `VIEW`	VARCHAR(30)	NULL,
                        `STANDARD_CAPACITY`	INT	NULL,
                        `MAXIMUM_CAPACITY`	INT	NULL,
                        `BED_COUNT`	INT	NULL,
                        `CREATED_AT`	DATETIME	NULL	DEFAULT CURRENT_TIMESTAMP,
                        `CREATED_BY`	INT	NULL,
                        `UPDATED_AT`	DATETIME	NULL	DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `OLD_RESERVE`;

CREATE TABLE `OLD_RESERVE` (
                               `RESERVE_ID`	INT	NOT NULL,
                               `RESERVE_DATE`	DATETIME	NULL,
                               `ACCOMMODATION_NAME`	VARCHAR(10)	NULL,
                               `ROOM_NAME`	VARCHAR(10)	NULL,
                               `PRICE`	INT	NULL
);

DROP TABLE IF EXISTS `POINT_EVENT`;

CREATE TABLE `POINT_EVENT` (
                               `EVENT_ID`	INT	NOT NULL,
                               `ORIGINAL_EVENT_ID`	INT	NOT NULL,
                               `CUSTOMER_ID`	INT	NOT NULL,
                               `POINT_STATUS`	VARCHAR(10)	NULL,
                               `POINT_AMOUNT`	INT	NULL,
                               `TRANSACTED_AT`	DATETIME	NOT NULL,
                               `EXPIRE_AT`	DATETIME	NULL,
                               `TRANSACTION_CAUSE`	VARCHAR(100)	NULL
);

DROP TABLE IF EXISTS `COUPON`;

CREATE TABLE `COUPON` (
                          `COUPON_ID`	INT	NOT NULL,
                          `EVENT_ID`	INT	NULL,
                          `ROOM_ID`	INT	NULL,
                          `ACCOMMODATION_CATEGORY_L1_ID`	INT	NULL,
                          `ACCOMMODATION_CATEGORY_L2_ID`	INT	NULL,
                          `ACCOMMODATION_CATEGORY_L3_ID`	INT	NULL,
                          `COUPON_DESCRIPTION`	VARCHAR(100)	NULL,
                          `DISCOUNT_TYPE`	VARCHAR(10)	NULL,
                          `DISCOUNT_VALUE`	INT	NULL,
                          `DISCOUNT_RATE_100`	INT	NULL,
                          `MIN_RESERVATION_AMOUNT`	INT	NULL,
                          `VALID_FROM`	DATETIME	NULL,
                          `VALID_TO`	DATETIME	NULL,
                          `IS_REUSABLE`	TINYINT	NOT NULL
);

DROP TABLE IF EXISTS `RESERVE`;

CREATE TABLE `RESERVE` (
                           `RESERVE_ID`	INT	NOT NULL,
                           `RESERVER_ID`	INT	NOT NULL,
                           `ROOM_ID`	INT	NOT NULL,
                           `CHECK_IN_AT`	DATETIME	NOT NULL,
                           `CHECK_OUT_DATE`	DATETIME	NOT NULL,
                           `RESERVE_STATUS_ID`	INT	NOT NULL,
                           `SPECIAL_REQ`	TEXT	NULL,
                           `IS_CANCELABLE`	TINYINT	NOT NULL,
                           `RESERVE_DATE`	DATETIME	NOT NULL,
                           `CREATED_AT`	DATETIME	NULL,
                           `CREATED_BY`	INT	NULL,
                           `UPDATED_AT`	DATETIME	NULL,
                           `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `CUSTOMER_BENEFIT`;

CREATE TABLE `CUSTOMER_BENEFIT` (
                                    `BENEFIT_ID`	INT	NOT NULL,
                                    `GRADE_ID`	INT	NOT NULL,
                                    `DISCOUNT_RATE_100`	INT	NULL,
                                    `MAX_DISCOUNT_AMOUNT`	INT	NULL,
                                    `IS_STACKABLE`	TINYINT	NOT NULL,
                                    `BENEFIT_TYPE`	VARCHAR(10)	NULL,
                                    `BENEFIT_NAME`	VARCHAR(30)	NOT NULL,
                                    `BENEFIT_DESCRIPTION`	TEXT	NULL,
                                    `CREATED_AT`	DATETIME	NULL,
                                    `CREATED_BY`	INT	NULL,
                                    `UPDATED_AT`	DATETIME	NULL,
                                    `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `PAYMENT`;

CREATE TABLE `PAYMENT` (
                           `PAYMENT_ID`	INT	NOT NULL,
                           `RESERVE_ID`	INT	NOT NULL,
                           `PAYMENT_OPTION_ID`	INT	NOT NULL,
                           `PAYMENT_STATUS_ID`	INT	NOT NULL,
                           `PAYMENT_ACK_NO`	INT	NULL,
                           `PRICE`	INT	NOT NULL,
                           `BASE_PRICE`	INT	NULL,
                           `DISCOUNT_PRICE`	INT	NULL,
                           `CREDIT_CARD_ID`	CHAR(16)	NULL,
                           `IS_REFUNDABLE`	TINYINT	NOT NULL,
                           `REFUND_RATE_100`	INT	NULL,
                           `CREATED_AT`	DATETIME	NULL,
                           `CREATED_BY`	INT	NULL,
                           `UPDATED_AT`	DATETIME	NULL,
                           `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `ACCOMMODATION_CATEGORY_L3`;

CREATE TABLE `ACCOMMODATION_CATEGORY_L3` (
                                             `ACCOMMODATION_CATEGORY_L3_ID`	INT	NOT NULL,
                                             `ACCOMMODATION_CATEGORY_L3_NAME`	VARCHAR(30)	NOT NULL,
                                             `ACCOMMODATION_CATEGORY_L3_DETAIL`	VARCHAR(30)	NULL,
                                             `CREATED_AT`	DATETIME	NULL,
                                             `CREATED_BY`	INT	NULL,
                                             `UPDATED_AT`	DATETIME	NULL,
                                             `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `CUSTOMER_GRADE`;

CREATE TABLE `CUSTOMER_GRADE` (
                                  `GRADE_ID`	INT	NOT NULL,
                                  `GRADE_NAME`	VARCHAR(10)	NOT NULL,
                                  `MIN_USAGE_AMOUNT`	INT	NULL,
                                  `MIN_USAGE_COUNT`	INT	NULL,
                                  `IS_AVAILABLE`	TINYINT	NOT NULL,
                                  `PRIORITY`	INT	NULL,
                                  `CREATED_BY`	INT	NULL,
                                  `CREATED_AT`	DATETIME	NULL,
                                  `UPDATED_BY`	INT	NULL,
                                  `UPDATED_AT`	DATETIME	NULL
);

DROP TABLE IF EXISTS `PAYMENT_OPTION`;

CREATE TABLE `PAYMENT_OPTION` (
                                  `PAYMENT_OPTION_ID`	INT	NOT NULL,
                                  `PAYMENT_OPTION_STATUS_ID`	INT	NOT NULL,
                                  `IS_CREDIT_CARD`	TINYINT	NOT NULL,
                                  `PAYMENT_OPTION_NAME`	VARCHAR(30)	NOT NULL,
                                  `PAYMENT_COMPANY_NAME`	VARCHAR(30)	NULL,
                                  `PAYMENT_REQUEST_URL`	TEXT	NULL,
                                  `PAYMENT_COMPANY_REP_NAME`	VARCHAR(30)	NULL,
                                  `PAYMENT_COMPANY_REP_TEL`	CHAR	NULL,
                                  `CREATED_AT`	DATETIME	NULL,
                                  `CREATED_BY`	INT	NULL,
                                  `UPDATED_AT`	DATETIME	NULL,
                                  `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `PAY_OPT_BEN_STAT_HIS`;

CREATE TABLE `PAY_OPT_BEN_STAT_HIS` (
                                        `PAYMENT_OPTION_STATUS_HISTORY_ID`	INT	NOT NULL,
                                        `PAYMENT_OPTION_BENEFIT_ID`	INT	NOT NULL,
                                        `BEFORE_PAYMENT_OPTION_BENEFIT_STATUS_ID`	INT	NULL,
                                        `AFTER_PAYMENT_OPTION_BENEFIT_STATUS_ID`	INT	NULL,
                                        `CHANGED_AT`	DATETIME	NOT NULL,
                                        `CAUSE`	VARCHAR(50)	NULL
);

DROP TABLE IF EXISTS `COMMISSION_POLICY`;

CREATE TABLE `COMMISSION_POLICY` (
                                     `COMMISSION_POLICY_ID`	INT	NOT NULL,
                                     `SELLER_ID`	INT	NOT NULL,
                                     `TOTAL_SETTLEMENT_RATE_100`	INT	NOT NULL,
                                     `COMMISSION_RATE_100`	INT	NOT NULL,
                                     `VAT_RATE_100`	INT	NOT NULL	DEFAULT 10,
                                     `IS_EFFECTIVE`	TINYINT	NOT NULL,
                                     `EFFECT_START`	DATETIME	NULL,
                                     `EFFECT_END`	DATETIME	NULL,
                                     `CREATED_AT`	DATETIME	NULL,
                                     `CREATED_BY`	INT	NULL,
                                     `UPDATED_AT`	DATETIME	NULL,
                                     `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `RESOURCE`;

CREATE TABLE `RESOURCE` (
                            `RESOURCE_ID`	INT	NOT NULL,
                            `LEVEL`	INT	NULL,
                            `RESOURCE_NAME`	VARCHAR(10)	NOT NULL,
                            `RESOURCE_DETAIL`	TEXT	NULL,
                            `CREATED_AT`	DATETIME	NULL,
                            `CREATED_BY`	INT	NULL,
                            `UPDATED_AT`	DATETIME	NULL,
                            `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `SHOPPING_CART`;

CREATE TABLE `SHOPPING_CART` (
                                 `CART_ID`	INT	NOT NULL,
                                 `ROOM_ID`	INT	NOT NULL,
                                 `CUSTOMER_ID`	INT	NOT NULL,
                                 `DESIRED_CHECK_IN_AT`	DATETIME	NULL,
                                 `DESIRED_CHECK_OUT_AT`	DATETIME	NULL,
                                 `ADULT_COUNT`	INT	NULL,
                                 `CHILD_COUNT`	INT	NULL,
                                 `CREATED_AT`	DATETIME	NOT NULL,
                                 `CREATED_BY`	INT	NULL,
                                 `UPDATED_AT`	DATETIME	NULL,
                                 `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `SETTLEMENT_STATUS_HISTORY`;

CREATE TABLE `SETTLEMENT_STATUS_HISTORY` (
                                             `SETTLEMENT_STATUS_HISTORY_ID`	INT	NOT NULL,
                                             `SETTLEMENT_ID`	INT	NOT NULL,
                                             `BEFORE_SETTLEMENT_STATUS_ID`	INT	NULL,
                                             `AFTER_SETTLEMENT_STATUS_ID`	INT	NULL,
                                             `CHANGED_AT`	DATETIME	NOT NULL,
                                             `CAUSE`	VARCHAR(50)	NULL
);

DROP TABLE IF EXISTS `CUSTOMER_GRADE_HISTORY`;

CREATE TABLE `CUSTOMER_GRADE_HISTORY` (
                                          `HISTORY_ID`	INT	NOT NULL,
                                          `CUSTOMER_ID`	INT	NOT NULL,
                                          `BEFORE_GRADE_ID`	INT	NULL,
                                          `AFTER_GRADE_ID`	INT	NULL,
                                          `UPDATED_AT`	DATETIME	NOT NULL,
                                          `UPDATED_BY`	INT	NULL,
                                          `CAUSE`	VARCHAR(100)	NULL
);

DROP TABLE IF EXISTS `FACILITY`;

CREATE TABLE `FACILITY` (
                            `FACILITY_ID`	INT	NOT NULL,
                            `FACILITY_NAME`	VARCHAR(50)	NOT NULL,
                            `FACILITY_TYPE`	VARCHAR(30)	NULL,
                            `CREATED_AT`	DATETIME	NULL,
                            `CREATED_BY`	INT	NULL,
                            `UPDATED_AT`	DATETIME	NULL,
                            `UPDATED_BY`	INT	NULL
);

DROP TABLE IF EXISTS `COUPON_HISTORY`;

CREATE TABLE `COUPON_HISTORY` (
                                  `COUPON_HISTORY_ID`	INT	NOT NULL,
                                  `COUPON_ID`	INT	NOT NULL,
                                  `USED_AT`	DATETIME	NOT NULL
);

DROP TABLE IF EXISTS `INQUIRY_ANSWER`;

CREATE TABLE `INQUIRY_ANSWER` (
                                  `ANSWER_ID`	INT	NOT NULL,
                                  `ADMIN_ID`	INT	NOT NULL,
                                  `INQUIRY_ID`	INT	NOT NULL,
                                  `ANSWER_DATE`	DATETIME	NOT NULL,
                                  `ANSWER_DETAIL`	TEXT	NOT NULL
);

ALTER TABLE `ACCOMMODATION_CATEGORY_L2` ADD CONSTRAINT `PK_ACCOMMODATION_CATEGORY_L2` PRIMARY KEY (
                                                                                                   `ACCOMMODATION_CATEGORY_L2_ID`
    );

ALTER TABLE `LOGIN_LOG` ADD CONSTRAINT `PK_LOGIN_LOG` PRIMARY KEY (
                                                                   `LOG_ID`
    );

ALTER TABLE `CUSTOMER_STATUS_HISTORY` ADD CONSTRAINT `PK_CUSTOMER_STATUS_HISTORY` PRIMARY KEY (
                                                                                               `CUSTOMER_STATUS_HISTORY_ID`
    );

ALTER TABLE `CUSTOMER` ADD CONSTRAINT `PK_CUSTOMER` PRIMARY KEY (
                                                                 `CUSTOMER_ID`
    );

ALTER TABLE `ACCOMMODATION_CATEGORY_L1` ADD CONSTRAINT `PK_ACCOMMODATION_CATEGORY_L1` PRIMARY KEY (
                                                                                                   `ACCOMMODATION_CATEGORY_L1_ID`
    );

ALTER TABLE `ACCOMMODATION_HISTORY` ADD CONSTRAINT `PK_ACCOMMODATION_HISTORY` PRIMARY KEY (
                                                                                           `HISTORY_ID`
    );

ALTER TABLE `COMPANION` ADD CONSTRAINT `PK_COMPANION` PRIMARY KEY (
                                                                   `COMPANION_ID`
    );

ALTER TABLE `ROLE_PRIVILEGE` ADD CONSTRAINT `PK_ROLE_PRIVILEGE` PRIMARY KEY (
                                                                             `PRIVILEGE_ID`,
                                                                             `ROLE_ID`
    );

ALTER TABLE `DEPARTMENT` ADD CONSTRAINT `PK_DEPARTMENT` PRIMARY KEY (
                                                                     `DEPT_ID`
    );

ALTER TABLE `SELLER` ADD CONSTRAINT `PK_SELLER` PRIMARY KEY (
                                                             `SELLER_ID`
    );

ALTER TABLE `ACCOMMODATION_INFO` ADD CONSTRAINT `PK_ACCOMMODATION_INFO` PRIMARY KEY (
                                                                                     `ACCOMMODATION_INFO_ID`
    );

ALTER TABLE `POLICY` ADD CONSTRAINT `PK_POLICY` PRIMARY KEY (
                                                             `POLICY_ID`
    );

ALTER TABLE `ACCOMMODATION_IMAGE` ADD CONSTRAINT `PK_ACCOMMODATION_IMAGE` PRIMARY KEY (
                                                                                       `ACCOMMODATION_IMAGE_ID`
    );

ALTER TABLE `ROLE` ADD CONSTRAINT `PK_ROLE` PRIMARY KEY (
                                                         `ROLE_ID`
    );

ALTER TABLE `REVIEW` ADD CONSTRAINT `PK_REVIEW` PRIMARY KEY (
                                                             `REVIEW_ID`
    );

ALTER TABLE `EVENT` ADD CONSTRAINT `PK_EVENT` PRIMARY KEY (
                                                           `EVENT_ID`
    );

ALTER TABLE `ACTION_CRUD` ADD CONSTRAINT `PK_ACTION_CRUD` PRIMARY KEY (
                                                                       `ACTION_ID`
    );

ALTER TABLE `PAYMENT_STATUS` ADD CONSTRAINT `PK_PAYMENT_STATUS` PRIMARY KEY (
                                                                             `PAYMENT_STATUS_ID`
    );

ALTER TABLE `CUSTOMER_STATUS` ADD CONSTRAINT `PK_CUSTOMER_STATUS` PRIMARY KEY (
                                                                               `CUSTOMER_STATUS_ID`
    );

ALTER TABLE `USER_COUPON` ADD CONSTRAINT `PK_USER_COUPON` PRIMARY KEY (
                                                                       `CUSTOMER_ID`,
                                                                       `COUPON_ID`
    );

ALTER TABLE `RESERVE_STATUS` ADD CONSTRAINT `PK_RESERVE_STATUS` PRIMARY KEY (
                                                                             `RESERVE_STATUS_ID`
    );

ALTER TABLE `ROOM_HISTORY` ADD CONSTRAINT `PK_ROOM_HISTORY` PRIMARY KEY (
                                                                         `HISTORY_ID`
    );

ALTER TABLE `PAYMENT_OPTION_BENEFIT` ADD CONSTRAINT `PK_PAYMENT_OPTION_BENEFIT` PRIMARY KEY (
                                                                                             `PAYMENT_OPTION_BENEFIT_ID`
    );

ALTER TABLE `ADMIN` ADD CONSTRAINT `PK_ADMIN` PRIMARY KEY (
                                                           `ADMIN_ID`
    );

ALTER TABLE `PRICE_POLICY_HISTORY` ADD CONSTRAINT `PK_PRICE_POLICY_HISTORY` PRIMARY KEY (
                                                                                         `HISTORY_ID`
    );

ALTER TABLE `ACCOMMODATION_POLICY` ADD CONSTRAINT `PK_ACCOMMODATION_POLICY` PRIMARY KEY (
                                                                                         `POLICY_ID`,
                                                                                         `ACCOMMODATION_ID`
    );

ALTER TABLE `REVIEW_IMAGE` ADD CONSTRAINT `PK_REVIEW_IMAGE` PRIMARY KEY (
                                                                         `REVIEW_IMAGE_ID`
    );

ALTER TABLE `CUSTOMER_INQUIRY` ADD CONSTRAINT `PK_CUSTOMER_INQUIRY` PRIMARY KEY (
                                                                                 `INQUIRY_ID`
    );

ALTER TABLE `ACCOMMODATION_WISHLIST` ADD CONSTRAINT `PK_ACCOMMODATION_WISHLIST` PRIMARY KEY (
                                                                                             `ACCOMMODATION_ID`,
                                                                                             `CUSTOMER_ID`
    );

ALTER TABLE `PRIVILEGE` ADD CONSTRAINT `PK_PRIVILEGE` PRIMARY KEY (
                                                                   `PRIVILEGE_ID`
    );

ALTER TABLE `NOTICE` ADD CONSTRAINT `PK_NOTICE` PRIMARY KEY (
                                                             `NOTICE_ID`
    );

ALTER TABLE `RESERVE_AGREEMENT` ADD CONSTRAINT `PK_RESERVE_AGREEMENT` PRIMARY KEY (
                                                                                   `RESERVE_AGREEMENT_ID`
    );

ALTER TABLE `ADMIN_HISTORY` ADD CONSTRAINT `PK_ADMIN_HISTORY` PRIMARY KEY (
                                                                           `ADMIN_HISTORY_ID`
    );

ALTER TABLE `ROOM_IMAGE` ADD CONSTRAINT `PK_ROOM_IMAGE` PRIMARY KEY (
                                                                     `ROOM_IMAGE_ID`
    );

ALTER TABLE `POINT_DETAIL` ADD CONSTRAINT `PK_POINT_DETAIL` PRIMARY KEY (
                                                                         `POINT_DETAIL_ID`
    );

ALTER TABLE `PAY_OPT_BEN_STAT` ADD CONSTRAINT `PK_PAY_OPT_BEN_STAT` PRIMARY KEY (
                                                                                 `PAYMENT_OPTION_BENEFIT_STATUS_ID`
    );

ALTER TABLE `ACCOMMODATION` ADD CONSTRAINT `PK_ACCOMMODATION` PRIMARY KEY (
                                                                           `ACCOMMODATION_ID`
    );

ALTER TABLE `RESERVE_STATUS_HISTORY` ADD CONSTRAINT `PK_RESERVE_STATUS_HISTORY` PRIMARY KEY (
                                                                                             `RESERVE_STATUS_HISTORY_ID`
    );

ALTER TABLE `SETTLEMENT` ADD CONSTRAINT `PK_SETTLEMENT` PRIMARY KEY (
                                                                     `SETTLEMENT_ID`
    );

ALTER TABLE `PRICE_POLICY` ADD CONSTRAINT `PK_PRICE_POLICY` PRIMARY KEY (
                                                                         `PRICE_POLICY_ID`
    );

ALTER TABLE `CUSTOMER_BENEFIT_HISTORY` ADD CONSTRAINT `PK_CUSTOMER_BENEFIT_HISTORY` PRIMARY KEY (
                                                                                                 `CUSTOMER_BENEFIT_HISTORY_ID`
    );

ALTER TABLE `ROOM_BED` ADD CONSTRAINT `PK_ROOM_BED` PRIMARY KEY (
                                                                 `BED_ID`
    );

ALTER TABLE `SELLER_STATUS` ADD CONSTRAINT `PK_SELLER_STATUS` PRIMARY KEY (
                                                                           `SELLER_STATUS_ID`
    );

ALTER TABLE `PAY_OPT_STAT` ADD CONSTRAINT `PK_PAY_OPT_STAT` PRIMARY KEY (
                                                                         `PAYMENT_OPTION_STATUS_ID`
    );

ALTER TABLE `PAY_OPT_STAT_HIST` ADD CONSTRAINT `PK_PAY_OPT_STAT_HIST` PRIMARY KEY (
                                                                                   `PAYMENT_OPTION_STATUS_HISTORY_ID`
    );

ALTER TABLE `SETTLEMENT_STATUS` ADD CONSTRAINT `PK_SETTLEMENT_STATUS` PRIMARY KEY (
                                                                                   `SETTLEMENT_STATUS_ID`
    );

ALTER TABLE `RESERVE_AGREEMENT_VERIFY` ADD CONSTRAINT `PK_RESERVE_AGREEMENT_VERIFY` PRIMARY KEY (
                                                                                                 `RESERVE_AGREEMENT_ID`,
                                                                                                 `RESERVE_ID`
    );

ALTER TABLE `ACCOMMODATION_FACILITY` ADD CONSTRAINT `PK_ACCOMMODATION_FACILITY` PRIMARY KEY (
                                                                                             `ACCOMMODATION_ID`,
                                                                                             `FACILITY_ID`
    );

ALTER TABLE `PAYMENT_STATUS_HISTORY` ADD CONSTRAINT `PK_PAYMENT_STATUS_HISTORY` PRIMARY KEY (
                                                                                             `PAYMENT_STATUS_HISTORY_ID`
    );

ALTER TABLE `SELLER_STATUS_HISTORY` ADD CONSTRAINT `PK_SELLER_STATUS_HISTORY` PRIMARY KEY (
                                                                                           `SELLER_STATUS_HISTORY_ID`
    );

ALTER TABLE `ROOM` ADD CONSTRAINT `PK_ROOM` PRIMARY KEY (
                                                         `ROOM_ID`
    );

ALTER TABLE `OLD_RESERVE` ADD CONSTRAINT `PK_OLD_RESERVE` PRIMARY KEY (
                                                                       `RESERVE_ID`
    );

ALTER TABLE `POINT_EVENT` ADD CONSTRAINT `PK_POINT_EVENT` PRIMARY KEY (
                                                                       `EVENT_ID`
    );

ALTER TABLE `COUPON` ADD CONSTRAINT `PK_COUPON` PRIMARY KEY (
                                                             `COUPON_ID`
    );

ALTER TABLE `RESERVE` ADD CONSTRAINT `PK_RESERVE` PRIMARY KEY (
                                                               `RESERVE_ID`
    );

ALTER TABLE `CUSTOMER_BENEFIT` ADD CONSTRAINT `PK_CUSTOMER_BENEFIT` PRIMARY KEY (
                                                                                 `BENEFIT_ID`
    );

ALTER TABLE `PAYMENT` ADD CONSTRAINT `PK_PAYMENT` PRIMARY KEY (
                                                               `PAYMENT_ID`
    );

ALTER TABLE `ACCOMMODATION_CATEGORY_L3` ADD CONSTRAINT `PK_ACCOMMODATION_CATEGORY_L3` PRIMARY KEY (
                                                                                                   `ACCOMMODATION_CATEGORY_L3_ID`
    );

ALTER TABLE `CUSTOMER_GRADE` ADD CONSTRAINT `PK_CUSTOMER_GRADE` PRIMARY KEY (
                                                                             `GRADE_ID`
    );

ALTER TABLE `PAYMENT_OPTION` ADD CONSTRAINT `PK_PAYMENT_OPTION` PRIMARY KEY (
                                                                             `PAYMENT_OPTION_ID`
    );

ALTER TABLE `PAY_OPT_BEN_STAT_HIS` ADD CONSTRAINT `PK_PAY_OPT_BEN_STAT_HIS` PRIMARY KEY (
                                                                                         `PAYMENT_OPTION_STATUS_HISTORY_ID`
    );

ALTER TABLE `COMMISSION_POLICY` ADD CONSTRAINT `PK_COMMISSION_POLICY` PRIMARY KEY (
                                                                                   `COMMISSION_POLICY_ID`
    );

ALTER TABLE `RESOURCE` ADD CONSTRAINT `PK_RESOURCE` PRIMARY KEY (
                                                                 `RESOURCE_ID`
    );

ALTER TABLE `SHOPPING_CART` ADD CONSTRAINT `PK_SHOPPING_CART` PRIMARY KEY (
                                                                           `CART_ID`
    );

ALTER TABLE `SETTLEMENT_STATUS_HISTORY` ADD CONSTRAINT `PK_SETTLEMENT_STATUS_HISTORY` PRIMARY KEY (
                                                                                                   `SETTLEMENT_STATUS_HISTORY_ID`
    );

ALTER TABLE `CUSTOMER_GRADE_HISTORY` ADD CONSTRAINT `PK_CUSTOMER_GRADE_HISTORY` PRIMARY KEY (
                                                                                             `HISTORY_ID`
    );

ALTER TABLE `FACILITY` ADD CONSTRAINT `PK_FACILITY` PRIMARY KEY (
                                                                 `FACILITY_ID`
    );

ALTER TABLE `COUPON_HISTORY` ADD CONSTRAINT `PK_COUPON_HISTORY` PRIMARY KEY (
                                                                             `COUPON_HISTORY_ID`
    );

ALTER TABLE `INQUIRY_ANSWER` ADD CONSTRAINT `PK_INQUIRY_ANSWER` PRIMARY KEY (
                                                                             `ANSWER_ID`
    );

/* TODO auto_increment 추가, 초기값 설정 */
-- AUTO_INCREMENT 속성 추가 및 초기값 1 설정 쿼리 목록
-- (복합키 테이블은 AUTO_INCREMENT를 적용할 수 없어 제외되었습니다.)

ALTER TABLE `ACCOMMODATION_CATEGORY_L2`
    MODIFY COLUMN `ACCOMMODATION_CATEGORY_L2_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `ACCOMMODATION_CATEGORY_L2` AUTO_INCREMENT = 1;

ALTER TABLE `LOGIN_LOG`
    MODIFY COLUMN `LOG_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `LOGIN_LOG` AUTO_INCREMENT = 1;

ALTER TABLE `CUSTOMER_STATUS_HISTORY`
    MODIFY COLUMN `CUSTOMER_STATUS_HISTORY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `CUSTOMER_STATUS_HISTORY` AUTO_INCREMENT = 1;

/* 고객 모듈: 대량 트래픽 예상, 별도 10,000대 블록으로 분리 (관리자와 충돌 방지) */
ALTER TABLE `CUSTOMER`
    MODIFY COLUMN `CUSTOMER_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `CUSTOMER` AUTO_INCREMENT = 10000; -- TODO 고객 PK 시작값 정하기

ALTER TABLE `ACCOMMODATION_CATEGORY_L1`
    MODIFY COLUMN `ACCOMMODATION_CATEGORY_L1_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `ACCOMMODATION_CATEGORY_L1` AUTO_INCREMENT = 1;

ALTER TABLE `ACCOMMODATION_HISTORY`
    MODIFY COLUMN `HISTORY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `ACCOMMODATION_HISTORY` AUTO_INCREMENT = 1;

ALTER TABLE `COMPANION`
    MODIFY COLUMN `COMPANION_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `COMPANION` AUTO_INCREMENT = 1;

ALTER TABLE `DEPARTMENT`
    MODIFY COLUMN `DEPT_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `DEPARTMENT` AUTO_INCREMENT = 1;

/* 판매자 모듈: 고객(10k)과 동시 생성될 수 있으므로 30,000대 블록 할당 */
ALTER TABLE `SELLER`
    MODIFY COLUMN `SELLER_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `SELLER` AUTO_INCREMENT = 30000; -- SELLER PK 시작값

ALTER TABLE `ACCOMMODATION_INFO`
    MODIFY COLUMN `ACCOMMODATION_INFO_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `ACCOMMODATION_INFO` AUTO_INCREMENT = 1;

/* 정책 모듈: 프로모션, 혜택 모듈과 분리하기 위해 90,000대 블록 할당 */
ALTER TABLE `POLICY`
    MODIFY COLUMN `POLICY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `POLICY` AUTO_INCREMENT = 90000;  -- POLICY PK 시작값

ALTER TABLE `ACCOMMODATION_IMAGE`
    MODIFY COLUMN `ACCOMMODATION_IMAGE_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `ACCOMMODATION_IMAGE` AUTO_INCREMENT = 1;

ALTER TABLE `ROLE`
    MODIFY COLUMN `ROLE_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `ROLE` AUTO_INCREMENT = 1;

/* 리뷰 모듈: 사용자 리뷰와 리뷰 이미지 동시 생성되므로 70,000대 블록 할당 */
ALTER TABLE `REVIEW`
    MODIFY COLUMN `REVIEW_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `REVIEW` AUTO_INCREMENT = 70000;  -- REVIEW PK 시작값

/* 프로모션(이벤트) 모듈: 쿠폰과 동시 발급되므로 50,000대 블록 할당 */
ALTER TABLE `EVENT`
    MODIFY COLUMN `EVENT_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `EVENT` AUTO_INCREMENT = 50000;  -- EVENT PK 시작값

ALTER TABLE `ACTION_CRUD`
    MODIFY COLUMN `ACTION_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `ACTION_CRUD` AUTO_INCREMENT = 1;

ALTER TABLE `PAYMENT_STATUS`
    MODIFY COLUMN `PAYMENT_STATUS_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `PAYMENT_STATUS` AUTO_INCREMENT = 1;

ALTER TABLE `CUSTOMER_STATUS`
    MODIFY COLUMN `CUSTOMER_STATUS_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `CUSTOMER_STATUS` AUTO_INCREMENT = 1;

ALTER TABLE `RESERVE_STATUS`
    MODIFY COLUMN `RESERVE_STATUS_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `RESERVE_STATUS` AUTO_INCREMENT = 1;

ALTER TABLE `ROOM_HISTORY`
    MODIFY COLUMN `HISTORY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `ROOM_HISTORY` AUTO_INCREMENT = 1;

ALTER TABLE `PAYMENT_OPTION_BENEFIT`
    MODIFY COLUMN `PAYMENT_OPTION_BENEFIT_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `PAYMENT_OPTION_BENEFIT` AUTO_INCREMENT = 1;

/* 관리자 모듈: 고객과 동시 식별 리스크 방지 위해 20,000대 블록 할당 */
ALTER TABLE `ADMIN`
    MODIFY COLUMN `ADMIN_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `ADMIN` AUTO_INCREMENT = 20000;  -- 관리자 PK 시작값

ALTER TABLE `PRICE_POLICY_HISTORY`
    MODIFY COLUMN `HISTORY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `PRICE_POLICY_HISTORY` AUTO_INCREMENT = 1;

/* 리뷰 이미지 모듈: REVIEW(70k)와 동시에 삽입되므로 71,000대 블록 할당 */
ALTER TABLE `REVIEW_IMAGE`
    MODIFY COLUMN `REVIEW_IMAGE_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `REVIEW_IMAGE` AUTO_INCREMENT = 71000;  -- REVIEW_IMAGE PK 시작값

/* 고객 문의 모듈: NOTICE(80k)와 동시 조회되지만 충돌 위험 낮으므로 81,000대 할당 */
ALTER TABLE `CUSTOMER_INQUIRY`
    MODIFY COLUMN `INQUIRY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `CUSTOMER_INQUIRY` AUTO_INCREMENT = 81000;  -- CUSTOMER_INQUIRY PK 시작값

ALTER TABLE `PRIVILEGE`
    MODIFY COLUMN `PRIVILEGE_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `PRIVILEGE` AUTO_INCREMENT = 1;

/* 공지사항 모듈: CUSTOMER_INQUIRY(81k)와 동시 제공되므로 80,000대 블록 할당 */
ALTER TABLE `NOTICE`
    MODIFY COLUMN `NOTICE_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `NOTICE` AUTO_INCREMENT = 80000;  -- NOTICE PK 시작값

ALTER TABLE `RESERVE_AGREEMENT`
    MODIFY COLUMN `RESERVE_AGREEMENT_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `RESERVE_AGREEMENT` AUTO_INCREMENT = 1;

ALTER TABLE `ADMIN_HISTORY`
    MODIFY COLUMN `ADMIN_HISTORY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `ADMIN_HISTORY` AUTO_INCREMENT = 1;

ALTER TABLE `ROOM_IMAGE`
    MODIFY COLUMN `ROOM_IMAGE_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `ROOM_IMAGE` AUTO_INCREMENT = 1;

/* 포인트 상세 모듈: POINT_EVENT(60k)와 동시 생성되므로 61,000대 블록 할당 */
ALTER TABLE `POINT_DETAIL`
    MODIFY COLUMN `POINT_DETAIL_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `POINT_DETAIL` AUTO_INCREMENT = 61000;  -- POINT_DETAIL PK 시작값

ALTER TABLE `PAY_OPT_BEN_STAT`
    MODIFY COLUMN `PAYMENT_OPTION_BENEFIT_STATUS_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `PAY_OPT_BEN_STAT` AUTO_INCREMENT = 1;

/* 숙소 모듈: SELLER(30k)와 동시 처리되므로 30,000대 블록 할당 */
ALTER TABLE `ACCOMMODATION`
    MODIFY COLUMN `ACCOMMODATION_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `ACCOMMODATION` AUTO_INCREMENT = 30000;  -- ACCOMMODATION PK 시작값

ALTER TABLE `RESERVE_STATUS_HISTORY`
    MODIFY COLUMN `RESERVE_STATUS_HISTORY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `RESERVE_STATUS_HISTORY` AUTO_INCREMENT = 1;

ALTER TABLE `SETTLEMENT`
    MODIFY COLUMN `SETTLEMENT_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `SETTLEMENT` AUTO_INCREMENT = 1;

ALTER TABLE `PRICE_POLICY`
    MODIFY COLUMN `PRICE_POLICY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `PRICE_POLICY` AUTO_INCREMENT = 1;

ALTER TABLE `CUSTOMER_BENEFIT_HISTORY`
    MODIFY COLUMN `CUSTOMER_BENEFIT_HISTORY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `CUSTOMER_BENEFIT_HISTORY` AUTO_INCREMENT = 1;

ALTER TABLE `ROOM_BED`
    MODIFY COLUMN `BED_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `ROOM_BED` AUTO_INCREMENT = 1;

ALTER TABLE `SELLER_STATUS`
    MODIFY COLUMN `SELLER_STATUS_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `SELLER_STATUS` AUTO_INCREMENT = 1;

ALTER TABLE `PAY_OPT_STAT`
    MODIFY COLUMN `PAYMENT_OPTION_STATUS_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `PAY_OPT_STAT` AUTO_INCREMENT = 1;

ALTER TABLE `PAY_OPT_STAT_HIST`
    MODIFY COLUMN `PAYMENT_OPTION_STATUS_HISTORY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `PAY_OPT_STAT_HIST` AUTO_INCREMENT = 1;

ALTER TABLE `SETTLEMENT_STATUS`
    MODIFY COLUMN `SETTLEMENT_STATUS_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `SETTLEMENT_STATUS` AUTO_INCREMENT = 1;

ALTER TABLE `PAYMENT_STATUS_HISTORY`
    MODIFY COLUMN `PAYMENT_STATUS_HISTORY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `PAYMENT_STATUS_HISTORY` AUTO_INCREMENT = 1;

ALTER TABLE `SELLER_STATUS_HISTORY`
    MODIFY COLUMN `SELLER_STATUS_HISTORY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `SELLER_STATUS_HISTORY` AUTO_INCREMENT = 1;

ALTER TABLE `ROOM`
    MODIFY COLUMN `ROOM_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `ROOM` AUTO_INCREMENT = 31000;  -- ROOM PK 시작값

ALTER TABLE `OLD_RESERVE`
    MODIFY COLUMN `RESERVE_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `OLD_RESERVE` AUTO_INCREMENT = 1;

/* 포인트 이벤트 모듈: POINT_DETAIL(61k)와 동시 생성되므로 60,000대 블록 할당 */
ALTER TABLE `POINT_EVENT`
    MODIFY COLUMN `EVENT_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `POINT_EVENT` AUTO_INCREMENT = 60000;  -- POINT_EVENT PK 시작값

/* 쿠폰 모듈: EVENT(50k)와 동시 발급되므로 51,000대 블록 할당 */
ALTER TABLE `COUPON`
    MODIFY COLUMN `COUPON_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `COUPON` AUTO_INCREMENT = 51000;  -- COUPON PK 시작값

/* 예약(RESERVE) 모듈: PAYMENT(41k)와 연계되므로 40,000대 블록 할당 */
ALTER TABLE `RESERVE`
    MODIFY COLUMN `RESERVE_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `RESERVE` AUTO_INCREMENT = 40000;  -- RESERVE PK 시작값

/* 고객 혜택 모듈: POLICY(90k)와 분리하기 위해 91,000대 블록 할당 */
ALTER TABLE `CUSTOMER_BENEFIT`
    MODIFY COLUMN `BENEFIT_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `CUSTOMER_BENEFIT` AUTO_INCREMENT = 91000;  -- CUSTOMER_BENEFIT PK 시작값

/* 결제 모듈: RESERVE(40k)와 연동되므로 41,000대 블록 할당 */
ALTER TABLE `PAYMENT`
    MODIFY COLUMN `PAYMENT_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `PAYMENT` AUTO_INCREMENT = 41000;  -- PAYMENT PK 시작값

ALTER TABLE `ACCOMMODATION_CATEGORY_L3`
    MODIFY COLUMN `ACCOMMODATION_CATEGORY_L3_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `ACCOMMODATION_CATEGORY_L3` AUTO_INCREMENT = 1;

ALTER TABLE `CUSTOMER_GRADE`
    MODIFY COLUMN `GRADE_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `CUSTOMER_GRADE` AUTO_INCREMENT = 1;

ALTER TABLE `PAYMENT_OPTION`
    MODIFY COLUMN `PAYMENT_OPTION_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `PAYMENT_OPTION` AUTO_INCREMENT = 1;

ALTER TABLE `PAY_OPT_BEN_STAT_HIS`
    MODIFY COLUMN `PAYMENT_OPTION_STATUS_HISTORY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `PAY_OPT_BEN_STAT_HIS` AUTO_INCREMENT = 1;

ALTER TABLE `COMMISSION_POLICY`
    MODIFY COLUMN `COMMISSION_POLICY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `COMMISSION_POLICY` AUTO_INCREMENT = 1;

ALTER TABLE `RESOURCE`
    MODIFY COLUMN `RESOURCE_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `RESOURCE` AUTO_INCREMENT = 1;

ALTER TABLE `SHOPPING_CART`
    MODIFY COLUMN `CART_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `SHOPPING_CART` AUTO_INCREMENT = 1;

ALTER TABLE `SETTLEMENT_STATUS_HISTORY`
    MODIFY COLUMN `SETTLEMENT_STATUS_HISTORY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `SETTLEMENT_STATUS_HISTORY` AUTO_INCREMENT = 1;

ALTER TABLE `CUSTOMER_GRADE_HISTORY`
    MODIFY COLUMN `HISTORY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `CUSTOMER_GRADE_HISTORY` AUTO_INCREMENT = 1;

ALTER TABLE `FACILITY`
    MODIFY COLUMN `FACILITY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `FACILITY` AUTO_INCREMENT = 1;

ALTER TABLE `COUPON_HISTORY`
    MODIFY COLUMN `COUPON_HISTORY_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `COUPON_HISTORY` AUTO_INCREMENT = 1;

ALTER TABLE `INQUIRY_ANSWER`
    MODIFY COLUMN `ANSWER_ID` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `INQUIRY_ANSWER` AUTO_INCREMENT = 1;

