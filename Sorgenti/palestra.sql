drop database if exists palestra;
create database palestra;
use palestra;

drop table if exists personale;
create table personale(
codiceFiscale char(16) primary key,
nome char(16),
cognome char(16),
tel char(16),
indirizzo varchar(32),
qualifiche varchar(32)
) ENGINE=INNODB;

drop table if exists contratto;
create table contratto(
codicePersonale char(16) primary key,
descrizione varchar(256),
dataInizio date,
dataFine date,
foreign key (codicePersonale) references personale(codiceFiscale) on delete cascade on update cascade
) ENGINE=INNODB;

drop table if exists impianto;
create table impianto(
nome char(16) primary key,
descrizione varchar(32)
) ENGINE=INNODB;

drop table if exists corso;
create table corso(
nome char(16) primary key,
nomeImpianto char(16),
istruttore char(16),
descrizione varchar(256),
minIscritto int(2),
maxIscritto int(2),
foreign key (nomeImpianto) references impianto(nome) on delete no action on update cascade,
foreign key (istruttore) references personale(codiceFiscale) on delete no action on update cascade
) ENGINE=INNODB;

drop table if exists lezione;
create table lezione(
inizio datetime,
nomeCorso char(16),
fine datetime,
primary key(inizio, nomeCorso),
foreign key (nomeCorso) references corso(nome) on delete cascade on update cascade
) ENGINE=INNODB;

drop table if exists iscritto;
create table iscritto(
matricola int(6) primary key AUTO_INCREMENT,
codiceFiscale char(16) unique,
nome char(16),
cognome char(16),
medico char(16),
dataCert date,
indirizzo varchar(32),
tel char(16),
dataIscrizione date
) ENGINE=INNODB;

drop table if exists abbonato;
create table abbonato(
matricolaAbbonato int(6) primary key,
costo numeric(6,2),
tipo char(32),
dataInizio date,
dataFine date,
foreign key (matricolaAbbonato) references iscritto(matricola) on delete cascade on update cascade
) ENGINE=INNODB;

drop table if exists partecipa;
create table partecipa(
abbonato int(6),
nomeCorso char(16),
primary key(abbonato, nomeCorso),
foreign key (abbonato) references abbonato(matricolaAbbonato) on delete cascade on update cascade,
foreign key (nomeCorso) references corso(nome) on delete cascade on update cascade
) ENGINE=INNODB;
