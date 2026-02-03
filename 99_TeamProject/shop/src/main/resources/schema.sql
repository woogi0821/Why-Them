/* ==============================================
   [초기화] 기존 객체 삭제
   ============================================== */
-- 테이블 삭제
DROP TABLE PAYMENTS CASCADE CONSTRAINTS;
DROP TABLE ORDER_ITEMS CASCADE CONSTRAINTS;
DROP TABLE ORDERS CASCADE CONSTRAINTS;
DROP TABLE CART_ITEM CASCADE CONSTRAINTS;
DROP TABLE CART CASCADE CONSTRAINTS;
DROP TABLE PROMOTION_PRODUCT CASCADE CONSTRAINTS;
DROP TABLE PROMOTION CASCADE CONSTRAINTS;
DROP TABLE PRODUCT_IMAGE CASCADE CONSTRAINTS;
DROP TABLE PRODUCT CASCADE CONSTRAINTS;
DROP TABLE CATEGORY CASCADE CONSTRAINTS;
DROP TABLE MEMBER_ADDRESS CASCADE CONSTRAINTS;
DROP TABLE ADMIN_LOG CASCADE CONSTRAINTS;
DROP TABLE ADMIN CASCADE CONSTRAINTS;
DROP TABLE MEMBER CASCADE CONSTRAINTS;

-- 시퀀스 삭제
DROP SEQUENCE MEMBER_SEQ;
DROP SEQUENCE ADMIN_SEQ;
DROP SEQUENCE ADMIN_LOG_SEQ;
DROP SEQUENCE MEMBER_ADDRESS_SEQ;
DROP SEQUENCE CATEGORY_SEQ;
DROP SEQUENCE PRODUCT_SEQ;
DROP SEQUENCE PRODUCT_IMAGE_SEQ;
DROP SEQUENCE CART_SEQ;
DROP SEQUENCE CART_ITEM_SEQ;
DROP SEQUENCE ORDERS_SEQ;
DROP SEQUENCE ORDER_ITEMS_SEQ;
DROP SEQUENCE PAYMENTS_SEQ;
DROP SEQUENCE PROMOTION_SEQ;

/* ==============================================
   [생성] 테이블 및 시퀀스 (컬럼명 일원화 적용)
   ============================================== */

-- 1. 회원 (MEMBER)
CREATE TABLE MEMBER (
                        MEMBER_ID       NUMBER(19)          NOT NULL,
                        LOGIN_ID        VARCHAR2(50)        NOT NULL, -- USER_ID -> LOGIN_ID (관리자와 통일)
                        LOGIN_PW        VARCHAR2(255)       NOT NULL, -- USER_PW -> LOGIN_PW
                        MEMBER_NAME     VARCHAR2(50)        NOT NULL, -- NAME -> MEMBER_NAME (조인 시 충돌 방지)
                        EMAIL           VARCHAR2(100)       NOT NULL,
                        PHONE_NUMBER    VARCHAR2(20)        NOT NULL,
                        MEMBER_GRADE    VARCHAR2(1)         DEFAULT 'N' NOT NULL,
                        CREATED_AT      DATE                DEFAULT SYSDATE,
                        STATUS          VARCHAR2(20)        DEFAULT 'ACTIVE',
                        CONSTRAINT PK_MEMBER PRIMARY KEY (MEMBER_ID),
                        CONSTRAINT UQ_MEMBER_LOGIN_ID UNIQUE (LOGIN_ID)
);
CREATE SEQUENCE MEMBER_SEQ NOCACHE;

-- 2. 관리자 (ADMIN)
CREATE TABLE ADMIN (
                       ADMIN_ID        NUMBER(19)          NOT NULL,
                       LOGIN_ID        VARCHAR2(50)        NOT NULL,
                       LOGIN_PW        VARCHAR2(255)       NOT NULL, -- PASSWORD -> LOGIN_PW
                       ADMIN_NAME      VARCHAR2(50)        NOT NULL, -- NAME -> ADMIN_NAME
                       ROLE            VARCHAR2(20)        DEFAULT 'ADMIN',
                       STATUS          VARCHAR2(20)        DEFAULT 'ACTIVE',
                       LAST_LOGIN_AT   DATE,
                       CREATED_AT      DATE                DEFAULT SYSDATE,
                       CONSTRAINT PK_ADMIN PRIMARY KEY (ADMIN_ID)
);
CREATE SEQUENCE ADMIN_SEQ NOCACHE;

-- 3. 관리자 로그 (ADMIN_LOG)
CREATE TABLE ADMIN_LOG (
                           LOG_ID          NUMBER(19)          NOT NULL,
                           ADMIN_ID        NUMBER(19)          NOT NULL,
                           MEMBER_ID       NUMBER(19),         -- TARGET_MEMBER_ID -> MEMBER_ID (조인 편의성)
                           ACTION_TYPE     VARCHAR2(50)        NOT NULL,
                           REASON          VARCHAR2(1000),
                           CREATED_AT      DATE                DEFAULT SYSDATE,
                           CONSTRAINT PK_ADMIN_LOG PRIMARY KEY (LOG_ID),
                           CONSTRAINT FK_LOG_ADMIN FOREIGN KEY (ADMIN_ID) REFERENCES ADMIN(ADMIN_ID),
                           CONSTRAINT FK_LOG_MEMBER FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID)
);
CREATE SEQUENCE ADMIN_LOG_SEQ NOCACHE;

-- 4. 회원 주소 (MEMBER_ADDRESS)
CREATE TABLE MEMBER_ADDRESS (
                                ADDRESS_ID      NUMBER(19)          NOT NULL,
                                MEMBER_ID       NUMBER(19)          NOT NULL,
                                ADDRESS_NAME    VARCHAR2(50),       -- '우리집' 같은 별칭
                                RECIPIENT_NAME  VARCHAR2(50)        NOT NULL,
                                RECIPIENT_PHONE VARCHAR2(20)        NOT NULL,
                                ZIP_CODE        VARCHAR2(10)        NOT NULL,
                                BASE_ADDRESS    VARCHAR2(255)       NOT NULL,
                                DETAIL_ADDRESS  VARCHAR2(255)       NOT NULL,
                                IS_DEFAULT      CHAR(1)             DEFAULT 'N',
                                CONSTRAINT PK_ADDRESS PRIMARY KEY (ADDRESS_ID),
                                CONSTRAINT FK_ADDRESS_MEMBER FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE
);
CREATE SEQUENCE MEMBER_ADDRESS_SEQ NOCACHE;

-- 5. 카테고리 (CATEGORY)
CREATE TABLE CATEGORY (
                          CATEGORY_ID     NUMBER              NOT NULL,
                          CATEGORY_NAME   VARCHAR2(100)       NOT NULL, -- NAME -> CATEGORY_NAME
                          PARENT_ID       NUMBER,
                          C_LEVEL         NUMBER              DEFAULT 1,
                          CONSTRAINT PK_CATEGORY PRIMARY KEY (CATEGORY_ID),
                          CONSTRAINT FK_CATEGORY_PARENT FOREIGN KEY (PARENT_ID) REFERENCES CATEGORY(CATEGORY_ID)
);
CREATE SEQUENCE CATEGORY_SEQ NOCACHE;

-- 6. 상품 (PRODUCT)
CREATE TABLE PRODUCT (
                         PRODUCT_ID      NUMBER              NOT NULL,
                         CATEGORY_ID     NUMBER              NOT NULL,
                         PRODUCT_NAME    VARCHAR2(255)       NOT NULL, -- NAME -> PRODUCT_NAME
                         PRICE           NUMBER              NOT NULL,
                         STOCK_QUANTITY  NUMBER              DEFAULT 0 NOT NULL,
                         DESCRIPTION     CLOB,
                         STATUS          VARCHAR2(20)        DEFAULT 'SALE',
                         VIEW_COUNT      NUMBER              DEFAULT 0,
                         CREATED_AT      DATE                DEFAULT SYSDATE,
                         UPDATED_AT      DATE                DEFAULT SYSDATE,
                         CONSTRAINT PK_PRODUCT PRIMARY KEY (PRODUCT_ID),
                         CONSTRAINT FK_PRODUCT_CATEGORY FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID)
);
CREATE SEQUENCE PRODUCT_SEQ NOCACHE;

-- 7. 상품 이미지 (PRODUCT_IMAGE)
CREATE TABLE PRODUCT_IMAGE (
                               IMAGE_ID        NUMBER              NOT NULL,
                               PRODUCT_ID      NUMBER              NOT NULL,
                               IMAGE_URL       VARCHAR2(500)       NOT NULL,
                               IS_MAIN         CHAR(1)             DEFAULT 'N',
                               CONSTRAINT PK_PROD_IMG PRIMARY KEY (IMAGE_ID),
                               CONSTRAINT FK_IMG_PRODUCT FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID) ON DELETE CASCADE
);
CREATE SEQUENCE PRODUCT_IMAGE_SEQ NOCACHE;

-- 8. 장바구니 (CART)
CREATE TABLE CART (
                      CART_ID         NUMBER              NOT NULL,
                      MEMBER_ID       NUMBER(19)          NOT NULL,
                      CREATED_AT      DATE                DEFAULT SYSDATE,
                      UPDATED_AT      DATE                DEFAULT SYSDATE,
                      CONSTRAINT PK_CART PRIMARY KEY (CART_ID),
                      CONSTRAINT FK_CART_MEMBER FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE
);
CREATE SEQUENCE CART_SEQ NOCACHE;

-- 9. 장바구니 항목 (CART_ITEM)
CREATE TABLE CART_ITEM (
                           CART_ITEM_ID    NUMBER              NOT NULL,
                           CART_ID         NUMBER              NOT NULL,
                           PRODUCT_ID      NUMBER              NOT NULL,
                           QUANTITY        NUMBER              DEFAULT 1 NOT NULL,
                           CREATED_AT      DATE                DEFAULT SYSDATE, -- ADDED_AT -> CREATED_AT (통일)
                           CONSTRAINT PK_CART_ITEM PRIMARY KEY (CART_ITEM_ID),
                           CONSTRAINT FK_CI_CART FOREIGN KEY (CART_ID) REFERENCES CART(CART_ID) ON DELETE CASCADE,
                           CONSTRAINT FK_CI_PRODUCT FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)
);
CREATE SEQUENCE CART_ITEM_SEQ NOCACHE;

-- 10. 주문 (ORDERS)
CREATE TABLE ORDERS (
                        ORDER_ID        NUMBER              NOT NULL,
                        MEMBER_ID       NUMBER(19)          NOT NULL,
                        TOTAL_PRICE     NUMBER(10, 2)       NOT NULL,
                        STATUS          VARCHAR2(20)        DEFAULT 'PENDING',
                        CREATED_AT      DATE                DEFAULT SYSDATE,
                        UPDATED_AT      DATE                DEFAULT SYSDATE,
                        CONSTRAINT PK_ORDERS PRIMARY KEY (ORDER_ID),
                        CONSTRAINT FK_ORDER_MEMBER FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID)
);
CREATE SEQUENCE ORDERS_SEQ NOCACHE;

-- 11. 주문 상세 (ORDER_ITEMS)
CREATE TABLE ORDER_ITEMS (
                             ORDER_ITEM_ID   NUMBER              NOT NULL,
                             ORDER_ID        NUMBER              NOT NULL,
                             PRODUCT_ID      NUMBER              NOT NULL,
                             QUANTITY        NUMBER              NOT NULL,
                             PRICE           NUMBER(10, 2)       NOT NULL,
                             CONSTRAINT PK_ORDER_ITEMS PRIMARY KEY (ORDER_ITEM_ID),
                             CONSTRAINT FK_OI_ORDER FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID) ON DELETE CASCADE,
                             CONSTRAINT FK_OI_PRODUCT FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)
);
CREATE SEQUENCE ORDER_ITEMS_SEQ NOCACHE;

-- 12. 결제 (PAYMENTS)
CREATE TABLE PAYMENTS (
                          PAYMENT_ID      NUMBER              NOT NULL,
                          ORDER_ID        NUMBER              NOT NULL,
                          PAYMENT_METHOD  VARCHAR2(20)        NOT NULL,
                          AMOUNT          NUMBER(10, 2)       NOT NULL,
                          STATUS          VARCHAR2(20)        DEFAULT 'READY',
                          PAID_AT         DATE,
                          CREATED_AT      DATE                DEFAULT SYSDATE,
                          CONSTRAINT PK_PAYMENTS PRIMARY KEY (PAYMENT_ID),
                          CONSTRAINT FK_PAY_ORDER FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID)
);
CREATE SEQUENCE PAYMENTS_SEQ NOCACHE;

-- 13. 프로모션 (PROMOTION)
CREATE TABLE PROMOTION (
                           PROMOTION_ID    NUMBER              NOT NULL,
                           PROMOTION_TITLE VARCHAR2(100)       NOT NULL, -- TITLE -> PROMOTION_TITLE
                           DISCOUNT_TYPE   VARCHAR2(20)        NOT NULL,
                           DISCOUNT_VALUE  NUMBER(10, 2)       NOT NULL,
                           START_DATE      DATE,
                           END_DATE        DATE,
                           IS_ACTIVE       CHAR(1)             DEFAULT 'Y',
                           CONSTRAINT PK_PROMOTION PRIMARY KEY (PROMOTION_ID)
);
CREATE SEQUENCE PROMOTION_SEQ NOCACHE;

-- 14. 프로모션-상품 매핑
CREATE TABLE PROMOTION_PRODUCT (
                                   PP_ID           NUMBER              NOT NULL,
                                   PROMOTION_ID    NUMBER              NOT NULL,
                                   PRODUCT_ID      NUMBER              NOT NULL,
                                   CONSTRAINT PK_PP PRIMARY KEY (PP_ID),
                                   CONSTRAINT FK_PP_PROMO FOREIGN KEY (PROMOTION_ID) REFERENCES PROMOTION(PROMOTION_ID) ON DELETE CASCADE,
                                   CONSTRAINT FK_PP_PROD FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID) ON DELETE CASCADE
);