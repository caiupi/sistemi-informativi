DELIMITER $$
DROP PROCEDURE IF EXISTS `iscrivi` $$
CREATE PROCEDURE iscrivi(IN codicefiscaleI char(16),nomeI char(16), cognomeI char(16),medicoI char(16),
dataCertI date, indirizzoI varchar(32), telI char(16))
COMMENT "Questa procedura restituisce il numero di matricola libero e memoriza il nuovo iscritto "
BEGIN
DECLARE tmp, indice, y int(6);
set indice = 1;
set y = (select count(*) from iscritto);
ciclo: loop
set tmp=(select matricola from iscritto where matricola=indice);
if tmp is null then leave ciclo; end if;
if indice=y then set indice= y+1; leave ciclo; end if;
set indice=indice+1;
end loop;
select "L'indice libero e: "+indice ;
insert into iscritto values(indice,codicefiscaleI,nomeI,cognomeI,medicoI,dataCertI,indirizzoI,telI,CURDATE());
end;