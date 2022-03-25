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

-- Stored procedure, retrieve orders from user based on userID
DELIMITER //
CREATE PROCEDURE `getOrdersUser`
	(IN `userID` INT)
BEGIN
	SELECT `Creation_Date`, `HeaderID`, `Total_Price`, `Status`
	FROM `OrderHeaders`
	WHERE `Order_by` = `userID`;
END
//
	
-- Dummy data table `users`

INSERT INTO `users` (`First_Name`,`Middle_Name`,`Last_Name`,`Email`,`Phone_Number`,`Password`,`Street`,`House_Number`,`House_Number_Addition`,`Zipcode`,`City`)
VALUES
  ('Alden','Vasquez','Nelson','maecenas.iaculis@outlook.ca','(910) 404-6094','CPL52RLZ7IM','Namen','739','S8','7603 LN','Grave'),
  ('Igor','Poole','Mcpherson','nam@outlook.couk','(438) 414-8723','CIG02CHL2TT','Korhoen','628','I1','5837 KW','Buren'),
  ('Bradley','Wright','Cole','senectus.et@icloud.com','(846) 492-3051','KOZ37DJQ3DC','Junín','379','M6','1428 MB','Waalwijk'),
  ('Francis','Decker','Norman','cras@aol.net','(451) 683-4738','KRZ75TNF3DB','Rijnsingel','543','X6','8048 JP','Oss'),
  ('Arthur','Vincent','Chaney','eget@aol.ca','(158) 108-4302','FYP09VQO1IK','Saint Petersburg City','361','S3','4313 WM','Tilburg'),
  ('Thane','Bowman','Dean','lobortis.augue.scelerisque@outlook.couk','(765) 845-9833','MQY08BPX3AV','Ancash','486','X8','2920 NW','Harlingen'),
  ('August','Johns','Salas','augue.sed@outlook.couk','(180) 522-4086','BYV23TYF8GN','North Gyeongsang','566','D2','7383 XU','Veenendaal'),
  ('Nehru','Mcguire','Baird','pretium@yahoo.net','(838) 233-3173','UFJ67OUJ3CZ','Nord-Pas-de-Calais','963','G9','4564 HT','Enkhuizen'),
  ('Thane','Hill','Perkins','sed@google.ca','(164) 842-1442','CXI92IUY7TW','Sicilia','665','W4','7943 YJ','Hindeloopen'),
  ('Galvin','Calderon','Scott','ut.mi@aol.couk','(868) 523-8730','GSL46PDH1DQ','Nord-Pas-de-Calais','212','H3','2101 EO','Zaanstad');
INSERT INTO `users` (`First_Name`,`Middle_Name`,`Last_Name`,`Email`,`Phone_Number`,`Password`,`Street`,`House_Number`,`House_Number_Addition`,`Zipcode`,`City`)
VALUES
  ('Timothy','Sims','Valdez','auctor.vitae@protonmail.ca','(524) 474-8105','IUS64LOS8FU','Puntarenas','573','F2','8037 GY','Wageningen'),
  ('Nigel','Fisher','Ingram','fames.ac@yahoo.com','(334) 797-1558','OXK42DQG0ZE','Sachsen-Anhalt','327','B4','8902 XQ','Deventer'),
  ('Keane','Harrington','Wall','commodo.auctor@aol.couk','(704) 681-7755','LUO26WOH4SA','Alabama','181','F4','1429 JN','Enschede'),
  ('Alvin','Boyle','Berry','eget@icloud.ca','(222) 766-1557','EEF81UVO7HY','Nordland','683','A6','2247 JC','Veere'),
  ('Bruno','Cross','Zamora','dictum@aol.edu','(383) 352-3624','YXE97CMV7SB','Riau','754','D4','8841 DP','Zutphen'),
  ('Ivor','Lynn','Lowe','metus.in@outlook.org','(554) 396-3753','IKZ28PCC6NN','New South Wales','725','N8','4989 NV','Veenendaal'),
  ('Howard','Barrett','Sharpe','donec@hotmail.ca','(471) 432-1432','WBD04ODK4QX','Gaziantep','477','W3','9046 IH','Flushing'),
  ('Brent','Mclean','Rice','consectetuer.mauris@google.net','(303) 515-1471','YVB43EHU2VV','Huila','845','R8','4858 QQ','Lelystad'),
  ('Alfonso','Chen','Yang','nulla.in.tincidunt@aol.couk','(441) 192-9846','GTN45OGS7DJ','Heredia','325','Q6','3512 NQ','Almere'),
  ('Stuart','Cooper','Cameron','ligula.nullam@hotmail.ca','(630) 180-8934','QPG61HGL3JW','Yukon','589','O3','3642 SJ','Zutendaal');
INSERT INTO `users` (`First_Name`,`Middle_Name`,`Last_Name`,`Email`,`Phone_Number`,`Password`,`Street`,`House_Number`,`House_Number_Addition`,`Zipcode`,`City`)
VALUES
  ('Tanner','Thornton','Daniel','aliquam.vulputate@outlook.ca','(321) 770-3929','IIA35EMY1FM','Haute-Normandie','856','U9','7968 RI','Terneuzen'),
  ('Palmer','Sampson','Vaughan','lectus@google.couk','(636) 300-6485','NRS57KKU7CY','Salzburg','553','B9','8375 YN','Flushing'),
  ('Louis','Sandoval','Hoffman','aliquam.nec@protonmail.org','(926) 579-6580','FKG62FDU7XB','Lorraine','152','C7','4339 LS','Sittard'),
  ('Austin','Ashley','Bridges','in.scelerisque@aol.edu','(380) 429-4133','OLK45FHS5NP','Aisén','638','V6','3478 DP','Lanklaar'),
  ('Lance','Hickman','Acosta','libero.donec@protonmail.com','(251) 384-7403','EVO41YDO2ZJ','Kursk Oblast','248','P8','3761 JH','Sloten'),
  ('Philip','Holder','Waller','phasellus@icloud.net','(978) 486-1104','KXU21MXH1EC','South Island','397','K7','8713 ZD','Tilburg'),
  ('Wyatt','Dale','Merrill','consequat.purus@google.edu','(818) 342-4945','GSJ15HBG7ED','Illes Balears','216','R4','8339 RF','Hindeloopen'),
  ('Maxwell','Dalton','Harmon','quam.elementum@aol.ca','(126) 843-1652','MOZ42LKK2VR','Vorarlberg','176','R2','4261 MQ','Flushing'),
  ('Hu','Sanchez','Ingram','et.commodo.at@hotmail.com','(638) 757-6217','LQT84EQA8KT','Bremen','648','U5','4954 GS','Tilburg'),
  ('Caldwell','Rivers','Blake','nulla.cras@icloud.edu','(788) 339-9859','OKM01IFX5FD','Maluku','421','L5','2729 QX','Opglabbeek');
INSERT INTO `users` (`First_Name`,`Middle_Name`,`Last_Name`,`Email`,`Phone_Number`,`Password`,`Street`,`House_Number`,`House_Number_Addition`,`Zipcode`,`City`)
VALUES
  ('Russell','Peterson','Madden','non.lobortis.quis@hotmail.com','(363) 740-1846','LFS35DIW3OM','Innlandet','497','M4','5936 NF','Delft'),
  ('Preston','Lamb','Mitchell','auctor@hotmail.org','(807) 247-3452','QLX59ZON4VR','Brandenburg','257','R8','7333 XQ','Meppel'),
  ('Connor','Jarvis','Moses','consequat.enim.diam@google.org','(321) 319-8483','MBO91UPC8GM','Vichada','822','I8','4874 FF','Zutphen'),
  ('Keegan','Walls','Coleman','nullam@yahoo.ca','(444) 685-6482','BTT28CJL7KH','Central Luzon','547','O4','4354 FM','Almelo'),
  ('Kirk','Hayden','Donaldson','blandit@protonmail.com','(963) 213-8112','YWY05WGI3ZD','Samsun','466','V7','0161 JJ','Zwolle'),
  ('Dillon','Ashley','Collier','in@protonmail.edu','(885) 254-1178','BFR78IJC7CL','Zhōngnán','186','Y3','6843 XF','Coevorden'),
  ('Clinton','Spencer','Kelley','diam.sed@aol.net','(252) 333-2238','PCI43NST5GX','Melilla','586','K7','1411 UF','Grave'),
  ('Rashad','Suarez','Gallagher','dictum.eu.eleifend@hotmail.couk','(432) 205-3332','PTR84GGK2UQ','Bangsamoro','943','Z9','1236 ZK','Hulst'),
  ('Oliver','Wise','Boone','ipsum.primis.in@hotmail.org','(896) 516-2212','KJI67IWJ1TM','Kayseri','868','H7','5736 JW','Amersfoort'),
  ('Orson','Cook','Barton','dictum.phasellus@aol.edu','(336) 561-7752','LBV60DRN7KN','Tasmania','653','O2','7449 NI','Dordrecht');
INSERT INTO `users` (`First_Name`,`Middle_Name`,`Last_Name`,`Email`,`Phone_Number`,`Password`,`Street`,`House_Number`,`House_Number_Addition`,`Zipcode`,`City`)
VALUES
  ('Kenneth','Yates','Ford','lorem.luctus@protonmail.com','(251) 647-3625','THG28ESY5TU','San Andrés y Providencia','837','H1','9678 MX','Lelystad'),
  ('Erich','Roman','Craig','eget.venenatis@google.edu','(367) 377-3864','CJA26QHC6JB','Mazowieckie','678','H3','8435 FX','Oldenzaal'),
  ('Chaim','Langley','Gibson','scelerisque.dui@protonmail.edu','(988) 518-1825','JRH15GIP7UL','Southeast Sulawesi','666','C4','5702 BW','Utrecht'),
  ('Roth','Cummings','Armstrong','aliquam.eros.turpis@hotmail.edu','(479) 212-4155','AKP37OIP8IG','Valle del Cauca','467','R1','7736 GG','Lelystad'),
  ('Armand','Shields','Moody','sed.libero@outlook.ca','(971) 443-8019','UAO75OUB8ER','Yaroslavl Oblast','952','H2','7185 NJ','Nieuwegein'),
  ('Mohammad','Richards','Reeves','ac.mattis@aol.ca','(460) 218-0742','JHX20FEY1IW','Balochistan','868','L6','7351 FI','Zaltbommel'),
  ('Callum','Cherry','Hodges','morbi.accumsan.laoreet@hotmail.net','(614) 746-7414','END94PAY7NW','Gävleborgs län','781','R4','5143 CN','Franeker'),
  ('Travis','Suarez','Cline','felis@aol.edu','(535) 677-9945','WVT51JKD2YT','Brussels Hoofdstedelijk Gewest','544','Q1','5843 NT','Emmen'),
  ('Amal','Lloyd','Walsh','ridiculus@hotmail.couk','(384) 336-9685','OXO28YGG7LC','Champagne-Ardenne','679','N3','3419 JR','Gorinchem'),
  ('Isaac','Henry','Coffey','elit.dictum.eu@icloud.net','(666) 715-8125','WXM13HUV4FP','Southeast Sulawesi','329','G4','8569 KR','Apeldoorn');
