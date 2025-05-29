
-- 1. Popis svih zahtjeva bolnica s nazivom bolnice, krvnom grupom i imenom davatelja koji je ispunio zahtjev
SELECT b.naziv AS bolnica, kg.krvna_grupa, d.ime AS davatelj_ime, d.prezime AS davatelj_prezime
FROM ISPUNJENI_ZAHTJEVI_BOLNICA iz
JOIN ZAHTJEV_BOLNICE z ON iz.id_zahtjev = z.id_zahtjev
JOIN BOLNICE b ON z.id_bolnica = b.id_bolnice
JOIN KRVNE_GRUPE kg ON z.id_krvna_grupa = kg.id_krvna_grupa
JOIN DAVATELJ d ON iz.id_davatelj = d.id_davatelj;

-- 2. Popis pacijenata s njihovim krvnim grupama i trenutnim medicinskim statusom
SELECT p.ime, p.prezime, kg.krvna_grupa, sp.opis
FROM PACIJENT p
JOIN KRVNE_GRUPE kg ON p.id_krvna_grupa = kg.id_krvna_grupa
JOIN STATUS_PACJENTA sp ON p.id_pacijent = sp.id_pacijent;

-- 3. Popis zakazanih termina davatelja s pripadajućim osobljem i krvnom grupom
SELECT d.ime AS davatelj_ime, d.prezime, td.vrijeme, td.status, o.ime AS osoblje_ime, kg.krvna_grupa
FROM TERMINI_DAVATELJ_SPOJENO td
JOIN DAVATELJ d ON td.id_davatelj = d.id_davatelj
JOIN OSOBLJE o ON td.id_osoblje = o.id_osoblje
JOIN KRVNE_GRUPE kg ON d.id_krvna_grupa = kg.id_krvna_grupa
WHERE td.status = 'Zakazan';

-- 4. Koji davatelji imaju istu krvnu grupu kao neki pacijent
SELECT DISTINCT d.ime AS davatelj_ime, d.prezime AS davatelj_prezime, kg.krvna_grupa
FROM DAVATELJ d
JOIN KRVNE_GRUPE kg ON d.id_krvna_grupa = kg.id_krvna_grupa
WHERE d.id_krvna_grupa IN (
    SELECT DISTINCT id_krvna_grupa FROM PACIJENT
);

-- 5. Broj zahtjeva po bolnici
SELECT b.naziv AS bolnica, COUNT(z.id_zahtjev) AS broj_zahtjeva
FROM BOLNICE b
JOIN ZAHTJEV_BOLNICE z ON b.id_bolnice = z.id_bolnica
GROUP BY b.id_bolnice;

-- 6. Davatelji koji su ispunili zahtjev i njihova krvna grupa
SELECT d.ime, d.prezime, kg.krvna_grupa
FROM DAVATELJ d
JOIN KRVNE_GRUPE kg ON d.id_krvna_grupa = kg.id_krvna_grupa
JOIN ISPUNJENI_ZAHTJEVI_BOLNICA iz ON d.id_davatelj = iz.id_davatelj;
