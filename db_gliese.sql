-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.30 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para db_gliese
CREATE DATABASE IF NOT EXISTS `db_gliese` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_gliese`;

-- Volcando estructura para tabla db_gliese.accessory
CREATE TABLE IF NOT EXISTS `accessory` (
  `id_accessory` int NOT NULL AUTO_INCREMENT,
  `accessory_description` varchar(250) NOT NULL,
  `accessory_price` decimal(10,2) NOT NULL,
  `accessory_stock` int NOT NULL,
  PRIMARY KEY (`id_accessory`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla db_gliese.accessory: ~5 rows (aproximadamente)
DELETE FROM `accessory`;
INSERT INTO `accessory` (`id_accessory`, `accessory_description`, `accessory_price`, `accessory_stock`) VALUES
	(1, 'Funda para teléfono', 5.00, 20),
	(2, 'Correa para reloj', 3.00, 10),
	(3, 'Llavero', 2.00, 15),
	(4, 'Monedero', 7.00, 12),
	(5, 'Gafas de sol', 10.00, 14),
	(6, 'Mochila', 20.00, 10);

-- Volcando estructura para tabla db_gliese.campus
CREATE TABLE IF NOT EXISTS `campus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(45) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.campus: ~3 rows (aproximadamente)
DELETE FROM `campus`;
INSERT INTO `campus` (`id`, `description`, `status`) VALUES
	(1, 'CHANCAY', 1),
	(2, 'HUARAL', 1),
	(3, 'LIMA', 1);

-- Volcando estructura para tabla db_gliese.carrier
CREATE TABLE IF NOT EXISTS `carrier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_document_type` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `document_number` varchar(20) NOT NULL,
  `address` varchar(150) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `business_name` varchar(256) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `document_number` (`document_number`) USING BTREE,
  KEY `id_document_type` (`id_document_type`) USING BTREE,
  CONSTRAINT `FK_CARRIER_DOCUMENT_TYPE` FOREIGN KEY (`id_document_type`) REFERENCES `document_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.carrier: ~3 rows (aproximadamente)
DELETE FROM `carrier`;
INSERT INTO `carrier` (`id`, `id_document_type`, `name`, `document_number`, `address`, `phone`, `business_name`, `email`, `status`) VALUES
	(1, 2, 'ALEXANDER ANGEL', '75232411451', 'Asoc Santa Rosa MZ E3 Lote 9', '933430561', 'ANGEL ASOC 5050', 'alexanderdiaz78@gmail.com', 1),
	(2, 1, 'ROSANGELA ', '75418596', 'Asoc Santa Rosa Lote 15 A4', '974852142', 'ROSANGELA ASOC 7890', 'rosangelahuanilo74@gmail.com', 1),
	(3, 1, 'ALEXANDER ANGEL DIAZ GRANADOS', '78456252', 'Chancay 748', '526415748', 'ALEXANDER', 'Angel_1574858@hotmail.com', 1);

-- Volcando estructura para tabla db_gliese.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(120) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.categories: ~2 rows (aproximadamente)
DELETE FROM `categories`;
INSERT INTO `categories` (`id`, `description`, `status`) VALUES
	(2, 'VAMO A PROGRAMAR', 1),
	(3, 'VENDEDORGF', 1);

-- Volcando estructura para tabla db_gliese.clients
CREATE TABLE IF NOT EXISTS `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_document_type` int NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `document_number` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `address` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `phone` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `business_name` varchar(50) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `document_type` (`id_document_type`) USING BTREE,
  CONSTRAINT `FK_CLIENTS_DOCUMENT_TYPE` FOREIGN KEY (`id_document_type`) REFERENCES `document_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.clients: ~0 rows (aproximadamente)
DELETE FROM `clients`;
INSERT INTO `clients` (`id`, `id_document_type`, `name`, `document_number`, `address`, `phone`, `email`, `business_name`, `status`) VALUES
	(1, 1, 'Ruben', '72131009', 'Chancay', '987975591', 'rubengmail.com', 'RYR', 1);

-- Volcando estructura para tabla db_gliese.detail_income
CREATE TABLE IF NOT EXISTS `detail_income` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_product` int NOT NULL,
  `id_income` int NOT NULL,
  `stock` int NOT NULL,
  `purchase_price` decimal(11,2) NOT NULL,
  `sale_price` decimal(11,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_product` (`id_product`),
  CONSTRAINT `FK_INCOME_PRODUCT` FOREIGN KEY (`id_product`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.detail_income: ~0 rows (aproximadamente)
DELETE FROM `detail_income`;

-- Volcando estructura para tabla db_gliese.document_type
CREATE TABLE IF NOT EXISTS `document_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(45) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.document_type: ~2 rows (aproximadamente)
DELETE FROM `document_type`;
INSERT INTO `document_type` (`id`, `description`, `status`) VALUES
	(1, 'DNI', 1),
	(2, 'RUC', 1);

-- Volcando estructura para tabla db_gliese.guest
CREATE TABLE IF NOT EXISTS `guest` (
  `id_guest` int NOT NULL AUTO_INCREMENT,
  `document_type` varchar(50) NOT NULL,
  `document_number` varchar(50) NOT NULL,
  `first_names` varchar(50) NOT NULL,
  `last_names` varchar(50) NOT NULL,
  `address` varchar(255) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_guest`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla db_gliese.guest: ~8 rows (aproximadamente)
DELETE FROM `guest`;
INSERT INTO `guest` (`id_guest`, `document_type`, `document_number`, `first_names`, `last_names`, `address`, `company_name`) VALUES
	(1, 'DNI', '12345678', 'Juan', 'Perez', 'Calle 123', ''),
	(2, 'DNI', '77707469', 'ANDRES ALEJANDRO', 'HUAMANI VILLAGOMEZ', 'Jiron Tablao', ''),
	(3, 'DNI', '76389289', 'VERONICA', 'YANQUE CAHUANTICO', 'Avenida Bolivar', ''),
	(4, 'RUC', '20100047218', '', '', 'CAL. CENTENARIO NRO. 156 URB. LAS LADERAS DE MELGAREJO LIMA LIMA LA MOLINA', 'BANCO DE CREDITO DEL PERU'),
	(5, 'DNI', '76535554', 'ALEX CHRISTOPHER', 'CORREA GONZALES', 'MIRAFLORES', ''),
	(6, 'RUC', '20100053455', '', '', 'AV. CARLOS VILLARAN NRO. 140 URB. SANTA CATALINA LIMA LIMA LA VICTORIA', 'BANCO INTERNACIONAL DEL PERU-INTERBANK'),
	(7, 'DNI', '33562458', 'TADEO', 'REQUEJO CARRERO', 'LIMA', ''),
	(8, 'RUC', '20263322496', '', '', 'CAL. LUIS GALVANI NRO. 493 URB. LOTIZACION INDUSTRIAL SAN LIMA LIMA ATE', 'NESTLE PERU S A');

-- Volcando estructura para tabla db_gliese.income
CREATE TABLE IF NOT EXISTS `income` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_supplier` int NOT NULL,
  `id_user` int NOT NULL,
  `id_voucher_type` int NOT NULL,
  `id_payment_type` int NOT NULL,
  `proof_series` varchar(7) DEFAULT NULL,
  `voucher_series` varchar(10) NOT NULL,
  `proof_date` datetime NOT NULL,
  `igv` decimal(4,2) NOT NULL,
  `number_installments` int DEFAULT NULL,
  `installment_value` decimal(11,2) DEFAULT NULL,
  `full_purchase` decimal(11,2) NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `id_supplier` (`id_supplier`),
  KEY `id_user` (`id_user`),
  KEY `id_voucher_type` (`id_voucher_type`),
  KEY `id_payment_type` (`id_payment_type`),
  CONSTRAINT `FK_INCOME_PAYMENT_TYPE` FOREIGN KEY (`id_payment_type`) REFERENCES `payment_type` (`id`),
  CONSTRAINT `FK_INCOME_SUPPLIER` FOREIGN KEY (`id_supplier`) REFERENCES `supplier` (`id`),
  CONSTRAINT `FK_INCOME_USER` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_INCOME_VOUCHER_TYPE` FOREIGN KEY (`id_voucher_type`) REFERENCES `voucher_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.income: ~0 rows (aproximadamente)
DELETE FROM `income`;
INSERT INTO `income` (`id`, `id_supplier`, `id_user`, `id_voucher_type`, `id_payment_type`, `proof_series`, `voucher_series`, `proof_date`, `igv`, `number_installments`, `installment_value`, `full_purchase`, `status`) VALUES
	(1, 1, 13, 1, 1, 'B001', '00000001', '2023-03-30 21:43:58', 0.18, NULL, NULL, 100.50, '1');

-- Volcando estructura para tabla db_gliese.intent
CREATE TABLE IF NOT EXISTS `intent` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.intent: ~30 rows (aproximadamente)
DELETE FROM `intent`;
INSERT INTO `intent` (`id`, `token`) VALUES
	(12, 'gjYSL8sm4porYSQSPo436rnlxTIqTpgfW9jgjnwtfze3caCPGAAZIHGF1n7mlWNvaA863E4TYam55/Pm+LwjiBGPnvSoTQ7QD88mYd5pM4cUpWQgJThJKHGRZL1EsNtsdpBAmg=='),
	(13, 'gjYSL8sm4porYSQSPo436rnlxTIqTpgfW9jgjnwtfze3caCPGAAZIHGF1n7mlWNvaA863E4TYam55/Pm+LwjiBGPnvSoTQ7QD88mYd5pM4cUpWQgJThJKHGRZL1EsNtsdpBAmg=='),
	(14, 'gjYSL8sm4porYSQSPo436rnlxTIqTpgfW9jgjnwtfze3caCPGAAZIHGF1n7mlWNvaA863E4TYam55/Pm+LwjiBGPnvSoTQ7QD88mYd5pM4cUpWQgJThJKHGRZL1EsNtsdpBAmg=='),
	(15, 'gjYSL8sm4porYSQSPo436rnlxTIqTpgfW9jgjnwtfze3caCPGAAZIHGF1n7mlWNvaA863E4TYam55/Pm+LwjiBGPnvSoTQ7QD88mYd5pM4cUpWQgJThJKHGRZL1EsNtsdpBAmg=='),
	(16, 'EFj4ncJXv2k7BoTw6rZUJ7Qto8w/U2stpqCNZY0boNeX8Q7/noplT8/at/4a55wyFySCmYyf5cN0rDX3c+p9u28OyYSJeeJsyvg7fgbo+3IihvmAWidiivGDJGYoJMywbhIZdA=='),
	(17, 'RXy0/jSAd5JczrdApFzVgMPPoN9ZJ7RR1JdvuG5bKZ3443zRi8vjrEqYRwkikqQ2fU7BKe3H3A3IACnGLt97aVeRUDl9VL/3hqUx7HSR+EtlAj6HGCZ6TKjLL6bm3GiNuI8MIQ=='),
	(18, 'RXy0/jSAd5JczrdApFzVgMPPoN9ZJ7RR1JdvuG5bKZ3443zRi8vjrEqYRwkikqQ2fU7BKe3H3A3IACnGLt97aVeRUDl9VL/3hqUx7HSR+EtlAj6HGCZ6TKjLL6bm3GiNuI8MIQ=='),
	(19, 'VYtGUGue1OCp8/5QBhcIi3ShJbk85/YmVbk3iENr8rIseReWUKYmyZ9BPSmQJflxXaZlVIg62LFTcneW9aJBMVZT6srkr+wXoTGA0pzbPKXKZOPIF+U2dwTS6JX3RDysc12VjA=='),
	(20, '3ckmMmMWPQfjL1f5lUk3P+kf38KcpJca/H8FExPCtPDZ6qvN/JaaZAMP/yevdj6Kglp/jhDZhTnnjOs88mh6FM8au67U+FLaEFtG5Jktwhs9e0rjGrfCbbLWnhojZWb53P1/Jg=='),
	(21, 'ao4rLnLR32VGiEXTRJnRDvUa0/YeDi30TSIcPdbYLAdF8SS54edHQXF3yx6rCs3XBfuHr4C04kmqU9XJd5Ya5YlMZSdQDgCZTykvcHIrHGC+QrXzHtu8YLeshLb3W5pmQW5avw=='),
	(22, '4M2cNr72yhLkmPpw+xXJt82moY7QeBgsAWNznGMkjnIbP3LrxA8OFdi3itOI9y38HC0rsQrgxKnE43AKUpVTTnRM/yUME4sFTUVKX/iWYvsYdkqcfh8P662f+Apoj0/chlz3Og=='),
	(23, '4LDRDYaAaQu9fMJdJdpk43GN4uDk4tNzN6RZEhYdSJqSXlCSuDNPZA+wqVY5RVTw+qNyOVA+YbNjZrkXDMINumRg1st8sftzpcQvvp57tbDD3077aHoHnOP2CJ+78V8795lA1g=='),
	(24, 'qQ82xrb5o3w/NUv8+4xU3QLIFSXYmLoFuXE4B8CQGn5vlKZRYBJaVRLyM6go8SAdHb0bSD6w/gARnwrZINKjOwYHjqpb5gTRDYxSsV1gxnzTknpZP2DT7G139Qbvi0uNpXY+6Q=='),
	(25, 'wwDgSp8/w8HlzFp4ixnFeGaa3QjTF8WqFCDzMjLIMDyDinMVMTjDcmBK7WLGJ1fBtsBsQh4MFZs8YWD1w9IwpWYck99EKXOeHzyZaOqvWzaAvoNO6IiO/Exl5evaBVFqZr2uFw=='),
	(26, 'vmPuFTwgdHAcR54wS9/Goo8pse63dXIBiJsW1EYaKuK2FBHGrV6HZG4pyOPZpooyuhwExlF256fpgQA9O0jWvfazf04VrRTk+//IfXO4v7sk0wqxhdl9hmQBQYo095JMCRyUXA=='),
	(27, 'JdJdygjLOIbVjFg93+AaR4DdFoOgOzp1WI7UI0fECYCcxee+3vC+rHpQki4hgHhAGQC7BU/3EhYuMkPNoBbuynjNIs4vWQT+vu83fNPl+za0xP+4qHPRhQfa4+HG8KLyX4rhDQ=='),
	(28, 'JdJdygjLOIbVjFg93+AaR4DdFoOgOzp1WI7UI0fECYCcxee+3vC+rHpQki4hgHhAGQC7BU/3EhYuMkPNoBbuynjNIs4vWQT+vu83fNPl+za0xP+4qHPRhQfa4+HG8KLyX4rhDQ=='),
	(29, 'JdJdygjLOIbVjFg93+AaR4DdFoOgOzp1WI7UI0fECYCcxee+3vC+rHpQki4hgHhAGQC7BU/3EhYuMkPNoBbuynjNIs4vWQT+vu83fNPl+za0xP+4qHPRhQfa4+HG8KLyX4rhDQ=='),
	(30, 'dny3DYhuE4cX88faDKbj/zD5GpT6ckZgs1zIhRhNObiRFaQaWLywK7n94lp48J8aDoKxvbhP2h5S3lvFtg6oVAYs2969pxivipecdEgE+/Dwa74ZYW7sWRMZtwJ3t9N2E8PhZw=='),
	(31, 'brasEAQFOXbEYDh1VB98yhujiqk+XYiFCMJQXKarLW30UnE7yG2EMGAzFeFMxsC/mpDroNMx/L/B86Jv40GzgK/7a0m/xR9O60AcSWy4j/ba0U9qqknsexBBPsg2+29G4M4mfQ=='),
	(32, 'L2kllk6Q0VL0QTBZDQL2PmGmZIWpAdkrvPESQudzKytCTKMdDeaXh3dCnxa9U3Evi5NeI6k/lWK3QuakCNo2uvW67oL4yiuUKb4d3BtY1nLDeK7ctpwSHRKTFXheCtGKU2EScA=='),
	(33, 'CMuIs0DXfHTOmVt07WOg2SmVesqlt6TB10eQiY6QORXdp5eOIj9O05rfVRjrLqYfUOLM4n4iIOXmPElpfvQfGmMZLSTbKSQzP5ms70Zm+xKYAGuIzzO1Dt1pAnu3DvPMmF3hPw=='),
	(34, 'CMuIs0DXfHTOmVt07WOg2SmVesqlt6TB10eQiY6QORXdp5eOIj9O05rfVRjrLqYfUOLM4n4iIOXmPElpfvQfGmMZLSTbKSQzP5ms70Zm+xKYAGuIzzO1Dt1pAnu3DvPMmF3hPw=='),
	(35, 'yTJYC0YLWYYPgXyPI1oWliNEbOS/ngEp/iaqpTdiOBYtHoOzHqHvnjlZBYPLHRX2sxk4hSRTnvozwY3wLIfHXXmvoT3TXryGo3tqyUZoFOCP1HMTjcmkR9YMtMqagYNj+E2wtg=='),
	(36, '8/I+RafHkUtOZd5zLst9jXUwIrTeRcTXZq/oi8gPN8ULJ+8k7P4gN3DvD8Ov+s6zRr7lsDkB7epwBu65BDvu870wnP4Dsco5DVgqN2x9WzEhDpLagd6QHFDXXyOPn0EudP9Qlw=='),
	(37, 'qAtNqKFIkKUEZvdyphz7yiVUgS739UsxIdfYGtRIGimf77hJytInC4BRcgOuU6wXl7W7RGvHN3sK3nuAgezuYks8P2gwFcxLLXOzpURgGbTKnSckf7COSKeaGCP9iCtKHNQfoA=='),
	(38, 'qAtNqKFIkKUEZvdyphz7yiVUgS739UsxIdfYGtRIGimf77hJytInC4BRcgOuU6wXl7W7RGvHN3sK3nuAgezuYks8P2gwFcxLLXOzpURgGbTKnSckf7COSKeaGCP9iCtKHNQfoA=='),
	(39, 'S+IpMWva4SxhY02Q/Ji1nPI/5U4CUa0C2Ed2VZyvqiGENtiZ5R8RpI3QTP7oOXuy6WHTspEgBXeZ+UJje3ztmVCZNJSx/R5T2MbWX4JG2vzRM3psV7oEJy6kPueC6LZHUxVJgA=='),
	(40, 'F4RYFozjjXXKkOcYeoxqJqzPCXP7FTe1hb0rOqJXLKqZFx/RkaDoeat9+H/MiPsgmWFFyn1zn4fLCmydtdwC3WHNF5cCb5s8W0HT/ZGgJMhXQli8723mQG/josKKY3pimIdQ6Q=='),
	(41, 'V64jBc2nzgGGt7RgJiHGnRm0Bnb6bPIPjbmpzP0PicNadtNCW9qLzqK0rbKcEaRfpm7Q0sX6nX62PeGgje+klo1PW6AHUH+X2B7L2pwynU2HHWYAkIdwNMK4MQHYni/QSO3StA==');

-- Volcando estructura para tabla db_gliese.kardex
CREATE TABLE IF NOT EXISTS `kardex` (
  `id_kardex` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `product` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `entry` int DEFAULT NULL,
  `exit` int DEFAULT NULL,
  `balance` int DEFAULT NULL,
  PRIMARY KEY (`id_kardex`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla db_gliese.kardex: ~7 rows (aproximadamente)
DELETE FROM `kardex`;
INSERT INTO `kardex` (`id_kardex`, `code`, `product`, `category`, `entry`, `exit`, `balance`) VALUES
	(1, '12345678', 'AGUA CIELO', 'BEBIDA', 12, 3, 9),
	(2, '214335354', 'GALLETA RITZ', 'COMIDA', 30, 21, 9),
	(3, '124578965', 'CEREAL CRUNCH', 'DESAYUNO', 50, 15, 35),
	(4, '789654321', 'AGUA MINERAL', 'BEBIDA', 40, 10, 30),
	(5, '654321987', 'CHOCOLATE AMARGO', 'DULCES', 25, 8, 17),
	(6, '987654321', 'YOGUR NATURAL', 'LÁCTEOS', 20, 5, 15),
	(7, '333333333', 'PASTA INTEGRAL', 'CEREALES', 15, 7, 8);

-- Volcando estructura para tabla db_gliese.meal
CREATE TABLE IF NOT EXISTS `meal` (
  `id_meal` int NOT NULL AUTO_INCREMENT,
  `meal_sku` varchar(250) NOT NULL,
  `meal_name` varchar(100) NOT NULL,
  `meal_description` varchar(250) NOT NULL,
  `id_category` int NOT NULL,
  `meal_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_meal`),
  UNIQUE KEY `meal_sku` (`meal_sku`),
  KEY `id_meal` (`id_category`),
  CONSTRAINT `id_meal` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla db_gliese.meal: ~4 rows (aproximadamente)
DELETE FROM `meal`;
INSERT INTO `meal` (`id_meal`, `meal_sku`, `meal_name`, `meal_description`, `id_category`, `meal_price`) VALUES
	(1, 'ZG011AQA', 'Lomo saltado', 'Tiene papa,cebolla,tomate', 3, 10.00),
	(2, 'TH045AKH', 'Cau Cau', 'tiene papa,zanahoria', 3, 8.00),
	(3, 'RGM344GD', 'Ceviche', 'tiene pescado,limon,cebolla', 3, 20.00),
	(4, 'KI343JFG', 'Chaufa', 'tiene arroz,sillao', 3, 7.00);

-- Volcando estructura para tabla db_gliese.menu
CREATE TABLE IF NOT EXISTS `menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(80) NOT NULL,
  `icon` varchar(45) DEFAULT NULL,
  `order` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.menu: ~7 rows (aproximadamente)
DELETE FROM `menu`;
INSERT INTO `menu` (`id`, `description`, `icon`, `order`) VALUES
	(1, 'Habitaciones', 'home', 1),
	(2, 'Ventas', 'shopping-cart', 2),
	(3, 'Almacen', 'package', 3),
	(4, 'Caja', 'archive', 4),
	(5, 'Reportes', 'clipboard', 5),
	(6, 'Administración', 'sliders', 6),
	(7, 'Configuraciones', 'settings', 7);

-- Volcando estructura para tabla db_gliese.notification
CREATE TABLE IF NOT EXISTS `notification` (
  `id_notification` int NOT NULL AUTO_INCREMENT,
  `date_notification` date NOT NULL,
  `time_notification` time NOT NULL,
  `type` varchar(255) NOT NULL,
  `id_reservation` int NOT NULL,
  `status_notification` varchar(50) NOT NULL,
  `sku_notification` varchar(100) NOT NULL,
  PRIMARY KEY (`id_notification`),
  KEY `id_reservation` (`id_reservation`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`id_reservation`) REFERENCES `reservation` (`id_reservation`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla db_gliese.notification: ~0 rows (aproximadamente)
DELETE FROM `notification`;

-- Volcando estructura para tabla db_gliese.payment
CREATE TABLE IF NOT EXISTS `payment` (
  `id_payment` int NOT NULL AUTO_INCREMENT,
  `id_reservation` int NOT NULL,
  `payment_room` decimal(10,2) DEFAULT NULL,
  `payment_sales` decimal(10,2) DEFAULT NULL,
  `payment_extra` decimal(10,2) DEFAULT NULL,
  `payment_discount` decimal(10,2) DEFAULT NULL,
  `pre_payment` decimal(10,2) DEFAULT NULL,
  `payment_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_payment`),
  KEY `id_reservation` (`id_reservation`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`id_reservation`) REFERENCES `reservation` (`id_reservation`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla db_gliese.payment: ~0 rows (aproximadamente)
DELETE FROM `payment`;

-- Volcando estructura para tabla db_gliese.payment_extra
CREATE TABLE IF NOT EXISTS `payment_extra` (
  `id_extra` int NOT NULL AUTO_INCREMENT,
  `extra_time` time NOT NULL,
  `price_extra` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_extra`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla db_gliese.payment_extra: ~4 rows (aproximadamente)
DELETE FROM `payment_extra`;
INSERT INTO `payment_extra` (`id_extra`, `extra_time`, `price_extra`) VALUES
	(1, '00:20:00', 10.00),
	(2, '01:00:00', 20.00),
	(3, '02:00:00', 30.00),
	(4, '03:00:00', 50.00);

-- Volcando estructura para tabla db_gliese.payment_type
CREATE TABLE IF NOT EXISTS `payment_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(50) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.payment_type: ~3 rows (aproximadamente)
DELETE FROM `payment_type`;
INSERT INTO `payment_type` (`id`, `description`, `status`) VALUES
	(1, 'Contado', 1),
	(2, 'Credito', 1),
	(3, 'Transferencia', 1);

-- Volcando estructura para tabla db_gliese.permission
CREATE TABLE IF NOT EXISTS `permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_role` int NOT NULL,
  `id_sub_menu` int NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK_PERMISSION_ROLE` (`id_role`),
  KEY `FK_PERMISSION_SUB_MENU` (`id_sub_menu`),
  CONSTRAINT `FK_PERMISSION_ROLE` FOREIGN KEY (`id_role`) REFERENCES `role` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_PERMISSION_SUB_MENU` FOREIGN KEY (`id_sub_menu`) REFERENCES `sub_menu` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.permission: ~25 rows (aproximadamente)
DELETE FROM `permission`;
INSERT INTO `permission` (`id`, `id_role`, `id_sub_menu`, `status`) VALUES
	(1, 1, 1, 1),
	(2, 1, 6, 1),
	(3, 1, 7, 1),
	(4, 1, 8, 1),
	(5, 1, 9, 1),
	(6, 1, 10, 1),
	(7, 1, 11, 1),
	(15, 1, 12, 1),
	(16, 1, 13, 1),
	(17, 1, 14, 1),
	(18, 1, 15, 1),
	(19, 1, 16, 1),
	(20, 1, 17, 1),
	(21, 1, 18, 1),
	(22, 1, 2, 1),
	(23, 1, 3, 1),
	(24, 1, 4, 1),
	(25, 1, 5, 1),
	(26, 1, 19, 1),
	(27, 1, 20, 1),
	(28, 1, 21, 1),
	(29, 1, 22, 1),
	(30, 1, 23, 1),
	(31, 1, 24, 1),
	(32, 1, 25, 1);

-- Volcando estructura para tabla db_gliese.product
CREATE TABLE IF NOT EXISTS `product` (
  `id_product` int NOT NULL AUTO_INCREMENT,
  `product_sku` varchar(250) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `product_description` varchar(250) NOT NULL,
  `id_category` int NOT NULL,
  `product_price` decimal(10,2) NOT NULL,
  `product_stock` int NOT NULL,
  `expiration_date` date NOT NULL,
  `status_expiration_date` int NOT NULL,
  PRIMARY KEY (`id_product`),
  UNIQUE KEY `product_sku` (`product_sku`),
  KEY `id_category` (`id_category`),
  CONSTRAINT `id_category` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla db_gliese.product: ~6 rows (aproximadamente)
DELETE FROM `product`;
INSERT INTO `product` (`id_product`, `product_sku`, `product_name`, `product_description`, `id_category`, `product_price`, `product_stock`, `expiration_date`, `status_expiration_date`) VALUES
	(1, 'ZG011AQA', 'Rellenita', 'Galleta fabricado por la empresa San Jorge', 3, 1.00, 24, '2023-10-27', 1),
	(2, 'TH045AKH', 'Agua cielo', 'Bebida fabricado por la empresa  Grupo AJE', 3, 1.50, 14, '2023-10-27', 0),
	(3, 'RGM344GD', 'Coca cola', 'Bebida fabricado por la empresa Coca-Cola Company', 3, 3.50, 18, '2023-10-27', 1),
	(4, 'KI343JFG', 'Ritz', 'Galleta fabricado por la empresa Nabisco', 3, 1.50, 23, '2023-10-27', 1),
	(5, 'ER194RGJ', 'Inka cola', 'Bebida fabricado por la empresa Arca Continental Lindley S.A', 3, 3.50, 18, '2023-10-27', 1),
	(6, '123345', 'Yougurt', 'Bebida', 3, 4.00, 6, '2023-10-27', 1);

-- Volcando estructura para tabla db_gliese.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_category` int DEFAULT NULL,
  `description` varchar(100) NOT NULL,
  `stock` int DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `expiration_date` int DEFAULT NULL,
  `status_expiration_date` tinyint(1) NOT NULL DEFAULT '1',
  `ts_start` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `description` (`description`),
  UNIQUE KEY `code` (`code`),
  KEY `id_categories` (`id_category`) USING BTREE,
  CONSTRAINT `FK_PRODUCTS_CATEGORIES` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.products: ~8 rows (aproximadamente)
DELETE FROM `products`;
INSERT INTO `products` (`id`, `id_category`, `description`, `stock`, `code`, `status`, `expiration_date`, `status_expiration_date`, `ts_start`) VALUES
	(97, 2, 'DESC 01', 52, '01', 1, NULL, 1, 1681254999),
	(112, 3, 'DESC 02', 90, '02', 1, NULL, 1, 1681250641),
	(115, 2, 'DESC 03', 90, '03', 1, NULL, 1, 1681250783),
	(116, 3, 'DESC 04', 15, '04', 1, NULL, 1, 0),
	(117, 3, 'DESC 05', 150, '05', 1, NULL, 1, 1681249710),
	(129, 3, 'DESC 06', 60, '06', 1, NULL, 1, 1681251158),
	(130, 3, 'DESC 07', 70, '07', 1, NULL, 1, 0),
	(131, 2, 'DESC 08', 15, '08', 1, NULL, 1, 1681251540);

-- Volcando estructura para tabla db_gliese.reservation
CREATE TABLE IF NOT EXISTS `reservation` (
  `id_reservation` int NOT NULL AUTO_INCREMENT,
  `checkin_date` date NOT NULL,
  `checkin_time` time NOT NULL,
  `checkout_date` date DEFAULT NULL,
  `checkout_time` time DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  `departure_time` time DEFAULT NULL,
  `id_room` int NOT NULL,
  `id_guest` int NOT NULL,
  `status` varchar(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_reservation`),
  KEY `id_room` (`id_room`),
  KEY `id_guest` (`id_guest`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`id_room`) REFERENCES `room` (`id_room`),
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`id_guest`) REFERENCES `guest` (`id_guest`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla db_gliese.reservation: ~0 rows (aproximadamente)
DELETE FROM `reservation`;

-- Volcando estructura para tabla db_gliese.role
CREATE TABLE IF NOT EXISTS `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(45) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.role: ~0 rows (aproximadamente)
DELETE FROM `role`;
INSERT INTO `role` (`id`, `description`, `status`) VALUES
	(1, 'ADMINISTRADOR', 1);

-- Volcando estructura para tabla db_gliese.room
CREATE TABLE IF NOT EXISTS `room` (
  `id_room` int NOT NULL AUTO_INCREMENT,
  `room_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `room_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `id_type` int DEFAULT NULL,
  PRIMARY KEY (`id_room`),
  UNIQUE KEY `room_number` (`room_number`),
  KEY `id_type` (`id_type`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`id_type`) REFERENCES `room_type` (`id_type`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla db_gliese.room: ~2 rows (aproximadamente)
DELETE FROM `room`;
INSERT INTO `room` (`id_room`, `room_number`, `room_status`, `id_type`) VALUES
	(26, '1', 'Disponible', 3),
	(27, '2', 'Disponible', 1),
	(28, '3', 'Disponible', 2),
	(29, '4', 'Disponible', 3),
	(30, '5', 'Disponible', 1),
	(31, '6', 'Disponible', 2);

-- Volcando estructura para tabla db_gliese.room_type
CREATE TABLE IF NOT EXISTS `room_type` (
  `id_type` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  `person_limit` int NOT NULL,
  `price_temporary` decimal(10,2) NOT NULL,
  `price_half` decimal(10,2) NOT NULL,
  `price_day` decimal(10,2) NOT NULL,
  `bed_type` varchar(150) NOT NULL,
  PRIMARY KEY (`id_type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla db_gliese.room_type: ~3 rows (aproximadamente)
DELETE FROM `room_type`;
INSERT INTO `room_type` (`id_type`, `type_name`, `person_limit`, `price_temporary`, `price_half`, `price_day`, `bed_type`) VALUES
	(1, 'Simple', 2, 30.00, 40.00, 50.00, '1 x Dos plazas'),
	(2, 'Doble', 4, 40.00, 50.00, 60.00, '2 x Dos plazas'),
	(3, 'Triple', 6, 50.00, 90.00, 120.00, '2 x Dos plazas, 1 Plaza y media');

-- Volcando estructura para tabla db_gliese.sales_accessory
CREATE TABLE IF NOT EXISTS `sales_accessory` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `id_accessory` int NOT NULL,
  `amount_ac` int NOT NULL,
  `price_sales_ac` decimal(10,2) DEFAULT NULL,
  `id_reservation` int NOT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `id_accessory` (`id_accessory`),
  KEY `id_reservation` (`id_reservation`),
  CONSTRAINT `sales_accessory_ibfk_1` FOREIGN KEY (`id_accessory`) REFERENCES `accessory` (`id_accessory`),
  CONSTRAINT `sales_accessory_ibfk_2` FOREIGN KEY (`id_reservation`) REFERENCES `reservation` (`id_reservation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla db_gliese.sales_accessory: ~0 rows (aproximadamente)
DELETE FROM `sales_accessory`;

-- Volcando estructura para tabla db_gliese.sales_meal
CREATE TABLE IF NOT EXISTS `sales_meal` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `id_meal` int NOT NULL,
  `amount_me` int NOT NULL,
  `price_sales_me` decimal(10,2) DEFAULT NULL,
  `id_reservation` int NOT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `id_meal` (`id_meal`),
  KEY `id_reservation` (`id_reservation`),
  CONSTRAINT `sales_meal_ibfk_1` FOREIGN KEY (`id_meal`) REFERENCES `meal` (`id_meal`),
  CONSTRAINT `sales_meal_ibfk_2` FOREIGN KEY (`id_reservation`) REFERENCES `reservation` (`id_reservation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla db_gliese.sales_meal: ~0 rows (aproximadamente)
DELETE FROM `sales_meal`;

-- Volcando estructura para tabla db_gliese.sales_product
CREATE TABLE IF NOT EXISTS `sales_product` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `id_product` int NOT NULL,
  `amount_pr` int NOT NULL,
  `price_sales_pr` decimal(10,2) DEFAULT NULL,
  `id_reservation` int NOT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `id_product` (`id_product`),
  KEY `id_reservation` (`id_reservation`),
  CONSTRAINT `sales_product_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`),
  CONSTRAINT `sales_product_ibfk_2` FOREIGN KEY (`id_reservation`) REFERENCES `reservation` (`id_reservation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla db_gliese.sales_product: ~0 rows (aproximadamente)
DELETE FROM `sales_product`;

-- Volcando estructura para tabla db_gliese.sub_menu
CREATE TABLE IF NOT EXISTS `sub_menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_menu` int NOT NULL,
  `description` varchar(45) NOT NULL,
  `icon` varchar(45) DEFAULT NULL,
  `url` varchar(80) NOT NULL,
  `order` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK_SUB_MENU_MENU` (`id_menu`),
  CONSTRAINT `FK_SUB_MENU_MENU` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.sub_menu: ~0 rows (aproximadamente)
DELETE FROM `sub_menu`;
INSERT INTO `sub_menu` (`id`, `id_menu`, `description`, `icon`, `url`, `order`) VALUES
	(1, 1, 'Reservas', 'circle', 'Reservation', 1),
	(2, 1, 'Recepción', 'circle', 'Reception', 2),
	(3, 2, 'Ventas', 'circle', 'Sales', 1),
	(4, 2, 'Lista de ventas', 'circle', 'Saleslist', 2),
	(5, 3, 'Accesorios', 'circle', 'Accessories', 3),
	(6, 3, 'Producto', 'circle', 'Product', 4),
	(7, 3, 'Comidas', 'circle', 'Meal', 5),
	(8, 3, 'Categoria', 'circle', 'Categories', 6),
	(9, 4, 'Apertura inicial', 'circle', 'Openingcash', 1),
	(10, 4, 'Cierre de caja', 'circle', 'Closingcash', 2),
	(11, 4, 'Lista de caja', 'circle', 'Cashlist', 3),
	(12, 5, 'Reporte de cliente', 'circle', 'Customer_report', 1),
	(13, 5, 'Reporte mensual', 'circle', 'Monthlyreport', 2),
	(14, 5, 'Reporte de facturas', 'circle', 'Invoicereport', 3),
	(15, 5, 'Reporte de caja', 'circle', 'Cashreport', 4),
	(16, 6, 'Tipo habitación', 'circle', 'Roomtype', 1),
	(17, 6, 'Habitaciones', 'circle', 'Rooms', 2),
	(18, 6, 'Huespedes', 'circle', 'Guests', 3),
	(19, 7, 'Usuarios', 'circle', 'Users', 1),
	(20, 7, 'Roles', 'circle', 'Roles', 2),
	(21, 7, 'Sedes', 'circle', 'Campus', 3),
	(22, 7, 'Personalizar', 'circle', 'Personalization', 4),
	(23, 3, 'Ingresos', 'circle', 'Income', 1),
	(24, 3, 'Kardex', 'circle', 'Kardex', 2),
	(25, 3, 'Proveedores', 'circle', 'Suppliers', 7);

-- Volcando estructura para tabla db_gliese.supplier
CREATE TABLE IF NOT EXISTS `supplier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_document_type` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `document_number` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `address` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `business_name` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `document_number` (`document_number`),
  KEY `id_document_type` (`id_document_type`),
  CONSTRAINT `FK_SUPPLIER_DOCUMENT_TYPE` FOREIGN KEY (`id_document_type`) REFERENCES `document_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla db_gliese.supplier: ~0 rows (aproximadamente)
DELETE FROM `supplier`;
INSERT INTO `supplier` (`id`, `id_document_type`, `name`, `document_number`, `address`, `phone`, `business_name`, `email`, `status`) VALUES
	(1, 1, 'ALEXANDER', '71695889', 'lopez de zuñiga', '915959584', 'R&amp;J ACTION', 'generateindollars@gmail.com', 1),
	(3, 1, 'JEREMI', '72003664', 'Av 1 de mayo', '936672334', 'J&amp;amp;D ACTION', 'jeregr.21042002@gmail.com12', 1),
	(4, 1, 'RUBEN DARIO', '721368235', 'Chancay Lopez 04', '987975591', 'R&amp;R ACTION', 'rubendario7tu@gmail.com', 1),
	(5, 1, 'JEREMI ARMANDO GONZALES RUEDA', '7', 'Av 1 de mayo', '8', 'J&amp;D ACTION ', 'jeregr.21042002@gmail.com', 1),
	(6, 2, 'JUAN PEREZ', '20100047218', 'CAL. CENTENARIO NRO. 156 URB. LAS LADERAS DE MELGAREJO LIMA LIMA LA MOLINA', '8732544744216543', 'INTERNET SAC', 'a@asacgmail.com', 1);

-- Volcando estructura para tabla db_gliese.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_role` int NOT NULL,
  `id_document_type` int NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `document_number` varchar(45) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `telephone` varchar(45) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `user` varchar(45) NOT NULL,
  `password` text NOT NULL,
  `image_url` varchar(100) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_UNIQUE` (`user`),
  UNIQUE KEY `document_number_UNIQUE` (`document_number`),
  KEY `FK_USER_ROLE` (`id_role`),
  KEY `FK_USER_DOCUMENT_TYPE` (`id_document_type`),
  CONSTRAINT `FK_USER_DOCUMENT_TYPE` FOREIGN KEY (`id_document_type`) REFERENCES `document_type` (`id`),
  CONSTRAINT `FK_USER_ROLE` FOREIGN KEY (`id_role`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.user: ~0 rows (aproximadamente)
DELETE FROM `user`;
INSERT INTO `user` (`id`, `id_role`, `id_document_type`, `first_name`, `last_name`, `document_number`, `address`, `telephone`, `email`, `user`, `password`, `image_url`, `status`, `active`) VALUES
	(1, 1, 2, 'Diego', 'Uriarte chancafe', '12345678912', 'Chancay', '913085587', 'grjere698@gmail.com', 'admin', '5a6d4d35597a41334e6a4a6a5a4459784d7a51355a6a457a596d593159324d7a597a566d4d5445784e7a633d', NULL, 1, 1),
	(13, 1, 1, 'Jeremi', 'Gonzales', '8', 'Av. 1 de mayo 1031', '913085589', 'grjere698@gmail.com', 'admin2', '5a6d4d35597a41334e6a4a6a5a4459784d7a51355a6a457a596d593159324d7a597a566d4d5445784e7a633d', NULL, 1, 1),
	(15, 1, 1, 'Ruben', 'Dario', '12345678', 'Av. 1 de mayo 1031', '999888777', 'essaulherrerasangay601@gmail.com', 'admin3', '5a6d4d35597a41334e6a4a6a5a4459784d7a51355a6a457a596d593159324d7a597a566d4d5445784e7a633d', NULL, 1, 1),
	(18, 1, 1, 'Alex', 'Diaz', '88888', 'Calichera', '8', 'generateindollars@gmail.com12', 'admin4', 'admin', NULL, 1, 1),
	(19, 1, 1, 'Leonardo', 'Gonzales', '78945612', 'Av. 1 de mayo 1031', '987975591', 'grjere698@gmail.com', 'Leonardo', '4d47566d4e5463304d6a67774e5746695932557a5a54426a4d6d457a5a6a466b5a57517a4d7a63324e7a673d', NULL, 0, 1);

-- Volcando estructura para tabla db_gliese.user_campus
CREATE TABLE IF NOT EXISTS `user_campus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `id_campus` int NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK_USER_CAMPUS_CAMPUS` (`id_campus`),
  KEY `FK_USER_CAMPUS_USER` (`id_user`),
  CONSTRAINT `FK_USER_CAMPUS_CAMPUS` FOREIGN KEY (`id_campus`) REFERENCES `campus` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_USER_CAMPUS_USER` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.user_campus: ~0 rows (aproximadamente)
DELETE FROM `user_campus`;
INSERT INTO `user_campus` (`id`, `id_user`, `id_campus`, `status`) VALUES
	(1, 1, 1, 1),
	(2, 1, 2, 1),
	(16, 1, 3, 1),
	(17, 13, 1, 1),
	(18, 13, 2, 1),
	(19, 13, 3, 1),
	(20, 15, 1, 1),
	(21, 15, 2, 1),
	(22, 15, 3, 1),
	(23, 18, 1, 1),
	(24, 18, 2, 1),
	(25, 18, 3, 1),
	(26, 19, 2, 1),
	(27, 19, 1, 1),
	(28, 19, 3, 1);

-- Volcando estructura para tabla db_gliese.voucher_type
CREATE TABLE IF NOT EXISTS `voucher_type` (
  `id` int NOT NULL,
  `description` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla db_gliese.voucher_type: ~8 rows (aproximadamente)
DELETE FROM `voucher_type`;
INSERT INTO `voucher_type` (`id`, `description`, `status`) VALUES
	(1, 'Factura', 1),
	(2, 'Boleta de Venta', 1),
	(3, 'Nota de Credito', 1),
	(4, 'Guia de Remisión Remitente', 1),
	(5, 'Cotización', 1),
	(6, 'Orden de Pagos', 1),
	(7, 'Ticket', 1),
	(8, 'Prestamo', 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;