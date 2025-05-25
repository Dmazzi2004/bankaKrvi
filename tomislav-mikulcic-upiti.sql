-- 1. Prikaz svih davatelja i datuma zadnjeg puta darivanja krvi
SELECT d.ime, d.prezime, MAX(ptd.datum) AS zadnje_darivanje
FROM PROSLI_TERMIN_DAVATELJ ptd
JOIN DAVATELJ d ON ptd.id_davatelj = d.id_davatelj
GROUP BY d.id_davatelj, d.ime, d.prezime;

-- 2. Krvne grupe čije su zalihe prazne
SELECT k.krvna_grupa, z.zalihe
FROM ZALIHE_KRVNE_GRUPE AS z
JOIN KRVNE_GRUPE AS k ON z.id_krvna_grupa = k.id_krvna_grupa
WHERE z.zalihe = 0;

-- 3. Zahtjevi bolnica koji još nisu ispunjeni
SELECT z.id_zahtjev, b.naziv, k.krvna_grupa, z.rok
FROM ZAHTJEV_BOLNICE AS z
JOIN BOLNICE AS b ON z.id_bolnica = b.id_bolnice
JOIN KRVNE_GRUPE AS k ON z.id_krvna_grupa = k.id_krvna_grupa
WHERE z.id_zahtjev NOT IN (
	SELECT id_zahtjev 
  FROM ISPUNJENI_ZAHTJEVI_BOLNICA
);

-- 4. Broj uspješnih i neuspješnih donacija po davatelju
SELECT d.ime, d.prezime,SUM(p.uspjeh = 'T') AS uspjesne_donacije,SUM(p.uspjeh = 'F') AS neuspjesne_donacije
FROM DAVATELJ AS d
LEFT JOIN PROSLI_TERMIN_DAVATELJ AS p ON d.id_davatelj = p.id_davatelj
GROUP BY d.id_davatelj;

-- 5. Broj termina za darivanje krvi po danima, sortirano uzlazno
SELECT DATE(vrijeme) AS dan, COUNT(*) AS broj_termina
FROM TERMINI_DAVATELJ
GROUP BY dan
ORDER BY dan ASC;

-- 6. Davatelji koji su već donirali i imaju novi termin
SELECT DISTINCT d.ime, d.prezime, td.vrijeme
FROM DAVATELJ AS d
JOIN PROSLI_TERMIN_DAVATELJ AS pt ON d.id_davatelj = pt.id_davatelj
JOIN TERMINI_DAVATELJ AS td ON td.id_davatelj = d.id_davatelj
WHERE pt.uspjeh = 'T';

-- 7. Sve krvne grupe i njihove zalihe, sortirano po najvećim zalihama
SELECT kg.krvna_grupa, zk.zalihe
FROM ZALIHE_KRVNE_GRUPE zk
JOIN KRVNE_GRUPE kg ON zk.id_krvna_grupa = kg.id_krvna_grupa
ORDER BY zk.zalihe DESC;

-- 8. Bolnice koje imaju više od jednog zahtjeva za krv
SELECT b.naziv, COUNT(zb.id_zahtjev) AS broj_zahtjeva
FROM ZAHTJEV_BOLNICE zb
JOIN BOLNICE b ON zb.id_bolnica = b.id_bolnice
GROUP BY b.id_bolnice, b.naziv
HAVING COUNT(zb.id_zahtjev) > 1;