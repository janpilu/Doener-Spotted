DROP DATABASE IF EXISTS doenerspotted;
CREATE DATABASE doenerspotted;
USE doenerspotted;

CREATE TABLE benutzer (
	bname varchar(25),
	vname varchar(25),
	nname varchar(25),
	email varchar(25),
	bplz INTEGER,
	psswrt varchar(25),
	PRIMARY KEY (bname)
) ENGINE = INNODB;

INSERT INTO benutzer VALUES ("a","b", "c", "d", 5, "e");

























































