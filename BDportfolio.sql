-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema portfolio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema portfolio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `portfolio` DEFAULT CHARACTER SET utf8 ;
USE `portfolio` ;

-- -----------------------------------------------------
-- Table `portfolio`.`empresa_Instituto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`empresa_Instituto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`tecnologia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`tecnologia` (
  `id_tecnologia` INT NOT NULL AUTO_INCREMENT,
  `nombre_tecnologia` VARCHAR(45) NOT NULL,
  `grado_conocimiento` INT NOT NULL,
  PRIMARY KEY (`id_tecnologia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`pais` (
  `id_pais` INT NOT NULL AUTO_INCREMENT,
  `nombre_pais` VARCHAR(45) NULL,
  PRIMARY KEY (`id_pais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`provincia` (
  `id_provincia` INT NOT NULL AUTO_INCREMENT,
  `nombre_provincia` VARCHAR(45) NULL,
  `pais_id_pais` INT NOT NULL,
  PRIMARY KEY (`id_provincia`, `pais_id_pais`),
  INDEX `fk_provincia_pais1_idx` (`pais_id_pais` ASC) VISIBLE,
  CONSTRAINT `fk_provincia_pais1`
    FOREIGN KEY (`pais_id_pais`)
    REFERENCES `portfolio`.`pais` (`id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`localidad` (
  `id_localidad` INT NOT NULL AUTO_INCREMENT,
  `nombre_localidad` VARCHAR(45) NOT NULL,
  `provincia_id_provincia` INT NOT NULL,
  PRIMARY KEY (`id_localidad`, `provincia_id_provincia`),
  INDEX `fk_localidad_provincia_idx` (`provincia_id_provincia` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_provincia`
    FOREIGN KEY (`provincia_id_provincia`)
    REFERENCES `portfolio`.`provincia` (`id_provincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`persona` (
  `dni` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`dni`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`domicilio` (
  `id_domicilio` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NOT NULL,
  `altura` INT NOT NULL,
  `localidad_id_localidad` INT NOT NULL,
  `localidad_provincia_id_provincia` INT NOT NULL,
  `persona_dni` INT NOT NULL,
  PRIMARY KEY (`id_domicilio`, `localidad_id_localidad`, `localidad_provincia_id_provincia`, `persona_dni`),
  INDEX `fk_domicilio_localidad1_idx` (`localidad_id_localidad` ASC, `localidad_provincia_id_provincia` ASC) VISIBLE,
  INDEX `fk_domicilio_persona1_idx` (`persona_dni` ASC) VISIBLE,
  CONSTRAINT `fk_domicilio_localidad1`
    FOREIGN KEY (`localidad_id_localidad` , `localidad_provincia_id_provincia`)
    REFERENCES `portfolio`.`localidad` (`id_localidad` , `provincia_id_provincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_domicilio_persona1`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `portfolio`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`proyecto` (
  `id_proyecto` INT NOT NULL AUTO_INCREMENT,
  `nombre_proyecto` VARCHAR(150) NOT NULL,
  `descripcion` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id_proyecto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`tipo_educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`tipo_educacion` (
  `id_tipo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`educacion` (
  `id_educacion` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `desde` DATE NOT NULL,
  `hasta` DATE NULL,
  `tipo_educacion_id_tipo` INT NOT NULL,
  PRIMARY KEY (`id_educacion`, `tipo_educacion_id_tipo`),
  INDEX `fk_educacion_tipo_educacion1_idx` (`tipo_educacion_id_tipo` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_tipo_educacion1`
    FOREIGN KEY (`tipo_educacion_id_tipo`)
    REFERENCES `portfolio`.`tipo_educacion` (`id_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`puesto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`puesto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre_puesto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`experiencia_laboral` (
  `id_experiencia` INT NOT NULL AUTO_INCREMENT,
  `puesto` VARCHAR(45) NOT NULL,
  `desde` DATE NOT NULL,
  `hasta` DATE NULL,
  `empleo_actual` TINYINT NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  `pais_id_pais` INT NOT NULL,
  `puesto_id` INT NOT NULL,
  PRIMARY KEY (`id_experiencia`, `pais_id_pais`, `puesto_id`),
  INDEX `fk_experiencia_laboral_puesto1_idx` (`puesto_id` ASC) VISIBLE,
  CONSTRAINT `fk_experiencia_laboral_puesto1`
    FOREIGN KEY (`puesto_id`)
    REFERENCES `portfolio`.`puesto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `persona_dni` INT NOT NULL,
  PRIMARY KEY (`id_usuario`, `persona_dni`),
  INDEX `fk_usuario_persona1_idx` (`persona_dni` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_persona1`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `portfolio`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`persona_domina_tecnologia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`persona_domina_tecnologia` (
  `persona_dni` INT NOT NULL,
  `tecnologia_id_tecnologia` INT NOT NULL,
  PRIMARY KEY (`persona_dni`, `tecnologia_id_tecnologia`),
  INDEX `fk_persona_has_tecnologia_tecnologia1_idx` (`tecnologia_id_tecnologia` ASC) VISIBLE,
  INDEX `fk_persona_has_tecnologia_persona1_idx` (`persona_dni` ASC) VISIBLE,
  CONSTRAINT `fk_persona_has_tecnologia_persona1`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `portfolio`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_has_tecnologia_tecnologia1`
    FOREIGN KEY (`tecnologia_id_tecnologia`)
    REFERENCES `portfolio`.`tecnologia` (`id_tecnologia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`email` (
  `id_email` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(75) NOT NULL,
  `usuario_id_usuario` INT NOT NULL,
  `usuario_persona_dni` INT NOT NULL,
  PRIMARY KEY (`id_email`, `usuario_id_usuario`, `usuario_persona_dni`),
  INDEX `fk_email_usuario1_idx` (`usuario_id_usuario` ASC, `usuario_persona_dni` ASC) VISIBLE,
  CONSTRAINT `fk_email_usuario1`
    FOREIGN KEY (`usuario_id_usuario` , `usuario_persona_dni`)
    REFERENCES `portfolio`.`usuario` (`id_usuario` , `persona_dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`persona_realiza_proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`persona_realiza_proyecto` (
  `persona_dni` INT NOT NULL,
  `proyecto_id_proyecto` INT NOT NULL,
  PRIMARY KEY (`persona_dni`, `proyecto_id_proyecto`),
  INDEX `fk_persona_has_proyecto_proyecto1_idx` (`proyecto_id_proyecto` ASC) VISIBLE,
  INDEX `fk_persona_has_proyecto_persona1_idx` (`persona_dni` ASC) VISIBLE,
  CONSTRAINT `fk_persona_has_proyecto_persona1`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `portfolio`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_has_proyecto_proyecto1`
    FOREIGN KEY (`proyecto_id_proyecto`)
    REFERENCES `portfolio`.`proyecto` (`id_proyecto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`empresa_Instituto_tiene_localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`empresa_Instituto_tiene_localidad` (
  `empresa_Instituto_id` INT NOT NULL,
  `localidad_id_localidad` INT NOT NULL,
  `localidad_provincia_id_provincia` INT NOT NULL,
  PRIMARY KEY (`empresa_Instituto_id`, `localidad_id_localidad`, `localidad_provincia_id_provincia`),
  INDEX `fk_empresa_Instituto_has_localidad_localidad1_idx` (`localidad_id_localidad` ASC, `localidad_provincia_id_provincia` ASC) VISIBLE,
  INDEX `fk_empresa_Instituto_has_localidad_empresa_Instituto1_idx` (`empresa_Instituto_id` ASC) VISIBLE,
  CONSTRAINT `fk_empresa_Instituto_has_localidad_empresa_Instituto1`
    FOREIGN KEY (`empresa_Instituto_id`)
    REFERENCES `portfolio`.`empresa_Instituto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empresa_Instituto_has_localidad_localidad1`
    FOREIGN KEY (`localidad_id_localidad` , `localidad_provincia_id_provincia`)
    REFERENCES `portfolio`.`localidad` (`id_localidad` , `provincia_id_provincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`persona_tiene_educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`persona_tiene_educacion` (
  `persona_dni` INT NOT NULL,
  `educacion_id_educacion` INT NOT NULL,
  `educacion_tipo_educacion_id_tipo` INT NOT NULL,
  PRIMARY KEY (`persona_dni`, `educacion_id_educacion`, `educacion_tipo_educacion_id_tipo`),
  INDEX `fk_persona_has_educacion_educacion1_idx` (`educacion_id_educacion` ASC, `educacion_tipo_educacion_id_tipo` ASC) VISIBLE,
  INDEX `fk_persona_has_educacion_persona1_idx` (`persona_dni` ASC) VISIBLE,
  CONSTRAINT `fk_persona_has_educacion_persona1`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `portfolio`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_has_educacion_educacion1`
    FOREIGN KEY (`educacion_id_educacion` , `educacion_tipo_educacion_id_tipo`)
    REFERENCES `portfolio`.`educacion` (`id_educacion` , `tipo_educacion_id_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`persona_tiene_experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`persona_tiene_experiencia_laboral` (
  `persona_dni` INT NOT NULL,
  `experiencia_laboral_id_experiencia` INT NOT NULL,
  `experiencia_laboral_pais_id_pais` INT NOT NULL,
  PRIMARY KEY (`persona_dni`, `experiencia_laboral_id_experiencia`, `experiencia_laboral_pais_id_pais`),
  INDEX `fk_persona_has_experiencia_laboral_experiencia_laboral1_idx` (`experiencia_laboral_id_experiencia` ASC, `experiencia_laboral_pais_id_pais` ASC) VISIBLE,
  INDEX `fk_persona_has_experiencia_laboral_persona1_idx` (`persona_dni` ASC) VISIBLE,
  CONSTRAINT `fk_persona_has_experiencia_laboral_persona1`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `portfolio`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_has_experiencia_laboral_experiencia_laboral1`
    FOREIGN KEY (`experiencia_laboral_id_experiencia` , `experiencia_laboral_pais_id_pais`)
    REFERENCES `portfolio`.`experiencia_laboral` (`id_experiencia` , `pais_id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`empresa_Instituto_dicta_educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`empresa_Instituto_dicta_educacion` (
  `empresa_Instituto_id` INT NOT NULL,
  `educacion_id_educacion` INT NOT NULL,
  `educacion_tipo_educacion_id_tipo` INT NOT NULL,
  PRIMARY KEY (`empresa_Instituto_id`, `educacion_id_educacion`, `educacion_tipo_educacion_id_tipo`),
  INDEX `fk_empresa_Instituto_has_educacion_educacion1_idx` (`educacion_id_educacion` ASC, `educacion_tipo_educacion_id_tipo` ASC) VISIBLE,
  INDEX `fk_empresa_Instituto_has_educacion_empresa_Instituto1_idx` (`empresa_Instituto_id` ASC) VISIBLE,
  CONSTRAINT `fk_empresa_Instituto_has_educacion_empresa_Instituto1`
    FOREIGN KEY (`empresa_Instituto_id`)
    REFERENCES `portfolio`.`empresa_Instituto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empresa_Instituto_has_educacion_educacion1`
    FOREIGN KEY (`educacion_id_educacion` , `educacion_tipo_educacion_id_tipo`)
    REFERENCES `portfolio`.`educacion` (`id_educacion` , `tipo_educacion_id_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`empresa_Instituto_tiene_puesto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`empresa_Instituto_tiene_puesto` (
  `empresa_Instituto_id` INT NOT NULL,
  `puesto_id` INT NOT NULL,
  PRIMARY KEY (`empresa_Instituto_id`, `puesto_id`),
  INDEX `fk_empresa_Instituto_has_puesto_puesto1_idx` (`puesto_id` ASC) VISIBLE,
  INDEX `fk_empresa_Instituto_has_puesto_empresa_Instituto1_idx` (`empresa_Instituto_id` ASC) VISIBLE,
  CONSTRAINT `fk_empresa_Instituto_has_puesto_empresa_Instituto1`
    FOREIGN KEY (`empresa_Instituto_id`)
    REFERENCES `portfolio`.`empresa_Instituto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empresa_Instituto_has_puesto_puesto1`
    FOREIGN KEY (`puesto_id`)
    REFERENCES `portfolio`.`puesto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
