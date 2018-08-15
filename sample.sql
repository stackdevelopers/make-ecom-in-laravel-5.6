-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 15, 2018 at 07:36 AM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sample`
--

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE `banners` (
  `id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `banners`
--

INSERT INTO `banners` (`id`, `image`, `title`, `link`, `status`, `created_at`, `updated_at`) VALUES
(1, '94972.png', 'Banner Image 1', 'products/t-shirts1', 1, '2018-08-05 14:33:27', '2018-08-07 15:59:17'),
(2, '66584.png', 'Banner Image', 'products/t-shirts', 1, '2018-08-05 14:34:06', '2018-08-05 14:34:06'),
(4, '71958.png', 'Test Banner', 'products/shoes', 1, '2018-08-07 16:13:25', '2018-08-07 16:13:25');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_color` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `user_email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `product_id`, `product_name`, `product_code`, `product_color`, `size`, `price`, `quantity`, `user_email`, `session_id`, `created_at`, `updated_at`) VALUES
(1, 10, 'Blue Casual Tshirt', 'BCT01-S', 'Blue', 'Small', 1500.00, 1, '', 's00BJVlYYxaCFK1RcrOLBS9rPKNTzrPUhfA6l5KJ', NULL, NULL),
(2, 10, 'Blue Casual Tshirt', 'BCT01-M', 'Blue', 'Medium', 1800.00, 1, '', 's00BJVlYYxaCFK1RcrOLBS9rPKNTzrPUhfA6l5KJ', NULL, NULL),
(3, 10, 'Blue Casual Tshirt', 'BCT01-S', 'Blue', 'Small', 1500.00, 1, '', 'TgXwOXlGeIY4iAmSWRu1M1gKGXcEBwd8uzdez24U', NULL, NULL),
(4, 10, 'Blue Casual Tshirt', 'BCT01-S', 'Blue', 'Small', 1500.00, 1, '', 'uy4pUpdFxhPFhNm4d6y0v5d0lXfTlMH1mM1wYmbw', NULL, NULL),
(5, 10, 'Blue Casual Tshirt', 'BCT01-S', 'Blue', 'Small', 1500.00, 1, '', 'NJT1SIXaQsotXUQA55Q2LFF6TCneBLnjFK9SOqRu', NULL, NULL),
(6, 10, 'Blue Casual Tshirt', 'BCT01-M', 'Blue', 'Medium', 1500.00, 1, '', 'PLrjnC5QrDt9WqiiUv5SZqhv1gZ9NbmTz1VgsrQR', NULL, NULL),
(7, 10, 'Blue Casual Tshirt', 'BCT01-M', 'Blue', 'Medium', 1800.00, 1, '', 'dyPYuzkvZVYjGklSjkihsD9z2GTZN2cksN0QIfZR', NULL, NULL),
(8, 10, 'Blue Casual Tshirt', 'BCT01-M', 'Blue', 'Medium', 1800.00, 1, '', 'rsyhJBh0l72q8GmbEmArAU2fbcPQW9TeYtZUCYlf', NULL, NULL),
(13, 11, 'Sports TShirt', 'FTS001-S', 'Black', 'Small', 1200.00, 1, '', 'crTu92EzyCCJFLhA170MyOnI0CystVlR3zCk1XMj', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(11) DEFAULT '0',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `parent_id`, `name`, `description`, `url`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 0, 'T-Shirts', NULL, 't-shirts', 1, NULL, '2018-03-26 09:20:29', '2018-03-26 09:20:29'),
(2, 0, 'Shoes', NULL, 'shoes', 1, NULL, '2018-03-26 10:25:46', '2018-03-26 10:25:46'),
(3, 1, 'Formal T-Shirts', 'test', 'format-tshirts', 1, NULL, '2018-03-26 11:47:41', '2018-03-26 12:03:19'),
(4, 2, 'Formal Shoes', NULL, 'formal-shoes', 1, NULL, '2018-05-02 08:58:00', '2018-05-02 08:58:00'),
(5, 1, 'Casual T-Shirts', NULL, 'casual-t-shirts', 1, NULL, '2018-05-02 09:00:27', '2018-05-19 22:34:21'),
(6, 1, 'Sports T-Shirts', 'test', 'sports-tshirts', 1, NULL, '2018-05-09 10:55:52', '2018-05-10 08:36:55'),
(7, 1, 'Test T-shirts', 'tet', 'test', 0, NULL, '2018-05-09 10:56:56', '2018-05-09 10:56:56');

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(10) UNSIGNED NOT NULL,
  `coupon_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` int(11) NOT NULL,
  `amount_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiry_date` date NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`id`, `coupon_code`, `amount`, `amount_type`, `expiry_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 'test15', 15, 'Percentage', '2018-08-31', 1, '2018-07-13 15:11:19', '2018-08-01 08:55:10'),
(3, 'test150', 150, 'Fixed', '2018-07-25', 1, '2018-07-16 16:57:39', '2018-07-16 11:27:39'),
(4, 'test10', 10, 'Percentage', '2018-08-31', 1, '2018-07-22 03:36:00', '2018-08-05 01:08:03');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_03_18_090951_create_category_table', 2),
(4, '2018_03_18_100532_add_url_to_categories', 3),
(5, '2018_03_29_144354_create_products_table', 4),
(6, '2018_04_16_135232_create_products_attributes_table', 5),
(7, '2018_06_21_174929_create_cart_table', 6),
(8, '2018_07_09_150844_create_coupons_table', 7);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(11) NOT NULL,
  `product_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_color` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `care` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `product_name`, `product_code`, `product_color`, `description`, `care`, `price`, `image`, `status`, `created_at`, `updated_at`) VALUES
(9, 5, 'Green TShirt', 'GTS001', 'Green', 'test', 'test1', 2200.00, '76925.jpg', 1, '2018-04-14 08:34:05', '2018-08-10 09:41:43'),
(10, 3, 'Blue Casual Tshirt', 'BCT01', 'Blue', '', '', 1500.00, '52109.jpg', 1, '2018-04-14 08:34:29', '2018-05-12 08:34:56'),
(11, 6, 'Sports TShirt', 'FTS001', 'Black', '', '', 2200.00, '28449.jpg', 1, '2018-05-06 03:39:16', '2018-05-10 08:31:54'),
(12, 5, 'Blue Casual Tshirt', 'BCT01', 'Blue', 'Blue Casual Tshirt has a round neck, half sleeves', '', 2200.00, '83971.png', 1, '2018-05-19 22:21:22', '2018-05-19 22:21:22'),
(13, 5, 'Blue Casual Tshirt', 'BCT01', 'Blue', 'test', '', 1000.00, '51771.jpg', 1, '2018-05-19 22:22:27', '2018-05-19 22:22:27'),
(14, 5, 'Blue Casual Tshirt', 'BCT01', 'Blue', 'test', 'test1', 1000.00, '9988.jpg', 1, '2018-05-19 22:29:25', '2018-05-19 22:29:25'),
(15, 5, 'Blue Casual Tshirt', 'BCT01', 'Blue', 'Grey melange striped waist length T-shirt, has a round neck, long sleeves', 'Cotton\r\nMachine-wash', 1000.00, '63009.jpg', 1, '2018-05-19 22:33:43', '2018-05-19 22:33:43'),
(16, 5, 'Blue Casual Tshirt', 'BCT01', 'Blue', '', '', 1000.00, '6292.jpg', 1, '2018-06-16 09:28:14', '2018-06-16 09:28:14'),
(17, 5, 'Blue Casual Tshirt', 'BCT01', 'Blue', '', '', 1000.00, '57345.jpg', 0, '2018-06-16 09:29:01', '2018-06-16 09:30:43');

-- --------------------------------------------------------

--
-- Table structure for table `products_attributes`
--

CREATE TABLE `products_attributes` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `sku` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products_attributes`
--

INSERT INTO `products_attributes` (`id`, `product_id`, `sku`, `size`, `price`, `stock`, `created_at`, `updated_at`) VALUES
(3, 9, 'GTS001-S', 'Small', 500.00, 10, '2018-04-18 12:18:02', '2018-06-07 08:44:07'),
(5, 9, 'GTS001-M', 'Medium', 1000.00, 0, '2018-04-18 12:18:23', '2018-06-07 08:44:09'),
(6, 10, 'BCT01-S', 'Small', 1500.00, 2, '2018-05-15 11:40:25', '2018-07-07 10:17:09'),
(7, 10, 'BCT01-M', 'Medium', 1800.00, 2, '2018-05-15 11:40:28', '2018-07-07 10:17:11'),
(8, 11, 'FTS001-S', 'Small', 1200.00, 10, '2018-06-26 09:18:35', '2018-06-26 09:18:35');

-- --------------------------------------------------------

--
-- Table structure for table `products_images`
--

CREATE TABLE `products_images` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products_images`
--

INSERT INTO `products_images` (`id`, `product_id`, `image`, `created_at`, `updated_at`) VALUES
(3, 9, '69412.jpg', '2018-05-26 17:32:58', '2018-05-26 12:02:58'),
(4, 9, '81426.png', '2018-05-26 17:32:59', '2018-05-26 12:02:59'),
(5, 9, '86890.jpg', '2018-05-26 17:33:00', '2018-05-26 12:03:00'),
(6, 9, '15927.jpg', '2018-06-02 14:30:10', '2018-06-02 09:00:10');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin` tinyint(1) DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `admin`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Amit Gupta', 'amitphpprogrammer@gmail.com', '$2y$10$3I6cLW6xNL1IZVec1UPahOdA/S4PbXAh2SCoRMOPUE.EqTBV06mFu', 1, NULL, '2018-03-09 09:18:34', '2018-06-04 09:56:05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products_attributes`
--
ALTER TABLE `products_attributes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products_images`
--
ALTER TABLE `products_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `products_attributes`
--
ALTER TABLE `products_attributes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `products_images`
--
ALTER TABLE `products_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
