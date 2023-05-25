-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tripdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tripdb` ;

-- -----------------------------------------------------
-- Schema tripdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tripdb` DEFAULT CHARACTER SET utf8 ;
USE `tripdb` ;

-- -----------------------------------------------------
-- Table `tripdb`.`attraction_description`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tripdb`.`attraction_description` (
                                                                 `content_id` INT NOT NULL,
                                                                 `homepage` VARCHAR(100) NULL DEFAULT NULL,
    `overview` VARCHAR(10000) NULL DEFAULT NULL,
    `telname` VARCHAR(45) NULL DEFAULT NULL)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tripdb`.`sido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tripdb`.`sido` (
                                               `sido_code` INT NOT NULL,
                                               `sido_name` VARCHAR(30) NULL DEFAULT NULL,
    PRIMARY KEY (`sido_code`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tripdb`.`attraction_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tripdb`.`attraction_info` (
                                                          `content_id` INT NOT NULL,
                                                          `content_type_id` INT NULL DEFAULT NULL,
                                                          `title` VARCHAR(100) NULL DEFAULT NULL,
    `addr1` VARCHAR(100) NULL DEFAULT NULL,
    `addr2` VARCHAR(50) NULL DEFAULT NULL,
    `zipcode` VARCHAR(50) NULL DEFAULT NULL,
    `tel` VARCHAR(50) NULL DEFAULT NULL,
    `first_image` VARCHAR(200) NULL DEFAULT NULL,
    `first_image2` VARCHAR(200) NULL DEFAULT NULL,
    `readcount` INT NULL DEFAULT NULL,
    `sido_code` INT NULL DEFAULT NULL,
    `gugun_code` INT NULL DEFAULT NULL,
    `latitude` DECIMAL(20,17) NULL DEFAULT NULL,
    `longitude` DECIMAL(20,17) NULL DEFAULT NULL,
    `mlevel` VARCHAR(2) NULL DEFAULT NULL,
    PRIMARY KEY (`content_id`),
    INDEX `sido_to_attractioninfo_idx` (`sido_code` ASC) VISIBLE,
    CONSTRAINT `sido_to_attractioninfo`
    FOREIGN KEY (`sido_code`)
    REFERENCES `tripdb`.`sido` (`sido_code`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tripdb`.`attraction_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tripdb`.`attraction_detail` (
                                                            `content_id` INT NOT NULL,
                                                            `cat1` VARCHAR(3) NULL DEFAULT NULL,
    `cat2` VARCHAR(5) NULL DEFAULT NULL,
    `cat3` VARCHAR(9) NULL DEFAULT NULL,
    `created_time` VARCHAR(14) NULL DEFAULT NULL,
    `modified_time` VARCHAR(14) NULL DEFAULT NULL,
    `booktour` VARCHAR(5) NULL DEFAULT NULL,
    INDEX `attractioninfo_to_attractiondetail_idx` (`content_id` ASC) VISIBLE,
    CONSTRAINT `attractioninfo_to_attractiondetail`
    FOREIGN KEY (`content_id`)
    REFERENCES `tripdb`.`attraction_info` (`content_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tripdb`.`member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tripdb`.`member` (
                                                 `member_id` BIGINT NOT NULL AUTO_INCREMENT,
                                                 `login_id` VARCHAR(16) NOT NULL,
    `login_password` VARCHAR(72) NOT NULL,
    `name` VARCHAR(10) NOT NULL,
    `birthday` DATE NOT NULL,
    `email` VARCHAR(30) NOT NULL,
    `address` VARCHAR(40) NULL DEFAULT NULL,
    `sex` CHAR(1) NULL DEFAULT NULL,
    `role` VARCHAR(10) NOT NULL,
    `grade` VARCHAR(10) NOT NULL,
    `mileage` BIGINT NOT NULL DEFAULT '0',
    `createdat` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedat` DATETIME NULL DEFAULT NULL,
    PRIMARY KEY (`member_id`),
    UNIQUE INDEX `login_id_UNIQUE` (`login_id` ASC) VISIBLE)
    ENGINE = InnoDB
    AUTO_INCREMENT = 2
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tripdb`.`board`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tripdb`.`board` (
                                                `board_id` BIGINT NOT NULL AUTO_INCREMENT,
                                                `member_id` BIGINT NOT NULL,
                                                `title` VARCHAR(80) NOT NULL,
    `content` TEXT NOT NULL,
    `hit` INT NOT NULL,
    `createdat` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedat` DATETIME NULL DEFAULT NULL,
    PRIMARY KEY (`board_id`),
    INDEX `id_idx` (`member_id` ASC) VISIBLE,
    CONSTRAINT `member_to_board_id`
    FOREIGN KEY (`member_id`)
    REFERENCES `tripdb`.`member` (`member_id`))
    ENGINE = InnoDB
    AUTO_INCREMENT = 8
    DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `tripdb`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tripdb`.`comment` (
  `comment_id` BIGINT NOT NULL AUTO_INCREMENT,
  `board_id` BIGINT NOT NULL,
  `member_id` BIGINT NOT NULL,
  `content` VARCHAR(1000) NOT NULL,
  `createdat` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedat` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  INDEX `id_idx` (`board_id` ASC) VISIBLE,
  INDEX `id_idx1` (`member_id` ASC) VISIBLE,
  CONSTRAINT `board_to_comment_id`
  FOREIGN KEY (`board_id`)
  REFERENCES `tripdb`.`board` (`board_id`),
  CONSTRAINT `member_to_comment_id`
  FOREIGN KEY (`member_id`)
  REFERENCES `tripdb`.`member` (`member_id`))
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `tripdb`.`favorite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tripdb`.`favorite` (
                                                   `favorite_id` BIGINT NOT NULL AUTO_INCREMENT,
                                                   `member_id` BIGINT NOT NULL,
                                                   `content_id` INT NOT NULL,
                                                   `createdat` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
                                                   `updatedat` DATETIME NULL DEFAULT NULL,
                                                   PRIMARY KEY (`favorite_id`),
    INDEX `member_to_favorite_idx` (`member_id` ASC) VISIBLE,
    INDEX `attractioninfo_to_favorite_idx` (`content_id` ASC) VISIBLE,
    CONSTRAINT `attractioninfo_to_favorite`
    FOREIGN KEY (`content_id`)
    REFERENCES `tripdb`.`attraction_info` (`content_id`),
    CONSTRAINT `member_to_favorite`
    FOREIGN KEY (`member_id`)
    REFERENCES `tripdb`.`member` (`member_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tripdb`.`gugun`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tripdb`.`gugun` (
                                                `gugun_code` INT NOT NULL,
                                                `gugun_name` VARCHAR(30) NULL DEFAULT NULL,
    `sido_code` INT NOT NULL,
    INDEX `sido_to_gugun` (`sido_code` ASC) VISIBLE,
    CONSTRAINT `sido_to_gugun`
    FOREIGN KEY (`sido_code`)
    REFERENCES `tripdb`.`sido` (`sido_code`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tripdb`.`plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tripdb`.`plan` (
                                               `plan_id` BIGINT NOT NULL AUTO_INCREMENT,
                                               `member_id` BIGINT NOT NULL,
                                               `path` JSON NULL DEFAULT NULL,
                                               `plan_start` DATETIME NOT NULL,
                                               `plan_end` DATETIME NOT NULL,
                                               `plan_name` VARCHAR(16) NOT NULL,
    `createdat` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedat` DATETIME NULL DEFAULT NULL,
    PRIMARY KEY (`plan_id`),
    INDEX `member_to_plan_id_idx` (`member_id` ASC) VISIBLE,
    CONSTRAINT `member_to_plan_id`
    FOREIGN KEY (`member_id`)
    REFERENCES `tripdb`.`member` (`member_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tripdb`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tripdb`.`room` (
                                               `room_id` BIGINT NOT NULL AUTO_INCREMENT,
                                               `owner_id` BIGINT NOT NULL,
                                               `room_name` VARCHAR(45) NOT NULL,
    `address` VARCHAR(199) NOT NULL,
    `introduce` VARCHAR(1000) NOT NULL,
    `createdat` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedat` DATETIME NULL DEFAULT NULL,
    `price_per_night` BIGINT NOT NULL,
    PRIMARY KEY (`room_id`),
    INDEX `member_to_room_id_idx` (`owner_id` ASC) VISIBLE,
    CONSTRAINT `member_to_room_id`
    FOREIGN KEY (`owner_id`)
    REFERENCES `tripdb`.`member` (`member_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `tripdb`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tripdb`.`reservation` (
                                                      `reservation_id` BIGINT NOT NULL AUTO_INCREMENT,
                                                      `customer_id` BIGINT NULL DEFAULT NULL,
                                                      `room_id` BIGINT NULL DEFAULT NULL,
                                                      `total_price` BIGINT NULL DEFAULT NULL,
                                                      `ispaid` TINYINT NULL DEFAULT '0',
                                                      `check_in_date` DATE NOT NULL,
                                                      `check_out_date` DATE NOT NULL,
                                                      `createdat` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                                      `updatedat` DATETIME NULL DEFAULT NULL,
                                                      PRIMARY KEY (`reservation_id`),
    INDEX `member_to_reservation_idx` (`customer_id` ASC) VISIBLE,
    INDEX `room_to_reservation_idx` (`room_id` ASC) VISIBLE,
    CONSTRAINT `member_to_reservation`
    FOREIGN KEY (`customer_id`)
    REFERENCES `tripdb`.`member` (`member_id`),
    CONSTRAINT `room_to_reservation`
    FOREIGN KEY (`room_id`)
    REFERENCES `tripdb`.`room` (`room_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `tripdb`.`room_reservation_date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tripdb`.`room_reservation_date` (
                                                                `room_reservation_date_id` BIGINT NOT NULL AUTO_INCREMENT,
                                                                `room_id` BIGINT NOT NULL,
                                                                `reservation_id` BIGINT NOT NULL,
                                                                `reservation_date` DATE NOT NULL,
                                                                `createdat` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                                                `updatedat` DATETIME NULL DEFAULT NULL,
                                                                PRIMARY KEY (`room_reservation_date_id`),
    INDEX `room_to_reservation_date_idx` (`room_id` ASC) VISIBLE,
    CONSTRAINT `room_to_reservation_date_id`
    FOREIGN KEY (`room_id`)
    REFERENCES `tripdb`.`room` (`room_id`),
    CONSTRAINT `reservation_to_reservation_date_id`
    FOREIGN KEY (`reservation_id`)
    REFERENCES `tripdb`.`reservation` (`reservation_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `tripdb`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tripdb`.`review` (
                                                 `review_id` BIGINT NOT NULL AUTO_INCREMENT,
                                                 `member_id` BIGINT NOT NULL,
                                                 `room_id` BIGINT NOT NULL,
                                                 `content` VARCHAR(1000) NOT NULL,
                                                 `rating` DECIMAL(2, 1) NOT NULL,
    `createdat` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedat` DATETIME NULL DEFAULT NULL,
    PRIMARY KEY (`review_id`),
    INDEX `id_idx` (`room_id` ASC) VISIBLE,
    INDEX `id_idx1` (`member_id` ASC) VISIBLE,
    CONSTRAINT `member_to_review_id`
    FOREIGN KEY (`member_id`)
    REFERENCES `tripdb`.`member` (`member_id`),
    CONSTRAINT `room_to_review_id`
    FOREIGN KEY (`room_id`)
    REFERENCES `tripdb`.`room` (`room_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tripdb`.`room_picture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tripdb`.`room_picture` (
                                                       `room_picture_id` BIGINT NOT NULL AUTO_INCREMENT,
                                                       `room_id` BIGINT NOT NULL,
                                                       `picture` VARCHAR(1000) NULL DEFAULT NULL,
    `createdat` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedat` DATETIME NULL DEFAULT NULL,
    PRIMARY KEY (`room_picture_id`),
    INDEX `room_to_roomdetail_idx` (`room_id` ASC) VISIBLE,
    CONSTRAINT `room_to_roomdetail`
    FOREIGN KEY (`room_id`)
    REFERENCES `tripdb`.`room` (`room_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `tripdb`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tripdb`.`transaction` (
                                                      `transaction_id` BIGINT NOT NULL AUTO_INCREMENT,
                                                      `member_id` BIGINT NOT NULL,
                                                      `transaction_amount` BIGINT NULL DEFAULT NULL,
                                                      `transaction_type` VARCHAR(50) NOT NULL,
    `description` TEXT NULL DEFAULT NULL,
    `createdat` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedat` DATETIME NULL DEFAULT NULL,
    PRIMARY KEY (`transaction_id`),
    INDEX `member_to_transaction_idx` (`member_id` ASC) VISIBLE,
    CONSTRAINT `member_to_transaction`
    FOREIGN KEY (`member_id`)
    REFERENCES `tripdb`.`member` (`member_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;

CREATE TABLE IF NOT EXISTS `tripdb`.`payment` (
                                                  `payment_id` BIGINT NOT NULL AUTO_INCREMENT,
                                                  `member_id` BIGINT NOT NULL,
                                                  `pay_type` VARCHAR(50) NOT NULL,
    `order_id` VARCHAR(150) NOT NULL,
    `order_name` VARCHAR(50) NOT NULL,
    `customer_email` VARCHAR(30),
    `customer_name` VARCHAR(10),
    `amount` BIGINT NOT NULL,
    `payment_key` VARCHAR(100),
    `createdat` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`payment_id`),
    INDEX `member_to_payment_idx` (`member_id` ASC) VISIBLE,
    CONSTRAINT `member_to_paymentt`
    FOREIGN KEY (`member_id`)
    REFERENCES `tripdb`.`member` (`member_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into sido select * from enjoytrip.sido;
insert into gugun select * from enjoytrip.gugun;
insert into attraction_info select * from enjoytrip.attraction_info;
insert into attraction_detail select * from enjoytrip.attraction_detail;
insert into attraction_description select * from enjoytrip.attraction_description;