DROP TABLE IF EXISTS "Fragrance" CASCADE;
DROP TABLE IF EXISTS "Concentration" CASCADE;
DROP TABLE IF EXISTS "Designer" CASCADE;
DROP TABLE IF EXISTS "Company" CASCADE;
DROP TABLE IF EXISTS "Specialization" CASCADE;
DROP TABLE IF EXISTS "Perfumer" CASCADE;
DROP TABLE IF EXISTS "Notes" CASCADE;
DROP TABLE IF EXISTS "Group" CASCADE;
DROP TABLE IF EXISTS "Factory" CASCADE;
DROP TABLE IF EXISTS "Address" CASCADE;
DROP TABLE IF EXISTS "Reviewer" CASCADE;
DROP TABLE IF EXISTS "Review" CASCADE;
DROP TABLE IF EXISTS "many_Perfumer_has_many_Fragrance" CASCADE;
DROP TABLE IF EXISTS "many_Designer_has_many_Fragrance" CASCADE;
DROP TABLE IF EXISTS "many_Designer_has_many_Specialization" CASCADE;
DROP TABLE IF EXISTS "Top" CASCADE;
DROP TABLE IF EXISTS "Mid" CASCADE;
DROP TABLE IF EXISTS "Base" CASCADE;

CREATE TABLE "Fragrance" (
	"Name" varchar(30) NOT NULL,
	"Year" smallint NOT NULL,
	"Collection" varchar(30) NOT NULL,
	"Gender" varchar(6) NOT NULL,
	"Name_Concentration" varchar(15),
	CONSTRAINT "Fragrance_pk" PRIMARY KEY ("Name","Year")
);
CREATE TABLE "Concentration" (
	"Name" varchar(15) NOT NULL,
	"Min" decimal(5,2),
	"Max" decimal(5,2),
	CONSTRAINT "Concentration_pk" PRIMARY KEY ("Name")
);

INSERT INTO "Concentration" ("Name", "Min", "Max") VALUES (E'Eau de Cologne', E'3', E'5');
-- ddl-end --
INSERT INTO "Concentration" ("Name", "Min", "Max") VALUES (E'Eau de Toilette', E'12', E'15');
-- ddl-end --
INSERT INTO "Concentration" ("Name", "Min", "Max") VALUES (E'Eau de Parfum', E'15', E'20');
-- ddl-end --
INSERT INTO "Concentration" ("Name", "Min", "Max") VALUES (E'Perfume Extract ', E'20', E'30');

CREATE TABLE "Designer" (
	"Name" varchar(30) NOT NULL,
	"Website" varchar(30),
	"Name_Company" varchar(30),
	CONSTRAINT "Designer_pk" PRIMARY KEY ("Name")
);

INSERT INTO "Designer" ("Name", "Website", "Name_Company") VALUES (E'Versace', E'v.com', E'itlay');

CREATE TABLE "Company" (
	"Name" varchar(30) NOT NULL,
	"Descrizione" varchar,
	CONSTRAINT "Company_pk" PRIMARY KEY ("Name")
);

INSERT INTO "Company" ("Name", "Descrizione") VALUES (E'Euritalia', E'Italy');

CREATE TABLE "Specialization" (
	"Name" varchar(30) NOT NULL,
	"Description" varchar(100),
	CONSTRAINT "Industry_pk" PRIMARY KEY ("Name")
);
INSERT INTO "Specialization" ("Name") VALUES (E'Fashion');

CREATE TABLE "Perfumer" (
	"CF" varchar(30) NOT NULL,
	"Name" varchar(30),
	"Surname" varchar(30) NOT NULL,
	"Web" varchar(30),
	"ID_Address" integer,
	CONSTRAINT "Perfumer_pk" PRIMARY KEY ("CF")
);
INSERT INTO "Perfumer" ("Name") VALUES (E'Adison rato');

CREATE TABLE "Notes" (
	"Name" varchar(30) NOT NULL,
	"Name_Group" varchar(30),
	CONSTRAINT "Top_notes_pk" PRIMARY KEY ("Name")
);
INSERT INTO "Notes" ("Name", "Name_Group") VALUES (E'Albero di limone', E'Agrumi');

CREATE TABLE "Group" (
	"Name" varchar(30) NOT NULL,
	"Description" varchar(100),
	CONSTRAINT "Group_pk" PRIMARY KEY ("Name")
);
INSERT INTO "Group" ("Name") VALUES (E'Agrumi');

CREATE TABLE "Factory" (
	"Id" smallint NOT NULL,
	"Name" smallint,
	"Name_Company" varchar(30),
	CONSTRAINT "Factory_pk" PRIMARY KEY ("Id")
);

CREATE TABLE "Address" (
	"Street" varchar(50) NOT NULL,
	"Nr" smallint NOT NULL,
	"Cap" smallint NOT NULL,
	"Country" varchar(50) NOT NULL,
	"ID" integer NOT NULL,
	"Id_Factory" smallint,
	"Name_Designer" varchar(30),
	"Name_Company" varchar(30),
	CONSTRAINT "Address_pk" PRIMARY KEY ("ID")
);

CREATE TABLE "Reviewer" (
	"Cf" varchar(16) NOT NULL,
	"Name" varchar(30) NOT NULL,
	"Surname" varchar(30) NOT NULL,
	"Registration_year" smallint NOT NULL,
	"Stars" smallint NOT NULL,
	"ID_Address" integer,
	CONSTRAINT "Reviewer_pk" PRIMARY KEY ("Cf")
);

CREATE TABLE "Review" (
	"ID" smallint NOT NULL,
	"Stars" smallint NOT NULL,
	"Text" varchar(200) NOT NULL,
	"Cf_Reviewer" varchar(16),
	"Name_Fragrance" varchar(30),
	"Year_Fragrance" smallint,
	CONSTRAINT "Review_pk" PRIMARY KEY ("ID")
);

ALTER TABLE "Address" ADD CONSTRAINT "Factory_fk" FOREIGN KEY ("Id_Factory") REFERENCES "Factory" ("Id") MATCH FULL ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "Address" ADD CONSTRAINT "Address_uq" UNIQUE ("Id_Factory");
ALTER TABLE "Address" ADD CONSTRAINT "Designer_fk" FOREIGN KEY ("Name_Designer") REFERENCES "Designer" ("Name") MATCH FULL ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "Address" ADD CONSTRAINT "Address_uq1" UNIQUE ("Name_Designer");
ALTER TABLE "Address" ADD CONSTRAINT "Company_fk" FOREIGN KEY ("Name_Company") REFERENCES "Company" ("Name") MATCH FULL ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "Address" ADD CONSTRAINT "Address_uq2" UNIQUE ("Name_Company");

CREATE TABLE "many_Perfumer_has_many_Fragrance" (
	"CF_Perfumer" varchar(30) NOT NULL,
	"Name_Fragrance" varchar(30) NOT NULL,
	"Year_Fragrance" smallint NOT NULL,
	CONSTRAINT "many_Perfumer_has_many_Fragrance_pk" PRIMARY KEY ("CF_Perfumer","Name_Fragrance","Year_Fragrance")
);
ALTER TABLE "many_Perfumer_has_many_Fragrance" ADD CONSTRAINT "Perfumer_fk" FOREIGN KEY ("CF_Perfumer")
REFERENCES "Perfumer" ("CF") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "many_Perfumer_has_many_Fragrance" ADD CONSTRAINT "Fragrance_fk" FOREIGN KEY ("Name_Fragrance","Year_Fragrance")
REFERENCES "Fragrance" ("Name","Year") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE "many_Designer_has_many_Fragrance" (
	"Name_Designer" varchar(30) NOT NULL,
	"Name_Fragrance" varchar(30) NOT NULL,
	"Year_Fragrance" smallint NOT NULL,
	CONSTRAINT "many_Designer_has_many_Fragrance_pk" PRIMARY KEY ("Name_Designer","Name_Fragrance","Year_Fragrance")
);

ALTER TABLE "many_Designer_has_many_Fragrance" ADD CONSTRAINT "Designer_fk" FOREIGN KEY ("Name_Designer")
REFERENCES "Designer" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "many_Designer_has_many_Fragrance" ADD CONSTRAINT "Fragrance_fk" FOREIGN KEY ("Name_Fragrance","Year_Fragrance")
REFERENCES "Fragrance" ("Name","Year") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE "many_Designer_has_many_Specialization" (
	"Name_Designer" varchar(30) NOT NULL,
	"Name_Specialization" varchar(30) NOT NULL,
	CONSTRAINT "many_Designer_has_many_Specialization_pk" PRIMARY KEY ("Name_Designer","Name_Specialization")
);

ALTER TABLE "many_Designer_has_many_Specialization" ADD CONSTRAINT "Designer_fk" FOREIGN KEY ("Name_Designer")
REFERENCES "Designer" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "many_Designer_has_many_Specialization" ADD CONSTRAINT "Specialization_fk" FOREIGN KEY ("Name_Specialization")
REFERENCES "Specialization" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "Factory" ADD CONSTRAINT "Company_fk" FOREIGN KEY ("Name_Company")
REFERENCES "Company" ("Name") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "Reviewer" ADD CONSTRAINT "Address_fk" FOREIGN KEY ("ID_Address")
REFERENCES "Address" ("ID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "Perfumer" ADD CONSTRAINT "Address_fk" FOREIGN KEY ("ID_Address")
REFERENCES "Address" ("ID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "Review" ADD CONSTRAINT "Reviewer_fk" FOREIGN KEY ("Cf_Reviewer")
REFERENCES "Reviewer" ("Cf") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "Review" ADD CONSTRAINT "Fragrance_fk" FOREIGN KEY ("Name_Fragrance","Year_Fragrance")
REFERENCES "Fragrance" ("Name","Year") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "Designer" ADD CONSTRAINT "Company_fk" FOREIGN KEY ("Name_Company")
REFERENCES "Company" ("Name") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

CREATE TABLE "Top" (
	"Name_Fragrance" varchar(30) NOT NULL,
	"Year_Fragrance" smallint NOT NULL,
	"Name_Notes" varchar(30) NOT NULL,
	CONSTRAINT "Top_pk" PRIMARY KEY ("Name_Fragrance","Year_Fragrance","Name_Notes")
);

ALTER TABLE "Top" ADD CONSTRAINT "Fragrance_fk" FOREIGN KEY ("Name_Fragrance","Year_Fragrance")
REFERENCES "Fragrance" ("Name","Year") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "Top" ADD CONSTRAINT "Notes_fk" FOREIGN KEY ("Name_Notes")
REFERENCES "Notes" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE "Mid" (
	"Name_Fragrance" varchar(30) NOT NULL,
	"Year_Fragrance" smallint NOT NULL,
	"Name_Notes" varchar(30) NOT NULL,
	CONSTRAINT "Mid_pk" PRIMARY KEY ("Name_Fragrance","Year_Fragrance","Name_Notes")
);

ALTER TABLE "Mid" ADD CONSTRAINT "Fragrance_fk" FOREIGN KEY ("Name_Fragrance","Year_Fragrance")
REFERENCES "Fragrance" ("Name","Year") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "Mid" ADD CONSTRAINT "Notes_fk" FOREIGN KEY ("Name_Notes")
REFERENCES "Notes" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE "Base" (
	"Name_Fragrance" varchar(30) NOT NULL,
	"Year_Fragrance" smallint NOT NULL,
	"Name_Notes" varchar(30) NOT NULL,
	CONSTRAINT "Base_pk" PRIMARY KEY ("Name_Fragrance","Year_Fragrance","Name_Notes")
);

ALTER TABLE "Base" ADD CONSTRAINT "Fragrance_fk" FOREIGN KEY ("Name_Fragrance","Year_Fragrance")
REFERENCES "Fragrance" ("Name","Year") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "Base" ADD CONSTRAINT "Notes_fk" FOREIGN KEY ("Name_Notes")
REFERENCES "Notes" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "Notes" ADD CONSTRAINT "Group_fk" FOREIGN KEY ("Name_Group")
REFERENCES "Group" ("Name") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "Fragrance" ADD CONSTRAINT "Concentration_fk" FOREIGN KEY ("Name_Concentration")
REFERENCES "Concentration" ("Name") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;



