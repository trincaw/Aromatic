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
	Name varchar(50),
	PRIMARY KEY (Name)
);

CREATE TABLE Company (
	Name varchar(30),
	Name_Country varchar(50),
	Description varchar(200) NOT NULL,
	PRIMARY KEY (Name),
	FOREIGN KEY (Name_Country) REFERENCES Country(Name) ON UPDATE cascade ON DELETE SET NULL
);

CREATE TABLE Industry (
	Name varchar(30),
	PRIMARY KEY (Name)
);

CREATE TABLE Factory (
	Name varchar(30),
	Id int,
	PRIMARY KEY (Id)
);

CREATE TABLE Designer (
	Name varchar(30),
	Website varchar(50),
	Name_Country varchar(30),
	Name_Company varchar(30),
	Name_Industry varchar(30),
	Id_Factory int,
	PRIMARY KEY (Name),
	FOREIGN KEY (Name_Company) REFERENCES Company(Name) ON UPDATE cascade ON DELETE SET NULL,
	FOREIGN KEY (Name_Country) REFERENCES Country(Name) ON UPDATE cascade ON DELETE SET NULL,
	FOREIGN KEY (Name_Industry) REFERENCES Industry(Name) ON UPDATE cascade ON DELETE SET NULL,
	FOREIGN KEY (Id_Factory) REFERENCES Factory(Id) ON UPDATE cascade ON DELETE SET NULL
);

CREATE TABLE Concentration (
	Name varchar(15),
	Min int,
	Max int,
	PRIMARY KEY (Name)
);

CREATE TABLE Perfumer (
	Name varchar(30) NOT NULL,
	CF varchar(16),
	Website varchar(30) NOT NULL,
	PRIMARY KEY (CF)
);

CREATE TABLE Fragrance (
	Collection varchar(30),
	Name varchar(30),
	Year smallint NOT NULL,
	Gender varchar(6) NOT NULL,
	Name_Designer varchar(30),
	Name_Concentration varchar(15),
	CF_Perfumer varchar(30),
	PRIMARY KEY (Name,Name_Designer,Name_Concentration),
	FOREIGN KEY (Name_Concentration) REFERENCES Concentration(Name) ON UPDATE cascade ON DELETE SET NULL,
	FOREIGN KEY (Name_Designer) REFERENCES Designer(Name) ON UPDATE cascade ON DELETE SET NULL,
	FOREIGN KEY (CF_Perfumer) REFERENCES Perfumer(CF) ON UPDATE cascade ON DELETE SET NULL
);

CREATE TABLE OlfactoryGroup (
	Name varchar(30),
	Description varchar(200) NOT NULL,
	PRIMARY KEY (Name)
);

CREATE TABLE Notes (
	Name varchar(30),
	Name_OlfactoryGroup varchar(30),
	PRIMARY KEY (Name),
	FOREIGN KEY (Name_OlfactoryGroup) REFERENCES OlfactoryGroup(Name) ON UPDATE cascade ON DELETE SET NULL
);

CREATE TABLE Top_notes (
	Name_Notes varchar(30),
	Name_Concentration varchar(30),
	Name_Fragrance varchar(30),
	Name_Designer_Fragrance varchar(30),
	PRIMARY KEY (Name_Notes,Name_Concentration,Name_Fragrance,Name_Designer_Fragrance),
	FOREIGN KEY (Name_Notes) REFERENCES Notes(Name) ON UPDATE cascade ON DELETE SET NULL,
	FOREIGN KEY (Name_Concentration,Name_Fragrance,Name_Designer_Fragrance)REFERENCES Fragrance (Concentration,Name,Name_Designer) ON UPDATE cascade ON DELETE SET NULL
);

CREATE TABLE Middle_notes (
	Name_Notes varchar(30),
	Name_Concentration varchar(30),
	Name_Fragrance varchar(30),
	Name_Designer_Fragrance varchar(30),
	PRIMARY KEY (Name_Notes,Name_Concentration,Name_Fragrance,Name_Designer_Fragrance),
	FOREIGN KEY (Name_Notes) REFERENCES Notes(Name) ON UPDATE cascade ON DELETE SET NULL,
	FOREIGN KEY (Name_Concentration,Name_Fragrance,Name_Designer_Fragrance)REFERENCES Fragrance (Concentration,Name,Name_Designer) ON UPDATE cascade ON DELETE SET NULL
);

CREATE TABLE Base_notes (
	Name_Notes varchar(30),
	Name_Concentration varchar(30),
	Name_Fragrance varchar(30),
	Name_Designer_Fragrance varchar(30),
	PRIMARY KEY (Name_Notes,Name_Concentration,Name_Fragrance,Name_Designer_Fragrance),
	FOREIGN KEY (Name_Notes) REFERENCES Notes(Name) ON UPDATE cascade ON DELETE SET NULL,
	FOREIGN KEY (Name_Concentration,Name_Fragrance,Name_Designer_Fragrance)REFERENCES Fragrance (Concentration,Name,Name_Designer) ON UPDATE cascade ON DELETE SET NULL
);