CREATE DATABASE IF NOT EXISTS BankaKrvi;
USE BankaKrvi;

CREATE TABLE OSOBLJE (
    id_osoblje INT AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(50),
    prezime VARCHAR(50),
    uloga VARCHAR(50)
);

CREATE TABLE KRVNE_GRUPE (
    id_krvna_grupa INT AUTO_INCREMENT PRIMARY KEY,
    krvna_grupa VARCHAR(10)
);

CREATE TABLE PACIJENT (
    id_pacijent INT AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(50),
    prezime VARCHAR(50),
    godiste YEAR,
    spol ENUM('M', 'Ž'),
    id_krvna_grupa INT,
    FOREIGN KEY (id_krvna_grupa) REFERENCES KRVNE_GRUPE(id_krvna_grupa)
);

CREATE TABLE DAVATELJ (
    id_davatelj INT AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(50),
    prezime VARCHAR(50),
    spol ENUM('M', 'Ž'),
    godiste YEAR,
    id_krvna_grupa INT,
    FOREIGN KEY (id_krvna_grupa) REFERENCES KRVNE_GRUPE(id_krvna_grupa)
);

CREATE TABLE TERMINI_DAVATELJ_SPOJENO (
    id_termin_davatelj INT AUTO_INCREMENT PRIMARY KEY,
    id_davatelj INT,
    id_osoblje INT,
    vrijeme DATETIME,
    status ENUM('Zakazan', 'Uspješan', 'Neuspješan', 'Otkazan'),
    FOREIGN KEY (id_davatelj) REFERENCES DAVATELJ(id_davatelj),
    FOREIGN KEY (id_osoblje) REFERENCES OSOBLJE(id_osoblje)
);

CREATE TABLE TERMINI_PACIJENTI_SPOJENO (
    id_termin_pacijent INT AUTO_INCREMENT PRIMARY KEY,
    id_pacijent INT,
    id_osoblje INT,
    vrijeme DATETIME,
    status ENUM('Zakazan', 'Uspješan', 'Neuspješan', 'Otkazan'),
    FOREIGN KEY (id_pacijent) REFERENCES PACIJENT(id_pacijent),
    FOREIGN KEY (id_osoblje) REFERENCES OSOBLJE(id_osoblje)
);

CREATE TABLE STATUS_PACIJENTA (
    id_pacijent INT,
    id_osoblje INT,
    opis TEXT,
    PRIMARY KEY (id_pacijent, id_osoblje),
    FOREIGN KEY (id_pacijent) REFERENCES PACIJENT(id_pacijent),
    FOREIGN KEY (id_osoblje) REFERENCES OSOBLJE(id_osoblje)
);

CREATE TABLE ZALIHE_KRVNE_GRUPE (
    id_krvna_grupa INT PRIMARY KEY,
    zalihe INT,
    FOREIGN KEY (id_krvna_grupa) REFERENCES KRVNE_GRUPE(id_krvna_grupa)
);

CREATE TABLE BOLNICE (
    id_bolnice INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(100),
    adresa VARCHAR(255)
);

CREATE TABLE ZAHTJEV_BOLNICE (
    id_zahtjev INT AUTO_INCREMENT PRIMARY KEY,
    id_bolnica INT,
    id_krvna_grupa INT,
    rok DATE,
    FOREIGN KEY (id_bolnica) REFERENCES BOLNICE(id_bolnice),
    FOREIGN KEY (id_krvna_grupa) REFERENCES KRVNE_GRUPE(id_krvna_grupa)
);

CREATE TABLE ISPUNJENI_ZAHTJEVI_BOLNICA (
    id_zahtjev INT,
    id_davatelj INT,
    PRIMARY KEY (id_zahtjev, id_davatelj),
    FOREIGN KEY (id_zahtjev) REFERENCES ZAHTJEV_BOLNICE(id_zahtjev),
    FOREIGN KEY (id_davatelj) REFERENCES DAVATELJ(id_davatelj)
);