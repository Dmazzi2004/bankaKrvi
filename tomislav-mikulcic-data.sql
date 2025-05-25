-- Krvne grupe
INSERT INTO KRVNE_GRUPE (krvna_grupa) VALUES 
('A+'), ('A-'), ('B+'), ('B-'), ('AB+'), ('AB-'), ('O+'), ('O-');

-- Osoblje
INSERT INTO OSOBLJE (ime, prezime, uloga) VALUES 
('Marko', 'Horvat', 'Liječnik'),
('Ivana', 'Novak', 'Medicinska sestra'),
('Dario', 'Milić', 'Liječnik'),
('Katarina', 'Božić', 'Medicinska sestra'),
('Tomislav', 'Radić', 'Laborant');

-- Pacijenti
INSERT INTO PACIJENT (ime, prezime, godiste, spol, id_krvna_grupa) VALUES 
('Ana', 'Marić', 1990, 'Ž', 1),
('Ivan', 'Kovač', 1985, 'M', 8),
('Maja', 'Šimić', 1978, 'Ž', 2),
('Goran', 'Tomić', 2000, 'M', 3),
('Tina', 'Lončar', 1993, 'Ž', 4),
('Hrvoje', 'Petrić', 1982, 'M', 5),
('Sara', 'Jurčević', 1999, 'Ž', 6),
('Filip', 'Grgić', 1970, 'M', 7);

-- Davatelji
INSERT INTO DAVATELJ (ime, prezime, spol, godiste, id_krvna_grupa) VALUES 
('Luka', 'Barišić', 'M', 1992, 1),
('Petra', 'Jurić', 'Ž', 1995, 1),
('Nikola', 'Perić', 'M', 1988, 8),
('Ivana', 'Pranjić', 'Ž', 1990, 2),
('Ante', 'Klarić', 'M', 1991, 3),
('Jelena', 'Radoš', 'Ž', 1987, 4),
('Mario', 'Begović', 'M', 1995, 5),
('Martina', 'Zubčić', 'Ž', 1998, 6),
('Zoran', 'Lovrić', 'M', 1975, 7);

-- Termini davatelja
INSERT INTO TERMINI_DAVATELJ (id_davatelj, id_osoblje, vrijeme) VALUES 
(1, 1, '2025-05-05 09:00:00'),
(2, 2, '2025-05-06 10:00:00'),
(4, 3, '2025-05-09 08:00:00'),
(5, 1, '2025-05-10 09:30:00'),
(6, 2, '2025-05-11 10:00:00'),
(7, 3, '2025-05-12 11:00:00');

-- Prošli termini davatelja
INSERT INTO PROSLI_TERMIN_DAVATELJ (id_davatelj, datum, uspjeh) VALUES 
(1, '2025-04-01 09:00:00', 'T'),
(3, '2025-04-02 11:00:00', 'F'),
(4, '2025-03-15 08:30:00', 'T'),
(5, '2025-04-05 09:30:00', 'F'),
(6, '2025-04-10 10:00:00', 'T'),
(7, '2025-04-15 11:15:00', 'T'),
(8, '2025-04-20 12:00:00', 'F'),
(9, '2025-04-22 12:30:00', 'T');

-- Termini pacijenata
INSERT INTO TERMINI_PACIJENTI (id_pacijent, id_osoblje, datum) VALUES 
(1, 1, '2025-05-07 10:00:00'),
(2, 2, '2025-05-08 11:00:00'),
(3, 3, '2025-05-09 09:00:00'),
(4, 1, '2025-05-10 10:00:00'),
(5, 2, '2025-05-11 11:00:00'),
(6, 1, '2025-05-12 08:30:00'),
(7, 3, '2025-05-13 09:30:00');

-- Status pacijenata
INSERT INTO STATUS_PACIJENTA (id_pacijent, id_osoblje, opis) VALUES 
(1, 1, 'Potrebna krv A+ zbog operacije.'),
(2, 2, 'Stabilno stanje, ali treba dodatni nadzor.'),
(3, 3, 'Pacijentkinja stabilna, ali potrebna krv B+.'),
(4, 1, 'Nizak hemoglobin, preporuka za transfuziju.'),
(5, 2, 'Oporavak dobar, bez potrebe za dodatnom krvi.'),
(6, 1, 'Čeka hitnu operaciju – treba AB+.'),
(7, 3, 'Pacijent se prati, krvna grupa O- pri kraju.');

-- Zalihe krvne grupe
INSERT INTO ZALIHE_KRVNE_GRUPE (id_krvna_grupa, zalihe) VALUES 
(1, 3), (2, 2), (3, 1), (4, 0), (5, 3), (6, 2), (7, 1), (8, 1);

-- Bolnice
INSERT INTO BOLNICE (naziv, adresa) VALUES 
('KBC Zagreb', 'Kišpatićeva 12'), 
('Opća bolnica Split', 'Zrinsko-Frankopanska 8'),
('Opća bolnica Varaždin', 'Ivana Meštrovića 1'),
('OB Dubrovnik', 'Dr. Roka Mišetića 2');

-- Zahtjevi bolnica
INSERT INTO ZAHTJEV_BOLNICE (id_bolnica, id_krvna_grupa, rok) VALUES 
(1, 1, '2025-05-10'), 
(2, 8, '2025-05-09'),
(3, 2, '2025-05-12'),
(4, 4, '2025-05-13'),
(1, 6, '2025-05-14');

-- Ispunjeni zahtjevi
INSERT INTO ISPUNJENI_ZAHTJEVI_BOLNICA (id_zahtjev, id_davatelj) VALUES 
(1, 1),
(2, 3),
(3, 4),
(4, 6);