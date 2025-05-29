-- 1. Pacijenti i njihov status (ako postoji)
SELECT CONCAT(p.ime, ' ', p.prezime) AS pacijent, s.opis
FROM PACIJENT p
LEFT JOIN STATUS_PACIJENTA s ON p.id_pacijent = s.id_pacijent
WHERE s.opis IS NOT NULL;

-- 2. Broj uspješnih donacija po krvnoj grupi
SELECT k.krvna_grupa, COUNT(*) AS uspjesne_donacije
FROM ISPUNJENI_ZAHTJEVI_BOLNICA iz
JOIN ZAHTJEV_BOLNICE zb ON iz.id_zahtjev = zb.id_zahtjev
JOIN KRVNE_GRUPE k ON zb.id_krvna_grupa = k.id_krvna_grupa
GROUP BY k.krvna_grupa;

-- 3. Prosječna dob pacijenata po krvnoj grupi
SELECT k.krvna_grupa, ROUND(AVG(YEAR(CURDATE()) - p.godiste)) AS prosjecna_dob
FROM PACIJENT p
JOIN KRVNE_GRUPE k ON p.id_krvna_grupa = k.id_krvna_grupa
GROUP BY k.krvna_grupa
HAVING COUNT(*) > 1;

-- 4. Donatori koji nisu imali nijedan termin
SELECT d.ime, d.prezime
FROM DAVATELJ d
LEFT JOIN TERMINI_DAVATELJ_SPOJENO t ON d.id_davatelj = t.id_davatelj
WHERE t.id_termin_davatelj IS NULL;

-- 5. Zadnji termin svakog pacijenta i tko ga je pregledao
SELECT
  CONCAT(p.ime, ' ', p.prezime) AS pacijent,
  CONCAT(o.ime, ' ', o.prezime) AS osoblje,
  t.vrijeme AS zadnji_termin
FROM PACIJENT p
JOIN TERMINI_PACIJENTI_SPOJENO t
  ON p.id_pacijent = t.id_pacijent
JOIN OSOBLJE o
  ON t.id_osoblje = o.id_osoblje
WHERE t.vrijeme = (
  SELECT MAX(vrijeme)
  FROM TERMINI_PACIJENTI_SPOJENO
  WHERE id_pacijent = p.id_pacijent
);

-- 6. Broj donatora i pacijenata po krvnoj grupi
SELECT
  k.krvna_grupa,
  COALESCE(donatori.count,0)  AS broj_davatelja,
  COALESCE(pacijenata.count,0) AS broj_pacijenata
FROM KRVNE_GRUPE k
LEFT JOIN (
  SELECT id_krvna_grupa, COUNT(*) AS count
  FROM DAVATELJ
  GROUP BY id_krvna_grupa
) donatori ON k.id_krvna_grupa = donatori.id_krvna_grupa
LEFT JOIN (
  SELECT id_krvna_grupa, COUNT(*) AS count
  FROM PACIJENT
  GROUP BY id_krvna_grupa
) pacijenata ON k.id_krvna_grupa = pacijenata.id_krvna_grupa
ORDER BY k.krvna_grupa;