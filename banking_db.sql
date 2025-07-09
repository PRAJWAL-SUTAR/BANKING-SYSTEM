-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 09, 2025 at 12:20 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `banking_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `VerifyLogin` (IN `input_username` VARCHAR(50), IN `input_password_hash` VARCHAR(255))   BEGIN
    DECLARE user_count INT;

    SELECT COUNT(*) INTO user_count
    FROM LoginCredentials
    WHERE Username = input_username
      AND PasswordHash = input_password_hash;

    IF user_count = 1 THEN
        
        UPDATE LoginCredentials
        SET LastLogin = NOW()
        WHERE Username = input_username;

        SELECT 'Login Successful' AS Message;
    ELSE
        SELECT 'Invalid Credentials' AS Message;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `AccountID` int(11) NOT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `AccountType` varchar(20) DEFAULT NULL,
  `Balance` decimal(12,2) DEFAULT NULL,
  `DateOpened` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`AccountID`, `CustomerID`, `AccountType`, `Balance`, `DateOpened`) VALUES
(1, 1, 'Savings', 25000.00, '2025-07-09'),
(2, 2, 'Current', 40000.00, '2025-07-09'),
(3, 3, 'Savings', 15000.00, '2025-07-09'),
(4, 4, 'Savings', 30000.00, '2025-07-09'),
(5, 5, 'Current', 50000.00, '2025-07-09');

-- --------------------------------------------------------

--
-- Table structure for table `card`
--

CREATE TABLE `card` (
  `CardID` int(11) NOT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `CardType` varchar(20) DEFAULT NULL,
  `CardNumber` varchar(16) DEFAULT NULL,
  `ExpiryDate` date DEFAULT NULL,
  `CVV` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `card`
--

INSERT INTO `card` (`CardID`, `CustomerID`, `CardType`, `CardNumber`, `ExpiryDate`, `CVV`) VALUES
(1, 1, 'Debit', '1234567890123456', '2028-06-01', 123),
(2, 2, 'Credit', '2345678901234567', '2027-09-01', 456),
(3, 3, 'Debit', '3456789012345678', '2029-03-01', 789),
(4, 4, 'Credit', '4567890123456789', '2026-12-01', 321),
(5, 5, 'Debit', '5678901234567890', '2030-01-01', 654);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CustomerID` int(11) NOT NULL,
  `FullName` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CustomerID`, `FullName`, `Email`, `Phone`, `Address`, `DateOfBirth`) VALUES
(1, 'Amit Sharma', 'amit@example.com', '9876543210', 'Mumbai', '1990-02-14'),
(2, 'Priya Mehta', 'priya@example.com', '9123456789', 'Pune', '1992-06-25'),
(3, 'Rahul Verma', 'rahul@example.com', '9988776655', 'Delhi', '1988-11-11'),
(4, 'Neha Singh', 'neha@example.com', '9871234567', 'Bangalore', '1995-04-08'),
(5, 'Karan Joshi', 'karan@example.com', '9811122233', 'Hyderabad', '1991-12-01');

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `LoanID` int(11) NOT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `LoanType` varchar(50) DEFAULT NULL,
  `LoanAmount` decimal(12,2) DEFAULT NULL,
  `InterestRate` decimal(5,2) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan`
--

INSERT INTO `loan` (`LoanID`, `CustomerID`, `LoanType`, `LoanAmount`, `InterestRate`, `StartDate`, `EndDate`) VALUES
(1, 1, 'Home', 1000000.00, 7.50, '2022-01-01', '2032-01-01'),
(2, 2, 'Car', 500000.00, 8.20, '2023-05-10', '2028-05-10'),
(3, 3, 'Personal', 200000.00, 10.00, '2024-03-15', '2029-03-15'),
(4, 4, 'Education', 300000.00, 6.50, '2021-09-01', '2026-09-01'),
(5, 5, 'Business', 750000.00, 9.00, '2023-11-01', '2033-11-01');

-- --------------------------------------------------------

--
-- Table structure for table `logincredentials`
--

CREATE TABLE `logincredentials` (
  `CustomerID` int(11) NOT NULL,
  `Username` varchar(50) DEFAULT NULL,
  `PasswordHash` varchar(255) DEFAULT NULL,
  `LastLogin` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `logincredentials`
--

INSERT INTO `logincredentials` (`CustomerID`, `Username`, `PasswordHash`, `LastLogin`) VALUES
(1, 'amit_sharma', 'e99a18c428cb38d5f260853678922e03', '2025-07-09 10:02:35'),
(2, 'priya_mehta', '5f4dcc3b5aa765d61d8327deb882cf99', '2025-07-09 10:02:35'),
(3, 'rahul_verma', '6cb75f652a9b52798eb6cf2201057c73', '2025-07-09 10:02:35'),
(4, 'neha_singh', '8d31b1890c6b4d9ee0e236503d1c6bfb', '2025-07-09 10:02:35'),
(5, 'karan_joshi', '2c9341ca4cf3d87b9e4f9c061e0545c8', '2025-07-09 10:02:35');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `TransactionID` int(11) NOT NULL,
  `AccountID` int(11) DEFAULT NULL,
  `TransactionType` varchar(10) DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `TransactionDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`TransactionID`, `AccountID`, `TransactionType`, `Amount`, `TransactionDate`, `Description`) VALUES
(1, 1, 'Credit', 5000.00, '2025-07-09 10:03:37', 'Salary'),
(2, 2, 'Debit', 2000.00, '2025-07-09 10:03:37', 'Utility Bill'),
(3, 3, 'Credit', 10000.00, '2025-07-09 10:03:37', 'Freelance Payment'),
(4, 4, 'Debit', 1500.00, '2025-07-09 10:03:37', 'Grocery Shopping'),
(5, 5, 'Credit', 7000.00, '2025-07-09 10:03:37', 'Online Transfer');

--
-- Triggers `transaction`
--
DELIMITER $$
CREATE TRIGGER `UpdateBalanceAfterTransaction` AFTER INSERT ON `transaction` FOR EACH ROW BEGIN
    IF NEW.TransactionType = 'Credit' THEN
        UPDATE Account
        SET Balance = Balance + NEW.Amount
        WHERE AccountID = NEW.AccountID;
    ELSEIF NEW.TransactionType = 'Debit' THEN
        UPDATE Account
        SET Balance = Balance - NEW.Amount
        WHERE AccountID = NEW.AccountID;
    END IF;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`AccountID`),
  ADD KEY `CustomerID` (`CustomerID`);

--
-- Indexes for table `card`
--
ALTER TABLE `card`
  ADD PRIMARY KEY (`CardID`),
  ADD UNIQUE KEY `CardNumber` (`CardNumber`),
  ADD KEY `CustomerID` (`CustomerID`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CustomerID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`LoanID`),
  ADD KEY `CustomerID` (`CustomerID`);

--
-- Indexes for table `logincredentials`
--
ALTER TABLE `logincredentials`
  ADD PRIMARY KEY (`CustomerID`),
  ADD UNIQUE KEY `Username` (`Username`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`TransactionID`),
  ADD KEY `AccountID` (`AccountID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `AccountID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `card`
--
ALTER TABLE `card`
  MODIFY `CardID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `CustomerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `loan`
--
ALTER TABLE `loan`
  MODIFY `LoanID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `TransactionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `account_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`);

--
-- Constraints for table `card`
--
ALTER TABLE `card`
  ADD CONSTRAINT `card_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`);

--
-- Constraints for table `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`);

--
-- Constraints for table `logincredentials`
--
ALTER TABLE `logincredentials`
  ADD CONSTRAINT `logincredentials_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`AccountID`) REFERENCES `account` (`AccountID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
