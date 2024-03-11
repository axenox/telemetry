CREATE TABLE `checklist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_on` datetime NOT NULL DEFAULT (now()),
  `modified_on` datetime NOT NULL DEFAULT (now()),
  `created_by_user_oid` binary(16) NOT NULL,
  `modified_by_user_oid` binary(16) NOT NULL,
  `operation_id` int DEFAULT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `component_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `component_id` (`component_id`),
  CONSTRAINT `checklist_ibfk_1` FOREIGN KEY (`component_id`) REFERENCES `component` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;


CREATE TABLE `checklist_data` (
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
  CONSTRAINT `checklist_data_ibfk_1` FOREIGN KEY (`checklist_version_id`) REFERENCES `checklist_version` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;


CREATE TABLE `checklist_version` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_on` datetime NOT NULL DEFAULT (now()),
  `modified_on` datetime NOT NULL DEFAULT (now()),
  `created_by_user_oid` binary(16) NOT NULL,
  `modified_by_user_oid` binary(16) NOT NULL,
  `version` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `checklist_id` int NOT NULL,
  `form_definition` longtext NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `Name unique` (`version`,`checklist_id`) USING BTREE,
  KEY `checklist_id` (`checklist_id`),
  CONSTRAINT `checklist_version_ibfk_1` FOREIGN KEY (`checklist_id`) REFERENCES `checklist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;


CREATE TABLE `operation` (
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `created_by_user_oid` binary(16) NOT NULL,
  `modified_by_user_oid` binary(16) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;