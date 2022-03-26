-- DROP FUNCTION yearsEmployeeInCompany;
DELIMITER //
CREATE FUNCTION `yearsEmployeeInCompany`(`empID` INT)
	RETURNS INT
BEGIN
	-- Variable voor het startJaar`
	DECLARE `startDate` INT;
    
	SELECT YEAR(`Creation_Date`)
	INTO `startDate`
	FROM `employees`
	WHERE `EmployeeID` = `empID`;
	
	-- Bepaal huidig jaar en trek daar het startJaar van af
	RETURN YEAR(CURRENT_TIMESTAMP()) - `startDate`;

END
//
DELIMITER ;

-- Voorbeeld aanroep
SELECT yearsEmployeeInCompany(EmployeeID)
FROM `employees`;