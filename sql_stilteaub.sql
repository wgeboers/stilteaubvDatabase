-- DDL database StilteAUB
-- DROP TABLE nodig?
-- Users Country nodig?

DROP DATABASE IF EXISTS `stilteaubbv`;
CREATE DATABASE `stilteaubbv`;

USE `stilteaubbv`;

CREATE TABLE `employees` (
	`EmployeeID` INT NOT NULL AUTO_INCREMENT,
	`First_Name` VARCHAR(25) NOT NULL,
	`Middle_Name` VARCHAR(25) DEFAULT NULL,
	`Last_Name` VARCHAR(25) NOT NULL,
	`Email` VARCHAR(50) NOT NULL,
	`Password` VARCHAR(25) NOT NULL,
	`Creation_Date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`Created_By` INT DEFAULT NULL,
	`Last_Active` DATETIME DEFAULT NULL,
	`ACTIVE` TINYINT NOT NULL DEFAULT 1,
	CONSTRAINT `EmployeesPK`
		PRIMARY KEY (`EmployeeID`),
	CONSTRAINT `EmployeeFK`
		FOREIGN KEY (`Created_By`)
		REFERENCES `employees` (`EmployeeID`) ON DELETE SET NULL
);

CREATE TABLE `roles` (
	`RoleID` INT NOT NULL AUTO_INCREMENT,
	`Name` VARCHAR(50) NOT NULL,
	`Description` VARCHAR(255) DEFAULT NULL,
	`Creation_Date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`Created_By` INT DEFAULT NULL,
	CONSTRAINT `RolesPK`
		PRIMARY KEY (`RoleID`),
	CONSTRAINT `RolesFK`
		FOREIGN KEY (`Created_By`)
		REFERENCES `employees` (`EmployeeID`) ON DELETE SET NULL
	);
	

CREATE TABLE `employee-roles` (
	`TableID` INT NOT NULL AUTO_INCREMENT,
	`EmployeeID` INT NOT NULL,
	`RoleID` INT NOT NULL,
	CONSTRAINT `Employee-rolesPK`
		PRIMARY KEY (`TableID`),
	CONSTRAINT `Employee-rolesFK1`
		FOREIGN KEY (`EmployeeID`)
		REFERENCES `employees` (`EmployeeID`) ON DELETE CASCADE,
	CONSTRAINT `Employee-rolesFK2`
		FOREIGN KEY (`RoleID`)
		REFERENCES `roles` (`RoleID`) ON DELETE CASCADE
);

CREATE TABLE `products` (
	`ProductID` INT NOT NULL AUTO_INCREMENT,
	`Name` VARCHAR(50) NOT NULL,
	`Description` VARCHAR(255) NULL,
	`Stock` INT NOT NULL,
	`Price` DECIMAL(65,2) NOT NULL,
	`Creation_Date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`Created_By` INT DEFAULT NULL,
	CONSTRAINT `ProductsPK`
		PRIMARY KEY (`ProductID`),		
	CONSTRAINT `ProductsFK`
		FOREIGN KEY (`Created_By`)
		REFERENCES `employees` (`EmployeeID`) ON DELETE SET NULL
);

CREATE TABLE `productlogs` (
	`LogID` INT NOT NULL AUTO_INCREMENT,
	`ProductID` INT NOT NULL,
	`Modified_Date` DATETIME NOT NULL,
	`Modified_By` INT NULL,
	`Name` VARCHAR(50) DEFAULT NULL,
	`Description` VARCHAR(255) DEFAULT NULL,
	`Stock` INT NULL,
	`Price` DECIMAL(55,2) DEFAULT NULL,
	CONSTRAINT `ProductlogsPK`
		PRIMARY KEY (`LogID`),
	CONSTRAINT `ProductFK`
		FOREIGN KEY (`ProductID`)
		REFERENCES `products` (`ProductID`) ON DELETE CASCADE,
	CONSTRAINT `EmployeesFK` 
		FOREIGN KEY (`Modified_By`)
		REFERENCES `employees` (`EmployeeID`) ON DELETE SET NULL
);

CREATE TABLE `users` (
	`UserID` INT NOT NULL AUTO_INCREMENT,
	`First_Name` VARCHAR(25) NOT NULL,
	`Middle_Name` VARCHAR(25) DEFAULT NULL,
	`Last_Name` VARCHAR(25) NOT NULL,
	`Email` VARCHAR(50) DEFAULT NULL,
	`Phone_Number` VARCHAR(20) DEFAULT NULL,
	`Password` VARCHAR(25) NOT NULL,
	`Street` VARCHAR(100) DEFAULT NULL,
	`House_Number`INT DEFAULT NULL,
	`House_Number_Addition` VARCHAR(25) DEFAULT NULL,
	`Zipcode` VARCHAR(10) DEFAULT NULL,
	`City` VARCHAR(50) DEFAULT NULL,
	`Creation_Date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT `UserID`
		PRIMARY KEY (`UserID`)
);

CREATE TABLE `orderheaders` (
	`HeaderID` INT NOT NULL,
	`Order_By` INT DEFAULT NULL,
	`Total_Price` DECIMAL(65,2) NOT NULL,
	`Deliver_Adres` VARCHAR(255) NOT NULL,
	`Deliver_Zipcode` VARCHAR(10) NOT NULL,
	`Deliver_City` VARCHAR(50) NOT NULL,
	`Creation_Date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`Finished_Date` DATETIME DEFAULT NULL,
	`Status` VARCHAR(25) NOT NULL,
	CONSTRAINT `OrderheadersPK`
		PRIMARY KEY (`HeaderID`),
	CONSTRAINT `UsersFK`
		FOREIGN KEY (`Order_By`)
		REFERENCES `users` (`UserID`) ON DELETE SET NULL
);

CREATE TABLE `orderlines` (
	`LineID` INT NOT NULL,
	`HeaderID` INT NOT NULL,
	`ProductID` INT DEFAULT NULL,
	`Name` VARCHAR(50) NOT NULL,
	`Description` VARCHAR(255) DEFAULT NULL,
	`Amount` INT NOT NULL,
	`Price_PerUnit` DECIMAL(65,2) NOT NULL,
	`Total_Price` DECIMAL(65,2) NOT NULL,
	CONSTRAINT `OrderlinesPK`
		PRIMARY KEY (`LineID`),
	CONSTRAINT `OrderlinesFK`
		FOREIGN KEY (`ProductID`)
		REFERENCES `products` (`ProductID`) ON DELETE SET NULL,
	CONSTRAINT `OrderlinesFK2`
		FOREIGN KEY (`HeaderID`)
		REFERENCES `orderheaders` (`HeaderID`) ON DELETE CASCADE
);
