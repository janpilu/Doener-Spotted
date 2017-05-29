DROP DATABASE IF EXISTS musikarchiv3AHIT2017;
CREATE DATABASE musikarchiv3AHIT2017;
USE musikarchiv3AHIT2017;

-- Interpreten deren Homepage unbekannt ist
-- Interpreten deren Name aus einem Wort besteht
-- Interpreten deren Name mit einem Kleinbuchstaben beg.
-- Interpreten deren Name aus mehr als zwei Worten best.
-- Interpreten die noch kein Album produziert haben
-- Interpreten die mehr als zwei Alben produziert haben

CREATE TABLE interpret (
       iname VARCHAR(25),
       homepage VARCHAR(255),
       PRIMARY KEY (iname)
) ENGINE = INNODB;

INSERT INTO interpret VALUES ('ABBA', 'http://www.abbasite.com/');
INSERT INTO interpret VALUES ('Agnetha Fältskog', 'http://www.agnetha.com/');

-- Solisten die nach dem 1.1.2000 geboren wurden
-- Solisten die vor dem 1.1.2000 einer Band beitraten
-- Solisten die noch immer bei einer Band mitwirken
-- Solisten die in den 90er Jahren bei Bands mitwirkten
-- Solisten die nie bei Bands mitwirkten
-- Solisten die bei einer Band mitwirken
-- Solisten die bei mehreren Bands mitwirken

CREATE TABLE solist (
       iname VARCHAR(25),
       geburtsdatum DATE,
       PRIMARY KEY (iname),
       FOREIGN KEY (iname)
               REFERENCES interpret (iname)
               ON UPDATE CASCADE
               ON DELETE CASCADE
) ENGINE = INNODB;

INSERT INTO solist VALUES ('Agnetha Fältskog', '1950-04-05');

-- Bands die vor 2000 gegründet wurden
-- Bands die nie Mitglieder hatten
-- Bands die ein Mitglied haben / hatten
-- Bands die mehr als zwei Mitglieder haben / hatten

CREATE TABLE band (
       iname VARCHAR(25),
       gruendungsjahr CHAR(4),
       PRIMARY KEY (iname),
       FOREIGN KEY (iname)
               REFERENCES interpret (iname)
               ON UPDATE CASCADE
               ON DELETE CASCADE
) ENGINE = INNODB;

INSERT INTO band VALUES ('ABBA', '1972');

-- Mitgliedschaften die vor dem Gründungsjahr begannen

CREATE TABLE mitgliedschaft (
       biname VARCHAR(25),
       siname VARCHAR(25),
       mitvon DATE,
       mitbis DATE,
       PRIMARY KEY (biname, siname, mitvon),
       FOREIGN KEY (biname)
               REFERENCES band (iname)
               ON UPDATE CASCADE
               ON DELETE CASCADE,
       FOREIGN KEY (siname)
               REFERENCES solist (iname)
               ON UPDATE CASCADE
               ON DELETE CASCADE
) ENGINE = INNODB;

INSERT INTO mitgliedschaft
VALUES ('ABBA', 'Agnetha Fältskog', '1972-04-15', NULL);

-- CDs deren Titel unbekannt ist
-- CDs deren Titel aus einem Wort besteht
-- CDs deren Titel aus mehr als zwei Worten besteht
-- CDs die keine Disc enthalten
-- CDs die mehr als zwei Discs enthalten

CREATE TABLE mcd (
       mcdid INT,
       mcdtitel VARCHAR(128),
       PRIMARY KEY (mcdid)
) ENGINE = INNODB;

INSERT INTO mcd VALUES (1, 'Ring Ring');

-- Playlists die keinen Song enthalten
-- Playlists die mehr als zehn Songs enthalten

CREATE TABLE playlist (
       mcdid INT,
       PRIMARY KEY (mcdid),
       FOREIGN KEY (mcdid)
               REFERENCES mcd (mcdid)
               ON UPDATE CASCADE
               ON DELETE CASCADE
) ENGINE = INNODB;

-- Alben die vor dem Jahr 2000 produziert wurden
-- Alben die keinem Interpreten zugeordnet sind
-- Alben deren Titel unbekannt ist
-- Alben deren Titel identisch dem Interpretnamen ist
-- Alben deren Titel aus einem Wort besteht
-- Alben deren Titel aus mehr als zwei Worten besteht
-- Alben die keine Disc enthalten
-- Alben die mehr als zwei Discs enthalten
-- Alben deren erste Disc nicht die Discnummer 1 hat
-- Alben zu denen es eine Neuauflage gibt
-- Alben zu denen es mehrere Neuauflagen gibt

CREATE TABLE album (
       mcdid INT,
       pjahr CHAR(4),
	   iname VARCHAR(25),
	   vorgaengerid INT,
       PRIMARY KEY (mcdid),
       FOREIGN KEY (mcdid)
               REFERENCES mcd (mcdid)
               ON UPDATE CASCADE
               ON DELETE CASCADE,
       FOREIGN KEY (iname)
               REFERENCES interpret (iname)
               ON UPDATE CASCADE
               ON DELETE CASCADE,
       FOREIGN KEY (vorgaengerid)
               REFERENCES album (mcdid)
               ON UPDATE CASCADE
               ON DELETE CASCADE
) ENGINE = INNODB;

INSERT INTO album
VALUES (1, '1973', 'ABBA', NULL);

CREATE TABLE disc (
       mcdid INT,
       discnr TINYINT,
       PRIMARY KEY (mcdid, discnr),
       FOREIGN KEY (mcdid)
               REFERENCES mcd (mcdid)
               ON UPDATE CASCADE
               ON DELETE CASCADE
) ENGINE = INNODB;

INSERT INTO disc VALUES (1, 1);

-- Genrebezeichnungen die aus mehreren Worten bestehen

CREATE TABLE genre (
       gbez VARCHAR(25),
       PRIMARY KEY (gbez)
) ENGINE = INNODB;

INSERT INTO genre VALUES ('Pop');
INSERT INTO genre VALUES ('Rock');
INSERT INTO genre VALUES ('Schlager & Volksmusik');
INSERT INTO genre VALUES ('Klassik');
INSERT INTO genre VALUES ('Gangsta-Rap');
INSERT INTO genre VALUES ('Jazz');
INSERT INTO genre VALUES ('Metal');
INSERT INTO genre VALUES ('Elektro');
INSERT INTO genre VALUES ('Blues-Rock');
INSERT INTO genre VALUES ('Alternative Rock');
INSERT INTO genre VALUES ('Punk');

-- Songs deren Spieldauer unbekannt ist
-- Songs deren Spieldauer länger als 5 Minuten ist
-- Songs deren Genrebezeichnung unbekannt ist
-- Songs die vom selben Interpreten
--       in mehreren Versionen produziert wurden
-- Songs die von verschiedenen Interpreten
--       produziert wurden
-- Songs die auf keiner Disc enthalten sind
-- Songs die auf mehreren Discs enthalten sind

CREATE TABLE song (
       stitel   VARCHAR(255),
       sversion VARCHAR(255),
       sdauer   TIME,
       iname    VARCHAR(25),
       gbez     VARCHAR(25),
       PRIMARY KEY (stitel, sversion, iname),
       FOREIGN KEY (iname)
               REFERENCES interpret (iname)
               ON UPDATE CASCADE
               ON DELETE CASCADE,
       FOREIGN KEY (gbez)
               REFERENCES genre (gbez)
               ON UPDATE CASCADE
               ON DELETE CASCADE
) ENGINE = INNODB;

-- Inhalte die keine Tracknummer haben

CREATE TABLE inhalt (
	   tracknr  TINYINT,
       mcdid    INT,
       discnr   TINYINT,
       stitel   VARCHAR(255),
       sversion VARCHAR(255),
       iname    VARCHAR(25),
       PRIMARY KEY (mcdid, discnr, stitel, sversion, iname),
       FOREIGN KEY (mcdid, discnr)
               REFERENCES disc (mcdid, discnr)
               ON UPDATE CASCADE
               ON DELETE CASCADE,
       FOREIGN KEY (stitel, sversion, iname)
               REFERENCES song (stitel, sversion, iname)
               ON UPDATE CASCADE
               ON DELETE CASCADE
) ENGINE = INNODB;

-- Datum: 20170220
-- Autor: 3AHIT + MARM
-- Zweck: INSERT für Übung Musikarchiv

USE musikarchiv3AHIT2017;


-- 101 ALESEVIC Salih
-- (keine Abgabe)

-- 102 APPEL Simon
-- Interpreten deren Homepage unbekannt ist
-- Interpreten deren Name aus einem Wort besteht
-- Interpreten die noch kein Album produziert haben
-- Interpreten die mehr als zwei Alben produziert haben
INSERT INTO interpret VALUES ('Idlewild', 'http://idlewild.co.uk/');
INSERT INTO interpret VALUES ('Roddy Woomble', 'http://www.roddywoomble.com/');
INSERT INTO interpret VALUES ('Colin Newton', NULL);
INSERT INTO interpret VALUES ('Rod Jones', 'http://www.rodjonesmusic.com/');
INSERT INTO interpret VALUES ('Phil Scanlon', NULL);
INSERT INTO interpret VALUES ('Bob Fairfoull', NULL);
INSERT INTO interpret VALUES ('Allan Stewart', NULL);
INSERT INTO interpret VALUES ('Gareth Russell', NULL);
INSERT INTO interpret VALUES ('Gavin Fox', NULL);
INSERT INTO interpret VALUES ('Andrew Mitchell', 'http://www.andymitchellmusic.com/#/');
INSERT INTO interpret VALUES ('Luciano Rossi', NULL);

-- Solisten die nach dem 1.1.2000 geboren wurden
-- Solisten die vor dem 1.1.2000 einer Band beitraten
-- Solisten die noch immer bei einer Band mitwirken
-- Solisten die in den 90er Jahren bei Bands mitwirkten
-- Solisten die nie bei Bands mitwirkten
-- Solisten die bei einer Band mitwirken
-- Solisten die bei mehreren Bands mitwirken
INSERT INTO solist VALUES ('Roddy Woomble', '1976-08-13');
INSERT INTO solist VALUES ('Colin Newton', '1977-04-18');
INSERT INTO solist VALUES ('Rod Jones', '1976-12-03');
INSERT INTO solist VALUES ('Phil Scanlon', '1976-05-19');
INSERT INTO solist VALUES ('Bob Fairfoull', '1976-08-06');
INSERT INTO solist VALUES ('Allan Stewart', '1977-01-21');
INSERT INTO solist VALUES ('Gareth Russell', NULL);
INSERT INTO solist VALUES ('Gavin Fox', '1979-03-06');
INSERT INTO solist VALUES ('Andrew Mitchell', NULL);
INSERT INTO solist VALUES ('Luciano Rossi', NULL);

-- Bands die vor 2000 gegründet wurden
-- Bands die mehr als zwei Mitglieder haben / hatten
INSERT INTO band VALUES('Idlewild', '1995');

INSERT INTO mitgliedschaft VALUES ('Idlewild','Roddy Woomble','1995-12-15',NULL);
INSERT INTO mitgliedschaft VALUES ('Idlewild','Rod Jones','1995-12-15',NULL);
INSERT INTO mitgliedschaft VALUES ('Idlewild','Phil Scanlon','1995-12-15','1997-02-15');
INSERT INTO mitgliedschaft VALUES ('Idlewild','Colin Newton','1995-12-15',NULL);
INSERT INTO mitgliedschaft VALUES ('Idlewild','Bob Fairfoull','1997-02-28','2002-05-05');
INSERT INTO mitgliedschaft VALUES ('Idlewild','Allan Stewart','2001-05-19','2010-05-16');
INSERT INTO mitgliedschaft VALUES ('Idlewild','Gavin Fox','2003-11-08','2005-01-13');
INSERT INTO mitgliedschaft VALUES ('Idlewild','Gareth Russell','2006-09-23','2010-05-16');
INSERT INTO mitgliedschaft VALUES ('Idlewild','Andrew Mitchell','2014-12-12',NULL);
INSERT INTO mitgliedschaft VALUES ('Idlewild','Luciano Rossi','2014-11-17',NULL);

-- CDs deren Titel aus einem Wort besteht
-- CDs deren Titel aus mehr als zwei Worten besteht
-- CDs die keine Disc enthalten
-- CDs die mehr als zwei Discs enthalten
INSERT INTO mcd VALUES ('1022', 'Hope Is Important');
INSERT INTO mcd VALUES ('1023', '100 Broken Windows');
INSERT INTO mcd VALUES ('1024', 'The Remote Part');
INSERT INTO mcd VALUES ('1025', 'Warnings/Promises');
INSERT INTO mcd VALUES ('1026', 'Make Another World');
INSERT INTO mcd VALUES ('1027', 'Post Electric Blues');
INSERT INTO mcd VALUES ('1028', 'Everything Ever Written');
INSERT INTO mcd VALUES ('1029', 'Idlewild_Playlist');

-- Playlists die keinen Song enthalten
-- Playlists die mehr als zehn Songs enthalten
INSERT INTO playlist VALUES ('1029');

-- Alben die vor dem Jahr 2000 produziert wurden
-- Alben deren Titel aus mehr als zwei Worten besteht
-- Alben die keine Disc enthalten
-- Alben die mehr als zwei Discs enthalten
INSERT INTO album VALUES ('1022', '1998', 'Idlewild', NULL);
INSERT INTO album VALUES ('1023', '2000', 'Idlewild', NULL);
INSERT INTO album VALUES ('1024', '2002', 'Idlewild', NULL);
INSERT INTO album VALUES ('1025', '2005', 'Idlewild', NULL);
INSERT INTO album VALUES ('1026', '2007', 'Idlewild', NULL);
INSERT INTO album VALUES ('1027', '2009', 'Idlewild', NULL);
INSERT INTO album VALUES ('1028', '2015', 'Idlewild', NULL);

INSERT INTO disc VALUES ('1022', '1');
INSERT INTO disc VALUES ('1023', '1');
INSERT INTO disc VALUES ('1024', '1');
INSERT INTO disc VALUES ('1025', '1');
INSERT INTO disc VALUES ('1026', '1');
INSERT INTO disc VALUES ('1027', '1');
INSERT INTO disc VALUES ('1028', '1');
INSERT INTO disc VALUES ('1029', '0');

-- Songs deren Spieldauer unbekannt ist
-- Songs deren Spieldauer länger als 5 Minuten ist
-- Songs deren Genrebezeichnung unbekannt ist
-- Songs die vom selben Interpreten
--       in mehreren Versionen produziert wurden
-- Songs die von verschiedenen Interpreten
--       produziert wurden
-- Songs die auf keiner Disc enthalten sind
-- Songs die auf mehreren Discs enthalten sind
INSERT INTO song VALUES ('You have Lost Your Way','Version_1','00:01:30','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('A Film for the Future','Version_1','00:03:28','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('Paint Nothing','Version_1','00:03:12','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('When I Argue I See Shapes','Version_1','00:04:26','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('4 People Do Good','Version_1','00:02:00','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('I am Happy to Be Here Tonight','Version_1','00:03:11','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('Everyone Says You are So Fragile','Version_1','00:02:18','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('I am a Message','Version_1','00:02:28','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('You Do not Have the Heart','Version_1','00:02:08','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('Close the Door','Version_1','00:02:20','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('Safe and Sound','Version_1','00:03:15','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('Low Light','Version_1','00:05:32','Idlewild','Alternative Rock');

INSERT INTO song VALUES ('Little Discourage','Version_1','00:03:08','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('I Do not Have the Map','Version_1','00:02:14','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('These Wooden Ideas','Version_1','00:03:52','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('Roseability','Version_1','00:03:38','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('Idea Track','Version_1','00:03:13','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('Let Me Sleep (Next to the Mirror)','Version_1','00:03:20','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('Listen to What You have Got','Version_1','00:02:32','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('Actually It is Darkness','Version_1','00:02:39','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('Rusty','Version_1','00:04:17','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('Mistake Pageant','Version_1','00:02:49','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('Quiet Crown','Version_1','00:03:21','Idlewild','Alternative Rock');
INSERT INTO song VALUES ('The Bronze Medal','Version_1','00:03:35','Idlewild','Alternative Rock');

-- Inhalte die keine Tracknummer haben
INSERT INTO inhalt VALUES (1, '1022','1','You have Lost Your Way','Version_1','Idlewild');
INSERT INTO inhalt VALUES (2, '1022','1','A Film for the Future','Version_1','Idlewild');
INSERT INTO inhalt VALUES (3, '1022','1','Paint Nothing','Version_1','Idlewild');
INSERT INTO inhalt VALUES (4, '1022','1','When I Argue I See Shapes','Version_1','Idlewild');
INSERT INTO inhalt VALUES (5, '1022','1','4 People Do Good','Version_1','Idlewild');
INSERT INTO inhalt VALUES (6, '1022','1','I am Happy to Be Here Tonight','Version_1','Idlewild');
INSERT INTO inhalt VALUES (7, '1022','1','Everyone Says You are So Fragile','Version_1','Idlewild');
INSERT INTO inhalt VALUES (8, '1022','1','I am a Message','Version_1','Idlewild');
INSERT INTO inhalt VALUES (9, '1022','1','You Do not Have the Heart','Version_1','Idlewild');
INSERT INTO inhalt VALUES (10, '1022','1','Close the Door','Version_1','Idlewild');
INSERT INTO inhalt VALUES (11, '1022','1','Safe and Sound','Version_1','Idlewild');
INSERT INTO inhalt VALUES (12, '1022','1','Low Light','Version_1','Idlewild');

INSERT INTO inhalt VALUES (1, '1023','1','Little Discourage','Version_1','Idlewild');
INSERT INTO inhalt VALUES (2, '1023','1','I Do not Have the Map','Version_1','Idlewild');
INSERT INTO inhalt VALUES (3, '1023','1','These Wooden Ideas','Version_1','Idlewild');
INSERT INTO inhalt VALUES (4, '1023','1','Roseability','Version_1','Idlewild');
INSERT INTO inhalt VALUES (5, '1023','1','Idea Track','Version_1','Idlewild');
INSERT INTO inhalt VALUES (6, '1023','1','Let Me Sleep (Next to the Mirror)','Version_1','Idlewild');
INSERT INTO inhalt VALUES (7, '1023','1','Listen to What You have Got','Version_1','Idlewild');
INSERT INTO inhalt VALUES (8, '1023','1','Actually It is Darkness','Version_1','Idlewild');
INSERT INTO inhalt VALUES (9, '1023','1','Rusty','Version_1','Idlewild');
INSERT INTO inhalt VALUES (10, '1023','1','Mistake Pageant','Version_1','Idlewild');
INSERT INTO inhalt VALUES (11, '1023','1','Quiet Crown','Version_1','Idlewild');
INSERT INTO inhalt VALUES (12, '1023','1','The Bronze Medal','Version_1','Idlewild');

INSERT INTO inhalt VALUES (1, '1029','0','You have Lost Your Way','Version_1','Idlewild');
INSERT INTO inhalt VALUES (2, '1029','0','These Wooden Ideas','Version_1','Idlewild');
INSERT INTO inhalt VALUES (3, '1029','0','Paint Nothing','Version_1','Idlewild');
INSERT INTO inhalt VALUES (4, '1029','0','Actually It is Darkness','Version_1','Idlewild');
INSERT INTO inhalt VALUES (5, '1029','0','Rusty','Version_1','Idlewild');


-- 103 BURIAN Paul
INSERT INTO interpret VALUES ('The xx', 'http://thexx.info/rl/');
INSERT INTO interpret VALUES ('Romy Madley Croft', 'http://thexx.info/rl/');

INSERT INTO solist VALUES ('Romy Madley Croft', '1989-08-18');

INSERT INTO band VALUES ('The xx', '2005');

INSERT INTO mitgliedschaft
VALUES ('The xx', 'Romy Madley Croft', '2005-06-09', NULL);

INSERT INTO mcd VALUES (1031, 'xx');

INSERT INTO album
VALUES (1031, 'xx', 'The xx', NULL);

INSERT INTO disc VALUES (1031, 1);

INSERT INTO genre VALUES ('Indie Rock');
INSERT INTO genre VALUES ('Dream Pop');

INSERT INTO song VALUES ('Intro', 'Original', '00:02:08', 'The xx', 'Dream Pop');

INSERT INTO inhalt VALUES (1, 1031 ,1 , 'Intro', 'Original', 'The xx');




-- 104 EBENSTEIN Michael
-- Interpreten deren Homepage unbekannt ist
INSERT INTO interpret VALUES  ('Bob Marley',NULL);
INSERT INTO interpret VALUES  ('The Wailers','http://www.thewailers.net/');
INSERT INTO solist VALUES ('Bob Marley','1945-02-06');
-- Bands die vor 2000 gegründet wurden
INSERT INTO band VALUES ('The Wailers','1963');
INSERT INTO mitgliedschaft VALUES ('The Wailers','Bob Marley','1963-01-01',NULL);
INSERT INTO mcd VALUES (1040,'The Wailing Wailers');
INSERT INTO album VALUES (1040,'1965','The Wailers',NULL);
INSERT INTO disc VALUES (1040,1);
INSERT INTO genre VALUES ('Reggae');
INSERT INTO song VALUES ('Put it On','1.0','00:03:06','The Wailers','Reggae');
INSERT INTO song VALUES ('I Need You','1964','00:02:48','The Wailers','Reggae');
INSERT INTO song VALUES ('Lonesome Feeling','1.0','00:02:50','The Wailers','Reggae');
INSERT INTO song VALUES ('What´s new Pussycat?','1.0','00:03:02','The Wailers','Reggae');
INSERT INTO song VALUES ('One Love','1.0','00:03:20','The Wailers','Reggae');
INSERT INTO song VALUES ('When the Well Runs Dry','1.0','00:02:35','The Wailers','Reggae');
INSERT INTO song VALUES ('Ten Commandments of Love','1.0','00:04:16','The Wailers','Reggae');
INSERT INTO song VALUES ('Rude Boy','1.0','00:02:20','The Wailers','Reggae');
INSERT INTO song VALUES ('It Hurts to be Alone','1.0','00:02:42','The Wailers','Reggae');
INSERT INTO song VALUES ('Love and Affection','1.0','00:02:42','The Wailers','Reggae');
INSERT INTO song VALUES ('I´m Still Waiting','1.0','00:03:31','The Wailers','Reggae');
INSERT INTO song VALUES ('Simmer Down','1.0','00:02:49','The Wailers','Reggae');
INSERT INTO inhalt VALUES (1, 1040,1,'Put it On','1.0','The Wailers');
INSERT INTO inhalt VALUES (2, 1040,1,'I Need You','1964','The Wailers');
INSERT INTO inhalt VALUES (3, 1040,1,'Lonesome Feeling','1.0','The Wailers');
INSERT INTO inhalt VALUES (4, 1040,1,'What´s new Pussycat?','1.0','The Wailers');
INSERT INTO inhalt VALUES (5, 1040,1,'One Love','1.0','The Wailers');
INSERT INTO inhalt VALUES (6, 1040,1,'When the Well Runs Dry','1.0','The Wailers');
INSERT INTO inhalt VALUES (7, 1040,1,'Ten Commandments of Love','1.0','The Wailers');
INSERT INTO inhalt VALUES (8, 1040,1,'Rude Boy','1.0','The Wailers');
INSERT INTO inhalt VALUES (9, 1040,1,'It Hurts to be Alone','1.0','The Wailers');
INSERT INTO inhalt VALUES (10, 1040,1,'Love and Affection','1.0','The Wailers');
INSERT INTO inhalt VALUES (11, 1040,1,'I´m Still Waiting','1.0','The Wailers');
INSERT INTO inhalt VALUES (12, 1040,1,'Simmer Down','1.0','The Wailers');
                            
-- Interpreten deren Name aus einem Wort besteht
INSERT INTO interpret VALUES ('Batman','http://www.batman.com');
INSERT INTO solist VALUES ('Batman','1939-03-07');
INSERT INTO mcd VALUES (1041,'The Art of Batman');
INSERT INTO album VALUES (1041,'1966','Batman',NULL);
INSERT INTO disc VALUES (1041,1);
INSERT INTO genre VALUES ('Bat-Rock');
INSERT INTO song VALUES ('All alone in the Batcave','1.0','00:03:25','Batman','Bat-Rock');
INSERT INTO song VALUES ('If Alfred wasn´t there','1.0','00:03:29','Batman','Bat-Rock');
INSERT INTO song VALUES ('Holy symphony batman!','1.0','00:03:39','Batman','Bat-Rock');
INSERT INTO song VALUES ('The joking Joker','1.0','00:02:27','Batman','Bat-Rock');
INSERT INTO inhalt VALUES (1, 1041,1,'All alone in the Batcave','1.0','Batman');
INSERT INTO inhalt VALUES (2, 1041,1,'If Alfred wasn´t there','1.0','Batman');
INSERT INTO inhalt VALUES (3, 1041,1,'Holy symphony batman!','1.0','Batman');
INSERT INTO inhalt VALUES (4, 1041,1,'The joking Joker','1.0','Batman');


-- Interpreten deren Name aus mehr als zwei Worten best.
INSERT INTO interpret VALUES ('Beware of Darkness','http://bewareofdarknessmusic.com');
INSERT INTO interpret VALUES ('Kyle Nicolaides',NULL);
INSERT INTO interpret VALUES ('Daniel Curcio',NULL);
INSERT INTO interpret VALUES ('Tony Cupito',NULL);
INSERT INTO solist VALUES ('Kyle Nicolaides','1980-03-18');
INSERT INTO solist VALUES ('Daniel Curcio','1980-02-18');
INSERT INTO solist VALUES ('Tony Cupito','1980-04-18');
INSERT INTO band VALUES ('Beware of Darkness','2010');
INSERT INTO mitgliedschaft VALUES ('Beware of Darkness','Kyle Nicolaides','2010-01-01',NULL);
INSERT INTO mitgliedschaft VALUES ('Beware of Darkness','Daniel Curcio','2010-01-01',NULL);
INSERT INTO mitgliedschaft VALUES ('Beware of Darkness','Tony Cupito','2010-01-01',NULL);
INSERT INTO mcd VALUES (1042,'Are you Real?');
INSERT INTO album VALUES (1042,'2012','Beware of Darkness',NULL);
INSERT INTO disc VALUES (1042,1);
INSERT INTO song VALUES ('Summer Daze','1.0','00:03:32','Beware of Darkness','Alternative Rock');
INSERT INTO song VALUES ('Angle','1.0','00:03:20','Beware of Darkness','Alternative Rock');
INSERT INTO song VALUES ('Surrender','1.0','00:03:37','Beware of Darkness','Alternative Rock');
INSERT INTO inhalt VALUES (1, 1042,1,'Summer Daze','1.0','Beware of Darkness');
INSERT INTO inhalt VALUES (2, 1042,1,'Angle','1.0','Beware of Darkness');
INSERT INTO inhalt VALUES (3, 1042,1,'Surrender','1.0','Beware of Darkness');

-- Interpreten die mehr als zwei Alben produziert haben
INSERT INTO interpret VALUES ('Die C++ profis',NULL);
INSERT INTO interpret VALUES ('Brabenetz',NULL);
INSERT INTO interpret VALUES ('Bjarne Stroustrup',NULL);
INSERT INTO solist VALUES ('Brabenetz','0000-00-00');
INSERT INTO solist VALUES ('Bjarne Stroustrup','1950-12-30');
INSERT INTO band VALUES ('Die C++ profis','1985');
INSERT INTO mitgliedschaft VALUES ('Die C++ profis','Brabenetz','1985-01-01',NULL);
INSERT INTO mitgliedschaft VALUES ('Die C++ profis','Bjarne Stroustrup','1985-01-01',NULL);
INSERT INTO mcd VALUES (1043,'Best of Pointer Arithmetic');
INSERT INTO mcd VALUES (1044,'You Sun of a *****');
INSERT INTO album VALUES (1043,'1985','Die C++ profis',NULL);
INSERT INTO album VALUES (1044,'1995','Die C++ profis',NULL);
INSERT INTO disc VALUES(1043,1);
INSERT INTO disc VALUES (1044,1);
INSERT INTO genre VALUES ('Hans Rock');
INSERT INTO genre VALUES ('Hard Coding');
INSERT INTO song VALUES ('Not so fast kiddo','1985','01:25:26','Die C++ profis','Hans Rock');
INSERT INTO song VALUES ('Faster tha light','1985','00:14:23','Die C++ profis','Hans Rock');
INSERT INTO song VALUES ('Performance here we come!','1985','00:04:57','Die C++ profis','Hans Rock');
INSERT INTO inhalt VALUES (1, 1043,1,'Not so fast kiddo','1985','Die C++ profis');
INSERT INTO inhalt VALUES (2, 1043,1,'Faster tha light','1985','Die C++ profis');
INSERT INTO inhalt VALUES (3, 1043,1,'Performance here we come!','1985','Die C++ profis');
INSERT INTO song VALUES ('When the Nullpointer Strikes','1995','00:18:26','Die C++ profis','Hard Coding');
INSERT INTO song VALUES ('Performance? never heard of that','1995','00:49:19','Die C++ profis','Hard Coding');
INSERT INTO song VALUES ('Just a copy made worse','1995','00:01:57','Die C++ profis','Hard Coding');
INSERT INTO inhalt VALUES (1, 1044,1,'When the Nullpointer Strikes','1995','Die C++ profis');
INSERT INTO inhalt VALUES (2, 1044,1,'Performance? never heard of that','1995','Die C++ profis');
INSERT INTO inhalt VALUES (3, 1044,1,'Just a copy made worse','1995','Die C++ profis');


-- Interpreten die noch kein Album produziert haben
INSERT INTO interpret VALUES ('Barack Obama',NULL);




-- 105 FREUDENTHALER Armin
INSERT INTO interpret VALUES('Joel Zimmerman', NULL);
INSERT INTO interpret VALUES('Deadmau5', 'http://live.deadmau5.com/');
INSERT INTO solist VALUES('Joel Zimmerman', '1981-01-05');
INSERT INTO band VALUES ('Deadmau5', '2005');
INSERT INTO mitgliedschaft VALUES ('Deadmau5','Joel Zimmerman','2005-01-01',NULL);
INSERT INTO mcd VALUES (1050, '4x4=12');
INSERT INTO mcd VALUES (1052, 'Meine-Playlist');
INSERT INTO playlist VALUES (1050);
INSERT INTO playlist VALUES (1052);
INSERT INTO album VALUES (1050, '2010','Deadmau5',NULL);
INSERT INTO album VALUES (1052, '2010','Deadmau5',NULL);
INSERT INTO disc VALUES (1050, 1);
INSERT INTO disc VALUES (1052, 1);
INSERT INTO genre VALUES ('Progressive House');
INSERT INTO song VALUES ('Ghosts ’n’ Stuff', 'feat. Rob Swire', '00:03:14','Deadmau5','Progressive House');
INSERT INTO song VALUES ('Raise Your Weapon', 'feat. Greta Svabo Bech', '00:10:34','Deadmau5','Progressive House');
INSERT INTO song VALUES ('Some Chords', 'Remix', '00:10:34','Deadmau5','Progressive House');
INSERT INTO song VALUES ('Animal Rights', 'feat. Wolfgang Gartner', '00:05:40','Deadmau5','Progressive House');
INSERT INTO inhalt VALUES (1,1050,1,'Ghosts ’n’ Stuff','feat. Rob Swire','Deadmau5');
INSERT INTO inhalt VALUES (2,1050,1,'Raise Your Weapon','feat. Greta Svabo Bech','Deadmau5');
INSERT INTO inhalt VALUES (3,1050,1,'Some Chords','Remix','Deadmau5');
INSERT INTO inhalt VALUES (4,1050,1,'Animal Rights', 'feat. Wolfgang Gartner','Deadmau5');
INSERT INTO inhalt VALUES (1,1052,1,'Animal Rights', 'feat. Wolfgang Gartner','Deadmau5');
INSERT INTO inhalt VALUES (2,1052,1,'Some Chords','Remix','Deadmau5');




-- 106 FUCHS Peter
-- Interpreten
INSERT INTO interpret VALUES('Jetta', NULL);
INSERT INTO interpret VALUES('Jasmine Thompson', 'http://www.jasminethompsonmusic.com/');
INSERT INTO interpret VALUES('John Lennon', 'http://www.thebeatles.com/');
INSERT INTO interpret VALUES('Jason "Jay" Kay', NULL);
INSERT INTO interpret VALUES('John Legend', 'http://www.johnlegend.com/');
INSERT INTO interpret VALUES('Jamiroquai', NULL);

-- Solisten
INSERT INTO solist VALUES('Jasmine Thompson', '2000-11-08');
INSERT INTO solist VALUES('Jetta', '1989-06-10');
INSERT INTO solist VALUES('John Legend', '1978-12-28');
INSERT INTO solist VALUES('Jason "Jay" Kay', '1969-12-30');
INSERT INTO solist VALUES('John Lennon', '1940-10-09');

-- Bands
INSERT INTO band VALUES('Jamiroquai', '1992');

-- Mitgliedschaften
INSERT INTO mitgliedschaft
VALUES('Jamiroquai', 'Jason "Jay" Kay', '1992-08-12', NULL);

-- Musik CD
INSERT INTO mcd VALUES(1061, 'Love in the Future');
INSERT INTO mcd VALUES(1062, NULL);
INSERT INTO mcd VALUES(1063, 'An empty disc');
INSERT INTO mcd VALUES(1064, 'Love in the Future Remake');
INSERT INTO mcd VALUES(1065, 'Jetta Best Remixes + Original');

-- Playlists
INSERT INTO playlist VALUES(1062);

-- Alben
INSERT INTO album VALUES(1061, '2013', 'John Legend', NULL);
INSERT INTO album VALUES(1063, NULL, NULL, NULL);
INSERT INTO album VALUES(1064, '2016', 'John Legend', 1);
INSERT INTO album VALUES(1065, '2010', 'Jetta', NULL);

-- Genre
INSERT INTO genre VALUES('Indiepop');
INSERT INTO genre VALUES('Trap');

-- Discs
INSERT INTO disc VALUES(1061, 1);
INSERT INTO disc VALUES(1064, 1);

-- Songs
INSERT INTO song VALUES('I\' love to change the world', 'Original', NULL, 'Jetta', 'Indiepop');  -- Song mit unbekannter Spieldauer
INSERT INTO song VALUES('I\' love to change the world (Matstubs Remix)', 'Remix', '00:03:10', 'Jetta', 'Trap');
INSERT INTO song VALUES('All of me', 'Original', '00:04:29', 'John Legend', 'Pop');
INSERT INTO song VALUES('Save the Night', 'Original', '00:03:09', 'John Legend', 'Pop');
INSERT INTO song VALUES('Save the Night', 'Remix', '00:05:09', 'John Legend', 'Trap');

-- Inhalte
INSERT INTO inhalt VALUES(1, 1061, 1, 'All of me', 'Original', 'John Legend');
INSERT INTO inhalt VALUES(2, 1061, 1, 'Save the Night', 'Original', 'John Legend');
INSERT INTO inhalt VALUES(1, 1064, 1, 'All of me', 'Original', 'John Legend');
INSERT INTO inhalt VALUES(2, 1064, 1, 'Save the Night', 'Remix', 'John Legend');





-- 107 GRASL Christina
-- Interpreten Insert 
INSERT INTO interpret VALUES ('Nirvana', 'http://www.nirvana.com/');
INSERT INTO interpret VALUES ('Kurt Cobain', null);
INSERT INTO interpret VALUES ('Krist Novoselić', null);
INSERT INTO interpret VALUES ('Aaron Burckhard', null);

-- Solisten Inserts
INSERT INTO solist VALUES ('Kurt Cobain', '1967-02-10');
INSERT INTO solist VALUES ('Krist Novoselić', '1965-05-16');
INSERT INTO solist VALUES ('Aaron Burckhard', '1963-11-14');

-- Band Insert
INSERT INTO band VALUES ('Nirvana','1987');

-- Mitglied Insert
INSERT INTO mitgliedschaft VALUES('Nirvana','Kurt Cobain','1987-01-01','1994-04-05');
INSERT INTO mitgliedschaft VALUES('Nirvana','Krist Novoselić','1987-01-01','1994-04-05');
INSERT INTO mitgliedschaft VALUES('Nirvana','Aaron Burckhard','1987-01-01','1994-04-05');

-- CD Insert
INSERT INTO mcd VALUES (1071,'Nevermind');
INSERT INTO mcd VALUES (1072,'Bleach');

-- Playlist Insert
INSERT INTO playlist VALUES(1071);
INSERT INTO playlist VALUES(1072);

-- Albbum Insert
INSERT INTO album VALUES (1071,'1991','Nirvana',NULL);
INSERT INTO album VALUES (1072,'1989','Nirvana',NULL);

-- Disc Insert
INSERT INTO disc VALUES (1071,1);
INSERT INTO disc VALUES (1072,1);

-- Song Insert
INSERT INTO song VALUES ('Smells Like Teen Spirit','Original','5:02','Nirvana','Rock');
INSERT INTO song VALUES ('Come as You Are','Original','3:39','Nirvana','Rock');
INSERT INTO song VALUES ('Lithium','Original','4:17','Nirvana','Rock');
INSERT INTO song VALUES ('In Bloom','Original','4:15','Nirvana','Rock');

INSERT INTO song VALUES ('About a Girl','Original','2:48','Nirvana','Rock');
INSERT INTO song VALUES ('Big Cheese','Original','3:42','Nirvana','Rock');
INSERT INTO song VALUES ('Been a Son','Live','2:01','Nirvana','Rock');
INSERT INTO song VALUES ('Sappy','Live','3:19','Nirvana','Rock');

-- Inhalt Insert
INSERT INTO inhalt VALUES (1, 1071,1,'Smells Like Teen Spirit','Original','Nirvana'); 
INSERT INTO inhalt VALUES (2, 1071,1,'Come as You Are','Original','Nirvana'); 
INSERT INTO inhalt VALUES (3, 1071,1,'Lithium','Original','Nirvana'); 
INSERT INTO inhalt VALUES (4, 1071,1,'In Bloom','Original','Nirvana'); 

INSERT INTO inhalt VALUES (1, 1072,1,'About a Girl','Original','Nirvana'); 
INSERT INTO inhalt VALUES (2, 1072,1,'Big Cheese','Original','Nirvana'); 
INSERT INTO inhalt VALUES (3, 1072,1,'Been a Son','Live','Nirvana'); 
INSERT INTO inhalt VALUES (4, 1072,1,'Sappy','Live','Nirvana'); 




-- 108 HASENBERGER Alexander
-- Interpreten deren Name aus einem Wort besteht
INSERT INTO interpret VALUES ('Zedd', 'https://www.zedd.net/');

-- Solisten die nie bei Bands mitwirkten
INSERT INTO solist VALUES ('Zedd', '1989-09-02');

-- CDs deren Titel aus einem Wort besteht
INSERT INTO mcd VALUES (1082, 'Clarity');

INSERT INTO playlist VALUES (1082);

-- Alben deren Titel aus einem Wort besteht
INSERT INTO album VALUES (1082, '2012', 'Zedd', NULL);

INSERT INTO disc VALUES (1082, 1);

INSERT INTO genre VALUES ('EDM');
INSERT INTO genre VALUES ('House');
INSERT INTO genre VALUES ('Dance');

-- Songs deren Spieldauer länger als 5 Minuten ist
INSERT INTO song VALUES ('Hourglass', 'NULL', '00:05:13', 'Zedd', 'Dance');
INSERT INTO song VALUES ('Codec', 'NULL', '00:06:01', 'Zedd', 'Dance');
INSERT INTO song VALUES ('Follow You Down', 'NULL', '00:05:47', 'Zedd', 'Dance');
INSERT INTO song VALUES ('Epos', 'NULL', '00:05:36', 'Zedd', 'Dance');

-- Songs die vom selben Interpreten
--       in mehreren Versionen produziert wurden
INSERT INTO song VALUES ('Spectrum', 'NULL', '00:04:03', 'Zedd', 'House');
INSERT INTO song VALUES ('Spectrum', 'Akustikversion', '00:01:50', 'Zedd', 'House');
INSERT INTO song VALUES ('Clarity', 'NULL', '00:04:31', 'Zedd', 'House');
INSERT INTO song VALUES ('Clarity', 'Zedd Union Mix', '00:03:27', 'Zedd', 'House');

-- Songs die vom selben Interpreten
--       in mehreren Versionen produziert wurden
-- Songs deren Spieldauer länger als 5 Minuten ist
INSERT INTO song VALUES ('Spectrum', 'Livetune Remix', '00:05:57', 'Zedd', 'House');

-- sonstige Songs aus dem Album Clarity
INSERT INTO song VALUES ('Lost at Sea', 'NULL', '00:03:45', 'Zedd', 'Dance');
INSERT INTO song VALUES ('Stache', 'NULL', '00:04:04', 'Zedd', 'Dance');
INSERT INTO song VALUES ('Fall Into the Sky', 'NULL', '00:03:37', 'Zedd', 'Dance');
INSERT INTO song VALUES ('Stay the Night', 'NULL', '00:03:37', 'Zedd', 'EDM');
INSERT INTO song VALUES ('Push Play', 'NULL', '00:03:37', 'Zedd', 'Dance');
INSERT INTO song VALUES ('Alive', 'Zedd Remix', '00:03:45', 'Zedd', 'Dance');
INSERT INTO song VALUES ('Breakn a Sweat', 'Zedd Remix', '00:04:33', 'Zedd', 'Dance');
INSERT INTO song VALUES ('Shave It Up', 'NULL', '00:03:10', 'Zedd', 'Pop');

INSERT INTO inhalt VALUES (1, 1082, 1, 'Hourglass', 'NULL', 'Zedd');
INSERT INTO inhalt VALUES (2, 1082, 1, 'Codec', 'NULL', 'Zedd');
INSERT INTO inhalt VALUES (3, 1082, 1, 'Follow You Down', 'NULL', 'Zedd');
INSERT INTO inhalt VALUES (4, 1082, 1, 'Epos', 'NULL', 'Zedd');
INSERT INTO inhalt VALUES (5, 1082, 1, 'Shave It Up', 'NULL', 'Zedd');
INSERT INTO inhalt VALUES (6, 1082, 1, 'Spectrum', 'NULL', 'Zedd');
INSERT INTO inhalt VALUES (7, 1082, 1, 'Spectrum', 'Akustikversion', 'Zedd');
INSERT INTO inhalt VALUES (8, 1082, 1, 'Clarity', 'NULL', 'Zedd');
INSERT INTO inhalt VALUES (9, 1082, 1, 'Clarity', 'Zedd Union Mix', 'Zedd');
INSERT INTO inhalt VALUES (10, 1082, 1, 'Spectrum', 'Livetune Remix', 'Zedd');
INSERT INTO inhalt VALUES (11, 1082, 1, 'Lost at Sea', 'NULL', 'Zedd');
INSERT INTO inhalt VALUES (12, 1082, 1, 'Stache', 'NULL', 'Zedd');
INSERT INTO inhalt VALUES (13, 1082, 1, 'Fall Into the Sky', 'NULL', 'Zedd');
INSERT INTO inhalt VALUES (14, 1082, 1, 'Stay the Night', 'NULL', 'Zedd');
INSERT INTO inhalt VALUES (15, 1082, 1, 'Push Play', 'NULL', 'Zedd');
INSERT INTO inhalt VALUES (16, 1082, 1, 'Alive', 'Zedd Remix', 'Zedd');
INSERT INTO inhalt VALUES (17, 1082, 1, 'Breakn a Sweat', 'Zedd Remix', 'Zedd');




-- 109 KERN Christoph
INSERT INTO interpret VALUES('Eden','http://mcmxcv.eu/');
INSERT INTO interpret VALUES('Jonathon Ng','NULL');
INSERT INTO solist VALUES('Jonathon Ng', '1995-09-23');
INSERT INTO band VALUES('Eden','2013');
INSERT INTO mitgliedschaft VALUES('Eden','Jonathon Ng','2013-01-15',NULL);
INSERT INTO mcd VALUES(1091,'Wake Up');
INSERT INTO mcd VALUES(1092,'XO');
INSERT INTO mcd VALUES(1093,'Soul');
INSERT INTO mcd VALUES(1094,'Fumes');
INSERT INTO mcd VALUES(1095,'Nocturne');
INSERT INTO playlist VALUES(1091);
INSERT INTO album VALUES(1091,'2016','Eden',NULL);
INSERT INTO album VALUES(1092,'2016','Eden',NULL);
INSERT INTO album VALUES(1093,'2016','Eden',NULL);
INSERT INTO disc VALUES(1091, 1);
INSERT INTO disc VALUES(1092, 2);
INSERT INTO disc VALUES(1094, 3);
INSERT INTO song VALUES('Wake Up','NULL','00:03:56','Eden','Pop');
INSERT INTO song VALUES('XO','NULL','00:02:42','Eden','Pop');
INSERT INTO song VALUES('Jupiter','NULL','00:04:07','Eden','Pop');
INSERT INTO song VALUES('Fumes','NULL','00:03:33','Eden','Pop');
INSERT INTO song VALUES('Nocturne','NULL','00:03:17','Eden','Pop');
INSERT INTO song VALUES('Limitless','NULL','00:04:52','Eden','Pop');
INSERT INTO song VALUES('Times Like These','NULL','00:04:47','Eden','Pop');
INSERT INTO song VALUES('Billie Jeans','NULL','00:03:57','Eden','Pop');
INSERT INTO song VALUES('Crazy in Love','NULL','00:04:27','Eden','Pop');
INSERT INTO song VALUES('Blank Space','NULL','00:03:37','Eden','Pop');
INSERT INTO song VALUES('The Fire','NULL','00:06:32','Eden','Pop');
INSERT INTO song VALUES('Gone','NULL','00:04:01','Eden','Pop');
INSERT INTO song VALUES('Man Down','NULL','00:05:17','Eden','Pop');
INSERT INTO song VALUES('Soul','NULL','00:02:10','Eden','Pop');
INSERT INTO song VALUES('Scribble','NULL','00:02:20','Eden','Pop');
INSERT INTO song VALUES('Drowning','NULL','00:04:20','Eden','Pop');
INSERT INTO song VALUES('Elysium','NULL','00:04:56','Eden','Pop');
INSERT INTO song VALUES('Space','NULL','00:02:54','Eden','Pop');
INSERT INTO song VALUES('Sleepless','NULL','00:04:33','Eden','Pop');
INSERT INTO song VALUES('Chasing Ghosts','NULL','00:04:54','Eden','Pop');
INSERT INTO inhalt VALUES(1, 1092, 2, 'Chasing Ghosts','NULL','Eden');




-- 110 KOINER Oskar-Laurin
INSERT INTO genre  VALUES ('Hip-Hop');
INSERT INTO interpret  VALUES ('Oasis', 'http://www.oasisinet.com');
INSERT INTO interpret  VALUES ('OutKast', 'http://www.outkast.com/');
INSERT INTO interpret  VALUES ('Ozzy Osbourne', 'http://www.ozzy.com/');
INSERT INTO solist  VALUES ('Ozzy Osbourne', '1948-12-03');
INSERT INTO band  VALUES ('Oasis', '1991');
INSERT INTO band  VALUES ('OutKast', '1991');
INSERT INTO interpret  VALUES ('André 3000', '');
INSERT INTO solist  VALUES ('André 3000', '1975-05-27');
INSERT INTO interpret  VALUES ('Big Boi', 'http://www.bigboi.com/');
INSERT INTO solist  VALUES ('Big Boi', '1975-02-01');
INSERT INTO mitgliedschaft VALUES ('OutKast', 'André 3000', '1991-01-01', NULL);
INSERT INTO mitgliedschaft VALUES ('OutKast', 'Big Boi', '1991-01-01', NULL);
INSERT INTO song VALUES ('Roses','','06:04','OutKast','Hip-Hop');
INSERT INTO song VALUES ('Wonderwall','','04:37','Oasis','Alternative Rock');
INSERT INTO mcd VALUES(1101,'MyCD');
INSERT INTO playlist VALUES(1101);
INSERT INTO album  VALUES(1101,'1991','OutKast',NULL);
INSERT INTO disc  VALUES (1101, 1);
INSERT INTO inhalt VALUES (1, 1101,1,'Roses','','OutKast');
INSERT INTO song VALUES ('Roses1','','06:14','OutKast','Hip-Hop');
INSERT INTO inhalt VALUES (2, 1101,1,'Roses1','','OutKast');
INSERT INTO song VALUES ('Roses2','','06:24','OutKast','Hip-Hop');
INSERT INTO inhalt VALUES (3, 1101,1,'Roses2','','OutKast');
INSERT INTO song VALUES ('Roses3','','06:34','OutKast','Hip-Hop');
INSERT INTO inhalt VALUES (4, 1101,1,'Roses3','','OutKast');
INSERT INTO mcd VALUES(1102,'MyCD2');
INSERT INTO playlist VALUES(1102);
INSERT INTO album  VALUES(1102,'1991','Oasis',NULL);
INSERT INTO disc  VALUES (1102, 2);




-- 111 LANGELA Regincos Jan
#interpret

INSERT INTO interpret VALUES('YSL Know Plug', 'https://www.gloupdinerogang.com/');
INSERT INTO interpret VALUES('Ying Yang Twins', NULL);
INSERT INTO interpret VALUES('Ylvis', 'http://ylvis.com/');
INSERT INTO interpret VALUES('Ylvisåker', NULL);

#solist

INSERT INTO solist VALUES('YSL Know Plug', '1981-06-27');
INSERT INTO solist VALUES('Ylvisåker', '1982-03-21');

#band

INSERT INTO band VALUES('Ying Yang Twins', '2000');
INSERT INTO band VALUES('Ylvis', '2011');

#mitgliedschaft

INSERT INTO mitgliedschaft VALUES('Ylvis', 'Ylvisåker', '2014-04-14', NULL);

#mcd

INSERT INTO mcd VALUES(1111, 'Alles ist Designer');
INSERT INTO mcd VALUES(1112, 'Best Westcoast Playlist');

#playlist

INSERT INTO playlist VALUES(1112);

#album

INSERT INTO album VALUES(1111, '2016', 'YSL Know Plug', NULL);

#disc

INSERT INTO disc VALUES(1111,1);

#genre

INSERT INTO genre VALUES('Hip-Hop/Rap');

#song

INSERT INTO song VALUES('YSL', '1','00:02:58', 'YSL Know Plug', 'Hip-Hop/Rap');
INSERT INTO song VALUES('Dip', '1','00:02:56', 'YSL Know Plug', 'Hip-Hop/Rap');
INSERT INTO song VALUES('Rite it Back', '1','00:02:31', 'YSL Know Plug', 'Hip-Hop/Rap');
INSERT INTO song VALUES('Alles ist Designer', '1','00:04:30', 'YSL Know Plug', 'Hip-Hop/Rap');
INSERT INTO song VALUES('Ananassaft', '1',NULL, 'YSL Know Plug', 'Hip-Hop/Rap');


#inhalt

INSERT INTO inhalt VALUES(1,1111,1,'YSL','1','YSL Know Plug');
INSERT INTO inhalt VALUES(2,1111,1,'Dip','1','YSL Know Plug');
INSERT INTO inhalt VALUES(3,1111,1,'Rite it Back','1','YSL Know Plug');
INSERT INTO inhalt VALUES(4,1111,1,'Alles ist Designer','1','YSL Know Plug');
INSERT INTO inhalt VALUES(5,1111,1,'Ananassaft','1','YSL Know Plug');





-- 112 MATOUSCHEK Marco
-- interpret
INSERT INTO interpret VALUES ('Vance Joy', 'http://www.vancejoy.com/');
INSERT INTO interpret VALUES ('James Keogh', NULL);

-- solist
INSERT INTO solist VALUES ('James Keogh', '1987-12-1');

-- band
INSERT INTO band VALUES ('Vance Joy','2013');

-- mitgliedschaft
INSERT INTO mitgliedschaft VALUES ('Vance Joy','James Keogh', '2013-01-01', NULL);

-- mcd
INSERT INTO mcd VALUES (1121,'Dream Your Life Away');

-- playlist
INSERT INTO playlist VALUES(1121);

-- album
INSERT INTO album VALUES (1121,'2014','Vance Joy',NULL);

-- disc
INSERT INTO disc VALUES (1121,1);

-- song
INSERT INTO song VALUES('Riptide','Original','3:24','Vance Joy','Alternative Rock');
INSERT INTO song VALUES('Wasted Time','Original','3:44','Vance Joy','Alternative Rock');
INSERT INTO song VALUES('From Afar','Original','4:22','Vance Joy','Alternative Rock');
INSERT INTO song VALUES('Georgia','Original','3:51','Vance Joy','Alternative Rock');
INSERT INTO song VALUES('Fire and the Flood','Original','3:24','Vance Joy','Alternative Rock');

-- inhalt
INSERT INTO inhalt VALUES(1, 1121,1,'Riptide','Original','Vance Joy');
INSERT INTO inhalt VALUES(2, 1121,1,'Wasted Time','Original','Vance Joy');
INSERT INTO inhalt VALUES(3, 1121,1,'From Afar','Original','Vance Joy');
INSERT INTO inhalt VALUES(4, 1121,1,'Georgia','Original','Vance Joy');
INSERT INTO inhalt VALUES(5, 1121,1,'Fire and the Flood','Original','Vance Joy');





-- 113 MAZZOLINI Paul B.
INSERT INTO interpret VALUES ('Madonna', 'http://www.madonna.com');
INSERT INTO solist VALUES ('Madonna', '1958-08-16');
INSERT INTO mcd VALUES (1131, 'True Blue');
INSERT INTO album VALUES (1131, '1986', 'Madonna', NULL);
INSERT INTO disc VALUES (1131, 1);
INSERT INTO playlist VALUES (1131);
INSERT INTO song VALUES ('Papa Dont Preach', '', '00:05:45', 'Madonna', 'POP');
INSERT INTO inhalt VALUES (1, 1131, 1, 'Papa Dont Preach', '', 'Madonna');
INSERT INTO song VALUES ('Open Your Heart', '', '00:04:13', 'Madonna', 'POP');
INSERT INTO inhalt VALUES (2, 1131, 1, 'Open Your Heart', '', 'Madonna');
INSERT INTO song VALUES ('White Heart', '', '00:04:41', 'Madonna', 'POP');
INSERT INTO inhalt VALUES (3, 1131, 1, 'White Heart', '', 'Madonna');
INSERT INTO song VALUES ('Live To Tell', '', '00:05:53', 'Madonna', 'POP');
INSERT INTO inhalt VALUES (4, 1131, 1, 'Live To Tell', '', 'Madonna');
INSERT INTO song VALUES ('Wheres The Party', '', '00:04:20', 'Madonna', 'POP');
INSERT INTO inhalt VALUES (5, 1131, 1, 'Wheres The Party', '', 'Madonna');
INSERT INTO song VALUES ('True Blue', '', '00:04:18', 'Madonna', 'POP');
INSERT INTO inhalt VALUES (6, 1131, 1, 'True Blue', '', 'Madonna');
INSERT INTO song VALUES ('La Isla Bonita', '', '00:04:02', 'Madonna', 'POP');
INSERT INTO inhalt VALUES (7, 1131, 1, 'La Isla Bonita', '', 'Madonna');
INSERT INTO song VALUES ('Jimmy Jimmy', '', '00:03:56', 'Madonna', 'POP');
INSERT INTO inhalt VALUES (8, 1131, 1, 'Jimmy Jimmy', '', 'Madonna');
INSERT INTO song VALUES ('Love Makes The World Go Round', '', '00:04:31', 'Madonna', 'POP');
INSERT INTO inhalt VALUES (9, 1131, 1, 'Love Makes The World Go Round', '', 'Madonna');
INSERT INTO song VALUES ('True Blue', 'The Color Mix', '00:06:40', 'Madonna', 'POP');
INSERT INTO inhalt VALUES (10, 1131, 1, 'True Blue', 'The Color Mix', 'Madonna');
INSERT INTO song VALUES ('La Isla Bonita', 'Extended Remix', '00:05:26', 'Madonna', 'POP');
INSERT INTO inhalt VALUES (11, 1131, 1, 'La Isla Bonita', 'Extended Remix', 'Madonna');





-- 114 MIAO Yuming
INSERT INTO interpret VALUES ('Green Day','http://www.greenday.com/');
INSERT INTO interpret VALUES ('Billie Joe Armstrong', null);
INSERT INTO interpret VALUES ('Mike Dirnt', null);
INSERT INTO interpret VALUES ('Al Sobrante', null);

INSERT INTO solist VALUES ('Billie Joe Armstrong','1972-02-17');
INSERT INTO solist VALUES ('Mike Dirnt','1972-05-04');
INSERT INTO solist VALUES ('Al Sobrante','1969-06-11');

INSERT INTO band VALUES ('Green Day','1989');

INSERT INTO mitgliedschaft VALUES ('Green Day','Billie Joe Armstrong','1989-01-01',NULL);
INSERT INTO mitgliedschaft VALUES ('Green Day','Mike Dirnt','1989-01-01',NULL);
INSERT INTO mitgliedschaft VALUES ('Green Day','Al Sobrante','1989-01-01','1990-01-01');

INSERT INTO mcd VALUES (1141,'39/Smooth');
INSERT INTO mcd VALUES (1142,'Kerplunk!');

-- INSERT INTO playlist VALUES(1141);
-- INSERT INTO playlist VALUES(1142);

INSERT INTO album VALUES (1141,'1990','Green Day',NULL);
INSERT INTO album VALUES (1142,'1992','Green Day',NULL);

INSERT INTO disc VALUES (1141,1);
INSERT INTO disc VALUES (1142,1);

INSERT INTO genre VALUES ('Punkrock');

INSERT INTO song VALUES ('At the Library with Waba Sé Wasca','Original','00:02:28','Green Day','Punkrock');
INSERT INTO song VALUES ('Do not Leave Me','Original','00:02:39','Green Day','Punkrock');
INSERT INTO song VALUES ('I Was There','Original','00:03:36','Green Day','Punkrock');
INSERT INTO song VALUES ('Disappearing Boy','Original','00:02:52','Green Day','Punkrock');
INSERT INTO song VALUES ('Green Day','Original','00:03:29','Green Day','Punkrock');
INSERT INTO song VALUES ('Going to Pasalacqua','Original','00:03:30','Green Day','Punkrock');
INSERT INTO song VALUES ('16','Original','00:03:24','Green Day','Punkrock');
INSERT INTO song VALUES ('Road to Acceptance','Original','00:03:35','Green Day','Punkrock');
INSERT INTO song VALUES ('Rest','Original','00:03:05','Green Day','Punkrock');
INSERT INTO song VALUES ('The Judges Daughter','Original','00:02:34','Green Day','Punkrock');

INSERT INTO song VALUES ('2,000 Light Years Away','Original','00:02:24','Green Day','Punkrock');
INSERT INTO song VALUES ('One for the Razorbacks','Original','00:03:30','Green Day','Punkrock');
INSERT INTO song VALUES ('Welcome to Paradise','Original','00:03:30','Green Day','Punkrock');
INSERT INTO song VALUES ('Christie Road','Original','00:03:33','Green Day','Punkrock');
INSERT INTO song VALUES ('Private Ale','Original','00:02:26','Green Day','Punkrock');
INSERT INTO song VALUES ('Dominated Love Slave','Original','00:01:42','Green Day','Punkrock');
INSERT INTO song VALUES ('One of My Lies','Original','00:02:19','Green Day','Punkrock');
INSERT INTO song VALUES ('80','Original','00:03:39','Green Day','Punkrock');
INSERT INTO song VALUES ('Android','Original','00:03:00','Green Day','Punkrock');
INSERT INTO song VALUES ('No One Knows','Original','00:03:39','Green Day','Punkrock');
INSERT INTO song VALUES ('Who Wrote Holden Caulfield?','Original','00:02:44','Green Day','Punkrock');
INSERT INTO song VALUES ('Words I Might Have Ate','Original','00:02:32','Green Day','Punkrock');
INSERT INTO song VALUES ('Sweet Children','CD-Version','00:01:41','Green Day','Punkrock');
INSERT INTO song VALUES ('Best Thing in Town','CD-Version','00:02:03','Green Day','Punkrock');
INSERT INTO song VALUES ('Strangeland','CD-Version','00:02:08','Green Day','Punkrock');
INSERT INTO song VALUES ('My Generation','CD-Version','00:02:19','Green Day','Punkrock');

INSERT INTO inhalt VALUES (1, 1141,1,'At the Library with Waba Sé Wasca','Original','Green Day');
INSERT INTO inhalt VALUES (2, 1141,1,'Do not Leave Me','Original','Green Day');
INSERT INTO inhalt VALUES (3, 1141,1,'I Was There','Original','Green Day');
INSERT INTO inhalt VALUES (4, 1141,1,'Disappearing Boy','Original','Green Day');
INSERT INTO inhalt VALUES (5, 1141,1,'Green Day','Original','Green Day');
INSERT INTO inhalt VALUES (6, 1141,1,'Going to Pasalacqua','Original','Green Day');
INSERT INTO inhalt VALUES (7, 1141,1,'16','Original','Green Day');
INSERT INTO inhalt VALUES (8, 1141,1,'Road to Acceptance','Original','Green Day');
INSERT INTO inhalt VALUES (9, 1141,1,'Rest','Original','Green Day');
INSERT INTO inhalt VALUES (10, 1141,1,'The Judges Daughter','Original','Green Day');

INSERT INTO inhalt VALUES (1, 1142,1,'2,000 Light Years Away','Original','Green Day');
INSERT INTO inhalt VALUES (2, 1142,1,'One for the Razorbacks','Original','Green Day');
INSERT INTO inhalt VALUES (3, 1142,1,'Welcome to Paradise','Original','Green Day');
INSERT INTO inhalt VALUES (4, 1142,1,'Christie Road','Original','Green Day');
INSERT INTO inhalt VALUES (5, 1142,1,'Private Ale','Original','Green Day');
INSERT INTO inhalt VALUES (6, 1142,1,'Dominated Love Slave','Original','Green Day');
INSERT INTO inhalt VALUES (7, 1142,1,'One of My Lies','Original','Green Day');
INSERT INTO inhalt VALUES (8, 1142,1,'80','Original','Green Day');
INSERT INTO inhalt VALUES (9, 1142,1,'Android','Original','Green Day');
INSERT INTO inhalt VALUES (10, 1142,1,'No One Knows','Original','Green Day');
INSERT INTO inhalt VALUES (11, 1142,1,'Who Wrote Holden Caulfield?','Original','Green Day');
INSERT INTO inhalt VALUES (12, 1142,1,'Words I Might Have Ate','Original','Green Day');
INSERT INTO inhalt VALUES (13, 1142,1,'Sweet Children','CD-Version','Green Day');
INSERT INTO inhalt VALUES (14, 1142,1,'Best Thing in Town','CD-Version','Green Day');
INSERT INTO inhalt VALUES (15, 1142,1,'Strangeland','CD-Version','Green Day');
INSERT INTO inhalt VALUES (16, 1142,1,'My Generation','CD-Version','Green Day');





-- 115 MOSER Patrizia
INSERT INTO interpret VALUES ('You Me at Six', 'http://www.youmeatsix.co.uk/');
INSERT INTO interpret VALUES ('Josh Franceschi', 'https://twitter.com/joshmeatsix?lang=de');

INSERT INTO solist VALUES ('Josh Franceschi', '1990-08-07');

INSERT INTO band VALUES ('You Me at Six', '2004');

INSERT INTO mitgliedschaft VALUES ('You Me at Six', 'Josh Franceschi', '2004-04-19', NULL);

INSERT INTO mcd VALUES (1151, 'Take Off Your Colours');

INSERT INTO album VALUES (1151, '2008', 'You Me at Six', NULL);

INSERT INTO disc VALUES (1151, 1);

INSERT INTO genre VALUES ('Pop-Punk');

INSERT INTO song VALUES ('The Truth Is a Terrible Thing', 'Original', '00:02:51', 'You Me at Six', 'Pop-Punk');

INSERT INTO inhalt VALUES (1, 1151 ,1 , 'The Truth Is a Terrible Thing', 'Original', 'You Me at Six');





-- 116 PETROVIC Damjan

INSERT INTO interpret VALUES ('Crown the Empire','http://crowntheempire.net/');

INSERT INTO interpret VALUES ('Andrew Velasquez','http://crowntheempire.net/');
INSERT INTO interpret VALUES ('Brandon Hoover','http://crowntheempire.net/');
INSERT INTO interpret VALUES ('Hayden Tree','http://crowntheempire.net/');
INSERT INTO interpret VALUES ('Brent Taddie','http://crowntheempire.net/');


INSERT INTO solist VALUES('Andrew Velasquez', '1994-05-01');
INSERT INTO solist VALUES('Brandon Hoover', '1993-01-10');
INSERT INTO solist VALUES('Hayden Tree', '1993-02-19');
INSERT INTO solist VALUES('Brent Taddie', '1989-12-21');


INSERT INTO band VALUES ('Crown the Empire', '2010');

INSERT INTO mitgliedschaft VALUES ('Crown the Empire', 'Andrew Velasquez', '2010-07-15', NULL);
INSERT INTO mitgliedschaft VALUES ('Crown the Empire', 'Brandon Hoover', '2010-07-15', NULL);
INSERT INTO mitgliedschaft VALUES ('Crown the Empire', 'Hayden Tree', '2010-07-15', NULL);
INSERT INTO mitgliedschaft VALUES ('Crown the Empire', 'Brent Taddie', '2010-07-15', NULL);


INSERT INTO mcd VALUES (1161, 'Limitless');
INSERT INTO mcd VALUES (1162, 'The Fallout');
INSERT INTO mcd VALUES (1163, 'The Resistence: Rise of Runaways');
INSERT INTO mcd VALUES (1164, 'Retrogate');


INSERT INTO album VALUES (1161, '2011', 'Crown the Empire', NULL);
INSERT INTO album VALUES (1162, '2012', 'Crown the Empire', NULL);
INSERT INTO album VALUES (1163, '2014', 'Crown the Empire', NULL);
INSERT INTO album VALUES (1164, '2016', 'Crown the Empire', NULL);

INSERT INTO disc VALUES (1161, 1);
INSERT INTO disc VALUES (1162, 1);
INSERT INTO disc VALUES (1163, 1);
INSERT INTO disc VALUES (1164, 1);


INSERT INTO genre VALUES ('Alternativ Metal');


INSERT INTO song VALUES ('Zero', 'Original', '00:03:02', 'Crown the Empire', 'Alternativ Metal');
INSERT INTO song VALUES ('Hologram', 'Original', '00:03:46', 'Crown the Empire', 'Alternativ Metal');
INSERT INTO song VALUES ('Are you coming with me?', 'Original', '00:03:50', 'Crown the Empire', 'Alternativ Metal');
INSERT INTO song VALUES ('SK-68', 'Original', '00:01:41', 'Crown the Empire', 'Alternativ Metal');
INSERT INTO song VALUES ('Aftermath', 'Original', '00:03:50', 'Crown the Empire', 'Alternativ Metal');
INSERT INTO song VALUES ('The fear is real', 'Original', '00:03:24', 'Crown the Empire', 'Alternativ Metal');
INSERT INTO song VALUES ('Lucky us', 'Original', '00:03:44', 'Crown the Empire', 'Alternativ Metal');
INSERT INTO song VALUES ('Weight of the World', 'Original', '00:03:28', 'Crown the Empire', 'Alternativ Metal');
INSERT INTO song VALUES ('Signs of Life', 'Original', '00:03:55', 'Crown the Empire', 'Alternativ Metal');
INSERT INTO song VALUES ('Oxygen', 'Original', '00:04:10', 'Crown the Empire', 'Alternativ Metal');
INSERT INTO song VALUES ('Kaleidoskope', 'Original', '00:03:29', 'Crown the Empire', 'Alternativ Metal');


INSERT INTO song VALUES ('The Glass Elevator(Walls)', 'Original', '00:02:56', 'Crown the Empire', 'Alternativ Metal');
INSERT INTO song VALUES ('Breaking Point', 'Original', '00:04:42', 'Crown the Empire', 'Alternativ Metal');
INSERT INTO song VALUES ('Wake me up', 'Original', '00:04:23', 'Crown the Empire', 'Alternativ Metal');
INSERT INTO song VALUES ('Johnny Ringo', 'Original', '00:04:19', 'Crown the Empire', 'Alternativ Metal');
INSERT INTO song VALUES ('Voices', 'Original', '00:03:22', 'Crown the Empire', 'Alternativ Metal');
INSERT INTO song VALUES ('Limitless', 'Original', '00:04:28', 'Crown the Empire', 'Alternativ Metal');
INSERT INTO song VALUES ('Lead me out of the Dark', 'Original', '00:03:18', 'Crown the Empire', 'Alternativ Metal');


INSERT INTO inhalt VALUES(1, 1164, 1, 'SK-68', 'Original', 'Crown the Empire');
INSERT INTO inhalt VALUES(2, 1164, 1, 'Are you coming with me?', 'Original', 'Crown the Empire');
INSERT INTO inhalt VALUES(3, 1164, 1, 'Zero', 'Original', 'Crown the Empire');
INSERT INTO inhalt VALUES(4, 1164, 1, 'Aftermath', 'Original', 'Crown the Empire');
INSERT INTO inhalt VALUES(5, 1164, 1, 'Hologram', 'Original', 'Crown the Empire');
INSERT INTO inhalt VALUES(6, 1164, 1, 'The fear is real', 'Original', 'Crown the Empire');
INSERT INTO inhalt VALUES(7, 1164, 1, 'Lucky us', 'Original', 'Crown the Empire');
INSERT INTO inhalt VALUES(8, 1164, 1, 'Weight of the World', 'Original', 'Crown the Empire');
INSERT INTO inhalt VALUES(9, 1164, 1, 'Signs of Life', 'Original', 'Crown the Empire');
INSERT INTO inhalt VALUES(10, 1164, 1, 'Oxygen', 'Original', 'Crown the Empire');
INSERT INTO inhalt VALUES(11, 1164, 1, 'Kaleidoskope', 'Original', 'Crown the Empire');


INSERT INTO inhalt VALUES(1, 1161, 1, 'The Glass Elevator(Walls)', 'Original', 'Crown the Empire');
INSERT INTO inhalt VALUES(2, 1161, 1, 'Breaking Point', 'Original', 'Crown the Empire');
INSERT INTO inhalt VALUES(3, 1161, 1, 'Wake me up', 'Original', 'Crown the Empire');
INSERT INTO inhalt VALUES(4, 1161, 1, 'Johnny Ringo', 'Original', 'Crown the Empire');
INSERT INTO inhalt VALUES(5, 1161, 1, 'Voices', 'Original', 'Crown the Empire');
INSERT INTO inhalt VALUES(6, 1161, 1, 'Limitless', 'Original', 'Crown the Empire');
INSERT INTO inhalt VALUES(7, 1161, 1, 'Lead me out of the Dark', 'Original', 'Crown the Empire');





-- 117 REICHMANN Adrian L.
-- CDs deren Titel aus mehr als zwei Worten besteht
INSERT INTO interpret VALUES ('Sido', 'http://www.sido.de');
INSERT INTO solist VALUES ('Sido', '1980-11-30');
INSERT INTO mcd VALUES (1171, 'Das goldene Album');
INSERT INTO mcd VALUES (1172, 'VI');
INSERT INTO mcd VALUES (1173, '30-11-80');
INSERT INTO album VALUES (1171, '2016', 'Sido', NULL);
INSERT INTO album VALUES (1172, '2015', 'Sido', NULL);
INSERT INTO album VALUES (1173, '2013', 'Sido', NULL);
INSERT INTO disc VALUES (1171, 1);
INSERT INTO disc VALUES (1172, 1);
INSERT INTO disc VALUES (1173, 1);
INSERT INTO song VALUES('Der einzige Weg','Mastered','00:03:41','Sido','Gangsta-Rap');
INSERT INTO song VALUES('Löwenzahn','Mastered','00:04:02','Sido','Gangsta-Rap');
INSERT INTO song VALUES('Liebe','Mastered','00:03:15','Sido','Gangsta-Rap');
INSERT INTO inhalt VALUES(1, 1171,1,'Der einzige Weg','Mastered','Sido');
INSERT INTO inhalt VALUES(1, 1172,1,'Löwenzahn','Mastered','Sido');
INSERT INTO inhalt VALUES(1, 1173,1,'Liebe','Mastered','Sido');




-- 118 SCHWARTZ Vincent
INSERT INTO interpret VALUES ('The Chainsmokers','www.thechainsmokers.com');
INSERT INTO interpret VALUES ('Andrew Taggart',NULL);
INSERT INTO interpret VALUES ('Alex Pall',NULL);

INSERT INTO solist VALUES ('Andrew Taggart','1990-06-09');
INSERT INTO solist VALUES ('Alex Pall','1985-08-12');

INSERT INTO band VALUES ('The Chainsmokers','2012');

INSERT INTO mitgliedschaft VALUES ('The Chainsmokers','Andrew Taggart','2012-02-17',NULL);
INSERT INTO mitgliedschaft VALUES ('The Chainsmokers','Alex Pall','2012-02-17',NULL);

INSERT INTO mcd VALUES (1181,'Bouquet');
INSERT INTO mcd VALUES (1182,'Collage');

INSERT INTO album VALUES (1181,'2015','The Chainsmokers',NULL);
INSERT INTO album VALUES (1182,'2016','The Chainsmokers',NULL);

INSERT INTO disc VALUES (1181,1);
INSERT INTO disc VALUES (1181,2);
INSERT INTO disc VALUES (1182,1);
INSERT INTO disc VALUES (1182,2);
INSERT INTO disc VALUES (1182,3);
INSERT INTO disc VALUES (1182,4);
INSERT INTO disc VALUES (1182,5);

INSERT INTO song VALUES ('#Selfie','Original',00-03-03,'The Chainsmokers','Elektro');
INSERT INTO song VALUES ('Roses','Original',00-03-46,'The Chainsmokers','Elektro');
INSERT INTO song VALUES ('Dont Let Me Down','Original',00-03-28,'The Chainsmokers','Elektro');
INSERT INTO song VALUES ('Closer','Original',00-04-22,'The Chainsmokers','Elektro');
INSERT INTO song VALUES ('All We Know','Original',00-03-16,'The Chainsmokers','Elektro');
INSERT INTO song VALUES ('Setting Fires','Original',00-04-21,'The Chainsmokers','Elektro');
INSERT INTO song VALUES ('Paris','Original',00-03-43,'The Chainsmokers','Elektro');

INSERT INTO inhalt VALUES (1, 1181,2,'#Selfie','Original','The Chainsmokers');
INSERT INTO inhalt VALUES (1, 1181,1,'Roses','Original','The Chainsmokers');
INSERT INTO inhalt VALUES (1, 1182,4,'Dont Let Me Down','Original','The Chainsmokers');
INSERT INTO inhalt VALUES (1, 1182,3,'Closer','Original','The Chainsmokers');
INSERT INTO inhalt VALUES (1, 1182,2,'All We Know','Original','The Chainsmokers');
INSERT INTO inhalt VALUES (1, 1182,1,'Setting Fires','Original','The Chainsmokers');
INSERT INTO inhalt VALUES (1, 1182,5,'Paris','Original','The Chainsmokers');





-- 119 SEEMANN Manuel
-- Interpreten deren Name aus einem Wort besteht
-- Interpreten die mehr als zwei Alben produziert haben
INSERT INTO interpret VALUES ('Adele', 'https://home.adele.com/');

-- Solisten die nie bei Bands mitwirkten
INSERT INTO solist VALUES ('Adele', '1988-05-05');

-- CDs deren Titel aus einem Wort besteht
INSERT INTO mcd VALUES(1192, '25');

-- Alben deren Titel aus einem Wort besteht
INSERT INTO album VALUES(1192, '2016', 'Adele', NULL);

INSERT INTO disc VALUES(1192, 1);

-- INSERT INTO genre VALUES('Pop');

INSERT INTO song VALUES ('Hello', '', '00:04:55', 'Adele', 'Pop');
INSERT INTO song VALUES ('Send My Love', '', '00:03:43', 'Adele', 'Pop');
INSERT INTO song VALUES ('I Miss You', '', '00:05:48', 'Adele', 'Pop');
INSERT INTO song VALUES ('When We Were Young', '', '00:04:50', 'Adele', 'Pop');
INSERT INTO song VALUES ('Remedy', '', '00:04:05', 'Adele', 'Pop');
INSERT INTO song VALUES ('Water Under the Bridge', '', '00:04:00', 'Adele', 'Pop');
INSERT INTO song VALUES ('River Lea', '', '00:03:48', 'Adele', 'Pop');
INSERT INTO song VALUES ('Love in the Dark', '', '00:04:45', 'Adele', 'Pop');
INSERT INTO song VALUES ('Million Years Ago', '', '00:03:47', 'Adele', 'Pop');
INSERT INTO song VALUES ('All I Ask', '', '00:04:31', 'Adele', 'Pop');
INSERT INTO song VALUES ('Sweetest Devotion', '', '00:04:11', 'Adele', 'Pop');

INSERT INTO inhalt VALUES (1, 1192, 1, 'Hello', '', 'Adele');
INSERT INTO inhalt VALUES (2, 1192, 1, 'Send My Love', '', 'Adele');
INSERT INTO inhalt VALUES (3, 1192, 1, 'I Miss You', '', 'Adele');
INSERT INTO inhalt VALUES (4, 1192, 1, 'When We Were Young', '', 'Adele');
INSERT INTO inhalt VALUES (5, 1192, 1, 'Remedy', '', 'Adele');
INSERT INTO inhalt VALUES (6, 1192, 1, 'Water Under the Bridge', '', 'Adele');
INSERT INTO inhalt VALUES (7, 1192, 1, 'River Lea', '', 'Adele');
INSERT INTO inhalt VALUES (8, 1192, 1, 'Love in the Dark', '', 'Adele');
INSERT INTO inhalt VALUES (9, 1192, 1, 'Million Years Ago', '', 'Adele');
INSERT INTO inhalt VALUES (10, 1192, 1, 'All I Ask', '', 'Adele');
INSERT INTO inhalt VALUES (11, 1192, 1, 'Sweetest Devotion', '', 'Adele');





-- 120 STRASSER Alexander
INSERT INTO interpret (iname, homepage) VALUES ('Hans Brabenetz', 'www.hans.com');
INSERT INTO interpret (iname, homepage) VALUES ('Hans Zimmer', 'www.hans-zimmer.com');
INSERT INTO interpret (iname) VALUES ('Howard Shore');
INSERT INTO interpret (iname, homepage) VALUES ('Hozier', 'www.hozierislovehozierislife.com');
INSERT INTO solist (iname, geburtsdatum) VALUES ('Hans Brabenetz', null);
INSERT INTO solist (iname, geburtsdatum) VALUES ('Hans Zimmer', '1957-09-12');
INSERT INTO solist (iname, geburtsdatum) VALUES ('Howard Shore', '1946-10-18');
INSERT INTO solist (iname, geburtsdatum) VALUES ('Hozier', '1990-03-17');

INSERT INTO mcd VALUES (1201, 'Bralphabet');
INSERT INTO mcd VALUES (1202, 'Hozier');
INSERT INTO mcd VALUES (1203, 'Live in America');
INSERT INTO mcd VALUES (1204, 'From Eden EP');
INSERT INTO mcd VALUES (1205, 'Take Me To Church E.P.');
INSERT INTO mcd VALUES (1206, 'Inception: Music from the Motion Picture');
INSERT INTO mcd VALUES (1207, 'Interstellar (Original Motion Picture Soundtrack');
INSERT INTO mcd VALUES (1208, 'The Dark Knight');
INSERT INTO mcd VALUES (1209, 'Man of Steel');
INSERT INTO mcd VALUES (12010, 'Pirates of the Caribbean: the Curse of the Black Pearl');
INSERT INTO mcd VALUES (12011, 'The Dark Knight Rises');
INSERT INTO mcd VALUES (12012, 'Illuminati');
INSERT INTO mcd VALUES (12013, 'Rush');
INSERT INTO mcd VALUES (12014, 'The Lord of the Rings: The Fellowship of the Ring');
INSERT INTO mcd VALUES (12015, 'The Lord of the Rings: The Two Towers');
INSERT INTO mcd VALUES (12016, 'The Hobbit: An Unexpected Journey');

INSERT INTO album (mcdid, pjahr, iname) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Bralphabet'), '0000', 'Hans Brabenetz');
INSERT INTO album (mcdid, pjahr, iname) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Hozier'), '2014', 'Hozier');
INSERT INTO album (mcdid, pjahr, iname) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Live in America'), '2015', 'Hozier');
INSERT INTO album (mcdid, pjahr, iname) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'From Eden EP'), '2014', 'Hozier');
INSERT INTO album (mcdid, pjahr, iname) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Take Me To Church E.P.'), '2013', 'Hozier');
INSERT INTO album (mcdid, pjahr, iname) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Inception: Music from the Motion Picture'), '2010', 'Hans Zimmer');
INSERT INTO album (mcdid, pjahr, iname) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Interstellar (Original Motion Picture Soundtrack'), '2014', 'Hans Zimmer');
INSERT INTO album (mcdid, pjahr, iname) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'The Dark Knight'), '2008' ,'Hans Zimmer');
INSERT INTO album (mcdid, pjahr, iname) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Man of Steel'), '2013', 'Hans Zimmer');
INSERT INTO album (mcdid, pjahr, iname) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Pirates of the Caribbean: the Curse of the Black Pearl'), '2003', 'Hans Zimmer');
INSERT INTO album (mcdid, pjahr, iname) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'The Dark Knight Rises'), '2012', 'Hans Zimmer');
INSERT INTO album (mcdid, pjahr, iname) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Illuminati'), '2009', 'Hans Zimmer');
INSERT INTO album (mcdid, pjahr, iname) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Rush'), '2013', 'Hans Zimmer');
INSERT INTO album (mcdid, pjahr, iname) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'The Lord of the Rings: The Fellowship of the Ring'), '2001', 'Howard Shore');
INSERT INTO album (mcdid, pjahr, iname) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'The Lord of the Rings: The Two Towers'), '2002', 'Howard Shore');
INSERT INTO album (mcdid, pjahr, iname) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'The Hobbit: An Unexpected Journey'), '2012', 'Howard Shore');

INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Bralphabet'), 1);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Bralphabet'), 2);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Hozier'), 1);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Hozier'), 2);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Live in America'), 1);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'From Eden EP'), 1);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Take Me To Church E.P.'), 1);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Inception: Music from the Motion Picture'), 1);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Interstellar (Original Motion Picture Soundtrack'), 1);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Interstellar (Original Motion Picture Soundtrack'), 2);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'The Dark Knight'), 1);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Man of Steel'), 1);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Man of Steel'), 2);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Pirates of the Caribbean: the Curse of the Black Pearl'), 1);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Pirates of the Caribbean: the Curse of the Black Pearl'), 2);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'The Dark Knight Rises'), 1);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Illuminati'), 1);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Rush'), 1);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'Rush'), 2);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'The Lord of the Rings: The Fellowship of the Ring'), 1);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'The Lord of the Rings: The Two Towers'), 1);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'The Lord of the Rings: The Two Towers'), 2);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'The Hobbit: An Unexpected Journey'), 1);
INSERT INTO disc (mcdid, discnr) VALUES ((SELECT mcdid FROM mcd WHERE mcdtitel = 'The Hobbit: An Unexpected Journey'), 2);

INSERT INTO genre (gbez) VALUES ('Folk-Rock');
INSERT INTO genre (gbez) VALUES ('Soundtrack');

INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Alles', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Brabenetz', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('C++', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Donau', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Excel', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Freund', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Geld', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Hans', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Intelligenz', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Jünglich', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Kayak', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Luxus', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Money', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Neuronales Netzwerk', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Ober cool', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Power', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Quelle des Wissens', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Reichtum', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Super', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Toll', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Ultra cool', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Visual Studio', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Wissen', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Xtra cool', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Yota cool', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Ziemlich cool', '', '00:07:07', 'Hans Brabenetz', 'Klassik');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Take Me To Church', '', '00:04:02', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Angel Of Small Death And The Codeine Scene', '', '00:03:39', 'Hozier', 'Folk-Rock'); 
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Jackie and Wilson', '', '00:03:43', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Someone New', '', '00:03:43', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('To Be Alone', '', '00:05:24', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('From Eden', '', '00:04:43', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('In A Week', '', '00:05:18', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Sedated', '', '00:03:16', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Work Song', '', '00:03:50', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Like Real People Do', '', '00:03:18', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('It Will Come Back', '', '00:04:38', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Foreigner\'s God', '', '00:03:45', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Cherry Wine', '', '00:04:00', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('In the Woods Somewhere', '', '00:05:31', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Run', '', '00:04:15', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Arsonist\'s Lullabye', '', '00:04:26', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('My Love Will Never Die', '', '00:03:55', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Someone New', 'Live in America', '00:04:21', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('To Be Alone', 'Live', '00:05:24', 'Hozier', 'Folk-Rock');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Half Remembered Dream', '', '00:01:12', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('We Built OUr Own World', '', '00:01:56', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Dream is Collapsing', '', '00:02:24', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Radical Notion', '', '00:03:43', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Old Souls', '', '00:07:44', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('528491', '', '00:02:24', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Mombasa', '', '00:04:54', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('One Simple Idea', '', '00:02:28', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Dream Within A Dream', '', '00:05:04', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Waiting For A Train', '', '00:09:30', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Paradox', '', '00:03:26', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Time', '', '00:04:36', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Dreaming of the Crash', '', '00:03:55', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Cornfield Chase', '', '00:02:06', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Dust', '', '00:05:41', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Day One', '', '00:03:19', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Stay', '', '00:06:52', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Message Frome Home', '', '00:01:40', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Wormhole', '', '00:01:30', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Mountains', '', '00:03:39', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Afraid of Time', '', '00:02:32', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('A Place Among the Stars', '', '00:03:27', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Running Out', '', '00:01:57', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('I\'m Going Home', '', '00:05:48', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Coward', '', '00:08:26', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Detach', '', '00:06:42', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('S.T.A.Y.', '', '00:06:23', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Where We\'re Going', '', '00:07:41', 'Hans Zimmer', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Concerning Hobbits', '', '00:02:55', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Shadow of the Past', '', '00:03:33', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('A Knife in the Dark', '', '00:03:34', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Fight to the Ford', '', '00:04:15', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Many Meetings', '', '00:03:05', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Council of Elrond', '', '00:03:49', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Ring Goes South', '', '00:02:03', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Bridge of Khazad Dum', '', '00:05:57', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Lothlorien', '', '00:04:34', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Amon Hen', '', '00:05:02', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Breaking of the Fellowship', '', '00:07:21', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('May It Be', '', '00:04:18', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Foundation of Stone', '', '00:03:54', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Taming of Sméagol', '', '00:02:51', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Riders of Rohan', '', '00:04:08', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Passage of the Marshes', '', '00:02:48', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Uruk-Hai', '', '00:02:47', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The King of the Golden Hall', '', '00:03:51', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Black Gate Is Closed', '', '00:03:02', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Evenstar', '', '00:03:18', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The White Rider', '', '00:02:30', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Treebeard', '', '00:02:46', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Leave Taking', '', '00:03:44', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Helm\'s Deep', '', '00:03:55', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Forbidden Pool', '', '00:05:29', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Breath of Life', '', '00:05:10', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Hornburg', '', '00:04:39', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Forth Eorlingas', '', '00:03:18', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Isengard Unleashed', '', '00:05:03', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Samwise the Brave', '', '00:03:48', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Gollum\'s Song', '', '00:05:51', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Farwell to Lórien', '', '00:04:38', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('My Dear Frod', '', '00:08:03', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Old Firends', '', '00:04:27', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('An Unexpected Party', '', '00:03:52', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Axe or Sword', '', '00:05:57', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Misty Mountains', '', '00:01:40', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Adventure Begins', '', '00:02:03', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The World Is Ahead', '', '00:02:19', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('An Ancient Enemy', '', '00:04:57', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Radagast The Brown', '', '00:04:53', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Roast Mutton', '', '00:04:01', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('A Troll-Hoard', '', '00:02:37', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Hill Of Sorcery', '', '00:03:49', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Warg-Scouts', '', '00:03:03', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Hidden Valley', '', '00:03:49', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Moon Runes', '', '00:03:18', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The Defiler', '', '00:01:12', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('The White Council', '', '00:07:19', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Over Hill', '', '00:03:42', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('A Thunder Battle', '', '00:03:53', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Under Hill', '', '00:01:53', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Riddles In the Dark', '', '00:05:21', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Brass Buttons', '', '00:07:37', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Out Of The Frying-Pan', '', '00:05:54', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('A Good Omen', '', '00:05:45', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Song Of The Lonley Mountain', '', '00:04:08', 'Howard Shore', 'Soundtrack');
INSERT INTO song (stitel, sversion, sdauer, iname, gbez) VALUES ('Dreaming Of Bag End', '', '00:01:50', 'Howard Shore', 'Soundtrack');

SET @mcdid = (SELECT mcdid FROM mcd WHERE mcdtitel = 'Bralphabet');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (1, @mcdid, 1, 'Alles', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (2, @mcdid, 1, 'Brabenetz', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (3, @mcdid, 1, 'C++', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (4, @mcdid, 1, 'Donau', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (5, @mcdid, 1, 'Excel', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (6, @mcdid, 1, 'Freund', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (7, @mcdid, 1, 'Geld', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (8, @mcdid, 1, 'Hans', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (9, @mcdid, 1, 'Intelligenz', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (10, @mcdid, 1, 'Jünglich', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (11, @mcdid, 1, 'Kayak', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (12, @mcdid, 1, 'Luxus', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (13, @mcdid, 1, 'Money', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (1, @mcdid, 2, 'Neuronales Netzwerk', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (2, @mcdid, 2, 'Ober cool', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (3, @mcdid, 2, 'Power', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (4, @mcdid, 2, 'Quelle des Wissens', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (5, @mcdid, 2, 'Reichtum', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (6, @mcdid, 2, 'Super', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (7, @mcdid, 2, 'Toll', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (8, @mcdid, 2, 'Ultra cool', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (9, @mcdid, 2, 'Visual Studio', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (10, @mcdid, 2, 'Wissen', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (11, @mcdid, 2, 'Xtra cool', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (12, @mcdid, 2, 'Yota cool', '', 'Hans Brabenetz');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (13, @mcdid, 2, 'Ziemlich cool', '', 'Hans Brabenetz');

SET @mcdid = (SELECT mcdid FROM mcd WHERE mcdtitel = 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (1, @mcdid, 1, 'Take Me To Church', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (2, @mcdid, 1, 'Angel Of Small Death And The Codeine Scene', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (3, @mcdid, 1, 'Jackie and Wilson', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (4, @mcdid, 1, 'Someone New', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (5, @mcdid, 1, 'To Be Alone', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (6, @mcdid, 1, 'From Eden', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (7, @mcdid, 1, 'In A Week', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (8, @mcdid, 1, 'Sedated', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (9, @mcdid, 1, 'Work Song', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (1, @mcdid, 2, 'Like Real People Do', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (2, @mcdid, 2, 'It Will Come Back', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (3, @mcdid, 2, 'Foreigner\'s God', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (4, @mcdid, 2, 'Cherry Wine', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (5, @mcdid, 2, 'In the Woods Somewhere', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (6, @mcdid, 2, 'Run', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (7, @mcdid, 2, 'Arsonist\'s Lullabye', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (8, @mcdid, 2, 'My Love Will Never Die', '', 'Hozier');

SET @mcdid = (SELECT mcdid FROM mcd WHERE mcdtitel = 'Live in America');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (1, @mcdid, 1, 'Like Real People Do', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (2, @mcdid, 1, 'From Eden', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (3, @mcdid, 1, 'Jackie and Wilson', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (4, @mcdid, 1, 'Someone New', 'Live in America', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (5, @mcdid, 1, 'Work Song', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (6, @mcdid, 1, 'Take Me To Church', '', 'Hozier');

SET @mcdid = (SELECT mcdid FROM mcd WHERE mcdtitel = 'From Eden EP');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (1, @mcdid, 1, 'From Eden', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (2, @mcdid, 1, 'Work Song', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (3, @mcdid, 1, 'Arsonist\'s Lullabye', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (4, @mcdid, 1, 'To Be Alone', 'Live', 'Hozier');

SET @mcdid = (SELECT mcdid FROM mcd WHERE mcdtitel = 'Take Me To Church E.P.');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (1, @mcdid, 1, 'Take Me To Church', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (2, @mcdid, 1, 'Like Real People Do', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (3, @mcdid, 1, 'Angel Of Small Death And The Codeine Scene', '', 'Hozier');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (4, @mcdid, 1, 'Cherry Wine', '', 'Hozier');

SET @mcdid = (SELECT mcdid FROM mcd WHERE mcdtitel = 'Inception: Music from the Motion Picture');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (1, @mcdid, 1, 'Half Remembered Dream', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (2, @mcdid, 1, 'We Built OUr Own World', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (3, @mcdid, 1, 'Dream is Collapsing', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (4, @mcdid, 1, 'Radical Notion', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (5, @mcdid, 1, 'Old Souls', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (6, @mcdid, 1, '528491', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (7, @mcdid, 1, 'Mombasa', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (8, @mcdid, 1, 'One Simple Idea', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (9, @mcdid, 1, 'Dream Within A Dream', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (10, @mcdid, 1, 'Waiting For A Train', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (11, @mcdid, 1, 'Paradox', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (12, @mcdid, 1, 'Time', '', 'Hans Zimmer');

SET @mcdid = (SELECT mcdid FROM mcd WHERE mcdtitel = 'Interstellar (Original Motion Picture Soundtrack');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (1, @mcdid, 1, 'Dreaming of the Crash', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (2, @mcdid, 1, 'Cornfield Chase', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (3, @mcdid, 1, 'Dust', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (4, @mcdid, 1, 'Day One', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (5, @mcdid, 1, 'Stay', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (6, @mcdid, 1, 'Message Frome Home', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (7, @mcdid, 1, 'The Wormhole', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (8, @mcdid, 1, 'Mountains', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (1, @mcdid, 2, 'Afraid of Time', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (2, @mcdid, 2, 'A Place Among the Stars', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (3, @mcdid, 2, 'Running Out', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (4, @mcdid, 2, 'I\'m Going Home', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (5, @mcdid, 2, 'Coward', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (6, @mcdid, 2, 'Detach', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (7, @mcdid, 2, 'S.T.A.Y.', '', 'Hans Zimmer');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (8, @mcdid, 2, 'Where We\'re Going', '', 'Hans Zimmer');

SET @mcdid = (SELECT mcdid FROM mcd WHERE mcdtitel = 'The Lord of the Rings: The Fellowship of the Ring');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (1, @mcdid, 1, 'Concerning Hobbits', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (2, @mcdid, 1, 'The Shadow of the Past', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (3, @mcdid, 1, 'A Knife in the Dark', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (4, @mcdid, 1, 'Fight to the Ford', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (5, @mcdid, 1, 'Many Meetings', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (6, @mcdid, 1, 'The Council of Elrond', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (7, @mcdid, 1, 'The Ring Goes South', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (8, @mcdid, 1, 'The Bridge of Khazad Dum', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (9, @mcdid, 1, 'Lothlorien', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (10, @mcdid, 1, 'Amon Hen', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (11, @mcdid, 1, 'The Breaking of the Fellowship', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (12, @mcdid, 1, 'May It Be', '', 'Howard Shore');

SET @mcdid = (SELECT mcdid FROM mcd WHERE mcdtitel = 'The Lord of the Rings: The Two Towers');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (1, @mcdid, 1, 'Foundation of Stone', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (2, @mcdid, 1, 'The Taming of Sméagol', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (3, @mcdid, 1, 'The Riders of Rohan', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (4, @mcdid, 1, 'The Passage of the Marshes', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (5, @mcdid, 1, 'The Uruk-Hai', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (6, @mcdid, 1, 'The King of the Golden Hall' , '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (7, @mcdid, 1, 'The Black Gate Is Closed', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (8, @mcdid, 1, 'Evenstar', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (9, @mcdid, 1, 'The White Rider', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (10, @mcdid, 1, 'Treebeard', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (1, @mcdid, 2, 'The Leave Taking', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (2, @mcdid, 2, 'Helm\'s Deep', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (3, @mcdid, 2, 'The Forbidden Pool', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (4, @mcdid, 2, 'Breath of Life', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (5, @mcdid, 2, 'The Hornburg', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (6, @mcdid, 2, 'Forth Eorlingas', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (7, @mcdid, 2, 'Isengard Unleashed', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (8, @mcdid, 2, 'Samwise the Brave', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (9, @mcdid, 2, 'Gollum\'s Song', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (10, @mcdid, 2, 'Farwell to Lórien', '', 'Howard Shore');

SET @mcdid = (SELECT mcdid FROM mcd WHERE mcdtitel = 'The Hobbit: An Unexpected Journey');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (1, @mcdid, 1, 'My Dear Frod', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (2, @mcdid, 1, 'Old Firends', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (3, @mcdid, 1, 'An Unexpected Party', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (4, @mcdid, 1, 'Axe or Sword', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (5, @mcdid, 1, 'Misty Mountains', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (6, @mcdid, 1, 'The Adventure Begins', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (7, @mcdid, 1, 'The World Is Ahead', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (8, @mcdid, 1, 'An Ancient Enemy', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (9, @mcdid, 1, 'Radagast The Brown', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (10, @mcdid, 1, 'Roast Mutton', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (11, @mcdid, 1, 'A Troll-Hoard', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (12, @mcdid, 1, 'The Hill Of Sorcery', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (13, @mcdid, 1, 'Warg-Scouts', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (1, @mcdid, 2, 'The Hidden Valley', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (2, @mcdid, 2, 'Moon Runes', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (3, @mcdid, 2, 'The Defiler', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (4, @mcdid, 2, 'The White Council', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (5, @mcdid, 2, 'Over Hill', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (6, @mcdid, 2, 'A Thunder Battle', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (7, @mcdid, 2, 'Under Hill', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (8, @mcdid, 2, 'Riddles In the Dark', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (9, @mcdid, 2, 'Brass Buttons', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (10, @mcdid, 2, 'Out Of The Frying-Pan', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (11, @mcdid, 2, 'A Good Omen', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (12, @mcdid, 2, 'Song Of The Lonley Mountain', '', 'Howard Shore');
INSERT INTO inhalt (tracknr, mcdid, discnr, stitel, sversion, iname) VALUES (13, @mcdid, 2,  'Dreaming Of Bag End', '', 'Howard Shore');





-- 121 TIEBER Matthias
-- Homepage des Interpreten ist nicht bekannt
-- Interpreten deren Name mit einem Kleinbuchstaben beg.
INSERT INTO interpret VALUES('yung hurn', 'NULL');

-- Solisten die nie bei Bands mitwirkten
INSERT INTO solist VALUES ('yung hurn', '2015-01-01');

-- CDs deren Titel aus einem Wort besteht
INSERT INTO mcd VALUES(1212, '22');

-- Alben deren Titel aus einem Wort besteht
INSERT INTO album VALUES(1212, '2016', 'yung hurn', NULL);

INSERT INTO disc VALUES(1212, 1);

INSERT INTO genre VALUES('Chill');

-- Songs die auf keiner Disc enthalten sind
INSERT INTO song VALUES ('Skrrt Skrrt', '', '00:03:41', 'yung hurn', 'Chill');
INSERT INTO song VALUES ('Grauer Rauch', '', '00:02:41', 'yung hurn', 'Chill');
INSERT INTO song VALUES ('Ich Will Dich', '', '00:03:59', 'yung hurn', 'Chill');
INSERT INTO song VALUES ('Blablablabla', '', '00:01:49', 'yung hurn', 'Chill');
INSERT INTO song VALUES ('Sk8erboi', '', '00:02:26', 'yung hurn', 'Chill');
INSERT INTO song VALUES ('Bianco', '', '00:03:55', 'yung hurn', 'Chill');
INSERT INTO song VALUES ('Stoli', '', '00:02:40', 'yung hurn', 'Chill');
INSERT INTO song VALUES ('Pillen', '', '00:03:30', 'yung hurn', 'Chill');
INSERT INTO song VALUES ('Ferrari', '', '00:03:36', 'yung hurn', 'Chill');
INSERT INTO song VALUES ('Nein', '', '00:02:54', 'yung hurn', 'Chill');
INSERT INTO song VALUES ('Diamant', '', '00:03:51', 'yung hurn', 'Chill');
INSERT INTO song VALUES ('Wiener Linien', '', '00:02:08', 'yung hurn', 'Chill');
INSERT INTO song VALUES ('Opernsänger', '', '00:03:04', 'yung hurn', 'Chill');
INSERT INTO song VALUES ('Crack ft. Tryptamine', '', '00:02:28', 'yung hurn', 'Chill');
INSERT INTO song VALUES ('Flippe Bricks', '', '00:03:47', 'yung hurn', 'Chill');

INSERT INTO inhalt VALUES (1, 1212, 1, 'Sk8erboi', '', 'yung hurn');
INSERT INTO inhalt VALUES (2, 1212, 1, 'Nein', '', 'yung hurn');
INSERT INTO inhalt VALUES (3, 1212, 1, 'Flippe Bricks', '', 'yung hurn');
INSERT INTO inhalt VALUES (4, 1212, 1, 'Crack ft. Tryptamine', '', 'yung hurn');
INSERT INTO inhalt VALUES (5, 1212, 1, 'Stoli', '', 'yung hurn');
INSERT INTO inhalt VALUES (6, 1212, 1, 'Pillen', '', 'yung hurn');
INSERT INTO inhalt VALUES (7, 1212, 1, 'Ferrari', '', 'yung hurn');
INSERT INTO inhalt VALUES (8, 1212, 1, 'Ich Will Dich', '', 'yung hurn');
INSERT INTO inhalt VALUES (9, 1212, 1, 'Grauer Rauch', '', 'yung hurn');





-- 122 WINTERSPERGER Michael
-- Interpreten deren Name aus mehr als zwei Worten best.
INSERT INTO interpret Values ('Five Finger Death Punch','https://fivefingerdeathpunch.com/');
INSERT INTO interpret VALUES ('Ivan „Ghost“ Moody','1980-01-07');
-- Interpreten deren Homepage unbekannt ist
INSERT INTO interpret VALUES ('Zoltan Bathory',NULL);
INSERT INTO interpret VALUES ('Jason Hook',NULL);
INSERT INTO interpret VALUES ('Chris Kael',NULL);
INSERT INTO interpret VALUES ('Jeremy Spencer',NULL);
INSERT INTO interpret VALUES ('Caleb Bingham',NULL);
INSERT INTO interpret VALUES ('Darrell Roberts',NULL);
INSERT INTO interpret VALUES ('Matt Snell',NULL);

-- Solisten die noch immer bei einer Band mitwirken
INSERT INTO solist VALUES ('Ivan „Ghost“ Moody','1980-01-07');
INSERT INTO solist VALUES ('Zoltan Bathory',NULL);
INSERT INTO solist VALUES ('Jason Hook','1970-10-03');
INSERT INTO solist VALUES ('Chris Kael',NULL);
INSERT INTO solist VALUES ('Jeremy Spencer','1973-01-08');
INSERT INTO solist VALUES ('Caleb Bingham',NULL);
INSERT INTO solist VALUES ('Darrell Roberts','1970-03-16');
INSERT INTO solist VALUES ('Matt Snell',NULL);

-- Bands die mehr als zwei Mitglieder haben / hatten
INSERT INTO band Values ('Five Finger Death Punch','2005');

INSERT INTO mitgliedschaft VALUES ('Five Finger Death Punch','Ivan „Ghost“ Moody','2005-01-01',NULL);
INSERT INTO mitgliedschaft VALUES ('Five Finger Death Punch','Zoltan Bathory','2005-01-01',NULL);
INSERT INTO mitgliedschaft VALUES ('Five Finger Death Punch','Jason Hook','2009-01-01',NULL);
INSERT INTO mitgliedschaft VALUES ('Five Finger Death Punch','Chris Kael','2011-01-01',NULL);
INSERT INTO mitgliedschaft VALUES ('Five Finger Death Punch','Jeremy Spencer','2005-01-01',NULL);
INSERT INTO mitgliedschaft VALUES ('Five Finger Death Punch','Caleb Bingham','2005-01-01','2007-01-01');
INSERT INTO mitgliedschaft VALUES ('Five Finger Death Punch','Darrell Roberts','2007-01-01','2009-01-01');
INSERT INTO mitgliedschaft VALUES ('Five Finger Death Punch','Matt Snell','2006-01-01','2011-01-01');

-- CDs deren Titel aus mehr als zwei Worten besteht
INSERT INTO mcd VALUES (1221,'Wrong Side of Heavenv1');
INSERT INTO mcd VALUES (1222,'Wrong Side of Heavenv2');

-- Playlists die mehr als zehn Songs enthalten
INSERT INTO playlist VALUES (1222);

-- Alben deren Titel aus mehr als zwei Worten besteht
INSERT INTO album VALUES (1221,2013,'Five Finger Death Punch',NULL);

INSERT INTO disc VALUES (1221,1);
INSERT INTO disc VALUES (1221,2);

INSERT INTO song VALUES('Lift Me Up','1','00:04:06','Five Finger Death Punch','Metal');
INSERT INTO song VALUES('Watch You Blee','1','00:03:43','Five Finger Death Punch','Metal');
INSERT INTO song VALUES('You','1','00:03:03','Five Finger Death Punch','Metal');
INSERT INTO song VALUES('Wrong Side of Heaven','1','00:04:31','Five Finger Death Punch','Metal');
INSERT INTO song VALUES('Burn MF','1','00:03:37','Five Finger Death Punch','Metal');
INSERT INTO song VALUES('I.M.Sin','1','00:03:39','Five Finger Death Punch','Metal');
INSERT INTO song VALUES('Anywhere But Here','1','00:03:45','Five Finger Death Punch','Metal');
INSERT INTO song VALUES('Dot Your Eyes','1','00:03:15','Five Finger Death Punch','Metal');
INSERT INTO song VALUES('M.I.N.E','1','00:04:06','Five Finger Death Punch','Metal');
INSERT INTO song VALUES('Mama Said Knock You Out','1','00:02:47','Five Finger Death Punch','Metal');
INSERT INTO song VALUES('Diary of a Deadman','1','00:04:44','Five Finger Death Punch','Metal');
INSERT INTO song VALUES('I.M.Sin','Gast Singer','00:03:39','Five Finger Death Punch','Metal');
INSERT INTO song VALUES('Anywhere But Here','Duet mit Gast Singer','00:03:46','Five Finger Death Punch','Metal');
INSERT INTO song VALUES('Dot Your Eres','Gast Singer','00:03:15','Five Finger Death Punch','Metal');

INSERT INTO inhalt VALUES(1, 1221,1,'Lift Me Up','1','Five Finger Death Punch');
INSERT INTO inhalt VALUES(2, 1221,1,'Watch You Blee','1','Five Finger Death Punch');
INSERT INTO inhalt VALUES(3, 1221,1,'You','1','Five Finger Death Punch');
INSERT INTO inhalt VALUES(4, 1221,1,'Wrong Side of Heaven','1','Five Finger Death Punch');
INSERT INTO inhalt VALUES(5, 1221,1,'Burn MF','1','Five Finger Death Punch');
INSERT INTO inhalt VALUES(6, 1221,1,'I.M.Sin','1','Five Finger Death Punch');
INSERT INTO inhalt VALUES(7, 1221,1,'Anywhere But Here','1','Five Finger Death Punch');
INSERT INTO inhalt VALUES(1, 1221,2,'Dot Your Eyes','1','Five Finger Death Punch');
INSERT INTO inhalt VALUES(2, 1221,2,'M.I.N.E','1','Five Finger Death Punch');
INSERT INTO inhalt VALUES(3, 1221,2,'Mama Said Knock You Out','1','Five Finger Death Punch');
INSERT INTO inhalt VALUES(4, 1221,2,'Diary of a Deadman','1','Five Finger Death Punch');
INSERT INTO inhalt VALUES(5, 1221,2,'I.M.Sin','Gast Singer','Five Finger Death Punch');
INSERT INTO inhalt VALUES(6, 1221,2,'Anywhere But Here','Duet mit gast Singer','Five Finger Death Punch');
INSERT INTO inhalt VALUES(7, 1221,2,'Dot Your Eres','Gast Singer','Five Finger Death Punch');





-- 123 ZHANEL Patrick A.
-- Homepage des Interpreten ist nicht bekannt
-- Interpreten deren Namen aus einem Wort besteht
INSERT INTO interpret VALUES ('Lund', NULL);

-- Solisten die nie bei Bands mitwirkten
INSERT INTO solist VALUES ('Lund', '1997-01-01');

-- CDs deren Titel aus einem Wort besteht
INSERT INTO mcd VALUES(1232, 'Gold');

-- Alben deren Titel aus einem Wort besteht
INSERT INTO album VALUES(1232, '2016', 'Lund', NULL);

INSERT INTO disc VALUES(1232, 1);

INSERT INTO genre VALUES('Chill');

INSERT INTO song VALUES ('Fall Away', '', '00:03:49', 'Lund', 'Chill');
INSERT INTO song VALUES ('Gold', '', '00:02:37', 'Lund', 'Chill');
INSERT INTO song VALUES ('MJ', '', '00:03:01', 'Lund', 'Chill');
INSERT INTO song VALUES ('Only For You', '', '00:03:49', 'Lund', 'Chill');
INSERT INTO song VALUES ('Cold Bones', '', '00:03:24', 'Lund', 'Chill');
INSERT INTO song VALUES ('Nature', '', '00:04:08', 'Lund', 'Chill');
INSERT INTO song VALUES ('Chemistry', '', '00:03:33', 'Lund', 'Chill');
INSERT INTO song VALUES ('Savage', '', '00:03:06', 'Lund', 'Chill');
INSERT INTO song VALUES ('Alone', '', '00:04:14', 'Lund', 'Chill');
INSERT INTO song VALUES ('Broken', '', '00:03:20', 'Lund', 'Chill');
INSERT INTO song VALUES ('Rx Luv', '', '00:03:38', 'Lund', 'Chill');
INSERT INTO song VALUES ('Weep', '', '00:03:06', 'Lund', 'Chill');
INSERT INTO song VALUES ('Mirror', '', '00:03:39', 'Lund', 'Chill');
INSERT INTO song VALUES ('All We Do', '', '00:03:43', 'Lund', 'Chill');
INSERT INTO song VALUES ('If I Die', '', '00:03:06', 'Lund', 'Chill');
INSERT INTO song VALUES ('Reality', '', '00:02:19', 'Lund', 'Chill');
INSERT INTO song VALUES ('Trill', '', '00:02:32', 'Lund', 'Chill');

INSERT INTO inhalt VALUES (1, 1232, 1, 'Fall Away', '', 'Lund');
INSERT INTO inhalt VALUES (2, 1232, 1, 'Gold', '', 'Lund');
INSERT INTO inhalt VALUES (3, 1232, 1, 'MJ', '', 'Lund');
INSERT INTO inhalt VALUES (4, 1232, 1, 'Only For You', '', 'Lund');
INSERT INTO inhalt VALUES (5, 1232, 1, 'Cold Bones', '', 'Lund');
INSERT INTO inhalt VALUES (6, 1232, 1, 'Nature', '', 'Lund');
INSERT INTO inhalt VALUES (7, 1232, 1, 'Chemistry', '', 'Lund');
INSERT INTO inhalt VALUES (8, 1232, 1, 'Savage', '', 'Lund');
INSERT INTO inhalt VALUES (9, 1232, 1, 'Alone', '', 'Lund');




-- Statistik
SELECT 'interpret' AS 'Tabelle', count(*) AS 'Datensätze' FROM interpret
UNION
SELECT 'solist' AS 'Tabelle', count(*) AS 'Datensätze' FROM solist
UNION
SELECT 'band' AS 'Tabelle', count(*) AS 'Datensätze' FROM band
UNION
SELECT 'mitgliedschaft' AS 'Tabelle', count(*) AS 'Datensätze' FROM mitgliedschaft
UNION
SELECT 'genre' AS 'Tabelle', count(*) AS 'Datensätze' FROM genre
UNION
SELECT 'song' AS 'Tabelle', count(*) AS 'Datensätze' FROM song
UNION
SELECT 'mcd' AS 'Tabelle', count(*) AS 'Datensätze' FROM mcd
UNION
SELECT 'playlist' AS 'Tabelle', count(*) AS 'Datensätze' FROM playlist
UNION
SELECT 'album' AS 'Tabelle', count(*) AS 'Datensätze' FROM album
UNION
SELECT 'disc' AS 'Tabelle', count(*) AS 'Datensätze' FROM disc
UNION
SELECT 'inhalt' AS 'Tabelle', count(*) AS 'Datensätze' FROM inhalt;