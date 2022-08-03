/* CREAZIONE TABELLE */

DROP TABLE IF EXISTS Fragrance CASCADE;
DROP TABLE IF EXISTS Concentration CASCADE;
DROP TABLE IF EXISTS Designer CASCADE;
DROP TABLE IF EXISTS Company CASCADE;
DROP TABLE IF EXISTS Country CASCADE;
DROP TABLE IF EXISTS Industry CASCADE;
DROP TABLE IF EXISTS Perfumer CASCADE;
DROP TABLE IF EXISTS MainGroup CASCADE;
DROP TABLE IF EXISTS Notes CASCADE;
DROP TABLE IF EXISTS Top_notes CASCADE;
DROP TABLE IF EXISTS Middle_notes CASCADE;
DROP TABLE IF EXISTS Base_notes CASCADE;
DROP TABLE IF EXISTS Factory CASCADE;

CREATE TABLE Country (
	Name varchar(30) NOT NULL,
	PRIMARY KEY (Name)
);

CREATE TABLE Company (
	Name varchar(30) NOT NULL,
	Name_Country varchar(30) NOT NULL,
	PRIMARY KEY (Name),
	FOREIGN KEY (Name_Country) REFERENCES Country(Name) ON UPDATE cascade ON DELETE SET NULL
);

CREATE TABLE Industry (
	Name varchar(30) NOT NULL,
	PRIMARY KEY (Name)
);

CREATE TABLE Factory (
	Nome smallint,
	Id smallint NOT NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE Designer (
	Name varchar(30) NOT NULL,
	Website varchar(30),
	Name_Country varchar(30) NOT NULL,
	Name_Company varchar(30) NOT NULL,
	Name_Industry varchar(30) NOT NULL,
	Id_Factory smallint NOT NULL,
	PRIMARY KEY (Name),
	FOREIGN KEY (Name_Company) REFERENCES Company(Name) ON UPDATE cascade ON DELETE SET NULL,
	FOREIGN KEY (Name_Country) REFERENCES Country(Name) ON UPDATE cascade ON DELETE SET NULL,
	FOREIGN KEY (Name_Industry) REFERENCES Industry(Name) ON UPDATE cascade ON DELETE SET NULL,
	FOREIGN KEY (Id_Factory) REFERENCES Factory(Id) ON UPDATE cascade ON DELETE SET NULL
);

CREATE TABLE Concentration (
	Name varchar(15) NOT NULL,
	Min decimal(5,2),
	Max decimal(5,2),
	PRIMARY KEY (Name)
);

CREATE TABLE Perfumer (
	Name varchar(30) NOT NULL,
	PRIMARY KEY (Name)
);

CREATE TABLE Fragrance (
	Collection varchar(30) NOT NULL,
	Name varchar(30) NOT NULL,
	Year smallint,
	Gender varchar(6) NOT NULL,
	Name_Designer varchar(30) NOT NULL,
	Name_Concentration varchar(15) NOT NULL,
	Name_Perfumer varchar(30) NOT NULL,
	PRIMARY KEY (Collection,Name,Name_Designer),
	FOREIGN KEY (Name_Concentration) REFERENCES Concentration(Name) ON UPDATE cascade ON DELETE SET NULL,
	FOREIGN KEY (Name_Designer) REFERENCES Designer(Name) ON UPDATE cascade ON DELETE SET NULL,
	FOREIGN KEY (Name_Perfumer) REFERENCES Perfumer(Name) ON UPDATE cascade ON DELETE SET NULL
);

CREATE TABLE MainGroup (
	Name varchar(30) NOT NULL,
	PRIMARY KEY (Name)
);

CREATE TABLE Notes (
	Name varchar(30) NOT NULL,
	Name_MainGroup varchar(30) NOT NULL,
	PRIMARY KEY (Name),
	FOREIGN KEY (Name_MainGroup) REFERENCES MainGroup(Name) ON UPDATE cascade ON DELETE SET NULL
);

CREATE TABLE Top_notes (
	Name_Notes varchar(30) NOT NULL,
	Collection_Fragrance varchar(30) NOT NULL,
	Name_Fragrance varchar(30) NOT NULL,
	Name_Designer_Fragrance varchar(30) NOT NULL,
	PRIMARY KEY (Name_Notes,Collection_Fragrance,Name_Fragrance,Name_Designer_Fragrance),
	FOREIGN KEY (Name_Notes) REFERENCES Notes(Name) ON UPDATE cascade ON DELETE SET NULL,
	FOREIGN KEY (Collection_Fragrance,Name_Fragrance,Name_Designer_Fragrance)REFERENCES Fragrance (Collection,Name,Name_Designer) ON UPDATE cascade ON DELETE SET NULL
);

CREATE TABLE Middle_notes (
	Name_Notes varchar(30) NOT NULL,
	Collection_Fragrance varchar(30) NOT NULL,
	Name_Fragrance varchar(30) NOT NULL,
	Name_Designer_Fragrance varchar(30) NOT NULL,
	PRIMARY KEY (Name_Notes,Collection_Fragrance,Name_Fragrance,Name_Designer_Fragrance),
	FOREIGN KEY (Name_Notes) REFERENCES Notes(Name) ON UPDATE cascade ON DELETE SET NULL,
	FOREIGN KEY (Collection_Fragrance,Name_Fragrance,Name_Designer_Fragrance)REFERENCES Fragrance (Collection,Name,Name_Designer) ON UPDATE cascade ON DELETE SET NULL
);

CREATE TABLE Base_notes (
	Name_Notes varchar(30) NOT NULL,
	Collection_Fragrance varchar(30) NOT NULL,
	Name_Fragrance varchar(30) NOT NULL,
	Name_Designer_Fragrance varchar(30) NOT NULL,
	PRIMARY KEY (Name_Notes,Collection_Fragrance,Name_Fragrance,Name_Designer_Fragrance),
	FOREIGN KEY (Name_Notes) REFERENCES Notes(Name) ON UPDATE cascade ON DELETE SET NULL,
	FOREIGN KEY (Collection_Fragrance,Name_Fragrance,Name_Designer_Fragrance)REFERENCES Fragrance (Collection,Name,Name_Designer) ON UPDATE cascade ON DELETE SET NULL
);

/* POPOLAZIONE */