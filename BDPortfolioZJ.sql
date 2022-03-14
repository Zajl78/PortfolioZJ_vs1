-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BDPortfolioZJ
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BDPortfolioZJ
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BDPortfolioZJ` DEFAULT CHARACTER SET utf8 ;
USE `BDPortfolioZJ` ;

-- -----------------------------------------------------
-- Table `BDPortfolioZJ`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDPortfolioZJ`.`pais` (
  `id_pais` INT NOT NULL AUTO_INCREMENT,
  `pais_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_pais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDPortfolioZJ`.`instituto_empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDPortfolioZJ`.`instituto_empresa` (
  `id_institutoEmpresa` INT NOT NULL AUTO_INCREMENT,
  `institutoEmpresa_nombre` VARCHAR(45) NOT NULL,
  `url_logo` VARCHAR(100) NULL,
  PRIMARY KEY (`id_institutoEmpresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDPortfolioZJ`.`tipo_trabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDPortfolioZJ`.`tipo_trabajo` (
  `id_tipoTrabajo` INT NOT NULL AUTO_INCREMENT,
  `tipoTrabajo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipoTrabajo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDPortfolioZJ`.`tipo_estudio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDPortfolioZJ`.`tipo_estudio` (
  `id_tipoEstudio` INT NOT NULL AUTO_INCREMENT,
  `tipoEstudio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipoEstudio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDPortfolioZJ`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDPortfolioZJ`.`provincia` (
  `id_provincia` INT NOT NULL AUTO_INCREMENT,
  `provincia_nombre` VARCHAR(45) NOT NULL,
  `pais_id_pais` INT NOT NULL,
  PRIMARY KEY (`id_provincia`, `pais_id_pais`),
  INDEX `fk_provincia_pais_idx` (`pais_id_pais` ASC) VISIBLE,
  CONSTRAINT `fk_provincia_pais`
    FOREIGN KEY (`pais_id_pais`)
    REFERENCES `BDPortfolioZJ`.`pais` (`id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDPortfolioZJ`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDPortfolioZJ`.`localidad` (
  `id_localidad` INT NOT NULL AUTO_INCREMENT,
  `localidad_nombrel` VARCHAR(45) NOT NULL,
  `provincia_id_provincia` INT NOT NULL,
  `provincia_pais_id_pais` INT NOT NULL,
  PRIMARY KEY (`id_localidad`, `provincia_id_provincia`, `provincia_pais_id_pais`),
  INDEX `fk_localidad_provincia1_idx` (`provincia_id_provincia` ASC, `provincia_pais_id_pais` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_provincia1`
    FOREIGN KEY (`provincia_id_provincia` , `provincia_pais_id_pais`)
    REFERENCES `BDPortfolioZJ`.`provincia` (`id_provincia` , `pais_id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDPortfolioZJ`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDPortfolioZJ`.`persona` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(12) NOT NULL,
  `url_foto` VARCHAR(100) NOT NULL,
  `sobreMi` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDPortfolioZJ`.`domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDPortfolioZJ`.`domicilio` (
  `id_domicilio` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NOT NULL,
  `altura` INT NOT NULL,
  `localidad_id_localidad` INT NOT NULL,
  `localidad_provincia_id_provincia` INT NOT NULL,
  `localidad_provincia_pais_id_pais` INT NOT NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id_domicilio`, `localidad_id_localidad`, `localidad_provincia_id_provincia`, `localidad_provincia_pais_id_pais`, `persona_id`),
  INDEX `fk_domicilio_localidad1_idx` (`localidad_id_localidad` ASC, `localidad_provincia_id_provincia` ASC, `localidad_provincia_pais_id_pais` ASC) VISIBLE,
  INDEX `fk_domicilio_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_domicilio_localidad1`
    FOREIGN KEY (`localidad_id_localidad` , `localidad_provincia_id_provincia` , `localidad_provincia_pais_id_pais`)
    REFERENCES `BDPortfolioZJ`.`localidad` (`id_localidad` , `provincia_id_provincia` , `provincia_pais_id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_domicilio_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `BDPortfolioZJ`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDPortfolioZJ`.`puesto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDPortfolioZJ`.`puesto` (
  `id_puesto` INT NOT NULL AUTO_INCREMENT,
  `puesto_nombre` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`id_puesto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDPortfolioZJ`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDPortfolioZJ`.`educacion` (
  `id_educacion` INT NOT NULL AUTO_INCREMENT,
  `tituloCurso` VARCHAR(75) NOT NULL,
  `desde` DATE NOT NULL,
  `hasta` DATE NOT NULL,
  `comentario` VARCHAR(200) NULL,
  `tipo_estudio_id_tipoEstudio` INT NOT NULL,
  `instituto_empresa_id_institutoEmpresa` INT NOT NULL,
  `persona_id` INT NOT NULL,
  `provincia_id_provincia` INT NOT NULL,
  `provincia_pais_id_pais` INT NOT NULL,
  PRIMARY KEY (`id_educacion`, `tipo_estudio_id_tipoEstudio`, `instituto_empresa_id_institutoEmpresa`, `persona_id`, `provincia_id_provincia`, `provincia_pais_id_pais`),
  INDEX `fk_educacion_tipo_estudio1_idx` (`tipo_estudio_id_tipoEstudio` ASC) VISIBLE,
  INDEX `fk_educacion_instituto_empresa1_idx` (`instituto_empresa_id_institutoEmpresa` ASC) VISIBLE,
  INDEX `fk_educacion_persona1_idx` (`persona_id` ASC) VISIBLE,
  INDEX `fk_educacion_provincia1_idx` (`provincia_id_provincia` ASC, `provincia_pais_id_pais` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_tipo_estudio1`
    FOREIGN KEY (`tipo_estudio_id_tipoEstudio`)
    REFERENCES `BDPortfolioZJ`.`tipo_estudio` (`id_tipoEstudio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_educacion_instituto_empresa1`
    FOREIGN KEY (`instituto_empresa_id_institutoEmpresa`)
    REFERENCES `BDPortfolioZJ`.`instituto_empresa` (`id_institutoEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_educacion_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `BDPortfolioZJ`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_educacion_provincia1`
    FOREIGN KEY (`provincia_id_provincia` , `provincia_pais_id_pais`)
    REFERENCES `BDPortfolioZJ`.`provincia` (`id_provincia` , `pais_id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDPortfolioZJ`.`experiencia_lab`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDPortfolioZJ`.`experiencia_lab` (
  `id_experienciaLab` INT NOT NULL AUTO_INCREMENT,
  `esTrabajoActual` TINYINT NOT NULL,
  `inicio` DATE NOT NULL,
  `fin` DATE NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `instituto_empresa_id_institutoEmpresa` INT NOT NULL,
  `tipo_trabajo_id_tipoTrabajo` INT NOT NULL,
  `puesto_id_puesto` INT NOT NULL,
  `persona_id` INT NOT NULL,
  `provincia_id_provincia` INT NOT NULL,
  `provincia_pais_id_pais` INT NOT NULL,
  PRIMARY KEY (`id_experienciaLab`, `instituto_empresa_id_institutoEmpresa`, `tipo_trabajo_id_tipoTrabajo`, `puesto_id_puesto`, `persona_id`, `provincia_id_provincia`, `provincia_pais_id_pais`),
  INDEX `fk_experiencia_lab_instituto_empresa1_idx` (`instituto_empresa_id_institutoEmpresa` ASC) VISIBLE,
  INDEX `fk_experiencia_lab_tipo_trabajo1_idx` (`tipo_trabajo_id_tipoTrabajo` ASC) VISIBLE,
  INDEX `fk_experiencia_lab_puesto1_idx` (`puesto_id_puesto` ASC) VISIBLE,
  INDEX `fk_experiencia_lab_persona1_idx` (`persona_id` ASC) VISIBLE,
  INDEX `fk_experiencia_lab_provincia1_idx` (`provincia_id_provincia` ASC, `provincia_pais_id_pais` ASC) VISIBLE,
  CONSTRAINT `fk_experiencia_lab_instituto_empresa1`
    FOREIGN KEY (`instituto_empresa_id_institutoEmpresa`)
    REFERENCES `BDPortfolioZJ`.`instituto_empresa` (`id_institutoEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experiencia_lab_tipo_trabajo1`
    FOREIGN KEY (`tipo_trabajo_id_tipoTrabajo`)
    REFERENCES `BDPortfolioZJ`.`tipo_trabajo` (`id_tipoTrabajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experiencia_lab_puesto1`
    FOREIGN KEY (`puesto_id_puesto`)
    REFERENCES `BDPortfolioZJ`.`puesto` (`id_puesto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experiencia_lab_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `BDPortfolioZJ`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experiencia_lab_provincia1`
    FOREIGN KEY (`provincia_id_provincia` , `provincia_pais_id_pais`)
    REFERENCES `BDPortfolioZJ`.`provincia` (`id_provincia` , `pais_id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDPortfolioZJ`.`email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BDPortfolioZJ`.`email` (
  `id_email` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id_email`, `persona_id`),
  INDEX `fk_email_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_email_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `BDPortfolioZJ`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
