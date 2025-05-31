-- 1. Pacijenti i njihov status (ako postoji)

Ovaj upit dohvaća sve pacijente koji imaju upisan barem jedan status u tablici STATUS_PACIJENTA. Korišten je LEFT JOIN kako bi se uz svakog pacijenta prikazao njegov status, ali i da bi se zadržali pacijenti bez statusa (kojima bi s.opis bio NULL). Funkcija CONCAT spaja ime i prezime pacijenta u jedan tekstualni niz, koji se prikazuje pod nazivom "pacijent". WHERE s.opis IS NOT NULL filtrira rezultat tako da se u ispis uključe samo oni pacijenti koji imaju definiran status. Time se izbacuju svi pacijenti bez statusa, iako su u početku bili uključeni LEFT JOIN-om.

SELECT CONCAT(p.ime, ' ', p.prezime) AS pacijent, s.opis
FROM PACIJENT p
LEFT JOIN STATUS_PACIJENTA s ON p.id_pacijent = s.id_pacijent
WHERE s.opis IS NOT NULL;

-- 2. Broj uspješnih donacija po krvnoj grupi

Ovaj upit prikazuje ukupan broj uspješno ispunjenih zahtjeva bolnica za svaku krvnu grupu. Tablica ISPUNJENI_ZAHTJEVI_BOLNICA sadrži informacije o ispunjenim zahtjevima. Ti zahtjevi su povezani s originalnim zahtjevima u tablici ZAHTJEV_BOLNICE putem stupca id_zahtjev. Zatim se ti zahtjevi povezuju s tablicom KRVNE_GRUPE preko id_krvna_grupa. Nakon toga, koristi se GROUP BY kako bi se rezultati grupirali po svakoj krvnoj grupi, i COUNT(*) da bi se prebrojalo koliko puta je za svaku grupu zahtjev uspješno ispunjen.

SELECT k.krvna_grupa, COUNT(*) AS uspjesne_donacije
FROM ISPUNJENI_ZAHTJEVI_BOLNICA iz
JOIN ZAHTJEV_BOLNICE zb ON iz.id_zahtjev = zb.id_zahtjev
JOIN KRVNE_GRUPE k ON zb.id_krvna_grupa = k.id_krvna_grupa
GROUP BY k.krvna_grupa;

-- 3. Prosječna dob pacijenata po krvnoj grupi

Ovaj upit računa prosječnu dob pacijenata unutar svake krvne grupe. Dob pacijenta se računa kao razlika između trenutne godine i godine rođenja (YEAR(CURDATE()) - p.godiste). Rezultat se zatim grupira po krvnoj grupi koristeći GROUP BY, a AVG funkcija računa aritmetičku sredinu. ROUND se koristi kako bi se rezultat zaokružio na cijeli broj. Na kraju, HAVING COUNT(*) > 1 osigurava da se prikažu samo one krvne grupe koje imaju više od jednog pacijenta.

SELECT k.krvna_grupa, ROUND(AVG(YEAR(CURDATE()) - p.godiste)) AS prosjecna_dob
FROM PACIJENT p
JOIN KRVNE_GRUPE k ON p.id_krvna_grupa = k.id_krvna_grupa
GROUP BY k.krvna_grupa
HAVING COUNT(*) > 1;

-- 4. Donatori koji nisu imali nijedan termin

Ovaj upit dohvaća sve donatore iz tablice DAVATELJ koji nisu imali nijedan evidentiran termin u tablici TERMINI_DAVATELJ_SPOJENO. LEFT JOIN omogućuje da se svi donatori uključe u rezultat, bez obzira imaju li termin ili ne. Ako ne postoji povezan zapis u tablici termina, tada će vrijednosti iz TERMINI_DAVATELJ_SPOJENO biti NULL. WHERE t.id_termin_davatelj IS NULL filtrira one koji nemaju nijedan termin i time prikazuje samo donatore koji nikad nisu sudjelovali u darivanju krvi.

SELECT d.ime, d.prezime
FROM DAVATELJ d
LEFT JOIN TERMINI_DAVATELJ_SPOJENO t ON d.id_davatelj = t.id_davatelj
WHERE t.id_termin_davatelj IS NULL;

-- 5. Zadnji termin svakog pacijenta i tko ga je pregledao

Ovaj upit prikazuje najnoviji (zadnji) termin za svakog pacijenta te ime osoblja koje ga je tada pregledalo. Spajaju se tri tablice: PACIJENT, TERMINI_PACIJENTI_SPOJENO i OSOBLJE. JOIN naredbama se povezuje pacijent s terminima i termin s osobljem koje ga je pregledalo. WHERE uvjet koristi podupit koji pronalazi maksimalno (najveće) vrijeme termina za svakog pacijenta, pomoću SELECT MAX(vrijeme). Tako se filtrira samo onaj red koji sadrži zadnji termin. CONCAT funkcija se koristi za spajanje imena i prezimena pacijenta i osoblja u jedan tekstualni prikaz.

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

Ovaj upit prikazuje broj donatora i pacijenata po krvnoj grupi. Krenulo se iz tablice KRVNE_GRUPE i napravljen je LEFT JOIN s dva podupita: jedan koji broji donatore po krvnoj grupi, a drugi koji broji pacijente. U oba slučaja se koristi COUNT(*) i GROUP BY kako bi se dobio broj za svaku krvnu grupu. Funkcija COALESCE osigurava da, ako neka krvna grupa nema nijednog donatora ili pacijenta, umjesto NULL vrijednosti prikaže se nula. Na kraju, rezultat se sortira po krvnoj grupi.

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