DELIMITER $$
DROP TRIGGER IF EXISTS `contratto_bi` $$
CREATE TRIGGER contrato_bi
BEFORE insert ON contratto
FOR EACH ROW
BEGIN
IF NEW.dataInizio > NEW.dataFine THEN
SET NEW.datafine = NEW.datainizio;
END IF;
END