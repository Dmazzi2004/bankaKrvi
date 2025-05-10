CREATE DATABASE BankaKrvi;
USE BankaKrvi;

CREATE TABLE OSOBLJE (
    id_osoblje INT AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(50),
    prezime VARCHAR(50),
    uloga VARCHAR(50)
);
INSERT INTO OSOBLJE (ime, prezime, uloga)
VALUES 
('Ana', 'Anić', 'Liječnik'),
('Marko', 'Marić', 'Medicinska sestra'),
('Iva', 'Ivić', 'Laboratorijski tehničar');

CREATE TABLE KRVNE_GRUPE (
    id_krvna_grupa INT AUTO_INCREMENT PRIMARY KEY,
    krvna_grupa VARCHAR(10)
);
INSERT INTO KRVNE_GRUPE (krvna_grupa)
VALUES
('0+'),
('0-'),
('A+'),
('A-'),
('B+'),
('B-'),
('AB+'),
('AB-');

CREATE TABLE PACIJENT (
    id_pacijent INT AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(50),
    prezime VARCHAR(50),
    godiste YEAR,
    spol ENUM('M', 'Ž'),
    id_krvna_grupa INT,
    FOREIGN KEY (id_krvna_grupa) REFERENCES KRVNE_GRUPE(id_krvna_grupa)
);
INSERT INTO PACIJENT (ime, prezime, godiste, spol, id_krvna_grupa)
VALUES
('Petar', 'Petrović', 1985, 'M', 1),
('Marija', 'Marić', 1990, 'Ž', 3),
('Ivana', 'Ilić', 2002, 'Ž', 5);

CREATE TABLE DAVATELJ (
    id_davatelj INT AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(50),
    prezime VARCHAR(50),
    spol ENUM('M', 'Ž'),
    godiste YEAR,
    id_krvna_grupa INT,
    FOREIGN KEY (id_krvna_grupa) REFERENCES KRVNE_GRUPE(id_krvna_grupa)
);
INSERT INTO DAVATELJ (ime, prezime, spol, godiste, id_krvna_grupa)
VALUES 
('Ivan', 'Ivić', 'M', 1990, 1),
('Ana', 'Anić', 'Ž', 1985, 2),
('Marko', 'Marić', 'M', 1992, 3);

CREATE TABLE TERMINI_DAVATELJ_SPOJENO (
    id_termin_davatelj INT AUTO_INCREMENT PRIMARY KEY,
    id_davatelj INT,
    id_osoblje INT,
    vrijeme DATETIME,
    status ENUM('Zakazan', 'Uspješan', 'Neuspješan', 'Otkazan'),
    FOREIGN KEY (id_davatelj) REFERENCES DAVATELJ(id_davatelj),
    FOREIGN KEY (id_osoblje) REFERENCES OSOBLJE(id_osoblje)
);
INSERT INTO TERMINI_DAVATELJ_SPOJENO (id_davatelj, id_osoblje, vrijeme, status)
VALUES
(1, 1, '2025-05-01 10:00:00', 'Uspješan'),
(2, 2, '2025-05-02 11:30:00', 'Zakazan');

CREATE TABLE TERMINI_PACIJENTI_SPOJENO (
    id_termin_pacijent INT AUTO_INCREMENT PRIMARY KEY,
    id_pacijent INT,
    id_osoblje INT,
    vrijeme DATETIME,
    status ENUM('Zakazan', 'Uspješan', 'Neuspješan', 'Otkazan'),
    FOREIGN KEY (id_pacijent) REFERENCES PACIJENT(id_pacijent),
    FOREIGN KEY (id_osoblje) REFERENCES OSOBLJE(id_osoblje)
);
INSERT INTO TERMINI_PACIJENTI_SPOJENO (id_pacijent, id_osoblje, vrijeme, status)
VALUES
(1, 1, '2025-05-03 09:00:00', 'Zakazan'),
(2, 2, '2025-05-04 14:30:00', 'Uspješan');

CREATE TABLE STATUS_PACJENTA (
    id_pacijent INT,
    id_osoblje INT,
    opis TEXT,
    PRIMARY KEY (id_pacijent, id_osoblje),
    FOREIGN KEY (id_pacijent) REFERENCES PACIJENT(id_pacijent),
    FOREIGN KEY (id_osoblje) REFERENCES OSOBLJE(id_osoblje)
);
INSERT INTO STATUS_PACJENTA (id_pacijent, id_osoblje, opis)
VALUES
(1, 1, 'Stabilno, čeka rezultate nalaza.'),
(2, 1, 'Povećana potreba za transfuzijom.');

CREATE TABLE ZALIHE_KRVNE_GRUPE (
    id_krvna_grupa INT PRIMARY KEY,
    zalihe INT,
    FOREIGN KEY (id_krvna_grupa) REFERENCES KRVNE_GRUPE(id_krvna_grupa)
);
INSERT INTO ZALIHE_KRVNE_GRUPE (id_krvna_grupa, zalihe)
VALUES
(1, 15),
(2, 8),
(3, 12),
(4, 5);

CREATE TABLE BOLNICE (
    id_bolnice INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(100),
    adresa VARCHAR(255)
);
INSERT INTO BOLNICE (naziv, adresa)
VALUES
('KBC Zagreb', 'Kišpatićeva 12, Zagreb'),
('Opća bolnica Split', 'Spinčićeva 1, Split'),
('Opća bolnica Rijeka', 'Krešimirova 42, Rijeka');

CREATE TABLE ZAHTJEV_BOLNICE (
    id_zahtjev INT AUTO_INCREMENT PRIMARY KEY,
    id_bolnica INT,
    id_krvna_grupa INT,
    rok DATE,
    FOREIGN KEY (id_bolnica) REFERENCES BOLNICE(id_bolnice),
    FOREIGN KEY (id_krvna_grupa) REFERENCES KRVNE_GRUPE(id_krvna_grupa)
);
INSERT INTO ZAHTJEV_BOLNICE (id_bolnica, id_krvna_grupa, rok)
VALUES
(1, 1, '2025-05-10'),
(2, 3, '2025-05-08'),
(3, 2, '2025-05-06');

CREATE TABLE ISPUNJENI_ZAHTJEVI_BOLNICA (
    id_zahtjev INT,
    id_davatelj INT,
    PRIMARY KEY (id_zahtjev, id_davatelj),
    FOREIGN KEY (id_zahtjev) REFERENCES ZAHTJEV_BOLNICE(id_zahtjev),
    FOREIGN KEY (id_davatelj) REFERENCES DAVATELJ(id_davatelj)
);
INSERT INTO ISPUNJENI_ZAHTJEVI_BOLNICA (id_zahtjev, id_davatelj)
VALUES
(1, 1),
(2, 2),
(3, 3);