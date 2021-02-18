DELIMITER $$
DROP TRIGGER IF EXISTS `abbonato_bi` $$
CREATE TRIGGER abbonato_bi
BEFORE insert ON abbonato
FOR EACH ROW
BEGIN
IF NEW.datainizio > NEW.datafine THEN
SET NEW.datafine = NEW.datainizio;
END IF;
IF NEW.costo < 1 THEN
SET NEW.costo = 1;
END IF;
END