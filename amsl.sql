-- phpMyAdmin SQL Dump
-- version 4.5.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jan 16, 2019 at 12:11 PM
-- Server version: 5.7.11
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `amsl`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_type` enum('Fixed Asset','Current Asset','Current Asset-AR','Long-term Liabilities','Short-term Liabilities','Liabilities-AP','Expense','Income','Owner Equity') COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `name`, `account_type`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Investment', 'Current Asset', NULL, NULL, NULL),
(2, 'Prepaid Wages', 'Current Asset', NULL, NULL, NULL),
(3, 'Wages', 'Expense', NULL, NULL, NULL),
(4, 'Electricity Bill', 'Expense', NULL, NULL, NULL),
(5, 'Depreciation', 'Expense', NULL, NULL, NULL),
(6, 'Room Rent', 'Income', NULL, NULL, NULL),
(7, 'Car Parking', 'Income', NULL, NULL, NULL),
(8, 'Furniture', 'Fixed Asset', NULL, NULL, NULL),
(9, 'Table', 'Fixed Asset', NULL, NULL, NULL),
(10, 'AR-Jhon', 'Current Asset-AR', NULL, NULL, NULL),
(11, 'AR-Karim', 'Current Asset-AR', NULL, NULL, NULL),
(12, 'AP-Hanif', 'Liabilities-AP', NULL, NULL, NULL),
(13, 'AP-Shohag', 'Liabilities-AP', NULL, NULL, NULL),
(14, 'Bank Loan', 'Long-term Liabilities', NULL, NULL, NULL),
(15, 'Car Loan', 'Long-term Liabilities', NULL, NULL, NULL),
(16, 'Short Term Loan', 'Short-term Liabilities', NULL, NULL, NULL),
(17, 'Short Term Car Loan', 'Short-term Liabilities', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_id` int(10) UNSIGNED NOT NULL,
  `ref` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_type` enum('Cash','Bank','Accounts Payable','Owner Equity','Adjust') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(14,2) NOT NULL DEFAULT '0.00',
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `liability_id` int(11) DEFAULT NULL,
  `expense_id` int(11) DEFAULT NULL,
  `asset_date` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `name`, `address`, `mobile`, `image_path`, `created_at`, `updated_at`) VALUES
(1, 'Your company', 'your address', '0212310140,1201356', 'company/E3m3aaVryI2bPSSSyUb1Av8jMLPH7O0ur7nfn5Gc.png', NULL, '2019-01-16 03:16:04');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_card` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_histories`
--

CREATE TABLE `employee_histories` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL,
  `start_date` timestamp NOT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_id` int(10) UNSIGNED NOT NULL,
  `ref` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(14,2) NOT NULL,
  `tax_rate` double(10,2) DEFAULT NULL,
  `tax_amount` decimal(14,2) DEFAULT NULL,
  `after_tax_amount` decimal(14,2) DEFAULT NULL,
  `payment_type` enum('Cash','Bank','Accounts Payable','Prepaid Expense','Depreciation Fund') COLLATE utf8mb4_unicode_ci NOT NULL,
  `modelable_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modelable_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `asset_id` int(11) DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expense_date` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `incomes`
--

CREATE TABLE `incomes` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_id` int(10) UNSIGNED NOT NULL,
  `ref` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(14,2) NOT NULL,
  `tax_rate` double(10,2) DEFAULT NULL,
  `tax_amount` decimal(14,2) DEFAULT NULL,
  `after_tax_amount` decimal(14,2) DEFAULT NULL,
  `payment_type` enum('Cash','Bank','Accounts Receivable') COLLATE utf8mb4_unicode_ci NOT NULL,
  `asset_id` int(11) DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `income_date` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `liabilities`
--

CREATE TABLE `liabilities` (
  `id` int(10) UNSIGNED NOT NULL,
  `accountable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accountable_id` int(11) NOT NULL,
  `ref` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_type` enum('Cash','Bank','Accounts Receivable','Owner Equity') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(14,2) NOT NULL DEFAULT '0.00',
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `asset_id` int(11) DEFAULT NULL,
  `liability_date` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ownerequities`
--

CREATE TABLE `ownerequities` (
  `id` int(10) UNSIGNED NOT NULL,
  `account` enum('Capital','Withdraw') COLLATE utf8mb4_unicode_ci NOT NULL,
  `ref` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_type` enum('Cash','Bank','Accounts Receivable') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(14,2) NOT NULL DEFAULT '0.00',
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `liability_id` int(11) DEFAULT NULL,
  `equity_date` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `regular_forms`
--

CREATE TABLE `regular_forms` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `agt` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ref` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash` decimal(14,2) NOT NULL DEFAULT '0.00',
  `bank` decimal(14,2) NOT NULL DEFAULT '0.00',
  `eviivo` decimal(14,2) NOT NULL DEFAULT '0.00',
  `parking_cash` decimal(14,2) NOT NULL DEFAULT '0.00',
  `parking_card` decimal(14,2) NOT NULL DEFAULT '0.00',
  `other_sales` decimal(14,2) NOT NULL DEFAULT '0.00',
  `return` decimal(14,2) NOT NULL DEFAULT '0.00',
  `advance_sales` decimal(14,2) NOT NULL DEFAULT '0.00',
  `remark` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('sub-admin','admin','user') COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `role`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Harison', 'amsl@admin.com', 'admin', NULL, '$2y$12$di13EgZz1onP8jNsvUhw0.MtUD9AmQ14VQvCkcbt27e1EWSOBA6kC', 'WhQAa54fgxEgYJrj3gHqPDaDx86eQX4gjSOp1bqxzPsV51AmjcdLWx1CYweP', NULL, NULL),
(2, 'Jon', 'amsl@sub-admin.com', 'sub-admin', NULL, '$2y$12$di13EgZz1onP8jNsvUhw0.MtUD9AmQ14VQvCkcbt27e1EWSOBA6kC', NULL, NULL, NULL),
(3, 'Parikon', 'amsl@user.com', 'user', NULL, '$2y$12$di13EgZz1onP8jNsvUhw0.MtUD9AmQ14VQvCkcbt27e1EWSOBA6kC', NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accounts_name_index` (`name`),
  ADD KEY `accounts_description_index` (`description`);

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assets_account_id_index` (`account_id`),
  ADD KEY `assets_ref_index` (`ref`),
  ADD KEY `assets_transaction_type_index` (`transaction_type`),
  ADD KEY `assets_payment_type_index` (`payment_type`),
  ADD KEY `assets_liability_id_index` (`liability_id`),
  ADD KEY `assets_expense_id_index` (`expense_id`),
  ADD KEY `assets_asset_date_index` (`asset_date`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employees_name_index` (`name`);

--
-- Indexes for table `employee_histories`
--
ALTER TABLE `employee_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_histories_employee_id_index` (`employee_id`),
  ADD KEY `employee_histories_start_date_index` (`start_date`),
  ADD KEY `employee_histories_end_date_index` (`end_date`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expenses_account_id_index` (`account_id`),
  ADD KEY `expenses_ref_index` (`ref`),
  ADD KEY `expenses_amount_index` (`amount`),
  ADD KEY `expenses_modelable_type_index` (`modelable_type`),
  ADD KEY `expenses_modelable_id_index` (`modelable_id`),
  ADD KEY `expenses_employee_id_index` (`employee_id`),
  ADD KEY `expenses_asset_id_index` (`asset_id`),
  ADD KEY `expenses_expense_date_index` (`expense_date`);

--
-- Indexes for table `incomes`
--
ALTER TABLE `incomes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `incomes_account_id_index` (`account_id`),
  ADD KEY `incomes_ref_index` (`ref`),
  ADD KEY `incomes_amount_index` (`amount`),
  ADD KEY `incomes_asset_id_index` (`asset_id`),
  ADD KEY `incomes_income_date_index` (`income_date`);

--
-- Indexes for table `liabilities`
--
ALTER TABLE `liabilities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `liabilities_ref_index` (`ref`),
  ADD KEY `liabilities_transaction_type_index` (`transaction_type`),
  ADD KEY `liabilities_payment_type_index` (`payment_type`),
  ADD KEY `liabilities_asset_id_index` (`asset_id`),
  ADD KEY `liabilities_liability_date_index` (`liability_date`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ownerequities`
--
ALTER TABLE `ownerequities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ownerequities_ref_index` (`ref`),
  ADD KEY `ownerequities_transaction_type_index` (`transaction_type`),
  ADD KEY `ownerequities_payment_type_index` (`payment_type`),
  ADD KEY `ownerequities_liability_id_index` (`liability_id`),
  ADD KEY `ownerequities_equity_date_index` (`equity_date`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `regular_forms`
--
ALTER TABLE `regular_forms`
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
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `employee_histories`
--
ALTER TABLE `employee_histories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `incomes`
--
ALTER TABLE `incomes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `liabilities`
--
ALTER TABLE `liabilities`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ownerequities`
--
ALTER TABLE `ownerequities`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `regular_forms`
--
ALTER TABLE `regular_forms`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
