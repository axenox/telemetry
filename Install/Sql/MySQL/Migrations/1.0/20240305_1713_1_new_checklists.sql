CREATE TABLE IF NOT EXISTS `checklist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_on` datetime NOT NULL DEFAULT (now()),
  `modified_on` datetime NOT NULL DEFAULT (now()),
  `created_by_user_oid` binary(16) NOT NULL,
  `modified_by_user_oid` binary(16) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `component_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `Name unique` (`name`) USING BTREE,
  KEY `component_id` (`component_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `checklist_data`
--

CREATE TABLE IF NOT EXISTS `checklist_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_on` datetime NOT NULL DEFAULT (now()),
  `modified_on` datetime NOT NULL DEFAULT (now()),
  `created_by_user_oid` binary(16) NOT NULL,
  `modified_by_user_oid` binary(16) NOT NULL,
  `checklist_version_id` int NOT NULL,
  `form_data` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `server_component_log_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `checklist_version_id` (`checklist_version_id`),
  KEY `server_id` (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `checklist_version`
--

CREATE TABLE IF NOT EXISTS `checklist_version` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_on` datetime NOT NULL DEFAULT (now()),
  `modified_on` datetime NOT NULL DEFAULT (now()),
  `created_by_user_oid` binary(16) NOT NULL,
  `modified_by_user_oid` binary(16) NOT NULL,
  `version` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `checklist_id` int NOT NULL,
  `form_definition` longtext NOT NULL,
  `component_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `Name unique` (`version`) USING BTREE,
  KEY `checklist_id` (`checklist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `checklist`
--
ALTER TABLE `checklist`
  ADD CONSTRAINT `checklist_ibfk_1` FOREIGN KEY (`component_id`) REFERENCES `component` (`id`);

--
-- Constraints for table `checklist_data`
--
ALTER TABLE `checklist_data`
  ADD CONSTRAINT `checklist_data_ibfk_1` FOREIGN KEY (`checklist_version_id`) REFERENCES `checklist_version` (`id`),
  ADD CONSTRAINT `checklist_data_ibfk_2` FOREIGN KEY (`server_id`) REFERENCES `server` (`id`);

--
-- Constraints for table `checklist_version`
--
ALTER TABLE `checklist_version`
  ADD CONSTRAINT `checklist_version_ibfk_1` FOREIGN KEY (`checklist_id`) REFERENCES `checklist` (`id`);
COMMIT;
