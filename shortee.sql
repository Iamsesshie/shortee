-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 09 juin 2025 à 10:08
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `shortee`
--

-- --------------------------------------------------------

--
-- Structure de la table `adonis_schema`
--

CREATE TABLE `adonis_schema` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  `migration_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `adonis_schema`
--

INSERT INTO `adonis_schema` (`id`, `name`, `batch`, `migration_time`) VALUES
(5, 'database/migrations/1749075965617_create_users_table', 1, '2025-06-06 22:21:54'),
(6, 'database/migrations/1749245067148_create_urls_table', 1, '2025-06-06 22:21:56'),
(7, 'database/migrations/1749245430022_create_clicks_table', 1, '2025-06-06 22:21:58'),
(8, 'database/migrations/1749399405650_create_add_max_clicks_to_urls_table', 2, '2025-06-08 16:22:30');

-- --------------------------------------------------------

--
-- Structure de la table `adonis_schema_versions`
--

CREATE TABLE `adonis_schema_versions` (
  `version` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `adonis_schema_versions`
--

INSERT INTO `adonis_schema_versions` (`version`) VALUES
(2);

-- --------------------------------------------------------

--
-- Structure de la table `clicks`
--

CREATE TABLE `clicks` (
  `id` int(10) UNSIGNED NOT NULL,
  `url_id` int(10) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `clicked_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `clicks`
--

INSERT INTO `clicks` (`id`, `url_id`, `ip_address`, `user_agent`, `clicked_at`, `description`, `created_at`, `updated_at`) VALUES
(1, 4, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-06-08 15:37:02', 'Clicked from redirect endpoint', '2025-06-08 15:37:02', '2025-06-08 15:37:02'),
(2, 10, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', '2025-06-08 22:06:09', 'Clicked from redirect endpoint', '2025-06-08 22:06:09', '2025-06-08 22:06:09');

-- --------------------------------------------------------

--
-- Structure de la table `urls`
--

CREATE TABLE `urls` (
  `id` int(10) UNSIGNED NOT NULL,
  `original_url` varchar(255) DEFAULT NULL,
  `short_code` varchar(255) DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `clicks` int(11) DEFAULT 0,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `max_clicks` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `urls`
--

INSERT INTO `urls` (`id`, `original_url`, `short_code`, `expires_at`, `clicks`, `user_id`, `created_at`, `updated_at`, `max_clicks`) VALUES
(1, 'https://microsoftedge.microsoft.com/addons/detail/translate-a-website-into-/bbihhnkfijmampfkmmdmcmchfbnphkoa', '3brQDE', NULL, 0, 1, '2025-06-06 22:25:52', '2025-06-06 22:25:52', NULL),
(2, 'https://microsoftedge.microsoft.com/addons/detail/translate-a-website-into-/bbihhnkfijmampfkmmdmcmchfbnphkoa', '-DVTLz', NULL, 0, 1, '2025-06-07 07:24:38', '2025-06-07 07:24:38', NULL),
(3, 'https://docs.adonisjs.com/guides/views-and-templates/introduction', 'sqexDN', '2025-06-12 07:32:00', 0, 1, '2025-06-07 07:32:27', '2025-06-07 07:32:27', NULL),
(4, 'https://docs.adonisjs.com/guides/views-and-templates/introduction', 'YlxeW9', '2025-06-12 15:36:00', 0, 1, '2025-06-08 15:36:14', '2025-06-08 15:36:14', NULL),
(5, 'https://edgejs.dev/docs/components/layouts', 'yTfdu2', '2025-06-05 15:45:00', 0, 1, '2025-06-08 15:45:37', '2025-06-08 15:45:37', NULL),
(6, 'https://fr.pinterest.com/pin/343681015332364264/', 'FPuycc', '2025-06-11 21:24:00', 0, NULL, '2025-06-08 21:24:17', '2025-06-08 21:24:17', 5),
(7, 'https://microsoftedge.microsoft.com/addons/detail/translate-a-website-into-/bbihhnkfijmampfkmmdmcmchfbnphkoa', 'twVfUg', '2025-06-05 21:24:00', 0, NULL, '2025-06-08 21:54:51', '2025-06-08 21:54:51', 5),
(8, 'https://github-com.translate.goog/adonisjs/eslint-plugin-adonisjs?_x_tr_sl=auto&_x_tr_tl=fr&_x_tr_hl=fr#prefer-lazy-controller-import', 'stUGTS', '2025-06-13 21:55:00', 0, NULL, '2025-06-08 21:55:59', '2025-06-08 21:55:59', 5),
(9, 'https://fr.pinterest.com/pin/343681015332364264/', 'BVmf99', '2025-06-11 22:00:00', 0, NULL, '2025-06-08 22:00:05', '2025-06-08 22:00:05', 5),
(10, 'https://fr.pinterest.com/pin/343681015332364264/', '_isunR', '2025-06-11 22:00:00', 0, NULL, '2025-06-08 22:05:55', '2025-06-08 22:05:55', 5),
(11, 'https://fr.pinterest.com/pin/343681015332364264/', 'a51tiV', '2025-06-11 22:18:00', 0, NULL, '2025-06-08 22:18:37', '2025-06-08 22:18:37', 5),
(12, 'https://microsoftedge.microsoft.com/addons/detail/translate-a-website-into-/bbihhnkfijmampfkmmdmcmchfbnphkoa', 'LulZMs', NULL, 0, NULL, '2025-06-08 23:06:25', '2025-06-08 23:06:25', 5),
(13, 'https://docs.adonisjs.com/guides/views-and-templates/introduction', 'a9osnf', NULL, 0, NULL, '2025-06-08 23:07:37', '2025-06-08 23:07:37', 5);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `password`, `created_at`, `updated_at`) VALUES
(1, ' koffi marius', 'mkoffi@gmail.com', '$scrypt$n=16384,r=8,p=1$ME/JYhuNtxM85I6CXqecsQ$XAUPHg2IPhkg+AzQw+WUEcs35GEF5ikS9PqRVEiwRr3VJaabXELyt7+hZCYTL1hckij4z2EvHFSVpO71+SePwg', '2025-06-06 22:25:30', '2025-06-06 22:25:30');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `adonis_schema`
--
ALTER TABLE `adonis_schema`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `adonis_schema_versions`
--
ALTER TABLE `adonis_schema_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `clicks`
--
ALTER TABLE `clicks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clicks_url_id_foreign` (`url_id`);

--
-- Index pour la table `urls`
--
ALTER TABLE `urls`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `urls_short_code_unique` (`short_code`),
  ADD KEY `urls_user_id_foreign` (`user_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `adonis_schema`
--
ALTER TABLE `adonis_schema`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `clicks`
--
ALTER TABLE `clicks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `urls`
--
ALTER TABLE `urls`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `clicks`
--
ALTER TABLE `clicks`
  ADD CONSTRAINT `clicks_url_id_foreign` FOREIGN KEY (`url_id`) REFERENCES `urls` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `urls`
--
ALTER TABLE `urls`
  ADD CONSTRAINT `urls_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
