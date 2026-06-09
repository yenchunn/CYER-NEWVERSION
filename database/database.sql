SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP SCHEMA IF EXISTS `cyer`;
CREATE SCHEMA IF NOT EXISTS `cyer` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `cyer`;

DROP TABLE IF EXISTS `reviews`;
DROP TABLE IF EXISTS `orders_items`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `product_images`;
DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `site_counter`;
DROP TABLE IF EXISTS `members`;
DROP TABLE IF EXISTS cart;

CREATE TABLE IF NOT EXISTS `members` (
  `m_id` INT(11) NOT NULL AUTO_INCREMENT,
  `m_email` VARCHAR(100) NOT NULL,
  `m_pwd` VARCHAR(50) NOT NULL,
  `m_name` VARCHAR(50) NOT NULL,
  `m_phone` VARCHAR(20) NOT NULL,
  `m_address` VARCHAR(250) NULL DEFAULT NULL,
  `m_role` INT(11) NOT NULL,
  PRIMARY KEY (`m_id`),
  UNIQUE INDEX `m_email_UNIQUE` (`m_email` ASC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS cart (
  cart_id INT AUTO_INCREMENT PRIMARY KEY,
  member_id INT NOT NULL,
  p_id INT NOT NULL,
  quantity INT NOT NULL DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  UNIQUE KEY uk_member_product (member_id, p_id),

  FOREIGN KEY (member_id) REFERENCES members(m_id),
  FOREIGN KEY (p_id) REFERENCES products(p_id),

  INDEX idx_member (member_id),
  INDEX idx_product (p_id)
);

CREATE TABLE IF NOT EXISTS `orders` (
  `o_id` INT(11) NOT NULL AUTO_INCREMENT,
  `m_id` INT(11) NOT NULL,
  `o_date` DATETIME NOT NULL,
  `o_total_price` INT(11) NOT NULL,
  `o_shupping` VARCHAR(50) NOT NULL,
  `o_address` VARCHAR(250) NOT NULL,
  `o_payment` VARCHAR(50) NOT NULL,
  `o_status` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`o_id`),
  INDEX `fk1_m_id_idx` (`m_id` ASC),
  CONSTRAINT `fk1_m_id`
    FOREIGN KEY (`m_id`) REFERENCES `members` (`m_id`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `products` (
  `p_id` INT(11) NOT NULL AUTO_INCREMENT,
  `p_name` VARCHAR(50) NOT NULL,
  `p_price` INT(11) NOT NULL,
  `p_stock` INT(11) NOT NULL,
  `p_desc` TEXT NOT NULL,
  `p_category` VARCHAR(50) NOT NULL,
  `p_image` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`p_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `product_images` (
  `pic_id` INT NOT NULL AUTO_INCREMENT,
  `p_path` VARCHAR(250) NOT NULL,
  `p_file` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`pic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `orders_items` (
  `item_id` INT(11) NOT NULL AUTO_INCREMENT,
  `o_id` INT(11) NOT NULL,
  `p_id` INT(11) NOT NULL,
  `item_quantity` INT(11) NOT NULL,
  `item_unit_price` INT(11) NOT NULL,
  PRIMARY KEY (`item_id`),
  INDEX `fk1_o_id_idx` (`o_id` ASC),
  INDEX `fk1_p_id_idx` (`p_id` ASC),
  CONSTRAINT `fk1_o_id`
    FOREIGN KEY (`o_id`) REFERENCES `orders` (`o_id`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk1_p_id`
    FOREIGN KEY (`p_id`) REFERENCES `products` (`p_id`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `reviews` (
  `r_id` INT(11) NOT NULL AUTO_INCREMENT,
  `p_id` INT(11) NOT NULL,
  `m_id` INT(11) NOT NULL,
  `r_stars` INT(11) NOT NULL,
  `r_content` TEXT NULL DEFAULT NULL,
  `r_date` DATETIME NOT NULL,
  PRIMARY KEY (`r_id`),
  INDEX `fk2_p_id_idx` (`p_id` ASC),
  INDEX `fk2_m_id_idx` (`m_id` ASC),
  CONSTRAINT `fk2_m_id`
    FOREIGN KEY (`m_id`) REFERENCES `members` (`m_id`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk2_p_id`
    FOREIGN KEY (`p_id`) REFERENCES `products` (`p_id`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `site_counter` (
  `count_id` INT(11) NOT NULL,
  `total_views` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`count_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `members` (`m_id`, `m_email`, `m_pwd`, `m_name`, `m_phone`, `m_address`, `m_role`) VALUES
(1, 'member@example.com', '123456', '王小明', '0912345678', '台北市中正區忠孝東路一段 1 號', 0),
(2, 'admin@example.com', 'admin123', '系統管理員', '0900000000', 'CYER 總部', 1),
(3, 'lin@example.com', '123456', '林怡君', '0922333444', '新北市板橋區文化路 88 號', 0);

INSERT INTO `product_images` (`pic_id`, `p_path`, `p_file`) VALUES
(1, 'image/air', 'air_1.jpg'),
(2, 'image/air', 'air_2.jpg'),
(3, 'image/air', 'air_3.png'),
(4, 'image/air', 'air_4.png'),
(5, 'image/air', 'air_5.png'),
(6, 'image/air', 'air_6.png'),
(7, 'image/de', 'de_1.png'),
(8, 'image/de', 'de_2.png'),
(9, 'image/de', 'de_3.png'),
(10, 'image/de', 'de_4.png'),
(11, 'image/de', 'de_5.png'),
(12, 'image/de', 'de_6.png'),
(13, 'image/fan', 'fan_1.jpg'),
(14, 'image/fan', 'fan_2.jpg'),
(15, 'image/fan', 'fan_3.png'),
(16, 'image/fan', 'fan_4.png'),
(17, 'image/fan', 'fan_5.png'),
(18, 'image/fan', 'fan_6.png'),
(19, 'image/hd', 'hd_1.png'),
(20, 'image/hd', 'hd_2.jpg'),
(21, 'image/hd', 'hd_3.png'),
(22, 'image/hd', 'hd_4.png'),
(23, 'image/hd', 'hd_5.png'),
(24, 'image/hd', 'hd_6.png'),
(25, 'image/ref', 'ref_1.jpg'),
(26, 'image/ref', 'ref_2.jpg'),
(27, 'image/ref', 'ref_3.jpg'),
(28, 'image/ref', 'ref_4.jpg'),
(29, 'image/ref', 'ref_5.jpg'),
(30, 'image/ref', 'ref_6.jpg'),
(31, 'image/vac', 'vac_1.jpg'),
(32, 'image/vac', 'vac_2.jpg'),
(33, 'image/vac', 'vac_3.jpg'),
(34, 'image/vac', 'vac_4.jpg'),
(35, 'image/vac', 'vac_5.jpg'),
(36, 'image/vac', 'vac_6.jpg');

INSERT INTO `products` (`p_id`, `p_name`, `p_price`, `p_stock`, `p_desc`, `p_category`, `p_image`) VALUES
(1, 'CYER 清淨空氣機 A1', 12900, 18, '適合小家庭與臥室使用，具備 HEPA 濾網、低噪音循環與夜間模式，讓日常呼吸更安心。', '空氣清淨機', 'image/air/air_1.jpg'),
(2, 'CYER 清淨空氣機 A2', 14900, 15, '強化粉塵與異味過濾，支援客廳中坪數空間，簡潔外型容易融入居家風格。', '空氣清淨機', 'image/air/air_2.jpg'),
(3, 'CYER 清淨空氣機 A3', 16800, 12, '內建空氣品質感測與自動風量調整，適合重視安靜與穩定淨化的使用者。', '空氣清淨機', 'image/air/air_3.png'),
(4, 'CYER 清淨空氣機 A4', 18900, 9, '高效循環設計搭配多層濾網，能快速改善室內空氣品質並維持低耗能。', '空氣清淨機', 'image/air/air_4.png'),
(5, 'CYER 清淨空氣機 A5', 20900, 10, '支援大坪數空間，具備濾網更換提醒與節能運轉模式，適合客廳與工作室。', '空氣清淨機', 'image/air/air_5.png'),
(6, 'CYER 清淨空氣機 A6', 23900, 7, '旗艦型空氣清淨機，提供快速淨化、低噪音與穩定風道，滿足高品質居家需求。', '空氣清淨機', 'image/air/air_6.png'),
(7, 'CYER 除濕機 D1', 9900, 20, '每日除濕量穩定，適合臥室與書房，降低潮濕與衣物異味。', '除濕機', 'image/de/de_1.png'),
(8, 'CYER 除濕機 D2', 11900, 18, '具備滿水自動停止與連續排水功能，適合台灣潮濕季節長時間使用。', '除濕機', 'image/de/de_2.png'),
(9, 'CYER 除濕機 D3', 13900, 16, '智慧濕度控制可自動維持舒適區間，降低能源浪費並照顧居家環境。', '除濕機', 'image/de/de_3.png'),
(10, 'CYER 除濕機 D4', 15900, 14, '大容量水箱與安靜運轉設計，適合客廳、衣帽間與多雨季節使用。', '除濕機', 'image/de/de_4.png'),
(11, 'CYER 除濕機 D5', 17900, 11, '加強乾衣模式，雨天也能協助衣物快速乾爽，並減少室內悶濕感。', '除濕機', 'image/de/de_5.png'),
(12, 'CYER 除濕機 D6', 19900, 8, '高效節能機種，提供穩定除濕、濾網提醒與簡易操作面板。', '除濕機', 'image/de/de_6.png'),
(13, 'CYER 靜音電風扇 F1', 3290, 25, '輕巧桌立兩用設計，適合臥室與辦公桌，提供柔和自然風。', '電風扇', 'image/fan/fan_1.jpg'),
(14, 'CYER 靜音電風扇 F2', 3990, 22, '多段風速調整與左右擺頭，兼顧通風效率與安靜使用體驗。', '電風扇', 'image/fan/fan_2.jpg'),
(15, 'CYER 靜音電風扇 F3', 4990, 20, 'DC 變頻馬達省電安靜，適合長時間使用並維持穩定循環。', '電風扇', 'image/fan/fan_3.png'),
(16, 'CYER 靜音電風扇 F4', 5990, 18, '簡潔立扇外型搭配定時功能，客廳與臥室都能輕鬆配置。', '電風扇', 'image/fan/fan_4.png'),
(17, 'CYER 靜音電風扇 F5', 6990, 15, '循環扇風道設計可提升冷房效率，搭配冷氣使用更加節能。', '電風扇', 'image/fan/fan_5.png'),
(18, 'CYER 靜音電風扇 F6', 7990, 12, '高階循環風扇，提供大範圍送風、安靜運轉與質感外觀。', '電風扇', 'image/fan/fan_6.png'),
(19, 'CYER 護髮吹風機 H1', 2490, 30, '輕量機身與穩定熱風，適合每日快速乾髮。', '吹風機', 'image/hd/hd_1.png'),
(20, 'CYER 護髮吹風機 H2', 3290, 26, '負離子護髮設計，減少毛躁並保留髮絲光澤。', '吹風機', 'image/hd/hd_2.jpg'),
(21, 'CYER 護髮吹風機 H3', 4290, 22, '多段溫控與冷風切換，適合不同髮質與造型需求。', '吹風機', 'image/hd/hd_3.png'),
(22, 'CYER 護髮吹風機 H4', 5290, 18, '大風量快速乾髮，搭配集中風嘴提升吹整效率。', '吹風機', 'image/hd/hd_4.png'),
(23, 'CYER 護髮吹風機 H5', 6290, 14, '智慧恆溫避免過熱，照顧頭皮與髮絲健康。', '吹風機', 'image/hd/hd_5.png'),
(24, 'CYER 護髮吹風機 H6', 7290, 10, '旗艦款高速馬達，兼具快速、低噪音與柔順護理。', '吹風機', 'image/hd/hd_6.png'),
(25, 'CYER 智慧冰箱 R1', 24900, 12, '雙門收納配置，適合小家庭每日保鮮與冷凍需求。', '冰箱', 'image/ref/ref_1.jpg'),
(26, 'CYER 智慧冰箱 R2', 29900, 11, '節能壓縮機與穩定溫控，降低耗電並延長食材鮮度。', '冰箱', 'image/ref/ref_2.jpg'),
(27, 'CYER 智慧冰箱 R3', 34900, 9, '大容量分層收納，冷藏、冷凍與蔬果保鮮各自有序。', '冰箱', 'image/ref/ref_3.jpg'),
(28, 'CYER 智慧冰箱 R4', 42900, 7, '多門設計與獨立溫區，適合重視食材分類管理的家庭。', '冰箱', 'image/ref/ref_4.jpg'),
(29, 'CYER 智慧冰箱 R5', 52900, 6, '高階保鮮科技與低噪音運轉，兼顧性能與居家質感。', '冰箱', 'image/ref/ref_5.jpg'),
(30, 'CYER 智慧冰箱 R6', 62900, 5, '旗艦大容量冰箱，提供精準溫控、寬敞收納與節能表現。', '冰箱', 'image/ref/ref_6.jpg'),
(31, 'CYER 無線吸塵器 V1', 6900, 24, '輕量無線設計，適合地板、沙發與日常灰塵清潔。', '吸塵器', 'image/vac/vac_1.jpg'),
(32, 'CYER 無線吸塵器 V2', 7900, 22, '多段吸力切換與可拆式集塵盒，清理更方便。', '吸塵器', 'image/vac/vac_2.jpg'),
(33, 'CYER 無線吸塵器 V3', 8900, 20, '長效電池與多刷頭配件，可應對不同居家清潔情境。', '吸塵器', 'image/vac/vac_3.jpg'),
(34, 'CYER 無線吸塵器 V4', 10900, 16, '強化吸力與低噪音風道，兼顧清潔效率與使用舒適。', '吸塵器', 'image/vac/vac_4.jpg'),
(35, 'CYER 無線吸塵器 V5', 12900, 13, '高效過濾系統可減少二次揚塵，適合重視空氣品質的家庭。', '吸塵器', 'image/vac/vac_5.jpg'),
(36, 'CYER 無線吸塵器 V6', 14900, 10, '旗艦無線吸塵器，具備強吸力、長續航與完整清潔配件。', '吸塵器', 'image/vac/vac_6.jpg');

INSERT INTO `reviews` (`r_id`, `p_id`, `m_id`, `r_stars`, `r_content`, `r_date`) VALUES
(1, 1, 1, 5, '清淨效果很明顯，晚上睡覺也很安靜。', '2026-06-01 20:15:00'),
(2, 1, 3, 4, '外型好看，濾網提醒很方便。', '2026-06-03 09:30:00'),
(3, 25, 1, 5, '冰箱容量很夠，蔬果保鮮區很好用。', '2026-06-02 14:10:00'),
(4, 31, 3, 5, '吸力很強，家裡地板清得很乾淨。', '2026-06-04 11:20:00');

INSERT INTO `site_counter` (`count_id`, `total_views`) VALUES (1, '0');

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
