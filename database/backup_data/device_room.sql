-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 12, 2023 at 12:04 PM
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
-- Table structure for table `device_room`
--

CREATE TABLE `device_room` (
  `id` bigint(20) NOT NULL,
  `code` varchar(20) NOT NULL,
  `device_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `device_name` varchar(100) NOT NULL,
  `device_detail` varchar(1000) NOT NULL,
  `is_active` tinyint(4) NOT NULL,
  `param` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `device_room`
--

INSERT INTO `device_room` (`id`, `code`, `device_id`, `room_id`, `device_name`, `device_detail`, `is_active`, `param`, `created_at`, `updated_at`) VALUES
(1, '1E4N3P', 2, 1, 'Điều hòa panasonic', 'Thở êm lành.', 0, '19', '2023-08-12 09:28:16', '2023-08-12 09:28:16'),
(2, '3D4E6K', 1, 0, 'Đèn học rạng đông', 'Thắp sáng future.', 1, '', '2023-08-10 09:29:40', '2023-08-11 09:29:40'),
(3, '9M2R6T', 3, 1, 'Tivi sony', 'Hòa mình vào thế giới huyền ảo', 1, '', '2023-08-12 09:30:21', '2023-08-18 09:30:21'),
(4, '2N4G6R', 1, 4, 'Đèn học bảy màu', 'Vừa học vừa bay lắc', 1, '', '2023-03-04 18:14:52', '2023-03-04 18:14:52'),
(5, 'A6A6A6', 1, 4, 'Đèn học blue moon', 'Có thể bật tắt tự động', 0, '1', '2023-03-04 18:15:32', '2023-03-04 18:23:09'),
(6, '9C6N4W', 2, 4, 'Điều hòa electrolux', 'Biến nhà bạn thành bắc cực', 1, '', '2023-03-04 18:18:24', '2023-03-04 18:18:24'),
(7, 'A1B2C3', 2, 4, 'Điều hòa electrolux 2', 'Biến nhà bạn thành bắc cực', 1, '1', '2023-03-04 18:24:05', '2023-03-04 18:24:05'),
(8, 'A2B3C4', 1, 4, 'Đèn học rạng đông', 'Hihi', 1, '1', '2023-03-04 18:24:16', '2023-03-04 18:24:16'),
(9, 'A5B3C2', 1, 4, 'Đèn học bluetooth', 'Hoho', 1, '20', '2023-03-04 18:42:46', '2023-03-04 18:42:46'),
(10, 'GEATS', 12, 9, 'Door', 'Vừng ơi mở ra', 0, '', '2023-08-12 09:20:39', '2023-08-12 09:20:39'),
(11, 'BUFFA', 13, 9, 'Led 1', 'Led 1', 1, '30', '2023-08-12 09:22:07', '2023-08-12 09:22:07'),
(12, 'NaGo', 13, 9, 'Led 2', 'Led 2', 0, '', '2023-08-12 09:37:57', '2023-08-12 09:37:57'),
(13, 'Ziin', 13, 9, 'Led 3', 'Led 3', 1, '', '2023-08-12 09:38:37', '2023-08-12 09:38:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `device_room`
--
ALTER TABLE `device_room`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `device_room`
--
ALTER TABLE `device_room`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
