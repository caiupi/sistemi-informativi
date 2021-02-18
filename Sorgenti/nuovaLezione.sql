DELIMITER $$
DROP PROCEDURE IF EXISTS `nuovaLezione` $$
create PROCEDURE palestra.nuovaLezione(IN inizio DATETIME, nomeC char(16) )
COMMENT "Questa procedura inserisce una nuova lezione "
BEGIN
declare x, tmp, tmp2 int(2);
declare fine datetime;
set fine=date_add(inizio,interval 1 hour);
set tmp=(select corso.minIscritto from corso where nome=nomeC);
set tmp2=(select corso.maxiscritto from corso where nome=nomeC);
set x=(select count(*) from partecipa where partecipa.nomeCorso=nomeC);
if x<tmp then select "Impossibile aggiungere questa lezione. Il numero dei partecipanti è minore
 del limite dei partecipanti del corso. Servono più partecipati";
  elseif x>tmp2 then select "Impossibile aggiungere questa lezione. Il numero dei partecipanti al corso
   è maggiore del consetito. Devi eliminare dei partecipanti";
  else insert into lezione values(inizio,nomeC,fine);
end if;
END;