-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 12, 2023 at 11:52 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `iot_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `device`
--

CREATE TABLE `device` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `device`
--

INSERT INTO `device` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'đèn học', '2015-04-03 14:00:45', '2015-04-03 14:00:45'),
(2, 'điều hòa', '2022-06-03 12:00:45', '2023-06-03 14:00:45'),
(3, 'tivi', '2022-02-03 12:00:45', '2023-02-03 14:00:45'),
(5, 'tủ lạnh', '2022-04-03 14:00:45', '2022-02-03 12:00:00'),
(6, 'máy giặt 2', '2022-04-03 14:00:45', '2023-01-29 09:58:42'),
(8, 'test 5', '2023-02-25 03:42:09', '2023-02-25 03:49:37'),
(9, 'tu lanh 2', '2023-03-05 06:01:58', '2023-03-05 06:01:58'),
(10, 'tu lanh 3', '2023-03-05 06:03:43', '2023-03-05 06:03:43'),
(12, 'door', '2023-08-12 16:12:42', '2023-08-12 16:12:42'),
(13, 'led', '2023-08-12 16:13:04', '2023-08-12 16:13:04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `device`
--
ALTER TABLE `device`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `device`
--
ALTER TABLE `device`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
