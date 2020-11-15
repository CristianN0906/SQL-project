
/* CREARE BAZA DE DATE, TABELE SI LEGATURILE DINTRE ACESTEA */

DROP DATABASE IF EXISTS company_db;
CREATE DATABASE IF NOT EXISTS company_db;

USE company_db;

CREATE TABLE departamente(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    denumire VARCHAR(40) NOT NULL
);

CREATE TABLE angajati(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nume VARCHAR(50) NOT NULL,
    prenume VARCHAR(50) NOT NULL,
    varsta INT(3) NOT NULL,
    salariu FLOAT NOT NULL,
    data_angajare DATE NOT NULL,
    id_departament INT NOT NULL,
    CONSTRAINT link_1 FOREIGN KEY(id_departament)
    REFERENCES departamente(id)    
);

CREATE TABLE licente(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    denumire VARCHAR(50) NOT NULL,
    data_expirare DATE NOT NULL,
    id_angajat INT NOT NULL,
    CONSTRAINT link_2 FOREIGN KEY(id_angajat)
    REFERENCES angajati(id) 
);

CREATE TABLE servicii(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    denumire VARCHAR(50) UNIQUE,
    pret FLOAT NOT NULL,
    moneda VARCHAR(10)
    );

CREATE TABLE proiecte(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nume VARCHAR(50),
    cod_proiect VARCHAR(30),
    id_servicii INT NOT NULL,
    CONSTRAINT link_3 FOREIGN KEY(id_servicii)
    REFERENCES servicii(id) 
);

CREATE TABLE angajati_proiecte(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_angajat INT NOT NULL,
    id_proiect INT NOT NULL,
    CONSTRAINT link_4 FOREIGN KEY(id_angajat)
    REFERENCES angajati(id),
    CONSTRAINT link_5 FOREIGN KEY(id_proiect)
    REFERENCES proiecte(id)
);

CREATE TABLE clienti(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nume VARCHAR(30) NOT NULL,
    prenume VARCHAR(30)NOT NULL,
    telefon VARCHAR(20)
);

CREATE TABLE facturi(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    suma FLOAT NOT NULL,
    data_factura DATE NOT NULL,
    serie_factura VARCHAR(20) NOT NULL,
    id_clienti INT NOT NULL,
    CONSTRAINT link_6 FOREIGN KEY(id_clienti)
    REFERENCES clienti(id),
    id_servicii INT NOT NULL,
    CONSTRAINT link_7 FOREIGN KEY(id_servicii)
    REFERENCES servicii(id)
);

CREATE TABLE servicii_clienti(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	id_servicii INT NOT NULL,
    id_clienti INT NOT NULL,
    CONSTRAINT link_8 FOREIGN KEY(id_servicii)
    REFERENCES servicii(id),
    CONSTRAINT link_9 FOREIGN KEY(id_clienti)
    REFERENCES clienti(id)
);

#DROP TABLE facturi;

/* MODIFICAREA STRUCTURII DATELOR */

/* schimbarea numelui tabelului si revenirea la numele intial */
ALTER TABLE servicii RENAME TO services;
ALTER TABLE services RENAME TO servicii;

/* adaugare de campuri suplimentare in tabele si stergerea acestuia */
ALTER TABLE facturi ADD COLUMN numar_factura INT NOT NULL;
SELECT * FROM facturi;
ALTER TABLE facturi DROP COLUMN numar_factura;

/* moificarea tipului de date al unui camp din tabel si revenirea la cel initial */
ALTER TABLE clienti MODIFY telefon TEXT NOT NULL;
ALTER TABLE clienti MODIFY telefon VARCHAR(20);

/* adaugare restrictie UNIQUE */
ALTER TABLE departamente MODIFY denumire VARCHAR(40) NOT NULL UNIQUE;

/* UTILIZAREA INSTRUCTIUNILOR LMD */

START TRANSACTION;

INSERT INTO departamente(denumire) VALUES
('Marketing'),
('Vanzari'),
('IT'),
('HR'),
('Management');

INSERT INTO angajati(nume, prenume, varsta, salariu, data_angajare, id_departament) VALUES
('Popescu', 'Marian', 33, '5000', '2010-03-15', 1),
('Ionescu', 'Cristina', 29, '4500', '2011-05-04', 2),
('Rusu', 'Daniel', 42, '7500', '2009-07-21', 5),
('Necula', 'Cristian', 24, '2800', '2020-08-14', 3),
('Munteanu', 'Roxana', 30, '3800', '2018-10-16', 4),
('Gheorghe', 'Ioana', 42, '5000', '2009-08-29', 4),
('Stoian', 'Andrei', 26, '3200','2019-05-01', 2),
('Olaru', 'Dragos', 44, '5500','2010-02-25', 3),
('Stefan', 'Georgiana', '35',4000, '2015-08-11', 1),
('Matei', 'Valentin', 36, '3800','2014-06-12', 3);

INSERT INTO licente(denumire, data_expirare, id_angajat) VALUES
('Matlab', '2020-09-29', 5),
('Microsoft Office', '2022-01-01', 1),
('Microsoft Office', '2021-09-12', 6),
('Microsoft Office', '2023-03-11', 4),
('Microsoft Office', '2020-10-07', 3),
('.NET', '2021-01-01', 8),
('.NET', '2020-10-08', 10),
('C.R.M', '2022-10-10', 2),
('C.R.M', '2022-10-10', 7);

INSERT INTO servicii VALUES
(1, 'Consultanta', 3000, 'Lei' ),
(2, 'Software development', 5000, 'Lei'),
(3, 'Finance', 4200, 'Lei'),
(4, 'Sales', 3300, 'Lei'),
(5, 'Catering', '150', 'Lei');

INSERT INTO proiecte(nume, cod_proiect, id_servicii) VALUES
('Sales', 'ID001F03', 4),
('Finance', 'ID002F01', 3),
('Software Development', 'ID003SF2', 2),
('Automotive', 'ID004AT2', 2),
('Banking', 'ID005BK1', 1);

INSERT INTO clienti(nume, prenume, telefon) VALUES
('Barloiu', 'Ionut', '0732.112345'),
('Parvu', 'Alma', '0723.234589'),
('Antonescu', 'Maria', '0731.224698'),
('Mihaescu', 'Iulian', '0741.254836'),
('Mihaila', 'Narcisa', '0752.234562'),
('Dumitrescu', 'Anca', '0756.332152'),
('Bucur', 'Bogdan', '0752.325689'),
('Radescu', 'Vicentiu', '0755.234558'),
('Niculae', 'Stefan', '0731.258634'),
('Pavelescu', 'Andreea', '0741.321145');

INSERT INTO facturi
(suma, data_factura, serie_factura, id_clienti, id_servicii) 
VALUES
(3000, '2011-10-02', 'GDF 10810851289', 1, 1),
(5000, '2012-11-12', 'GDF 10812254921', 2, 2),
(4200, '2011-02-09', 'GDF 10810854983', 3, 3),
(3300, '2013-06-17', 'GDF 10810844959', 4, 4),
(5000, '2017-08-11', 'GDF 10810854979', 5, 4),
(3300, '2019-07-04', 'GDF 10810854983', 6, 4),
(4200, '2020-10-02', 'GDF 10810855529', 7, 3),
(8300, '2018-05-18', 'GDF 10810854782', 8, 2),
(7500, '2016-07-14', 'GDF 10220854987', 9, 1),
(8000, '2019-04-22', 'GDF 10811854222', 10, 1),
(9200, '2020-01-08', 'GDF 10811454089', 2, 2),
(10000, '2012-10-02', 'GDF 10822854900', 4, 3),
(3300, '2015-05-12', 'GDF 10310854359', 6, 2),
(3000, '2014-10-06', 'GDF 10408549842', 8, 4),
(5000, '2019-04-14', 'GDF 10845854339', 10, 1);

/* IMPLEMENTARE DE INSTRUCTIUNI DE MODIFICARE (UPDATE) */

SELECT * FROM angajati;

UPDATE angajati SET salariu = salariu * 1.2
WHERE id IN(2,6,10);

SELECT * FROM clienti;

UPDATE clienti SET nume = UPPER(nume) ;

SELECT * FROM servicii;

UPDATE servicii SET
denumire = 'Consulting'
WHERE denumire = 'Consultanta';

/* IMPLEMENTARE DE INSTRUCTIUNI DE STERGERE (DELETE) */

SELECT * FROM facturi;

DELETE FROM facturi WHERE YEAR(data_factura) <= 2013; 

SELECT * FROM servicii;

DELETE FROM servicii
WHERE denumire = 'Catering';

COMMIT;
ROLLBACK;

/* INTEROGARI SIMPLE */

/* a. Sa se afiseze angajatii cu data de agajare mai veche de 2015-01-01*/

SELECT CONCAT(UPPER(nume), ' ', prenume) AS nume_angajat, data_angajare FROM angajati
WHERE data_angajare<'2015-01-01'
ORDER BY data_angajare ASC;

/* b. Sa se afiseze numarul total de facturi dintre anii 2018 si 2020 care au suma mai mare de 5000 lei */

SELECT COUNT(*) AS numar_facturi FROM facturi
WHERE suma > 5000 AND YEAR(data_factura) BETWEEN 2018 AND 2020;

/* c. Sa se afiseze angajatii in functie de vechime */

SELECT 
	CONCAT(UPPER(nume), ' ', prenume) AS nume_angajat,
    IF(
		YEAR(data_angajare) < 2014,
        'Angajat cu vechime mare de 6 ani',
			IF(
				YEAR(data_angajare) < 2018,
                'Angjat cu vechime intre 2 si 6 ani',
                'Angajat cu vechime mai mica de 2 ani'
                )
		) AS vechime
FROM angajati
ORDER BY YEAR(data_angajare) DESC;
        
/* d. Sa se afiseze numarul de facturi pentru fiecare an */    

SELECT 
	COUNT(*) AS numar_facturi,
    YEAR(data_factura) AS an
FROM facturi
GROUP BY YEAR(data_factura)
ORDER BY an ASC;

/* INTEROGARI COMPELXE */

/* a. Sa se afiseze numarul de angajati si salariul mediu din fiecare departament */

SELECT
    d.denumire AS departament,
	ROUND(AVG(salariu),2) AS salariu_mediu,
    COUNT(*) AS numar_angajati_dep
FROM 
angajati AS a JOIN departamente as d ON a.id_departament = d.id
GROUP BY d.denumire
ORDER BY numar_angajati_dep ASC, salariu_mediu DESC;

/* b. Sa se afiseze departamentele in care licentele angajatilor au expirat */

SELECT 
    CONCAT(UPPER(a.nume), ' ', a.prenume) AS nume_angajat,
	d.denumire AS departament,
    l.denumire AS licenta_soft,
    l.data_expirare
FROM 
departamente AS d
JOIN angajati AS a ON d.id = a.id_departament
JOIN licente AS l ON a.id = l.id_angajat
WHERE l.data_expirare < current_date()
ORDER BY nume_angajat ASC;

/* c. Sa se afisezee numarul de comenzi al fiecarui client */

SELECT 
	COUNT(id_clienti) AS nr_comenzi,
    c.nume,
    c.prenume
FROM 
facturi AS f 
JOIN clienti AS c ON f.id_clienti = c.id
JOIN servicii AS s ON s.id = f.id_servicii
GROUP BY id_clienti;

/* SUBINTEROGARI */

/* Sa se afiseze angajatii cu salariul peste medie */

SELECT * FROM angajati WHERE salariu > (
	SELECT AVG(salariu) FROM angajati);
    
/* Sa se clientii care au cel putin 2 comenzi de Software Development*/

SELECT 
	CONCAT(UPPER(nume), ' ', prenume) AS `client`
FROM clienti 
WHERE id IN (SELECT id_clienti FROM facturi
WHERE id_servicii =(SELECT id FROM servicii
WHERE denumire = 'Software Development')
GROUP BY id_clienti HAVING COUNT(*) >= 2);

/* ## VIEW-uri ## */

/*  Sa se afiseze toti angajatii cu varsta mai mare de 38 ani*/

CREATE VIEW ang_M38 AS

SELECT nume, prenume, varsta, salariu, data_angajare FROM angajati
WHERE varsta > 38;

DROP VIEW ang_M38;

