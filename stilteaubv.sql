-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 23, 2022 at 09:18 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stilteaubv`
--

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `EmployeeID` int(11) NOT NULL,
  `First_Name` varchar(25) NOT NULL,
  `Middle_Name` varchar(25) DEFAULT NULL,
  `Last_Name` varchar(25) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Password` varchar(25) NOT NULL,
  `Creation_Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `Created_By` int(11) DEFAULT NULL,
  `Last_Active` datetime DEFAULT NULL,
  `ACTIVE` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `employees-roles`
--

CREATE TABLE `employees-roles` (
  `TableID` int(11) NOT NULL,
  `EmployeeID` int(11) NOT NULL,
  `RoleID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `orderheaders`
--

CREATE TABLE `orderheaders` (
  `HeaderID` int(11) NOT NULL,
  `Order_By` int(11) DEFAULT NULL,
  `Total_Price` decimal(65,2) NOT NULL,
  `Deliver_Adres` varchar(255) NOT NULL,
  `Deliver_Zipcode` varchar(10) NOT NULL,
  `Deliver_City` varchar(50) NOT NULL,
  `Creation_Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `Finished_Date` datetime DEFAULT NULL,
  `Status` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `orderlines`
--

CREATE TABLE `orderlines` (
  `LineID` int(11) NOT NULL,
  `HeaderID` int(11) NOT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `Name` varchar(50) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Amount` int(11) NOT NULL,
  `Price_PerUnit` decimal(65,2) NOT NULL,
  `Total_Price` decimal(65,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `productlogs`
--

CREATE TABLE `productlogs` (
  `LogID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `Modified_Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `Modified_By` int(11) DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Stock` int(11) DEFAULT NULL,
  `Price` decimal(65,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `ProductID` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Stock` int(11) NOT NULL,
  `Price` decimal(65,2) NOT NULL,
  `Creation_Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `Created_By` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `RoleID` int(11) NOT NULL,
  `Name` varchar(25) NOT NULL,
  `Description` varchar(25) DEFAULT NULL,
  `Creation_Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `Created_By` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `First_Name` varchar(25) NOT NULL,
  `Middle_Name` varchar(25) DEFAULT NULL,
  `Last_Name` varchar(25) NOT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Phone_Number` varchar(20) DEFAULT NULL,
  `Password` varchar(25) NOT NULL,
  `Street` varchar(100) DEFAULT NULL,
  `House_Number` int(11) DEFAULT NULL,
  `House_Number_Addition` varchar(25) DEFAULT NULL,
  `Zipcode` varchar(10) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `Creation_Date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`EmployeeID`);

--
-- Indexes for table `employees-roles`
--
ALTER TABLE `employees-roles`
  ADD PRIMARY KEY (`TableID`),
  ADD KEY `EmployeeID` (`EmployeeID`),
  ADD KEY `RoleID` (`RoleID`);

--
-- Indexes for table `orderheaders`
--
ALTER TABLE `orderheaders`
  ADD PRIMARY KEY (`HeaderID`),
  ADD KEY `Order_By` (`Order_By`);

--
-- Indexes for table `orderlines`
--
ALTER TABLE `orderlines`
  ADD PRIMARY KEY (`LineID`),
  ADD KEY `HeaderID` (`HeaderID`),
  ADD KEY `ProductID` (`ProductID`);

--
-- Indexes for table `productlogs`
--
ALTER TABLE `productlogs`
  ADD PRIMARY KEY (`LogID`),
  ADD KEY `ProductID` (`ProductID`),
  ADD KEY `Modified_By` (`Modified_By`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ProductID`),
  ADD KEY `Created_By` (`Created_By`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`RoleID`),
  ADD KEY `Created_By` (`Created_By`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `EmployeeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employees-roles`
--
ALTER TABLE `employees-roles`
  MODIFY `TableID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orderheaders`
--
ALTER TABLE `orderheaders`
  MODIFY `HeaderID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orderlines`
--
ALTER TABLE `orderlines`
  MODIFY `LineID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `productlogs`
--
ALTER TABLE `productlogs`
  MODIFY `LogID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `ProductID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `RoleID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employees-roles`
--
ALTER TABLE `employees-roles`
  ADD CONSTRAINT `employees-roles_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`) ON DELETE CASCADE,
  ADD CONSTRAINT `employees-roles_ibfk_2` FOREIGN KEY (`RoleID`) REFERENCES `roles` (`RoleID`) ON DELETE CASCADE;

--
-- Constraints for table `orderheaders`
--
ALTER TABLE `orderheaders`
  ADD CONSTRAINT `orderheaders_ibfk_1` FOREIGN KEY (`Order_By`) REFERENCES `users` (`UserID`) ON DELETE SET NULL;

--
-- Constraints for table `orderlines`
--
ALTER TABLE `orderlines`
  ADD CONSTRAINT `orderlines_ibfk_1` FOREIGN KEY (`HeaderID`) REFERENCES `orderheaders` (`HeaderID`) ON DELETE CASCADE,
  ADD CONSTRAINT `orderlines_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE SET NULL;

--
-- Constraints for table `productlogs`
--
ALTER TABLE `productlogs`
  ADD CONSTRAINT `productlogs_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE,
  ADD CONSTRAINT `productlogs_ibfk_2` FOREIGN KEY (`Modified_By`) REFERENCES `employees` (`EmployeeID`) ON DELETE SET NULL;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`Created_By`) REFERENCES `employees` (`EmployeeID`) ON DELETE SET NULL;

--
-- Constraints for table `roles`
--
ALTER TABLE `roles`
  ADD CONSTRAINT `roles_ibfk_1` FOREIGN KEY (`Created_By`) REFERENCES `employees` (`EmployeeID`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
