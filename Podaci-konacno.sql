-- 1. OSOBLJE
INSERT INTO OSOBLJE (ime, prezime, uloga) VALUES
('Ana', 'Anić', 'Liječnik'),
('Marko', 'Marić', 'Medicinska sestra'),
('Iva', 'Ivić', 'Laboratorijski tehničar'),
('Petra', 'Kovač', 'Medicinska sestra'),
('Luka', 'Novak', 'Liječnik'),
('Maja', 'Horvat', 'Laboratorijski tehničar'),
('Tomislav', 'Bartolić', 'Liječnik'),
('Ivana', 'Grgić', 'Medicinska sestra'),
('Karlo', 'Vidović', 'Administrator'),
('Zoran', 'Škaro', 'Liječnik'),
('Marijana', 'Lukić', 'Medicinska sestra'),
('Dina', 'Mirković', 'Laboratorijski tehničar'),
('Goran', 'Živković', 'Liječnik'),
('Petra', 'Barić', 'Administrator'),
('Vedran', 'Knežević', 'Medicinska sestra'),
('Renata', 'Jurić', 'Liječnik'),
('Tomica', 'Čović', 'Laboratorijski tehničar'),
('Adriana', 'Vrban', 'Administrator');

-- 2. KRVNE_GRUPE
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

-- 3. PACIJENT
INSERT INTO PACIJENT (ime, prezime, godiste, spol, id_krvna_grupa) VALUES
('Petar', 'Petrović', 1985, 'M', 1),
('Marija', 'Marić', 1990, 'Ž', 3),
('Ivana', 'Ilić', 2002, 'Ž', 5),
('Nikola', 'Kralj', 1975, 'M', 2),
('Ana', 'Pokorny', 1980, 'Ž', 4),
('Ivica', 'Šarić', 1968, 'M', 6),
('Sandra', 'Perković', 1995, 'Ž', 7),
('Milan', 'Babić', 2000, 'M', 8),
('Katarina', 'Zorić', 2010, 'Ž', 3),
('Leo', 'Blašković', 1972, 'M', 1),
('Marina', 'Grubišić', 1987, 'Ž', 2),
('Viktor', 'Šegvić', 1993, 'M', 4),
('Kristina', 'Buljubašić', 1965, 'Ž', 6),
('Tomislav', 'Ćorić', 1978, 'M', 5),
('Barbara', 'Vidmar', 1999, 'Ž', 7),
('Ivan', 'Raić', 2001, 'M', 8),
('Lucija', 'Gričar', 1982, 'Ž', 1),
('Dino', 'Poljak', 1994, 'M', 3);

-- 4. DAVATELJ
INSERT INTO DAVATELJ (ime, prezime, spol, godiste, id_krvna_grupa) VALUES
('Ivan', 'Ivić', 'M', 1990, 1),
('Ana', 'Anić', 'Ž', 1985, 2),
('Marko', 'Marić', 'M', 1992, 3),
('Marina', 'Perić', 'Ž', 1988, 4),
('Nenad', 'Blažević', 'M', 1979, 5),
('Lucija', 'Radić', 'Ž', 1994, 7),
('Dario', 'Knežević', 'M', 1965, 8),
('Petra', 'Jurilj', 'Ž', 1992, 2),
('Filip', 'Matić', 'M', 1983, 6),
('Sandra', 'Kolarić', 'Ž', 1981, 1),
('Kristijan', 'Jelen', 'M', 1974, 2),
('Ema', 'Rukavina', 'Ž', 1997, 3),
('Damir', 'Pavić', 'M', 1969, 5),
('Mirna', 'Brkić', 'Ž', 1990, 7),
('Matej', 'Dragić', 'M', 1985, 8),
('Sara', 'Vidaković', 'Ž', 1989, 4),
('Robert', 'Flego', 'M', 1991, 6),
('Nikolina', 'Sertić', 'Ž', 1977, 1);

-- 5. TERMINI_DAVATELJ_SPOJENO
INSERT INTO TERMINI_DAVATELJ_SPOJENO (id_davatelj, id_osoblje, vrijeme, status) VALUES
(1, 1, '2025-05-01 10:00:00', 'Uspješan'),
(2, 2, '2025-05-02 11:30:00', 'Zakazan'),
(4, 4, '2025-05-03 15:00:00', 'Uspješan'),
(5, 5, '2025-05-05 08:30:00', 'Neuspješan'),
(1, 6, '2025-05-06 13:00:00', 'Zakazan'),
(7, 7, '2025-05-07 16:45:00', 'Otkazan'),
(9, 8, '2025-05-08 10:15:00', 'Uspješan'),
(9, 9, '2025-05-09 09:00:00', 'Zakazan'),
(10, 10, '2025-05-10 11:00:00', 'Zakazan'),
(2, 11, '2025-05-11 12:30:00', 'Uspješan'),
(12, 12, '2025-05-12 14:00:00', 'Neuspješan'),
(13, 13, '2025-05-13 09:15:00', 'Uspješan'),
(14, 14, '2025-05-14 10:45:00', 'Zakazan'),
(14, 15, '2025-05-15 11:30:00', 'Otkazan'),
(16, 16, '2025-05-16 13:00:00', 'Uspješan'),
(13, 17, '2025-05-17 15:30:00', 'Zakazan');

-- 6. TERMINI_PACIJENTI_SPOJENO
INSERT INTO TERMINI_PACIJENTI_SPOJENO (id_pacijent, id_osoblje, vrijeme, status) VALUES
(1, 1, '2025-05-03 09:00:00', 'Zakazan'),
(2, 2, '2025-05-04 14:30:00', 'Uspješan'),
(4, 4, '2025-05-05 10:00:00', 'Zakazan'),
(5, 5, '2025-05-06 11:00:00', 'Uspješan'),
(6, 6, '2025-05-07 12:00:00', 'Neuspješan'),
(7, 7, '2025-05-08 13:00:00', 'Zakazan'),
(8, 8, '2025-05-09 14:00:00', 'Otkazan'),
(9, 9, '2025-05-10 15:00:00', 'Zakazan'),
(10, 10, '2025-05-11 09:30:00', 'Zakazan'),
(11, 11, '2025-05-12 10:45:00', 'Uspješan'),
(12, 12, '2025-05-13 12:15:00', 'Neuspješan'),
(13, 13, '2025-05-14 13:30:00', 'Zakazan'),
(14, 14, '2025-05-15 14:00:00', 'Uspješan'),
(15, 15, '2025-05-16 11:15:00', 'Otkazan'),
(16, 16, '2025-05-17 12:45:00', 'Zakazan'),
(17, 17, '2025-05-18 15:00:00', 'Zakazan');

-- 7. STATUS_PACIJENTA
INSERT INTO STATUS_PACIJENTA (id_pacijent, id_osoblje, opis) VALUES
(1, 1, 'Stabilno, čeka rezultate nalaza.'),
(2, 1, 'Povećana potreba za transfuzijom.'),
(3, 1, 'Potrebna daljnja ispitivanja.'),
(4, 2, 'Dobro se oporavlja.'),
(5, 3, 'Povišena temperatura, prati stanje.'),
(6, 4, 'U stabilnom stanju, pušten na oporavak.'),
(7, 5, 'Ciljana terapija zakazana.'),
(8, 6, 'Praćenje krvne slike.'),
(9, 7, 'Kontrola za tjedan dana.'),
(10, 8, 'Reakcija na lijekove.'),
(11, 9, 'Hitna potreba za dodatnom dijagnostikom.'),
(12, 10, 'Oporavak ide po planu.'),
(13, 11, 'Bol se pogoršala, prilagoditi terapiju.'),
(14, 12, 'Krvna slika uredna.'),
(15, 13, 'Potrebna transfuzija.'),
(16, 14, 'Praćenje otkucaja srca.');

-- 8. ZALIHE_KRVNE_GRUPE
INSERT INTO ZALIHE_KRVNE_GRUPE (id_krvna_grupa, zalihe) VALUES
(1, 15),
(2, 8),
(3, 12),
(4, 5),
(5, 20),
(6, 7),
(7, 3),
(8, 2);


-- 9. BOLNICE
INSERT INTO BOLNICE (naziv, adresa) VALUES
('KBC Zagreb', 'Kišpatićeva 12, Zagreb'),
('Opća bolnica Split', 'Spinčićeva 1, Split'),
('Opća bolnica Rijeka', 'Krešimirova 42, Rijeka'),
('KBC Split', 'Spinčićeva 1, Split'),
('Opća bolnica Osijek', 'Europska avenija 13, Osijek'),
('Opća bolnica Varaždin', 'Zagrebačka 16, Varaždin'),
('KBC Rijeka', 'Krešimirova 42, Rijeka'),
('Specijalna bolnica Sv. Katarina', 'Zrinjska 73, Zabok'),
('Dom zdravlja Zagreb-Maksimir', 'Špansko ul. 45, Zagreb'),
('Klinika Magdalena', 'Ilica 234, Zagreb'),
('Opća bolnica Dubrovnik', 'Stari grad 12, Dubrovnik'),
('KBC Osijek', 'J.J. Strossmayera 341a, Osijek'),
('Specijalna bolnica za ortopediju', 'Kralja Zvonimira 1, Zagreb'),
('Dom zdravlja Split-Dračevac', 'Dračevac 45, Split'),
('KBC Sestre milosrdnice', 'Ilica 83, Zagreb'),
('Opća bolnica Karlovac', 'Vukovarska 58, Karlovac'),
('KBC Merkur', 'Zagorska 2, Zagreb'),
('Specijalna pedijatrijska klinika', 'Petrova 13, Zagreb');

-- 10. ZAHTJEV_BOLNICE
INSERT INTO ZAHTJEV_BOLNICE (id_bolnica, id_krvna_grupa, rok) VALUES
(1, 1, '2025-05-10'),
(2, 3, '2025-05-08'),
(2, 2, '2025-05-06'),
(5, 5, '2025-05-12'),
(5, 6, '2025-05-15'),
(12, 7, '2025-05-18'),
(11, 8, '2025-05-20'),
(8, 1, '2025-05-22'),
(9, 3, '2025-05-25'),
(10, 4, '2025-05-11'),
(11, 2, '2025-05-13'),
(17, 5, '2025-05-14'),
(13, 6, '2025-05-16'),
(15, 7, '2025-05-17'),
(15, 8, '2025-05-19'),
(16, 1, '2025-05-21'),
(17, 3, '2025-05-23'),
(18, 4, '2025-05-24');

-- 11. ISPUNJENI_ZAHTJEVI_BOLNICA
INSERT INTO ISPUNJENI_ZAHTJEVI_BOLNICA (id_zahtjev, id_davatelj) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18);
