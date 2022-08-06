DROP TABLE IF EXISTS Fragrance CASCADE;
DROP TABLE IF EXISTS Concentration CASCADE;
DROP TABLE IF EXISTS Designer CASCADE;
DROP TABLE IF EXISTS Company CASCADE;
DROP TABLE IF EXISTS Specialization CASCADE;
DROP TABLE IF EXISTS Perfumer CASCADE;
DROP TABLE IF EXISTS Notes CASCADE;
DROP TABLE IF EXISTS OlfactoryGroup CASCADE;
DROP TABLE IF EXISTS Factory CASCADE;
DROP TABLE IF EXISTS Address CASCADE;
DROP TABLE IF EXISTS Reviewer CASCADE;
DROP TABLE IF EXISTS Review CASCADE;
DROP TABLE IF EXISTS many_Perfumer_has_many_Fragrance CASCADE;
DROP TABLE IF EXISTS many_Designer_has_many_Fragrance CASCADE;
DROP TABLE IF EXISTS many_Designer_has_many_Specialization CASCADE;
DROP TABLE IF EXISTS Top CASCADE;
DROP TABLE IF EXISTS Mid CASCADE;
DROP TABLE IF EXISTS Base CASCADE;

CREATE TABLE Concentration (
	Name varchar(15) NOT NULL,
	Min decimal(5,2),
	Max decimal(5,2),
	PRIMARY KEY (Name)
);

CREATE TABLE Company (
	Name varchar(30) NOT NULL,
	Descrizione varchar,
	PRIMARY KEY (Name)
);

CREATE TABLE Fragrance (
	Name varchar(30) NOT NULL,
	Year smallint NOT NULL,
	Collection varchar(30) NOT NULL,
	Gender varchar(6) NOT NULL,
	Name_Concentration varchar(15),
	PRIMARY KEY (Name,Year),
	FOREIGN KEY (Name_Concentration) REFERENCES Concentration (Name) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Designer (
	Name varchar(30) NOT NULL,
	Website varchar(30),
	Name_Company varchar(30),
	PRIMARY KEY (Name),
	FOREIGN KEY (Name_Company) REFERENCES Company (Name) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Factory (
	Id smallint NOT NULL,
	Name smallint,
	Name_Company varchar(30),
	PRIMARY KEY (Id),
	FOREIGN KEY (Name_Company) REFERENCES Company (Name) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Specialization (
	Name varchar(30) NOT NULL,
	Description varchar(100),
	PRIMARY KEY (Name)
);

CREATE TABLE Address (
	Street varchar(50) NOT NULL,
	Nr smallint NOT NULL,
	Cap smallint NOT NULL,
	Country varchar(50) NOT NULL,
	ID integer NOT NULL,
	Id_Factory smallint,
	Name_Designer varchar(30),
	Name_Company varchar(30),
	PRIMARY KEY (ID),
	FOREIGN KEY (Id_Factory) REFERENCES Factory (Id) ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY (Name_Designer) REFERENCES Designer (Name) ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY (Name_Company) REFERENCES Company (Name)  ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Perfumer (
	CF varchar(30) NOT NULL,
	Name varchar(30),
	Surname varchar(30) NOT NULL,
	Web varchar(30),
	ID_Address integer,
	PRIMARY KEY (CF),
	FOREIGN KEY (ID_Address)REFERENCES Address (ID) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE OlfactoryGroup (
	Name varchar(30) NOT NULL,
	Description varchar(100),
	PRIMARY KEY (Name)
);

CREATE TABLE Notes (
	Name varchar(30) NOT NULL,
	Name_OlfactoryGroup varchar(30),
	PRIMARY KEY (Name),
	FOREIGN KEY (Name_OlfactoryGroup) REFERENCES OlfactoryGroup (Name) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Reviewer (
	Cf varchar(16) NOT NULL,
	Name varchar(30) NOT NULL,
	Surname varchar(30) NOT NULL,
	Registration_year smallint NOT NULL,
	Stars smallint NOT NULL,
	ID_Address integer,
	PRIMARY KEY (Cf),
	FOREIGN KEY (ID_Address) REFERENCES Address (ID) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Review (
	ID smallint NOT NULL,
	Stars smallint NOT NULL,
	Text varchar(200) NOT NULL,
	Cf_Reviewer varchar(16),
	Name_Fragrance varchar(30),
	Year_Fragrance smallint,
	PRIMARY KEY (ID),
	FOREIGN KEY (Name_Fragrance,Year_Fragrance) REFERENCES Fragrance (Name,Year)ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY (Cf_Reviewer) REFERENCES Reviewer (Cf) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE many_Perfumer_has_many_Fragrance (
	CF_Perfumer varchar(30) NOT NULL,
	Name_Fragrance varchar(30) NOT NULL,
	Year_Fragrance smallint NOT NULL,
	PRIMARY KEY (CF_Perfumer,Name_Fragrance,Year_Fragrance),
	FOREIGN KEY (CF_Perfumer) REFERENCES Perfumer (CF) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (Name_Fragrance,Year_Fragrance) REFERENCES Fragrance (Name,Year)ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE many_Designer_has_many_Fragrance (
	Name_Designer varchar(30) NOT NULL,
	Name_Fragrance varchar(30) NOT NULL,
	Year_Fragrance smallint NOT NULL,
	PRIMARY KEY (Name_Designer,Name_Fragrance,Year_Fragrance),
	FOREIGN KEY (Name_Designer) REFERENCES Designer (Name)ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (Name_Fragrance,Year_Fragrance) REFERENCES Fragrance (Name,Year)ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE many_Designer_has_many_Specialization (
	Name_Designer varchar(30) NOT NULL,
	Name_Specialization varchar(30) NOT NULL,
	PRIMARY KEY (Name_Designer,Name_Specialization),
	FOREIGN KEY (Name_Designer) REFERENCES Designer (Name)ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (Name_Specialization)REFERENCES Specialization (Name)ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Top (
	Name_Fragrance varchar(30) NOT NULL,
	Year_Fragrance smallint NOT NULL,
	Name_Notes varchar(30) NOT NULL,
	PRIMARY KEY (Name_Fragrance,Year_Fragrance,Name_Notes),
	FOREIGN KEY (Name_Fragrance,Year_Fragrance) REFERENCES Fragrance (Name,Year) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (Name_Notes) REFERENCES Notes (Name) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Mid (
	Name_Fragrance varchar(30) NOT NULL,
	Year_Fragrance smallint NOT NULL,
	Name_Notes varchar(30) NOT NULL,
	PRIMARY KEY (Name_Fragrance,Year_Fragrance,Name_Notes),
	FOREIGN KEY (Name_Fragrance,Year_Fragrance) REFERENCES Fragrance (Name,Year) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (Name_Notes) REFERENCES Notes (Name) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Base (
	Name_Fragrance varchar(30) NOT NULL,
	Year_Fragrance smallint NOT NULL,
	Name_Notes varchar(30) NOT NULL,
	PRIMARY KEY (Name_Fragrance,Year_Fragrance,Name_Notes),
	FOREIGN KEY (Name_Fragrance,Year_Fragrance) REFERENCES Fragrance (Name,Year) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (Name_Notes) REFERENCES Notes (Name) ON DELETE RESTRICT ON UPDATE CASCADE
);


