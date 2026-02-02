DROP TABLE IF EXISTS MEMBER_ADDRESS CASCADE;
DROP TABLE IF EXISTS MEMBER CASCADE;

CREATE TABLE MEMBER (
                        MEMBER_ID NUMBER PRIMARY KEY,
                        USER_ID VARCHAR2(50) NOT NULL,
                        USER_PW VARCHAR2(255) NOT NULL,
                        MEMBER_NAME VARCHAR2(10) NOT NULL,
                        EMAIL VARCHAR2(100),
                        PHONE_NUMBER VARCHAR2(20),
                        CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        STATUS VARCHAR2(20),
                        MEMBER_GRADE VARCHAR2(1) DEFAULT 'N' NOT NULL
);
CREATE SEQUENCE MEMBER_SEQ START WITH 1 INCREMENT BY 1;

CREATE TABLE MEMBER_ADDRESS (
                                ADDRESS_ID NUMBER PRIMARY KEY,
                                MEMBER_ID NUMBER NOT NULL,
                                ADDRESS_NAME VARCHAR2(50),
                                BASE_ADDRESS VARCHAR2(255),
                                RECIPIENT_NAME  VARCHAR2(50),
                                RECIPIENT_PHONE VARCHAR2(20),
                                ZIP_CODE        VARCHAR2(10),
                                DETAIL_ADDRESS VARCHAR2(255),
                                IS_DEFAULT CHAR(1) DEFAULT 'N',

                        CONSTRAINT FK_MEMBER_ADDRESS
                            FOREIGN KEY (MEMBER_ID)
                            REFERENCES MEMBER(MEMBER_ID)
                            ON DELETE CASCADE
);
CREATE SEQUENCE MEMBER_ADDRESS_SEQ START WITH 1 INCREMENT BY 1;