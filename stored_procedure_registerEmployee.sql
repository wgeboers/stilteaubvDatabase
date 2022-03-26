DELIMITER //

CREATE PROCEDURE `registerEmployee`
    (IN `First_Name` VARCHAR(25), IN `Middle_Name` VARCHAR(25), IN `Last_Name` VARCHAR(25), IN `Email` VARCHAR(50), IN `Password` VARCHAR(25), IN `Created_By` INT, IN `ACTIVE` BOOLEAN)
BEGIN
    INSERT INTO `Employees` 
		(`First_Name`, `Middle_Name`, `Last_Name`, `Email`, `Password`, `Created_By`, `ACTIVE`)
    VALUES
        (`First_Name`, `Middle_Name`, `Last_Name`, `Email`, `Password`, `Created_By`, `ACTIVE`);
END

//

-- Voorbeeld aanroep procedure
-- CALL registerEmployee('Philip', 'J.', 'Fry', 'p.fry@student.avans.nl', 'P@ssw0rd@2022!', 1, 1);