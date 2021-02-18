DELIMITER $$
DROP TRIGGER IF EXISTS `corso_bi` $$
CREATE TRIGGER corso_bi
BEFORE insert ON corso
FOR EACH ROW
BEGIN
IF NEW.maxIscritto > 20 OR NEW.maxIscritto < 2 THEN
SET NEW.maxIscritto = 20;
END IF;
IF NEW.minIscritto < 1 OR NEW.minIscritto > NEW.maxIscritto THEN
SET NEW.minIscritto = 1;
END IF;
END;