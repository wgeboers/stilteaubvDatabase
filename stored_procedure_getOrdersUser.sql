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
	