INSERT INTO ASIAKAS (Etunimi, Sukunimi, Katuosoite, Postitoimipaikka, Postinumero) VALUES
    ('Lasse', 'Lainaaja', 'Lainaamokatu 33', 'Helsinki', '00100'),
    ('Heikki', 'Heijari', 'Kellarikuja 77', 'Veteli', '69700'),
    ('Hermanni', 'Hiiri', 'Hiiritie 9', 'Helsinki', '00920');

INSERT INTO SIJAINTI (Osasto, Hyllykko, Hylly) VALUES
    (1, 1, 1),
    (1, 1, 2),
    (1, 1, 3),
    (1, 1, 4),
    (1, 2, 1),
    (2, 1, 1);

INSERT INTO NIMIKETYYPPI (Nimi) VALUES
    ('Kirja'),
    ('Elokuva'),
    ('Musiikki');

INSERT INTO NIMIKE (NimiketyyppiID, Nimi) VALUES
    (1, 'Kaapon muistelmat'),
    (1, 'Säästöpossu'),
    (1, 'Monivitamiini-hivenainetabletti ja 10 muuta suosikkitarinaa'),
    (2, 'Pelottava elokuva'),
    (2, 'Pelottavampi elokuva'),
    (3, 'DISCO PRINCE');

INSERT INTO KUVAILUTIETOTYYPPI (KuvailutietoTyyppiID, Nimi) VALUES
    ('PUBL', 'Kustantaja'),
    ('YEAR', 'Julkaisuvuosi'),
    ('ARTI', 'Esittäjä'),
    ('AUTH', 'Kirjoittaja'),
    ('DIRE', 'Ohjaaja');

INSERT INTO KUULUVAT_KUVAILUTIETOTYYPIT (NimiketyyppiID, KuvailutietoTyyppiID, Pakollinen) VALUES
    (1, 'YEAR', TRUE),
    (1, 'PUBL', FALSE),
    (1, 'AUTH', TRUE),
    (2, 'YEAR', TRUE),
    (2, 'DIRE', TRUE),
    (3, 'YEAR', TRUE),
    (3, 'ARTI', TRUE);

INSERT INTO KUVAILUTIETO (NimikeID, KuvailutietoTyyppiID, Tieto) VALUES
    (1, 'YEAR', '1992'),
    (1, 'PUBL', 'Petterin kustantamo'),
    (1, 'AUTH', 'Petteri Peijonen'),
    (1, 'AUTH', 'Vessapaperimies'),
    (2, 'YEAR', '1939'),
    (2, 'AUTH', 'Keijo Suuri'),
    (3, 'YEAR', '1999'),
    (3, 'AUTH', 'Rainbow'),
    (4, 'YEAR', '1924'),
    (4, 'DIRE', 'Hurja Ohjaaja'),
    (5, 'YEAR', '1925'),
    (5, 'DIRE', 'Hurja Ohjaaja'),
    (6, 'YEAR', '2005'),
    (6, 'ARTI', 'Katamari Damacy');

INSERT INTO KOHDE (NimikeID, SijaintiID, Hankittu, Hankintahinta, LainaAika) VALUES
    (1, 1, CURRENT_DATE, NULL, 30),
    (1, 2, CURRENT_DATE - 10, NULL, 30),
    (1, 2, CURRENT_DATE - 30, NULL, 0),
    (2, 3, '1992-01-01', 30.00, 3),
    (3, 2, '2000-03-02', NULL, 30),
    (4, 1, NULL, NULL, 20),
    (5, 2, NULL, NULL, 10),
    (6, 3, NULL, NULL, 1);

INSERT INTO LAINA (AsiakasID, KohdeID, Lainattu, Palautettava, Palautettu) VALUES
    (1, 2, CURRENT_DATE, CURRENT_DATE + 10, NULL),
    (2, 4, '1999-01-01', '1999-02-02', '1999-01-15'),
    (3, 3, '1999-02-02', '2000-02-02', NULL);

INSERT INTO TILAUS(AsiakasID, NimikeID, Paivamaara) VALUES
    (1, 3, CURRENT_DATE);
