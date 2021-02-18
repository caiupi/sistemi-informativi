DELIMITER $$
DROP PROCEDURE IF EXISTS `stampaPartecipanti` $$
create PROCEDURE stampaPartecipanti (IN corso char(16) )
COMMENT "Questa procedura restituisce gli abbonati a un corso "
BEGIN
select corso.nome as NomeCorso, personale.nome as NomeIstruttore, personale.cognome as CognomeIstruttore, personale.codiceFiscale,
 corso.MinIscritto as MinimoIscrittiCorso, corso.maxIscritto as MassimoIscrittiCorso
  from personale, corso
where corso.nome = corso and corso.istruttore = personale.codiceFiscale;
select iscritto.matricola, iscritto.Nome, iscritto.cognome, iscritto.codicefiscale, iscritto.tel
 from partecipa, iscritto
 where partecipa.nomeCorso=corso
and partecipa.abbonato=iscritto.matricola;
END;