-- Initialization Script to Create and Use the Database
USE master;
DROP DATABASE ebay_db;
CREATE DATABASE ebay_db;
USE ebay_db;

-- Create Address Table
CREATE TABLE Address (
    ADDRESS_ID INT NOT NULL PRIMARY KEY,
    STREET VARCHAR(255) NOT NULL,
    CITY VARCHAR(255) NOT NULL,
    STATE VARCHAR(255) NOT NULL,
    ZIP_CODE VARCHAR(20) NOT NULL,
    COUNTRY VARCHAR(255) NOT NULL
);

-- Create Customer Table
CREATE TABLE Customer (
    CUSTOMER_ID INT NOT NULL PRIMARY KEY,
    USERNAME VARCHAR(255) NOT NULL,
    PASSWORD VARCHAR(255) NOT NULL,
    FIRST_NAME VARCHAR(255) NOT NULL,
    LAST_NAME VARCHAR(255) NOT NULL,
    EMAIL VARCHAR(255),
    PHONE VARCHAR(20),
    ADDRESS_ID INT NOT NULL,
    FOREIGN KEY (ADDRESS_ID) REFERENCES Address(ADDRESS_ID)
);

-- Create Category Table
CREATE TABLE Category (
    CATEGORY_ID INT NOT NULL PRIMARY KEY,
    NAME VARCHAR(255) NOT NULL,
    DESCRIPTION TEXT NOT NULL
);

-- Create Product Table
CREATE TABLE Product (
    PRODUCT_ID INT NOT NULL PRIMARY KEY,
    NAME VARCHAR(255) NOT NULL,
    DESCRIPTION TEXT NOT NULL,
    PRICE DECIMAL(10,2) NOT NULL,
    STOCK INT NOT NULL,
    CATEGORY_ID INT NOT NULL,
    CREATED_AT DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CATEGORY_ID) REFERENCES Category(CATEGORY_ID)
);

-- Create Product Review Table
CREATE TABLE ProductReview (
    REVIEW_ID INT NOT NULL PRIMARY KEY,
    CUSTOMER_ID INT NOT NULL,
    PRODUCT_ID INT NOT NULL,
    RATING INT NOT NULL,
    REVIEW_DATE TIMESTAMP NOT NULL,
    REVIEW_TEXT TEXT NOT NULL,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES Customer(CUSTOMER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES Product(PRODUCT_ID)
);

-- Create Order Info Table
CREATE TABLE OrderInfo (
    ORDER_ID INT NOT NULL PRIMARY KEY,
    CUSTOMER_ID INT NOT NULL,
    ORDER_DATE DATETIME NOT NULL,
    STATUS VARCHAR(50) NOT NULL,
    TOTAL_AMOUNT DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES Customer(CUSTOMER_ID)
);

-- Create Order Item Table
CREATE TABLE OrderItem (
    ORDER_ITEM_ID INT NOT NULL PRIMARY KEY,
    ORDER_ID INT NOT NULL,
    PRODUCT_ID INT NOT NULL,
    UNIT_PRICE DECIMAL(10,2) NOT NULL,
    QUANTITY INT NOT NULL,
    TOTAL_PRICE DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ORDER_ID) REFERENCES OrderInfo(ORDER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES Product(PRODUCT_ID)
);

-- Create Payment Table
CREATE TABLE Payment (
    PAYMENT_ID INT NOT NULL PRIMARY KEY,
    ORDER_ID INT NOT NULL,
    METHOD VARCHAR(50) NOT NULL,
    TOTAL_AMOUNT DECIMAL(10,2) NOT NULL,
    DATE DATETIME NOT NULL,
    FOREIGN KEY (ORDER_ID) REFERENCES OrderInfo(ORDER_ID)
);