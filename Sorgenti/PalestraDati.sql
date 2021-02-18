# Popolamento delle tabelle
use palestra;

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