-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hackernews
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hackernews
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hackernews` DEFAULT CHARACTER SET utf8 ;
USE `hackernews` ;

-- -----------------------------------------------------
-- Table `hackernews`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hackernews`.`user` ;

CREATE TABLE IF NOT EXISTS `hackernews`.`user` (
  `username` VARCHAR(45) NOT NULL,
  `pwd_hash` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`username`, `pwd_hash`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `hackernews`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hackernews`.`post` ;

CREATE TABLE IF NOT EXISTS `hackernews`.`post` (
  `hanesst_id` INT(11) NOT NULL AUTO_INCREMENT,
  `post_title` VARCHAR(45) NULL DEFAULT NULL,
  `post_text` VARCHAR(400) NULL DEFAULT NULL,
  `post_url` VARCHAR(400) NULL DEFAULT NULL,
  `post_type` VARCHAR(45) NULL DEFAULT NULL,
  `post_parent` INT(11) NULL DEFAULT NULL,
  `username` VARCHAR(45) NOT NULL,
  `pwd_hash` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`hanesst_id`),
  UNIQUE INDEX `hanesst_id_UNIQUE` (`hanesst_id` ASC),
  INDEX `fk_post_user_idx` (`username` ASC, `pwd_hash` ASC),
  CONSTRAINT `fk_post_user`
    FOREIGN KEY (`username` , `pwd_hash`)
    REFERENCES `hackernews`.`user` (`username` , `pwd_hash`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `hackernews`.`vote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hackernews`.`vote` ;

CREATE TABLE IF NOT EXISTS `hackernews`.`vote` (
  `vote_id` INT(11) NOT NULL,
  `post_id` INT(11) NOT NULL,
  `vote_value` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`vote_id`),
  UNIQUE INDEX `vote_id_UNIQUE` (`vote_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

