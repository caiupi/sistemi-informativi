DELIMITER $$
DROp PROCEDURE IF EXISTS `aggPartecipante` $$
create PROCEDURE aggPartecipante (IN matricola int(6), nomeC char(16) )
COMMENT "Questa procedura aggiunge un partecipante "
BEGIN
declare tmp, x int(2);
set tmp = (select maxIscritto from corso where corso.nome=nomeC);
set x = (select count(*) from partecipa where partecipa.nomeCorso=nomeC);
if x<tmp then insert into partecipa values(matricola,nomeC);
  elseif tmp = x then select 'Impossibile eseguire l azione: Raggiunto numero massimo partecipanti al corso';
end if;
END;