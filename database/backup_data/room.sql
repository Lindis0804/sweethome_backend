-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 12, 2023 at 12:05 PM
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
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `id` int(11) NOT NULL,
  `house_id` int(11) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`id`, `house_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 'phong ngu', '2023-03-05 00:14:57', NULL),
(2, 1, 'phong ngu 1', '2023-03-04 17:29:14', '2023-03-04 17:29:14'),
(3, 1, 'phong ngu 2', '2023-03-04 17:29:18', '2023-03-04 17:29:18'),
(4, 1, 'phong khach', '2023-03-04 17:29:24', '2023-03-04 17:29:24'),
(5, 1, 'phong an', '2023-03-04 17:29:28', '2023-03-04 17:29:28'),
(6, 1, 'phong choi game', '2023-03-04 17:30:06', '2023-03-04 17:30:06'),
(7, 1, 'phong lam viec', '2023-03-04 17:30:13', '2023-03-04 17:30:13'),
(8, 1, 'phong hop', '2023-03-04 17:30:21', '2023-03-04 17:30:21'),
(9, 2, 'balcony', '2023-08-12 09:18:23', '2023-08-12 09:18:23');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
