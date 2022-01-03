-- -----------------------------------------------------------
/*Bajron Ismailaj - Matricola 2686563 - email caiupi@yahoo.it
Laboratorio di sistemi informativi (LSI)*/
-- -------------------------------------

-- ---------------------------------------
/*Costruiamo il nostro database palestra*/
-- --------------------------------------

drop database if exists palestra; #Se esiste un altro database con nome palestra viene eliminato
create database palestra; #Creiamo la nostra database chiamandola palestra
use palestra; #Tuttle le operazioni effetuate nel resto del file vengono eseguite su database palestra

/*Prima di creare una nuova tabela eliminiamo la vecchia versione. Questa scelta si presenta molto
flessibile in fase di sviluppo e verifica*/

drop table if exists personale;
/*La tabella Personale gestisce il personale della palestra.  */
create table personale(
codiceFiscale char(16) primary key, #Ha come chiave primaria il codicefiscale
nome char(16),
cognome char(16),
tel char(16),
indirizzo varchar(32),
qualifiche varchar(32)    #Le qualifiche dei dipendenti sono istruttore, medico, direttore etc.
) ENGINE=INNODB; #In questo progetto si utiliza il motore INNODB poiche più flessibile di MyISAM nella fase dello sviluppo.

drop table if exists contratto;
/*La tabella contratto contiene i dati relativi ai contrati di lavoro dei dipendenti della palestra*/
create table contratto(
codicePersonale char(16) primary key,
descrizione varchar(256),
dataInizio date,
dataFine date,
/*Si usa una chiave primaria esterna con personale tramite la chiave primaria codicefiscale.
Cascade: Se l'attributo si modifica nella tabella sterna si aggiorna anche in questa.*/
foreign key (codicePersonale) references personale(codiceFiscale) on delete cascade on update cascade
) ENGINE=INNODB;

drop table if exists impianto;
/*La tabella contiene i dati relativi al impianto, aree sale della palestra*/
create table impianto(
nome char(16) primary key, #L attributo nome identifica in modo univoco ogni istanza del impianto
descrizione varchar(32) #Descrizione breve del impianto
) ENGINE=INNODB;

drop table if exists corso;
/*La tabella Corso contiene i corsi/attivita svolte nella palestra. Rappresenta il fulcro del database
poichè con essa sono collegate le altre tabelle*/
create table corso(
nome char(16) primary key, #Usa come chiave primaria un nome che lo identifica in modo univoco
nomeImpianto char(16), #Ogni corso si svolge in un impianto
istruttore char(16),    #Ad ogni corso partecipa un istruttore
descrizione varchar(256),
minIscritto int(2), #Numero minimo d'iscritti
maxIscritto int(2), #Numero massimo d'iscritti
/*Quando aggiorniamo un l'attributo nome della tabella impianto questo viene aggiornato anche su corso
invece quando si elimina per questioni aziendali il corso non viene sorpreso*/
foreign key (nomeImpianto) references impianto(nome) on delete no action on update cascade,
/*Quando eliminiamo un istruttore il corso può essistere anche senza un istruttore, finche si trova un altro
invece se cambiamo l'istruttore questo viene aggiornato automaticamente in corso*/
foreign key (istruttore) references personale(codiceFiscale) on delete no action on update cascade
) ENGINE=INNODB;

drop table if exists lezione;
/*Ogni corso è composto da diverse lezioni*/
create table lezione(
inizio datetime,
nomeCorso char(16),
fine datetime,
primary key(inizio, nomeCorso), #Una lezione viene identificata dal corso e da la data ora in qui si svolge.
/*Ogni lezione appartine ad un corso ed e lagata strettamente ad esso. Per ogni azione su corso si
riflette anche su lezione*/
foreign key (nomeCorso) references corso(nome) on delete cascade on update cascade
) ENGINE=INNODB;

drop table if exists iscritto;
/*Gli iscritti della palestra*/
create table iscritto(
matricola int(6) primary key AUTO_INCREMENT, #Matricola è la chiave primaria di un iscritto
codiceFiscale char(16) unique,
nome char(16),
cognome char(16),
medico char(16), #Ogni iscritto deve fare una visita e il database tiene tracia del codice fiscale del medico
dataCert date,   #Data del rilascio del certificato
indirizzo varchar(32),
tel char(16),
dataIscrizione date    #La data d iscrizione nella palestra
) ENGINE=INNODB;

drop table if exists abbonato;
/*Il database tiene tracia dei iscritti nella palestra in possesso di un abbonamento*/
create table abbonato(
matricolaAbbonato int(6) primary key,
costo numeric(6,2), #Usiamo numeric per esprimere anche i centesimi
tipo char(32),
dataInizio date,
dataFine date,
/*Ogni abbonamento è collegato con la matricola del iscritto e per ogni azione su matricola viene
rispecchiata ache su abbonato*/
foreign key (matricolaAbbonato) references iscritto(matricola) on delete cascade on update cascade
) ENGINE=INNODB;

drop table if exists partecipa;
/*Il database tiene tracia dei corsi che un abbonato svolge*/
create table partecipa(
abbonato int(6),
nomeCorso char(16),
primary key(abbonato, nomeCorso), #Come chiave primaria si usano due attributi
/*Ogi azione su abbonato si riflette anche su Partecipa*/
foreign key (abbonato) references abbonato(matricolaAbbonato) on delete cascade on update cascade,
/*I corsi tenuti in palestra e le persone che in esso partecipano sono legato fortemente. Ogni cambiamento
su abbonato viene ereditato su Partecipa*/
foreign key (nomeCorso) references corso(nome) on delete cascade on update cascade
) ENGINE=INNODB;

-- --------------------------------------------------------------------
/*Per l'implementazione di diverse operazioni si e fatto uso di viste*/
-- -------------------------------------------------------------------

drop view if exists abbonamentiScaduti;
/*Questa vista contiene tutti i abbonamenti scaduti */
create view abbonamentiScaduti as
 select * from abbonato
 where dataFine < CURRENT_TIMESTAMP(); #La data di stampa e quella odierna

-- ----------------------------------------------------------------------------------------

drop view if exists istruttore;
/*Si e creato vista per definire meglio i dati relativi al istruttore. Dati che servirano
durante le operazioni.*/
create view istruttore as
select personale.nome, personale.cognome, personale.codicefiscale, corso.nome
as nomeCorso
from corso, personale
where personale.codicefiscale=corso.istruttore;

-- -----------------------------------------------------------------
/*In seguito esponiamo le procedure e i trigger  usati dal database*/
-- ----------------------------------------------------------------


DELIMITER $$
DROP TRIGGER IF EXISTS `corso_bi` $$
/*Per ogni corso nuovo inserito nella tabella corso il trigger controlla se sono sodisfate le condizioni*/
CREATE TRIGGER corso_bi
BEFORE insert ON corso #Operazione effetuate per ogni nuovo inserimento
FOR EACH ROW
BEGIN
IF NEW.maxIscritto > 20 OR NEW.maxIscritto < 2 THEN
SET NEW.maxIscritto = 20; #Il numero dei iscritti deve essere al massimo 20
END IF;
IF NEW.minIscritto < 1 OR NEW.minIscritto > NEW.maxIscritto THEN
SET NEW.minIscritto = 1; #Il numero dei iscritti deve essere al minimo 1
END IF;
END$$

-- -----------------------------------------------------------------------------

DELIMITER $$
DROP TRIGGER IF EXISTS `contratto_bi` $$
/*Per ogni nuovo inserimento nella tabella contratto devono essere sodisfate le condizioni*/
CREATE TRIGGER contrato_bi
BEFORE insert ON contratto  #Per ogni nuovo inserimento
FOR EACH ROW
BEGIN
IF NEW.dataInizio > NEW.dataFine THEN #Se la data fine contratto minore di data inizio
SET NEW.datafine = NEW.datainizio; #Imposta la nuova data
END IF;
END$$

-- -----------------------------------------------------------------------------

DELIMITER $$
DROP TRIGGER IF EXISTS `abbonato_bi` $$
/*Per ogni nuovo inserimento nella tabella abbonato le seguenti vincoli devono essere rispetati*/
CREATE TRIGGER abbonato_bi
BEFORE insert ON abbonato
FOR EACH ROW
BEGIN
IF NEW.datainizio > NEW.datafine THEN
SET NEW.datafine = NEW.datainizio; #La data d inizio abbonamento deve essere minore della data fine abbonamento
END IF;
IF NEW.costo < 1 THEN
SET NEW.costo = 1; #Il costo di un abbonamento non puù essere minore di 1
END IF;
END $$

-- -----------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS `palestra`.`aggPartecipante` $$
/*Per aggiungere dati alla tabella Partecipa si deve chiamare questa procedura che prende come parametri
la matricola del abbonato e il nome del corso in qui vuole partecipare. Avvisa tramite messaggio se l'azione va male*/
CREATE PROCEDURE `aggPartecipante`(IN matricola int(6), nomeC char(16) )
    COMMENT 'Questa procedura aggiunge un partecipante '
BEGIN
declare tmp, x int(2); #AVariabili usate per procesare la richiesta di registrazione nel corso
/*tmp contiene il massimo numero dei iscritti ad un corso*/
set tmp = (select maxIscritto from corso where corso.nome=nomeC);
/*x contiene il numero corrente dei partecipanti al corso identificato con nomeC*/
set x = (select count(*) from partecipa where partecipa.nomeCorso=nomeC);
/*Se nel corso possiamo aggiungere un altro partecipante lo facciamo altrimeto avvisiamo tramite messaggio*/
if x<tmp then insert into partecipa values(matricola,nomeC);
  elseif tmp = x then select 'Impossibile eseguire l azione: Raggiunto numero massimo partecipanti al corso';
end if;
END $$

-- -----------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS `palestra`.`iscrivi` $$
/*Aggiunge un nuovo iscritto mantenendo i valori del attributo Matricola in modo efficente cercando di
ridure l'esplosione dei suoi valori cercando di tenerli più bassi*/
CREATE PROCEDURE `iscrivi`(IN codicefiscaleI char(16),nomeI char(16), cognomeI char(16),medicoI char(16),
dataCertI date, indirizzoI varchar(32), telI char(16))
COMMENT 'Questa procedura restituisce il numero di matricola libero e memoriza il nuovo iscritto '
BEGIN
DECLARE tmp, indice, y int(6);
set indice = 1; #Inizializiamo indice a 1. indice sara usato per scandire i valori del attributo matricola
set y = (select count(*) from iscritto); # y contiene il numero dei iscritti nella palestra usato come limite superiore
ciclo: loop    #Usiamo un ciclo e rimaniamo in esso finche troviamo il minor numero libero del attributo Matricola
set tmp=(select matricola from iscritto where matricola=indice); #Assegnamo a tmp la matricola del iscritto
if tmp is null then leave ciclo; end if; #Se tmp è null allora in questa posizione possiamo memorizare il nuovo iscritto
if indice=y then set indice= y+1; leave ciclo; end if; #Se abbiamo raggiunto il limite superiore terminiamo il ciclo
set indice=indice+1; #Incrementiamo
end loop;  #Rimaniamo
select "L'indice libero e: "+indice ; #Inseriamo il nuovo iscritto con Matricola = indice
insert into iscritto values(indice,codicefiscaleI,nomeI,cognomeI,medicoI,dataCertI,indirizzoI,telI,CURDATE());
end $$

-- -----------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS `palestra`.`nuovaLezione` $$
/*Per inserire una lezione nuova di un corso chiamiamo questa procedura che prende come parametro
in nome del corso che la lezione appartiene e la data e ora in qui si svolge*/
CREATE PROCEDURE `nuovaLezione`(IN inizio DATETIME, nomeC char(16) )
    COMMENT 'Questa procedura inserisce una nuova lezione '
BEGIN
declare x, tmp, tmp2 int(2);
declare fine datetime; #Memoriza la data ora in qui la lezione finisce
set fine=date_add(inizio,interval 1 hour); #Una lezione dura 1 ora (vincoli aziendali)
set tmp=(select corso.minIscritto from corso where nome=nomeC);
set tmp2=(select corso.maxiscritto from corso where nome=nomeC);
set x=(select count(*) from partecipa where partecipa.nomeCorso=nomeC);
/*Per inserire una lezione si deve controllare se i partecipanti al corso (lezionne) rispetino i limiti*/
if x<tmp then select "Impossibile aggiungere questa lezione. Il numero dei partecipanti è minore
 del limite dei partecipanti del corso. Servono più partecipati";
  elseif x>tmp2 then select "Impossibile aggiungere questa lezione. Il numero dei partecipanti al corso
   è maggiore del consetito. Devi eliminare dei partecipanti";
  else insert into lezione values(inizio,nomeC,fine); #Se le condizioni sono sodisfate memoriza la lezione
end if;
END $$

-- -----------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS `palestra`.`stampaPartecipanti` $$
/*Usato per stampare due dati relativi a un corso: 1)L'istruttore del corso. 2)I partecipanti del corso.
 Prende come input il nome del corso che come sapiamo è una chiave primaria*/
CREATE PROCEDURE `stampaPartecipanti`(IN corso char(16) )
    COMMENT 'Questa procedura stampa gli abbonati a un corso '
BEGIN
select corso.nome as NomeCorso, personale.nome as NomeIstruttore, personale.cognome as CognomeIstruttore, personale.codiceFiscale,
 corso.MinIscritto as MinimoIscrittiCorso, corso.maxIscritto as MassimoIscrittiCorso
  from personale, corso  #Stampa l istruttore del corso
where corso.nome = corso and corso.istruttore = personale.codiceFiscale;
select iscritto.matricola, iscritto.Nome, iscritto.cognome, iscritto.codicefiscale, iscritto.tel
 from partecipa, iscritto  #Stampa i partecipanti del corso
 where partecipa.nomeCorso=corso
and partecipa.abbonato=iscritto.matricola;
END $$

-- -----------------------------------------------------------------------------


DELIMITER ;

-- ----------------------------------------------------------------------------------------
/*Per fini di esercitazione e per testare/valutare il database inseriamo dei dati fittizi*/
-- ---------------------------------------------------------------------------------------

insert into personale values
('PP32152dR10M082K','Giulio ','Cesare','055174352','Via Corsica 2','Direttore'),
('PPSDFFDSR10M082K','Claudio','Nerone','05565465','Via del albero 1','Istruttore'),
('PPSDGGSDGE33482K','Marco','Otone','055465465','Viale morgagni 34','Istruttore'),
('SDFGSH43553DGHE4','Aulo','Vitellio','055846546','Via alfani 2','AdettoPulizia'),
('BSDFBSHDTYR3456H','Marco','Aurelio','05584565','Via cesalpino 54','Medico'),
('BVXSDHJARE345HSD','Massimo','Trace','05576545','Via barbera 56','Istruttore'),
('JGHUXVDA244235DF','Publio','Valerio','05551689','Via corso 3','Istruttore'),
('DFJFKYUIXZ45DF54','Flavio','Teodosio','055568946','Piazza repubblica 16','Istruttore');

insert into contratto values
('PP32152dR10M082K','Indeterminato','2011-04-10','2050-01-01'),
('PPSDFFDSR10M082K','Indeterminato','2010-12-21','2050-01-01'),
('PPSDGGSDGE33482K','Indeterminato','2008-03-01','2050-01-01'),
('SDFGSH43553DGHE4','Indeterminato','2001-08-16','2050-01-01'),
('BSDFBSHDTYR3456H','Determinato','2009-11-01','2013-01-01'),
('BVXSDHJARE345HSD','Determinato','2010-01-09','2013-01-01'),
('JGHUXVDA244235DF','Progetto','2011-03-22','2012-01-21'),
('DFJFKYUIXZ45DF54','Progetto','2011-02-10','201-01-21');

insert into impianto values
('Danza','Sala danza'),
('Fitness','Area Fitness PALESTRA'),
('Pesi','Area Pesi PALESTRA'),
('Cyclete','Area Cyclete PALESTRA'),
('Sauna','Area Sauna'),
('Piscina1','Area Piscina corsia 1'),
('Piscina2','Area Piscina corsia 2'),
('Piscina3','Area Piscina corsia 3'),
('Piscina4','Area Piscina corsia 4');

insert into iscritto values
('1','DFJDFHDIXZ45DF54','Alyson','Hannigan','BSDFBSHDTYR3456H','2011-01-02','Via corsica 12','055556357',curdate()),
('2','DSDFLKM45I45FGF4','Amanda','Peet','BSDFBSHDTYR3456H','2009-12-01','Via morgagni 234','05571204',curdate()),
('3','GSKJGHKJ46456KLJ','Ben','Affleck','BSDFBSHDTYR3456H','2008-11-01','Via roma 3','05545450',curdate()),
('4','DFGSH4654645SAD6','Brad','Pitt','CVBCMXFG57567GFH','2009-08-01','Via roma 6','05570809',curdate()),
('5','DSDFSDHJS454664G','Britney','Spears','CVBCMXFG57567GFH','2009-10-01','Via alamani 56','055889988',curdate()),
('6','XCFH4654654ZDFGX','Liv','Tyler','CVBCMXFG57567GFH','2009-11-01','Via redi 23','055102004',curdate()),
('7','XCFHDFDSGGDGGFGX','Robert','De niro','CVBCMXFG57567GFH','2009-11-01','Via redi 23','055102004',curdate()),
('8','XFGKJDA567MFAASF','Christina','Aguilera','CVBCMXFG57567GFH','2009-08-01','Viale novoli','05550545',curdate()),
('9','CVBCMXFG57567GFH','Daryl','Hannah','CVBCMXFG57567GFH','2009-03-01','Via baracca 54','055905422',curdate()),
('10','CGHJSDBXF4357GSB','Demi','Moore','CVBCMXFG57567GFH','2011-04-01','Piazza repubblica 45','055200295',curdate()),
('11','JKAD23JK4656XSBF','Denzel','Washington','CVBCMXFG57567GFH','2009-01-01','Piazza santo spirito 34','0552390103',curdate()),
('12','FDHKJ54KJDFGJ5KL','Dustin','Hoffman','CVBCMXFG57567GFH','2009-12-28','Piazza santa croce 34','055920004',curdate()),
('13','DFK4ODGL54KLFGK5','Eddie','Murphy','BSDFBSHDTYR3456H','2009-11-01','Piazzale michelangelo 5','055325450',curdate()),
('14','FGDFG546DFG5BCFC','Elton','John','BSDFBSHDTYR3456H','2010-10-01','Via benci 45','055058864',curdate()),
('15','FKJSAFHJFFJKFG4F','Eva','Mendes','BSDFBSHDTYR3456H','2011-11-01','Via verdi 2','055997644',curdate()),
('16','SD6565SDFSDG54GG','Jack','Osbourne','BSDFBSHDTYR3456H','2009-08-01','Viale talenti 430','05579831247',curdate()),
('17','XDFHFSH54754568F','Jennifer','Lopez','BSDFBSHDTYR3456H','2009-04-01','Via ponte a le mosse 34','0551042140',curdate()),
('18','FGFGKLSK456KLMFG','Kanye','West','BSDFBSHDTYR3456H','2003-04-01','Via circondaia 34','0554696386',curdate()),
('19','SGHTRHTRLKHL565F','Zlatan','Ibrahimovic','BSDFBSHDTYR3456H','2009-06-01','Via barbera 43','0559993331',curdate()),
('20',null,'Xavier','Samuel','BSDFBSHDTYR3456H','2005-04-01','Piazza dalmazia 4','055012794',curdate());

insert into abbonato values
(1,50.00,'Abbonamento mensile','2012-01-10','2012-02-10'),
(2,90.00,'Abbonamento bimestrale','2011-12-11','2012-01-11'),
(3,150.00,'Abbonamento trimestrale','2011-12-10','2012-02-10'),
(4,400.00,'Abbonamento annuale','2011-04-10','2012-04-10'),
(5,100.00,'Abbonamento vip mensile','2011-12-30','2012-01-30'),
(6,250.00,'Abbonamento vip trimestrale','2011-11-20','2012-01-20'),
(7,50.00,'Abbonamento mensile','2012-01-10','2012-02-10'),
(8,90.00,'Abbonamento bimestrale','2011-12-11','2012-01-11'),
(9,150.00,'Abbonamento trimestrale','2011-12-10','2012-02-10'),
(10,400.00,'Abbonamento annuale','2011-04-10','2012-04-10'),
(11,100.00,'Abbonamento vip mensile','2011-12-30','2012-01-30'),
(12,250.00,'Abbonamento vip trimestrale','2011-11-20','2012-01-20');

insert into corso values
('Classica','Danza','PPSDFFDSR10M082K','Danza: Classica',1,12),
('Tango','Danza','PPSDFFDSR10M082K','Danza: Tango',1,12),
('Yoga','Danza','PPSDFFDSR10M082K','Yoga Flex: Disciplina che migliora mobilita, flessibilita, resistenza',1,12),
('Spinning','Fitness','PPSDGGSDGE33482K','Consente il coinvolgimento organico e muscolare a vari gradi di intensita',1,12),
('Body','Pesi','PPSDGGSDGE33482K','Body Building: Costruzione del corpo aumento della massa muscolare',1,20),
('Kick Boxing','Fitness','SDFGSH43553DGHE4','Disciplina che unisce i pugni del pugilato ai calci del karate',1,8),
('Acquagym','Piscina1','BVXSDHJARE345HSD','Ginnastica in acqua a tempo di musica',1,12),
('Hydrobike','Piscina2','BVXSDHJARE345HSD','Speciale bike posta sul fondo della piscina',1,8),
('Agonistica','Piscina3','DFJFKYUIXZ45DF54','Un percorso di costruzione continua del nuotatore',1,6);


insert into lezione values
('2012-01-11 12:00:00','Classica','2012-01-11 13:00:00'),
('2012-01-11 10:00:00','Tango','2012-01-11 11:00:00'),
('2012-01-11 15:00:00','Yoga','2012-01-11 16:00:00'),
('2012-01-11 09:00:00','Spinning','2012-01-11 10:00:00'),
('2012-01-11 16:00:00','Spinning','2012-01-11 17:00:00'),
('2012-01-12 11:00:00','Body','2012-01-12 12:00:00'),
('2012-01-12 17:00:00','Body','2012-01-12 18:00:00'),
('2012-01-12 16:00:00','Spinning','2012-01-12 17:00:00'),
('2012-01-12 10:00:00','Tango','2012-01-12 11:00:00'),
('2012-01-13 16:00:00','Kick Boxing','2012-01-13 17:00:00'),
('2012-01-13 12:00:00','Kick Boxing','2012-01-13 13:00:00'),
('2012-01-13 09:00:00','Acquagym','2012-01-13 10:00:00'),
('2012-01-13 14:00:00','Acquagym','2012-01-13 15:00:00'),
('2012-01-16 10:00:00','Hydrobike','2012-01-16 11:00:00'),
('2012-01-16 11:00:00','Agonistica','2012-01-16 12:00:00'),
('2012-01-16 16:00:00','Agonistica','2012-01-16 17:00:00'),
('2012-01-16 12:00:00','Classica','2012-01-16 13:00:00'),
('2012-01-17 10:00:00','Tango','2012-01-17 11:00:00'),
('2012-01-17 15:00:00','Yoga','2012-01-17 16:00:00'),
('2012-01-17 09:00:00','Spinning','2012-01-17 10:00:00'),
('2012-01-17 16:00:00','Spinning','2012-01-17 17:00:00'),
('2012-01-18 11:00:00','Body','2012-01-18 12:00:00'),
('2012-01-18 17:00:00','Body','2012-01-18 18:00:00'),
('2012-01-18 16:00:00','Spinning','2012-01-18 17:00:00'),
('2012-01-18 10:00:00','Tango','2012-01-18 11:00:00'),
('2012-01-18 16:00:00','Kick Boxing','2012-01-18 17:00:00'),
('2012-01-19 12:00:00','Kick Boxing','2012-01-19 13:00:00'),
('2012-01-19 09:00:00','Acquagym','2012-01-19 10:00:00'),
('2012-01-19 14:00:00','Acquagym','2012-01-19 15:00:00'),
('2012-01-19 10:00:00','Hydrobike','2012-01-19 11:00:00'),
('2012-01-19 11:00:00','Agonistica','2012-01-19 12:00:00'),
('2012-01-20 16:00:00','Agonistica','2012-01-20 17:00:00');


insert into partecipa values
(1,'Classica'),
(3,'Classica'),
(5,'Classica'),
(2,'Tango'),
(4,'Tango'),
(6,'Tango'),
(8,'Tango'),
(10,'Yoga'),
(12,'Yoga'),
(1,'Spinning'),
(2,'Spinning'),
(3,'Spinning'),
(5,'Body'),
(6,'Body'),
(11,'Body'),
(12,'Body'),
(9,'Kick Boxing'),
(10,'Kick Boxing'),
(11,'Kick Boxing'),
(12,'Kick Boxing'),
(7,'Acquagym'),
(6,'Acquagym'),
(5,'Acquagym'),
(4,'Acquagym'),
(5,'Hydrobike'),
(1,'Hydrobike'),
(2,'Hydrobike'),
(11,'Hydrobike'),
(10,'Agonistica'),
(5,'Agonistica'),
(7,'Agonistica'),
(12,'Agonistica');