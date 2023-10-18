/***************************************
* Script Name: Createbusiness.sql
* Created Date: 12-10-2023
* Author:Avadhut
****************************************/

-- Description: This script creates a tables for "dvsn_marketplace" and inserts some sample/required master data into it.

-- Input Parameters: None

-- Output: A multiple tables for "dvsn_marketplace" with some master data.

-- Version History:
-- Version 1.0 - Initial script

-- Database Schema: dvsn_marketplace_db
  
    ----------Table Creation------------------------------------------------------

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE COUNTRIES CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "COUNTRIES" (
    "ISN"             NUMBER(3)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE
        NOT NULL ENABLE,
    "NAME"            NVARCHAR2(255)
        NOT NULL ENABLE,
    "TWO_CHAR_CODE"   VARCHAR2(2)
        NOT NULL ENABLE,
    "THREE_CHAR_CODE" VARCHAR2(3)
        NOT NULL ENABLE,
    "NUMERIC_CODE"    VARCHAR2(3)
        NOT NULL ENABLE,
    CONSTRAINT "COUN_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "COUN_PK" ON
                "COUNTRIES" (
                    "ISN"
                )
        )
    ENABLE,
    CONSTRAINT "COUN_UK1" UNIQUE ( "NAME" )
        USING INDEX (
            CREATE UNIQUE INDEX "COUN_UK1" ON
                "COUNTRIES" (
                    "NAME"
                )
        )
    ENABLE,
    CONSTRAINT "COUN_UK2" UNIQUE ( "TWO_CHAR_CODE" )
        USING INDEX (
            CREATE UNIQUE INDEX "COUN_UK2" ON
                "COUNTRIES" (
                    "TWO_CHAR_CODE"
                )
        )
    ENABLE,
    CONSTRAINT "COUN_UK3" UNIQUE ( "THREE_CHAR_CODE" )
        USING INDEX (
            CREATE UNIQUE INDEX "COUN_UK3" ON
                "COUNTRIES" (
                    "THREE_CHAR_CODE"
                )
        )
    ENABLE,
    CONSTRAINT "COUN_UK4" UNIQUE ( "NUMERIC_CODE" )
        USING INDEX (
            CREATE UNIQUE INDEX "COUN_UK4" ON
                "COUNTRIES" (
                    "NUMERIC_CODE"
                )
        )
    ENABLE
);
/

COMMENT ON TABLE countries IS
    'COUNTRIES Table for COUNTRIES Details';

COMMENT ON COLUMN countries.isn IS
    'The unique identifier for the countries';

COMMENT ON COLUMN countries.two_char_code IS
    'Universal unique identifier(TWO_CHAR_CODE) for the countries';

COMMENT ON COLUMN countries.three_char_code IS
    'Universal unique identifier(THREE_CHAR_CODE) for the countries';

COMMENT ON COLUMN countries.numeric_code IS
    'Universal 3 digits unique identifier(NUMERIC_CODE) for the countries';
    --------------------------------------------------------------------------
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE STATES CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "STATES" (
    "ISN"         NUMBER(6)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE
        NOT NULL ENABLE,
    "CODE"        VARCHAR2(4)
        NOT NULL ENABLE,
    "NAME"        NVARCHAR2(45)
        NOT NULL ENABLE,
    "COUNTRY_ISN" NUMBER(16)
        NOT NULL ENABLE,
    CONSTRAINT "STAT_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "STAT_PK" ON
                "STATES" (
                    "ISN"
                )
        )
    ENABLE,
    CONSTRAINT "STAT_UK1" UNIQUE ( "COUNTRY_ISN",
                                   "CODE" )
        USING INDEX (
            CREATE UNIQUE INDEX "STAT_UK1" ON
                "STATES" (
                    "COUNTRY_ISN",
                    "CODE"
                )
        )
    ENABLE
);
/

COMMENT ON TABLE states IS
    'STATES Table for STATES Details';

COMMENT ON COLUMN states.isn IS
    'The unique identifier for the STATES';

COMMENT ON COLUMN states.code IS
    'The unique identifier for the STATES according to countries';

COMMENT ON COLUMN states.country_isn IS
    'The unique identifier for the countries';

    -----------------------------------------------------
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CITIES CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "CITIES" (
    "ISN"       NUMBER(6)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE
        NOT NULL ENABLE,
    "CODE"      VARCHAR2(4)
        NOT NULL ENABLE,
    "NAME"      NVARCHAR2(45)
        NOT NULL ENABLE,
    "STATE_ISN" NUMBER(6)
        NOT NULL ENABLE,
    CONSTRAINT "CITI_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "CITI_PK" ON
                "CITIES" (
                    "ISN"
                )
        )
    ENABLE,
    CONSTRAINT "CITI_UK1" UNIQUE ( "STATE_ISN",
                                   "CODE" )
        USING INDEX (
            CREATE UNIQUE INDEX "CITI_UK1" ON
                "CITIES" (
                    "STATE_ISN",
                    "CODE"
                )
        )
    ENABLE
);
/

COMMENT ON TABLE cities IS
    'CITIES Table for CITIES Details';

COMMENT ON COLUMN cities.isn IS
    'The unique identifier for the CITIES which is used in multiple other tables';

COMMENT ON COLUMN cities.code IS
    'The unique identifier for the CITIES according to STATES';

COMMENT ON COLUMN cities.state_isn IS
    'The unique identifier for the STATES';

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CONTACT_TYPES CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/
-------------------------------------------------------------------------------

CREATE TABLE "CONTACT_TYPES" (
    "ISN"         NUMBER(2)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 99 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE
        NOT NULL ENABLE,
    "CODE"        VARCHAR2(4)
        NOT NULL ENABLE,
    "DESCRIPTION" NVARCHAR2(20)
        NOT NULL ENABLE,
    CONSTRAINT "COTY_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "COTY_PK" ON
                "CONTACT_TYPES" (
                    "ISN"
                )
        )
    ENABLE,
    CONSTRAINT "COTY_UK1" UNIQUE ( "CODE" )
        USING INDEX (
            CREATE UNIQUE INDEX "COTY_UK1" ON
                "CONTACT_TYPES" (
                    "CODE"
                )
        )
    ENABLE
);
/

COMMENT ON COLUMN contact_types.code IS
    'The unique identifier for the CONTACT_TYPES in VARCHAR2';
    -------------------------------------------------------------------------

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE BUSINESS_TYPES CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "BUSINESS_TYPES" (
    "ISN"         NUMBER(2)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 99 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE
        NOT NULL ENABLE,
    "CODE"        VARCHAR2(4)
        NOT NULL ENABLE,
    "DESCRIPTION" NVARCHAR2(20)
        NOT NULL ENABLE,
    CONSTRAINT "BUTY_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "BUTY_PK" ON
                "BUSINESS_TYPES" (
                    "ISN"
                )
        )
    ENABLE,
    CONSTRAINT "BUTY_UK1" UNIQUE ( "CODE" )
        USING INDEX (
            CREATE UNIQUE INDEX "BUTY_UK1" ON
                "BUSINESS_TYPES" (
                    "CODE"
                )
        )
    ENABLE
);
/

COMMENT ON COLUMN business_types.code IS
    'The unique identifier for the BUSINESS_TYPES in VARCHAR2';

COMMENT ON COLUMN business_types.description IS
    'DESCRIBING TYPES OF THE BUSINESSES LIKE MICRO, SMALL, MEDIUM';
    
    --------------------------------------------------------------------

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE BUSINESS_CATEGORIES CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "BUSINESS_CATEGORIES" (
    "ISN"         NUMBER(2)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 99 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE
        NOT NULL ENABLE,
    "CODE"        VARCHAR2(4)
        NOT NULL ENABLE,
    "DESCRIPTION" NVARCHAR2(30)
        NOT NULL ENABLE,
    CONSTRAINT "BUCA_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "BUCA_PK" ON
                "BUSINESS_CATEGORIES" (
                    "ISN"
                )
        )
    ENABLE,
    CONSTRAINT "BUCA_UK1" UNIQUE ( "CODE" )
        USING INDEX (
            CREATE UNIQUE INDEX "BUCA_UK1" ON
                "BUSINESS_CATEGORIES" (
                    "CODE"
                )
        )
    ENABLE
);
/

COMMENT ON COLUMN business_categories.code IS
    'The unique identifier for the BUSINESS_CATEGORIES in VARCHAR2';

COMMENT ON COLUMN business_categories.description IS
    'DESCRIBING CATEGORIES OF THE BUSINESSES LIKE IT, MANUFACTURING, FINANCE, ETC';
    
    --------------------------------------------------------------------

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE BUSINESSES CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "BUSINESSES" (
    "ISN"                   NUMBER(16, 0)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP
        NOSCALE
        NOT NULL ENABLE,
    "GSTIN"                 NVARCHAR2(15)
        NOT NULL ENABLE,
    "PAN_ID"                NVARCHAR2(10)
        NOT NULL ENABLE,
    "NAME"                  NVARCHAR2(200),
    "BUSINESS_TYPE_ISN"     NUMBER(2)
        NOT NULL ENABLE,
    "BUSINESS_CATEGORY_ISN" NUMBER(3)
        NOT NULL ENABLE,
    "PASSWORD_HASH"         VARCHAR2(100)
        NOT NULL ENABLE,
    "SALT"                  VARCHAR2(20)
        NOT NULL ENABLE,
    "REGISTRATION_DATE"     DATE
        NOT NULL ENABLE,
    CONSTRAINT "BUSI_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "BUSI_PK" ON
                "BUSINESSES" (
                    "ISN"
                )
        )
    ENABLE,
    CONSTRAINT "BUSI_UK1" UNIQUE ( "GSTIN" )
        USING INDEX (
            CREATE UNIQUE INDEX "BUSI_UK1" ON
                "BUSINESSES" (
                    "GSTIN"
                )
        )
    ENABLE,
    CONSTRAINT "BUSI_UK2" UNIQUE ( "PAN_ID" )
        USING INDEX (
            CREATE UNIQUE INDEX "BUSI_UK2" ON
                "BUSINESSES" (
                    "PAN_ID"
                )
        )
    ENABLE
);
/

COMMENT ON COLUMN businesses.gstin IS
    'UNIQUE IDENTIFIER FOR GST REGISTRATION';

COMMENT ON COLUMN businesses.pan_id IS
    'UNIQUE IDENTIFIER/ERMANANT ACCOUNT NUMBER FOR BUSINESS PAN REGISTRATION';

COMMENT ON COLUMN businesses.business_type_isn IS
    'COMING ISN FROM BUSINESSES_TYPES WHICH PROVIDING TYPE OF THE BUSINESSES LIKE MICRO,SMALL,,MEDIUM';

COMMENT ON COLUMN businesses.business_category_isn IS
    'COMING ISN FROM BUSINESSES_CATEGORIES WHICH PROVIDING CATEGORIES OF THE BUSINESSES LIKE IT,MANUFACTURING,FINANCE AND BANKING, ETC'
    ;

COMMENT ON COLUMN businesses.password_hash IS
    'ITS A HASH  FOR PASSWORD';

COMMENT ON COLUMN businesses.registration_date IS
    'DATE ON WHICH BUSINESS IS REGISTERED ON PLATFORM';
         --------------------------------------------------------------

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CONTACTS CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "CONTACTS" (
    "ISN"              NUMBER(16)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP
        NOSCALE
        NOT NULL ENABLE,
    "BUSINESS_ISN"     NUMBER(16, 0),
    "CONTACT_TYPE_ISN" NUMBER(2)
        NOT NULL ENABLE,
    "CONTACT_VALUE"    NVARCHAR2(100)
        NOT NULL ENABLE,
    CONSTRAINT "CONT_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "CONT_PK" ON
                "CONTACTS" (
                    "ISN"
                )
        )
    ENABLE
);
/

COMMENT ON COLUMN contacts.business_isn IS
    'ISN COMING FROM BUSINESSES';

COMMENT ON COLUMN contacts.contact_type_isn IS
    'COMING ISN FROM CONTACT_TYPES TABLE WHICH PROVIDES ISN FOR PERTICULAR CONTACT_TYPE
    LIKE MOBILE_PHONE,PERSONAL_EMAIL,ETC';

COMMENT ON COLUMN contacts.contact_value IS
    'VALUES FOR DIFFERANT CONTACT TYPES STORED IN ONE FIELD ONLY';
--------------------------------------------------------------

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ADDRESSES CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "ADDRESSES" (
    "ISN"          NUMBER(16)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP
        NOSCALE
        NOT NULL ENABLE,
    "BUSINESS_ISN" NUMBER(16, 0),
    "ADDRESS1"     NVARCHAR2(200)
        NOT NULL ENABLE,
    "ADDRESS2"     NVARCHAR2(200),
    "ADDRESS3"     NVARCHAR2(135),
    "CITY_ISN"     NUMBER
        NOT NULL ENABLE,
    "ZIPCODE"      VARCHAR2(10 CHAR),
    CONSTRAINT "ADDR_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "ADDR_PK" ON
                "ADDRESSES" (
                    "ISN"
                )
        )
    ENABLE
);
/

COMMENT ON COLUMN addresses.address1 IS
    'NOT NULL FIELD WHICH INCLUDES FIRST LINE OF ADDRESS';

COMMENT ON COLUMN addresses.city_isn IS
    'CITY_ISN WHICH IS COMING FROM CITIES TABLE ACCORDING TO PERTICULAR CITY';
     --------------------------------------------------------------
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE BANK_ACCOUNTS CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "BANK_ACCOUNTS" (
    "ISN"            NUMBER(6)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE
        NOT NULL ENABLE,
    "BUSINESS_ISN"   NUMBER(16, 0)
        NOT NULL ENABLE,
    "ACCOUNT_NAME"   NVARCHAR2(50)
        NOT NULL ENABLE,
    "ACCOUNT_NUMBER" NUMBER(18)
        NOT NULL ENABLE,
    "IFSC"           NVARCHAR2(11)
        NOT NULL ENABLE,
    CONSTRAINT "BAAC_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "BAAC_PK" ON
                "BANK_ACCOUNTS" (
                    "ISN"
                )
        )
    ENABLE,
    CONSTRAINT "BAAC_UK1" UNIQUE ( "ACCOUNT_NUMBER" )
        USING INDEX (
            CREATE UNIQUE INDEX "BAAC_UK1" ON
                "BANK_ACCOUNTS" (
                    "ACCOUNT_NUMBER"
                )
        )
    ENABLE
);
/

COMMENT ON TABLE bank_accounts IS
    'BANK_ACCOUNTS Table for BANK ACCOUNTS Details OF BUSINESSES';

COMMENT ON COLUMN bank_accounts.isn IS
    'The unique identifier for the BANK_ACCOUNTS';

COMMENT ON COLUMN bank_accounts.business_isn IS
    'The BUSINESS COMING FROM BUSINESSES TABLE';

COMMENT ON COLUMN bank_accounts.account_name IS
    'NAME OF THE ACCOUNT HOLDER IT COULD BE BUSINESS_NAME OR PERSON NAME ';

COMMENT ON COLUMN bank_accounts.account_number IS
    'UNIQUE IDENTIFICATION NUMBER FOR EACH ACCOUNT ';

COMMENT ON COLUMN bank_accounts.ifsc IS
    'THE INDIAN FINANCIAL SYSTEM CODE (IFSC) IS A UNIQUE ALPHANUMERIC CODE USED TO IDENTIFY SPECIFIC BANK BRANCHES FOR ELECTRONIC FUND TRANSFERS AND OTHER FINANCIAL TRANSACTIONS WITHIN INDIA'
    ;
-----------------------------------------------------------------------------------------------------------------------------

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE DOCUMENTS CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "DOCUMENTS" (
    "ISN"             NUMBER(16, 0)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP
        NOSCALE
        NOT NULL ENABLE,
    "BUSINESS_ISN"    NUMBER(16, 0)
        NOT NULL ENABLE,
    "GSTIN"           BLOB,
    "MIMETYPE"        VARCHAR2(50),
    "FILENAME"        VARCHAR2(200),
    "CHARSET"         VARCHAR2(200),
    "CREATED_DATE"    DATE,
    "SHOP_ACT"        BLOB,
    "MIMETYPE_SA"     VARCHAR2(50),
    "FILENAME_SA"     VARCHAR2(200),
    "CHARSET_SA"      VARCHAR2(200),
    "CREATED_DATE_SA" DATE,
    CONSTRAINT "DOCU_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "DOCU_PK" ON
                "DOCUMENTS" (
                    "ISN"
                )
        )
    ENABLE
);
/

COMMENT ON TABLE documents IS
    'STORING DOCUMENTS ACCORDING TO PRODUCTS UPLOADED BY CUSTOMERS';

COMMENT ON COLUMN documents.gstin IS
    'GSTIN STORING IN BLOB TYPE AND OTHER SOME COLUMNS NAMELY MIMTYPE, FILENAME, CHARSET, CREATEDDATE ARE THE SUPPORTING COLUMNS FOR IMAGE( BLOB ) TYPE COLUMN'
    ;

COMMENT ON COLUMN documents.shop_act IS
    'SHOP_ACT STORING IN BLOB TYPE';
    -----------------------------------------------------------

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PRODUCT_CATEGORIES CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "PRODUCT_CATEGORIES" (
    "ISN"         NUMBER(2)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 99 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE
        NOT NULL ENABLE,
    "CODE"        VARCHAR2(4)
        NOT NULL ENABLE,
    "DESCRIPTION" NVARCHAR2(50)
        NOT NULL ENABLE,
    CONSTRAINT "PRCA_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "PRCA_PK" ON
                "PRODUCT_CATEGORIES" (
                    "ISN"
                )
        )
    ENABLE,
    CONSTRAINT "PRODUCT_CATEGORIES_UK1" UNIQUE ( "CODE" )
        USING INDEX (
            CREATE UNIQUE INDEX "PRODUCT_CATEGORIES_UK1" ON
                "PRODUCT_CATEGORIES" (
                    "CODE"
                )
        )
    ENABLE
);
/

COMMENT ON COLUMN product_categories.code IS
    'The unique identifier for the PRODUCT_CATEGORIES in VARCHAR2';

COMMENT ON COLUMN product_categories.description IS
    'DESCRIBING VARIOUS PRODUCT CATEGORIES OF THE PRODUCTS LIKE HEALTH AND BEUTY, CHEMICAL, ELECTRONICS, ETC';

     --------------------------------------------------------------------------------------------------------

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE UNITS CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "UNITS" (
    "ISN"         NUMBER(2)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 99 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE
        NOT NULL ENABLE,
    "CODE"        VARCHAR2(4)
        NOT NULL ENABLE,
    "DESCRIPTION" NVARCHAR2(20)
        NOT NULL ENABLE,
    CONSTRAINT "UNITS_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "UNITS_PK" ON
                "UNITS" (
                    "ISN"
                )
        )
    ENABLE,
    CONSTRAINT "UNITS_UK1" UNIQUE ( "CODE" )
        USING INDEX (
            CREATE UNIQUE INDEX "UNITS_UK1" ON
                "UNITS" (
                    "CODE"
                )
        )
    ENABLE
);
/

COMMENT ON COLUMN units.code IS
    'The unique identifier for the UNITS in VARCHAR2';

COMMENT ON COLUMN units.description IS
    'DESCRIBING VARIOUS UNITS OF THE PRODUCTS LIKE KG,PIECE,LITRE, ETC';
    ---------------------------------------------------------------------------------

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PRODUCTS CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "PRODUCTS" (
    "ISN"                  NUMBER(16, 0)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP
        NOSCALE
        NOT NULL ENABLE,
    "BUSINESS_ISN"         NUMBER(16, 0)
        NOT NULL ENABLE,
    "PRODUCT_NAME"         NVARCHAR2(50)
        NOT NULL ENABLE,
    "PRODUCT_CATEGORY_ISN" NUMBER(16)
        NOT NULL ENABLE,
    "DESCRIPTION"          NVARCHAR2(200),
    "UNIT_ISN"             NUMBER(2)
        NOT NULL ENABLE,
    "UNIT_PRICE"           NUMBER(10)
        NOT NULL ENABLE,
    CONSTRAINT "PROD_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "PROD_PK" ON
                "PRODUCTS" (
                    "ISN"
                )
        )
    ENABLE
);
/

COMMENT ON TABLE products IS
    'PRODUCTS Table for PRODUCTS Details';

COMMENT ON COLUMN products.isn IS
    'The unique identifier for the PRODUCTS';

COMMENT ON COLUMN products.business_isn IS
    'The unique BUSINESS identifier FROM BUSINESSES';

COMMENT ON COLUMN products.product_name IS
    'NAME FOR THE PRODUCT';

COMMENT ON COLUMN products.product_category_isn IS
    'ISN FROM PRODUCT_CATEGORIES LIKE HEALTH AND BEAUTY,CHEMICALS,ELECTRONICS, ETC ';

COMMENT ON COLUMN products.description IS
    'SHORT DETAILS FOR THE PRODUCT';

COMMENT ON COLUMN products.unit_price IS
    'UNITS FOR THE PRODUCT LIKE KG, LITRE, PIECE, ETC';
    -----------------------------------------------------------------------

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PRODUCT_COLATERALS CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "PRODUCT_COLATERALS" (
    "ISN"          NUMBER(16, 0)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP
        NOSCALE
        NOT NULL ENABLE,
    "PRODUCT_ISN"  NUMBER(16, 0)
        NOT NULL ENABLE,
    "IMAGE"        BLOB,
    "MIMETYPE"     VARCHAR2(50),
    "FILENAME"     VARCHAR2(200),
    "CHARSET"      VARCHAR2(200),
    "CREATED_DATE" DATE,
    "WEIGHT"       NUMBER(10),
    "COLOUR"       NVARCHAR2(50),
    CONSTRAINT "PRCO_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "PRCO_PK" ON
                "PRODUCT_COLATERALS" (
                    "ISN"
                )
        )
    ENABLE
);
/

COMMENT ON TABLE product_colaterals IS
    'PRODUCT_COLATERALS Table for PRODUCT_COLATERALS Details';

COMMENT ON COLUMN product_colaterals.isn IS
    'The unique identifier for the PRODUCT_COLATERALS';

COMMENT ON COLUMN product_colaterals.product_isn IS
    'The unique PRODUCT identifier FROM PRODUCTS';

COMMENT ON COLUMN product_colaterals.image IS
    'IMAGE FOR THE PRODUCT AND OTHER SOME COLUMNS NAMELY MIMTYPE, FILENAME, CHARSET, CREATEDDATE ARE THE SUPPORTING COLUMNS FOR IMAGE( BLOB ) TYPE COLUMN'
    ;

COMMENT ON COLUMN product_colaterals.weight IS
    'WEIGHT FOR THE PRODUCT PACKING ';

COMMENT ON COLUMN product_colaterals.colour IS
    'COLOUR OF THE PRODUCT';
    ----------------------------------------------------------------------------------

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE INVENTORY CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "INVENTORY" (
    "ISN"                NUMBER(5)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 99 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE
        NOT NULL ENABLE,
    "PRODUCT_ISN"        NUMBER(16)
        NOT NULL ENABLE,
    "AVAILABLE_QUANTITY" NUMBER(16),
    CONSTRAINT "INVENTORY_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "INVENTORY_PK" ON
                "INVENTORY" (
                    "ISN"
                )
        )
    ENABLE
);
/

COMMENT ON COLUMN inventory.product_isn IS
    'ID COME FROM PRODUCTS TABLE';

COMMENT ON COLUMN inventory.available_quantity IS
    'AVAILABLE QUANTITY IN STOCK FOR PERTICULAR PRODUCT';
    --------------------------------------------------------------------

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PAYMENT_MODES CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "PAYMENT_MODES" (
    "ISN"         NUMBER(2)
        GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 99 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE
        NOT NULL ENABLE,
    "CODE"        VARCHAR2(4)
        NOT NULL ENABLE,
    "DESCRIPTION" NVARCHAR2(20)
        NOT NULL ENABLE,
    CONSTRAINT "PAMO_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "PAMO_PK" ON
                "PAYMENT_MODES" (
                    "ISN"
                )
        )
    ENABLE,
    CONSTRAINT "PAMO_UK1" UNIQUE ( "CODE" )
        USING INDEX (
            CREATE UNIQUE INDEX "PAMO_UK1" ON
                "PAYMENT_MODES" (
                    "CODE"
                )
        )
    ENABLE
);
/

COMMENT ON COLUMN payment_modes.code IS
    'The unique identifier for the PAYMENT_MODES in VARCHAR2';

COMMENT ON COLUMN payment_modes.description IS
    'DESCRIBING VARIOUS PAYMENT_MODES OF THE PRODUCTS LIKE ONLINE, RTGS, CASH, CHEQUE, ETC';
    ------------------------------------------------------------------------------------------

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ORDERS CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "ORDERS" (
    "ISN"              NUMBER(10),
    "ORDER_DATE"       DATE
        NOT NULL ENABLE,
    "BUYER"            NUMBER(16)
        NOT NULL ENABLE,
    "SELLER"           NUMBER(16)
        NOT NULL ENABLE,
    "PRODUCT_ISN"      NUMBER(16)
        NOT NULL ENABLE,
    "QUANTITY"         NUMBER(10)
        NOT NULL ENABLE,
    "AMOUNT"           NUMBER(10),
    "DISCOUNT"         NUMBER(3),
    "TAX"              NUMBER(3),
    "TOTAL_AMOUNT"     NUMBER(10),
    "PAYMENT_MODE_ISN" NUMBER(2),
    "STATUS"           NVARCHAR2(20),
    CONSTRAINT "ORDERS_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "ORDERS_PK" ON
                "ORDERS" (
                    "ISN"
                )
        )
    ENABLE
);
/

COMMENT ON COLUMN orders.isn IS
    'NOT AUTO GENERATED ID, IT WILL CREATE AFTER SOME PROCESS';

COMMENT ON COLUMN orders.buyer IS
    'BUSINESS_ISN COMES FROM BUSINESSES TABLE AS BUYER';

COMMENT ON COLUMN orders.seller IS
    'BUSINESS_ISN COMES FROM BUSINESSES TABLE AS SELLER';

COMMENT ON COLUMN orders.product_isn IS
    'PRODUCT_ISN COMES FROM PRODUCTS TABLE AS SELLER';
    ------------------------------------------------------------
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE INVOICES CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE "INVOICES" (
    "ISN"          NUMBER(2)
        NOT NULL ENABLE,
    "INVOICE_DATE" DATE
        NOT NULL ENABLE,
    "ORDER_ISN"    NUMBER(10)
        NOT NULL ENABLE,
    CONSTRAINT "INVOICE_PK" PRIMARY KEY ( "ISN" )
        USING INDEX (
            CREATE UNIQUE INDEX "INVOICE_PK" ON
                "INVOICES" (
                    "ISN"
                )
        )
    ENABLE
);
/

COMMENT ON COLUMN invoices.isn IS
    'The unique identifier for the INVOICES WHICH IS NOT AUTO GENERATED';

COMMENT ON COLUMN invoices.order_isn IS
    'ORDER ISN COMING FROM ORDERS';
   
  -----------------Map Foreign Keys-------------------------

ALTER TABLE "STATES"
    ADD CONSTRAINT "STAT_COUN_FK" FOREIGN KEY ( "COUNTRY_ISN" )
        REFERENCES "COUNTRIES" ( "ISN" )
    ENABLE
/

ALTER TABLE "CITIES"
    ADD CONSTRAINT "CITI_STAT_FK" FOREIGN KEY ( "STATE_ISN" )
        REFERENCES "STATES" ( "ISN" )
    ENABLE
/

ALTER TABLE "BUSINESSES"
    ADD CONSTRAINT "BUSI_BUTY_FK" FOREIGN KEY ( "BUSINESS_TYPE_ISN" )
        REFERENCES "BUSINESS_TYPES" ( "ISN" )
    ENABLE
/

ALTER TABLE "BUSINESSES"
    ADD CONSTRAINT "BUSI_BUCA_FK" FOREIGN KEY ( "BUSINESS_CATEGORY_ISN" )
        REFERENCES "BUSINESS_CATEGORIES" ( "ISN" )
    ENABLE
/

ALTER TABLE "CONTACTS"
    ADD CONSTRAINT "CONT_BUSY" FOREIGN KEY ( "BUSINESS_ISN" )
        REFERENCES "BUSINESSES" ( "ISN" )
    ENABLE
/

ALTER TABLE "CONTACTS"
    ADD CONSTRAINT "CONT_COTY" FOREIGN KEY ( "CONTACT_TYPE_ISN" )
        REFERENCES "CONTACT_TYPES" ( "ISN" )
    ENABLE
/

ALTER TABLE "ADDRESSES"
    ADD CONSTRAINT "ADDR_BUSI_FK" FOREIGN KEY ( "BUSINESS_ISN" )
        REFERENCES "BUSINESSES" ( "ISN" )
    ENABLE
/

ALTER TABLE "ADDRESSES"
    ADD CONSTRAINT "ADDR_CITI_FK" FOREIGN KEY ( "CITY_ISN" )
        REFERENCES "CITIES" ( "ISN" )
    ENABLE
/

ALTER TABLE "BANK_ACCOUNTS"
    ADD CONSTRAINT "BAAC_BUSI_FK" FOREIGN KEY ( "BUSINESS_ISN" )
        REFERENCES "BUSINESSES" ( "ISN" )
    ENABLE
/

ALTER TABLE "DOCUMENTS"
    ADD CONSTRAINT "DOCU_BUSI_FK" FOREIGN KEY ( "BUSINESS_ISN" )
        REFERENCES "BUSINESSES" ( "ISN" )
    ENABLE
/

ALTER TABLE "PRODUCTS"
    ADD CONSTRAINT "PROD_BUSI_FK" FOREIGN KEY ( "BUSINESS_ISN" )
        REFERENCES "BUSINESSES" ( "ISN" )
    ENABLE
/

ALTER TABLE "PRODUCTS"
    ADD CONSTRAINT "PROD_PRCA_FK" FOREIGN KEY ( "PRODUCT_CATEGORY_ISN" )
        REFERENCES "PRODUCT_CATEGORIES" ( "ISN" )
    ENABLE
/

ALTER TABLE "PRODUCTS"
    ADD CONSTRAINT "PROD_UNI_FK" FOREIGN KEY ( "UNIT_ISN" )
        REFERENCES "UNITS" ( "ISN" )
    ENABLE
/

ALTER TABLE "PRODUCT_COLATERALS"
    ADD CONSTRAINT "PRCO_PROD_FK" FOREIGN KEY ( "PRODUCT_ISN" )
        REFERENCES "PRODUCTS" ( "ISN" )
    ENABLE
/

ALTER TABLE "INVENTORY"
    ADD CONSTRAINT "INVE_PROD_FK" FOREIGN KEY ( "PRODUCT_ISN" )
        REFERENCES "PRODUCTS" ( "ISN" )
    ENABLE
/

ALTER TABLE "ORDERS"
    ADD CONSTRAINT "ORDE_BUSI_FKB" FOREIGN KEY ( "BUYER" )
        REFERENCES "BUSINESSES" ( "ISN" )
    ENABLE
/

ALTER TABLE "ORDERS"
    ADD CONSTRAINT "ORDE_BUSI_FKS" FOREIGN KEY ( "SELLER" )
        REFERENCES "BUSINESSES" ( "ISN" )
    ENABLE
/

ALTER TABLE "ORDERS"
    ADD CONSTRAINT "ORDE_PROD_FK" FOREIGN KEY ( "PRODUCT_ISN" )
        REFERENCES "PRODUCTS" ( "ISN" )
    ENABLE
/

ALTER TABLE "ORDERS"
    ADD CONSTRAINT "ORDE_PAMO_FK" FOREIGN KEY ( "PAYMENT_MODE_ISN" )
        REFERENCES "PAYMENT_MODES" ( "ISN" )
    ENABLE
/

ALTER TABLE "INVOICES"
    ADD CONSTRAINT "INVO_ORDE_FK" FOREIGN KEY ( "ORDER_ISN" )
        REFERENCES "ORDERS" ( "ISN" )
    ENABLE
/
 ----------------------------------------------------------------------------------------------------
    Commit;
-----------------------------------------------------------------------------
    --- File created - MONDAY-OCTOBER-16-2023   ---
   /* --------------------------------------------------------*/
   
    REM INSERTING into COUNTRIES
    SET DEFINE OFF;
    Insert into COUNTRIES (NAME,TWO_CHAR_CODE,THREE_CHAR_CODE,NUMERIC_CODE) values ('India','IN','IND','091');

    --------------------------------------------------------
    --  File created - MONDAY-OCTOBER-16-2023   
    --------------------------------------------------------
    REM INSERTING into STATES
    SET DEFINE OFF;
    Insert into STATES (CODE,NAME,COUNTRY_ISN) values ('MH','Maharashtra',1);
    Insert into STATES (CODE,NAME,COUNTRY_ISN) values ('TN','Tamil Nadu',1);
    Insert into STATES (CODE,NAME,COUNTRY_ISN) values ('KA','Karnataka',1);
    Insert into STATES (CODE,NAME,COUNTRY_ISN) values ('GO','Goa',1);

    --------------------------------------------------------
    --  File created - MONDAY-OCTOBER-16-2023   
    --------------------------------------------------------
    REM INSERTING into CITIES
    SET DEFINE OFF;
    Insert into CITIES (CODE,NAME,STATE_ISN) values ('PU','Pune',1);
    Insert into CITIES (CODE,NAME,STATE_ISN) values ('MU','Mumbai',1);
    Insert into CITIES (CODE,NAME,STATE_ISN) values ('BG','Bangalore',3);
    Insert into CITIES (CODE,NAME,STATE_ISN) values ('PN','Panaji',4);
    --------------------------------------------------------
    --  File created - MONDAY-OCTOBER-16-2023   
    --------------------------------------------------------
    REM INSERTING into CONTACT_TYPES
    SET DEFINE OFF;
    Insert into CONTACT_TYPES (CODE,DESCRIPTION) values ('MOB','Mobile Phone');
    Insert into CONTACT_TYPES (CODE,DESCRIPTION) values ('WHAT','Whatsapp number');
    Insert into CONTACT_TYPES (CODE,DESCRIPTION) values ('CELL','Cellphone number');
    Insert into CONTACT_TYPES (CODE,DESCRIPTION) values ('OEMA','Official Email ID');
    
          --------------------------------------------------------
    -- File created - MONDAY-OCTOBER-16-2023 
    --------------------------------------------------------
    REM INSERTING into BUSINESS_TYPES
    SET DEFINE OFF;
    Insert into BUSINESS_TYPES (CODE,DESCRIPTION) values ('001','Micro');
    Insert into BUSINESS_TYPES (CODE,DESCRIPTION) values ('002','Small');
    Insert into BUSINESS_TYPES (CODE,DESCRIPTION) values ('003','Medium'); 
      --------------------------------------------------------
    -- File created - MONDAY-OCTOBER-16-2023 
    --------------------------------------------------------

    REM INSERTING into BUSINESS_CATEGORIES
    SET DEFINE OFF;
    Insert into BUSINESS_CATEGORIES (CODE,DESCRIPTION) values ('001','IT');
    Insert into BUSINESS_CATEGORIES (CODE,DESCRIPTION) values ('002','Manufacturing');
    Insert into BUSINESS_CATEGORIES (CODE,DESCRIPTION) values ('003','Retail and Cosumer Goods');
    Insert into BUSINESS_CATEGORIES (CODE,DESCRIPTION) values ('004','Finance and Banking');
    Insert into BUSINESS_CATEGORIES (CODE,DESCRIPTION) values ('005','Telecommunications');

        --------------------------------------------------------
    -- File created - MONDAY-OCTOBER-16-2023 
    --------------------------------------------------------
    REM INSERTING into PRODUCT_CATEGORIES
    SET DEFINE OFF;
    Insert into PRODUCT_CATEGORIES (CODE,DESCRIPTION) values ('001','Health and Beuty');
    Insert into PRODUCT_CATEGORIES (CODE,DESCRIPTION) values ('002','Entertainment');
    Insert into PRODUCT_CATEGORIES (CODE,DESCRIPTION) values ('003','Chemical');
    Insert into PRODUCT_CATEGORIES (CODE,DESCRIPTION) values ('004','Machinery');
    Insert into PRODUCT_CATEGORIES (CODE,DESCRIPTION) values ('005','Electronics');
    
      --------------------------------------------------------
    -- File created - MONDAY-OCTOBER-16-2023 
    --------------------------------------------------------
    REM INSERTING into UNITS
    SET DEFINE OFF;
    Insert into UNITS (CODE,DESCRIPTION) values ('001','KG');
    Insert into UNITS (CODE,DESCRIPTION) values ('002','LTR');
    Insert into UNITS (CODE,DESCRIPTION) values ('003','PIECE');
    Insert into UNITS (CODE,DESCRIPTION) values ('004','BOX');
          --------------------------------------------------------
    -- File created - MONDAY-OCTOBER-16-2023 
    --------------------------------------------------------
    REM INSERTING into PAYMENT_MODES
    SET DEFINE OFF;
    Insert into PAYMENT_MODES (CODE,DESCRIPTION) values ('001','ONLINE');
    Insert into PAYMENT_MODES (CODE,DESCRIPTION) values ('002','COD');
    Insert into PAYMENT_MODES (CODE,DESCRIPTION) values ('003','CASH');
    Insert into PAYMENT_MODES (CODE,DESCRIPTION) values ('004','CARDS');
    Insert into PAYMENT_MODES (CODE,DESCRIPTION) values ('005','CHEQUE');
    
 /*--------LOGIC BUILDING-----*/
 
 /* 1) BUSINESS_ONBOARDING----*/
 
    
