DELIMITER //

CREATE PROCEDURE `registerUser`
	(IN `First_Name` VARCHAR(25),IN `Middle_Name` VARCHAR(25),IN `Last_Name` VARCHAR(25),IN `Email` VARCHAR(50),IN `Phone_Number` VARCHAR(20),IN `Password` VARCHAR(25),IN `Street` VARCHAR(100),IN `House_Number` INT,IN `House_Number_Addition` VARCHAR(25),IN `Zipcode` VARCHAR(10),IN `City` VARCHAR(25)) 
BEGIN
	INSERT INTO `users` (`First_Name`,`Middle_Name`,`Last_Name`,`Email`,`Phone_Number`,`Password`,`Street`,`House_Number`,`House_Number_Addition`,`Zipcode`,`City`)
	VALUES
		(`First_Name`,`Middle_Name`,`Last_Name`,`Email`,`Phone_Number`,`Password`,`Street`,`House_Number`,`House_Number_Addition`,`Zipcode`,`City`);
END	

//

-- Voorbeeld aanroep
-- CALL registerUser('Igor','Poole','Mcpherson','nam@outlook.couk','(438) 414-8723','CIG02CHL2TT','Korhoen','628','I1','5837 KW','Buren');