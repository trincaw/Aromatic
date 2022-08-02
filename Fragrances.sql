-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.0.0-alpha1
-- PostgreSQL version: 15.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: public."Fragrance" | type: TABLE --
-- DROP TABLE IF EXISTS public."Fragrance" CASCADE;
CREATE TABLE public."Fragrance" (
	"Name_Designer" varchar(30) NOT NULL,
	"Collection" varchar(30) NOT NULL,
	"Name" varchar(30) NOT NULL,
	"Year" smallint,
	"Gender" varchar(6) NOT NULL,
	"Name_Concentration" varchar(15) NOT NULL,
	"Name_Perfumer" varchar(30) NOT NULL,
	CONSTRAINT "Fragrance_pk" PRIMARY KEY ("Collection","Name","Name_Designer")
);
-- ddl-end --

-- object: public."Concentration" | type: TABLE --
-- DROP TABLE IF EXISTS public."Concentration" CASCADE;
CREATE TABLE public."Concentration" (
	"Name" varchar(15) NOT NULL,
	"Min" decimal(5,2),
	"Max" decimal(5,2),
	CONSTRAINT "Concentration_pk" PRIMARY KEY ("Name")
);
-- ddl-end --

INSERT INTO public."Concentration" ("Name", "Min", "Max") VALUES (E'Eau de Cologne', E'3', E'5');
-- ddl-end --
INSERT INTO public."Concentration" ("Name", "Min", "Max") VALUES (E'Eau de Toilette', E'12', E'15');
-- ddl-end --
INSERT INTO public."Concentration" ("Name", "Min", "Max") VALUES (E'Eau de Parfum', E'15', E'20');
-- ddl-end --
INSERT INTO public."Concentration" ("Name", "Min", "Max") VALUES (E'Perfume Extract ', E'20', E'30');
-- ddl-end --

-- object: public."Designer" | type: TABLE --
-- DROP TABLE IF EXISTS public."Designer" CASCADE;
CREATE TABLE public."Designer" (
	"Name" varchar(30) NOT NULL,
	"Website" varchar(30),
	"Name_Country" varchar(30) NOT NULL,
	"Name_Company" varchar(30) NOT NULL,
	"Name_Industry" varchar(30) NOT NULL,
	"Id_Factory" smallint NOT NULL,
	CONSTRAINT "Designer_pk" PRIMARY KEY ("Name")
);
-- ddl-end --

-- object: public."Company" | type: TABLE --
-- DROP TABLE IF EXISTS public."Company" CASCADE;
CREATE TABLE public."Company" (
	"Name" varchar(30) NOT NULL,
	"Name_Country" varchar(30) NOT NULL,
	CONSTRAINT "Company_pk" PRIMARY KEY ("Name")
);
-- ddl-end --

-- object: public."Country" | type: TABLE --
-- DROP TABLE IF EXISTS public."Country" CASCADE;
CREATE TABLE public."Country" (
	"Name" varchar(30) NOT NULL,
	CONSTRAINT "Country_pk" PRIMARY KEY ("Name")
);
-- ddl-end --

-- object: "Country_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Designer" DROP CONSTRAINT IF EXISTS "Country_fk" CASCADE;
ALTER TABLE public."Designer" ADD CONSTRAINT "Country_fk" FOREIGN KEY ("Name_Country")
REFERENCES public."Country" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Country_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Company" DROP CONSTRAINT IF EXISTS "Country_fk" CASCADE;
ALTER TABLE public."Company" ADD CONSTRAINT "Country_fk" FOREIGN KEY ("Name_Country")
REFERENCES public."Country" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Company_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Designer" DROP CONSTRAINT IF EXISTS "Company_fk" CASCADE;
ALTER TABLE public."Designer" ADD CONSTRAINT "Company_fk" FOREIGN KEY ("Name_Company")
REFERENCES public."Company" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Designer_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Fragrance" DROP CONSTRAINT IF EXISTS "Designer_fk" CASCADE;
ALTER TABLE public."Fragrance" ADD CONSTRAINT "Designer_fk" FOREIGN KEY ("Name_Designer")
REFERENCES public."Designer" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Concentration_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Fragrance" DROP CONSTRAINT IF EXISTS "Concentration_fk" CASCADE;
ALTER TABLE public."Fragrance" ADD CONSTRAINT "Concentration_fk" FOREIGN KEY ("Name_Concentration")
REFERENCES public."Concentration" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Industry" | type: TABLE --
-- DROP TABLE IF EXISTS public."Industry" CASCADE;
CREATE TABLE public."Industry" (
	"Name" varchar(30) NOT NULL,
	CONSTRAINT "Industry_pk" PRIMARY KEY ("Name")
);
-- ddl-end --

-- object: "Industry_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Designer" DROP CONSTRAINT IF EXISTS "Industry_fk" CASCADE;
ALTER TABLE public."Designer" ADD CONSTRAINT "Industry_fk" FOREIGN KEY ("Name_Industry")
REFERENCES public."Industry" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Perfumer" | type: TABLE --
-- DROP TABLE IF EXISTS public."Perfumer" CASCADE;
CREATE TABLE public."Perfumer" (
	"Name" varchar(30) NOT NULL,
	CONSTRAINT "Perfumer_pk" PRIMARY KEY ("Name")
);
-- ddl-end --

-- object: "Perfumer_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Fragrance" DROP CONSTRAINT IF EXISTS "Perfumer_fk" CASCADE;
ALTER TABLE public."Fragrance" ADD CONSTRAINT "Perfumer_fk" FOREIGN KEY ("Name_Perfumer")
REFERENCES public."Perfumer" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.new_table | type: TABLE --
-- DROP TABLE IF EXISTS public.new_table CASCADE;
CREATE TABLE public.new_table (

);
-- ddl-end --
ALTER TABLE public.new_table OWNER TO postgres;
-- ddl-end --

-- object: public."Notes" | type: TABLE --
-- DROP TABLE IF EXISTS public."Notes" CASCADE;
CREATE TABLE public."Notes" (
	"Name" varchar(30) NOT NULL,
	"Name_Group" varchar(30) NOT NULL,
	CONSTRAINT "Top_notes_pk" PRIMARY KEY ("Name")
);
-- ddl-end --

-- object: public."Group" | type: TABLE --
-- DROP TABLE IF EXISTS public."Group" CASCADE;
CREATE TABLE public."Group" (
	"Name" varchar(30) NOT NULL,
	CONSTRAINT "Group_pk" PRIMARY KEY ("Name")
);
-- ddl-end --

-- object: "Group_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Notes" DROP CONSTRAINT IF EXISTS "Group_fk" CASCADE;
ALTER TABLE public."Notes" ADD CONSTRAINT "Group_fk" FOREIGN KEY ("Name_Group")
REFERENCES public."Group" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Top_notes" | type: TABLE --
-- DROP TABLE IF EXISTS public."Top_notes" CASCADE;
CREATE TABLE public."Top_notes" (
	"Name_Notes" varchar(30) NOT NULL,
	"Collection_Fragrance" varchar(30) NOT NULL,
	"Name_Fragrance" varchar(30) NOT NULL,
	"Name_Designer_Fragrance" varchar(30) NOT NULL,
	CONSTRAINT "Top_notes_pk" PRIMARY KEY ("Name_Notes","Collection_Fragrance","Name_Fragrance","Name_Designer_Fragrance")
);
-- ddl-end --

-- object: "Notes_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Top_notes" DROP CONSTRAINT IF EXISTS "Notes_fk" CASCADE;
ALTER TABLE public."Top_notes" ADD CONSTRAINT "Notes_fk" FOREIGN KEY ("Name_Notes")
REFERENCES public."Notes" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Fragrance_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Top_notes" DROP CONSTRAINT IF EXISTS "Fragrance_fk" CASCADE;
ALTER TABLE public."Top_notes" ADD CONSTRAINT "Fragrance_fk" FOREIGN KEY ("Collection_Fragrance","Name_Fragrance","Name_Designer_Fragrance")
REFERENCES public."Fragrance" ("Collection","Name","Name_Designer") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Middle_notes" | type: TABLE --
-- DROP TABLE IF EXISTS public."Middle_notes" CASCADE;
CREATE TABLE public."Middle_notes" (
	"Name_Notes" varchar(30) NOT NULL,
	"Collection_Fragrance" varchar(30) NOT NULL,
	"Name_Fragrance" varchar(30) NOT NULL,
	"Name_Designer_Fragrance" varchar(30) NOT NULL,
	CONSTRAINT "Middle_notes_pk" PRIMARY KEY ("Name_Notes","Collection_Fragrance","Name_Fragrance","Name_Designer_Fragrance")
);
-- ddl-end --

-- object: "Notes_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Middle_notes" DROP CONSTRAINT IF EXISTS "Notes_fk" CASCADE;
ALTER TABLE public."Middle_notes" ADD CONSTRAINT "Notes_fk" FOREIGN KEY ("Name_Notes")
REFERENCES public."Notes" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Fragrance_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Middle_notes" DROP CONSTRAINT IF EXISTS "Fragrance_fk" CASCADE;
ALTER TABLE public."Middle_notes" ADD CONSTRAINT "Fragrance_fk" FOREIGN KEY ("Collection_Fragrance","Name_Fragrance","Name_Designer_Fragrance")
REFERENCES public."Fragrance" ("Collection","Name","Name_Designer") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Base_notes" | type: TABLE --
-- DROP TABLE IF EXISTS public."Base_notes" CASCADE;
CREATE TABLE public."Base_notes" (
	"Name_Notes" varchar(30) NOT NULL,
	"Collection_Fragrance" varchar(30) NOT NULL,
	"Name_Fragrance" varchar(30) NOT NULL,
	"Name_Designer_Fragrance" varchar(30) NOT NULL,
	CONSTRAINT "Base_notes_pk" PRIMARY KEY ("Name_Notes","Collection_Fragrance","Name_Fragrance","Name_Designer_Fragrance")
);
-- ddl-end --

-- object: "Notes_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Base_notes" DROP CONSTRAINT IF EXISTS "Notes_fk" CASCADE;
ALTER TABLE public."Base_notes" ADD CONSTRAINT "Notes_fk" FOREIGN KEY ("Name_Notes")
REFERENCES public."Notes" ("Name") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Fragrance_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Base_notes" DROP CONSTRAINT IF EXISTS "Fragrance_fk" CASCADE;
ALTER TABLE public."Base_notes" ADD CONSTRAINT "Fragrance_fk" FOREIGN KEY ("Collection_Fragrance","Name_Fragrance","Name_Designer_Fragrance")
REFERENCES public."Fragrance" ("Collection","Name","Name_Designer") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Factory" | type: TABLE --
-- DROP TABLE IF EXISTS public."Factory" CASCADE;
CREATE TABLE public."Factory" (
	"Nome" smallint,
	"Id" smallint NOT NULL,
	CONSTRAINT "Factory_pk" PRIMARY KEY ("Id")
);
-- ddl-end --
ALTER TABLE public."Factory" OWNER TO postgres;
-- ddl-end --

-- object: "Factory_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Designer" DROP CONSTRAINT IF EXISTS "Factory_fk" CASCADE;
ALTER TABLE public."Designer" ADD CONSTRAINT "Factory_fk" FOREIGN KEY ("Id_Factory")
REFERENCES public."Factory" ("Id") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


