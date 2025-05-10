USE BankaKrvi;

-- 1. Bolnice koje traže krvne grupe čije su zalihe ispod 10 jedinica
/* Problem koji rješava: Upozorava na bolnice koje su zatražile krvne grupe s nedovoljno
zaliha - može se koristiti za planiranje hitnog darivanja. */
SELECT b.naziv AS bolnica,
	kg.krvna_grupa,
    zk.zalihe
	FROM ZAHTJEV_BOLNICE zb
	INNER JOIN ZALIHE_KRVNE_GRUPE zk ON zb.id_krvna_grupa = zk.id_krvna_grupa
	INNER JOIN BOLNICE b ON zb.id_bolnica = b.id_bolnice
	INNER JOIN KRVNE_GRUPE kg ON zb.id_krvna_grupa = kg.id_krvna_grupa
    WHERE zk.zalihe < 10;

-- 2. Davatelji koji su imali barem jedan uspješan termin
/* Problem koji rješava: Pronalazi davatelje koji su već uspješno darivali 
- moguće ih kontaktirati za ponovnu donaciju. */
SELECT DISTINCT d.ime, d.prezime
	FROM DAVATELJ d
	INNER JOIN TERMINI_DAVATELJ_SPOJENO tds ON d.id_davatelj = tds.id_davatelj
	WHERE tds.status = 'Uspješan';

-- 3. Popis termina pacijenata koji nisu bili uspješni
/* Problem koji rješava: Omogućava uvid u neuspješne preglede ili zahvate,
potencijalno za analizu razloga. */
SELECT p.ime, p.prezime, tp.vrijeme, tp.status
	FROM TERMINI_PACIJENTI_SPOJENO tp
	INNER JOIN PACIJENT p ON tp.id_pacijent = p.id_pacijent
	WHERE tp.status = 'Neuspješan';
    
-- 4. Ukupan broj zahtjeva po krvnoj grupi, sortirano po broju zahtjeva
/* Problem koji rješava: Pomaže vidjeti koja krvna grupa je najtraženija */
SELECT kg.krvna_grupa, COUNT(*) AS broj_zahtjeva
	FROM ZAHTJEV_BOLNICE zb
	INNER JOIN KRVNE_GRUPE kg ON zb.id_krvna_grupa = kg.id_krvna_grupa
	GROUP BY kg.krvna_grupa
	ORDER BY broj_zahtjeva DESC;
    
-- 5. Pacijenti čiji je status zabilježen od strane liječnika (osoblje uloga = 'Liječnik')
/* Problem koji rješava: Filtrira zapise koje je potpisao liječnik 
- korisno za izdvajanje službenih medicinskih statusa. */
SELECT p.ime, p.prezime, s.opis, o.ime AS osoblje_ime, o.prezime AS osoblje_prezime
	FROM STATUS_PACJENTA s
	INNER JOIN PACIJENT p ON s.id_pacijent = p.id_pacijent
    INNER JOIN OSOBLJE o ON s.id_osoblje = o.id_osoblje
	WHERE o.uloga = 'Liječnik';
    
-- 6. Koliko darivanja je imao svaki darivatelj, bez obzira na status
/* Problem koji rješava: Daje pregled ukupnog angažmana svakog davatelja 
- korisno za statistiku i motivaciju. */
SELECT d.ime, d.prezime, COUNT(tds.id_termin_davatelj) AS broj_termina
	FROM DAVATELJ d
    LEFT JOIN TERMINI_DAVATELJ_SPOJENO tds ON d.id_davatelj = tds.id_davatelj
	GROUP BY d.id_davatelj;