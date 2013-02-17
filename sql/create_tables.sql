/*
 * Asiakas on jokin kirjaston palveluita käyttävä henkilö. Tietokanta olettaa,
 * että järjestelmässä on vain asiakkaiden suomalaisia osoitteita -
 * "Postinumero" -kenttä ei salli kuin 5-merkkisiä postinumeroita.
 */
CREATE TABLE ASIAKAS (
    AsiakasID SERIAL PRIMARY KEY,
    Etunimi VARCHAR(32) NOT NULL,
    Sukunimi VARCHAR(64) NOT NULL,
    Katuosoite VARCHAR(64) NOT NULL,
    Postitoimipaikka VARCHAR(32) NOT NULL,
    Postinumero CHAR(5) NOT NULL
);

/*
 * Kuvaa jotain fyysistä sijaintia Kohteille kirjastossa - Osasto, Hyllykko ja
 * Hylly ovat tarkemmin rajaamattomia numeroita.
 */
CREATE TABLE SIJAINTI (
    SijaintiID SERIAL PRIMARY KEY,
    Osasto INTEGER NOT NULL,
    Hyllykko INTEGER NOT NULL,
    Hylly INTEGER NOT NULL
);

/*
 * Nimiketyyppejä ovat esimerkiksi elokuva ja kirja. Tämä nimiketyypin
 * tekstimuotoinen kuvaus on attribuutissa "Nimi".
 */
CREATE TABLE NIMIKETYYPPI (
    NimiketyyppiID SERIAL PRIMARY KEY,
    Nimi VARCHAR(32) NOT NULL
);

/*
 * Nimike on jokin kirjaston valikoimista löytyvä teos, josta sitten voi löytyä
 * monia fyysisiä kopioita - kts. taulu KOHDE. Nimikkeellä on aina jokin
 * nimiketyyppi.
 */
CREATE TABLE NIMIKE (
    NimikeID SERIAL PRIMARY KEY,
    NimiketyyppiID INTEGER NOT NULL REFERENCES NIMIKETYYPPI,
    Nimi VARCHAR(255)
);

/*
 * Kuvailutietotyyppi on nimikkeeseen liittyvän kuvailutiedon tyyppi.
 * Jokaisella kuvailutietotyypillä on neljä-kirjaiminen koodi ja
 * tekstimuotoinen kuvaus.
 */
CREATE TABLE KUVAILUTIETOTYYPPI (
    KuvailutietoTyyppiID CHAR(4) PRIMARY KEY,
    Nimi VARCHAR(64) NOT NULL
);

/*
 * Taulu kuvaa johonkin nimiketyyppiin kuuluvia kuvailutietotyyppejä.
 * Yhteydet voivat olla pakollisia tai valinnaisia.
 */
CREATE TABLE KUULUVAT_KUVAILUTIETOTYYPIT (
    NimiketyyppiID INTEGER NOT NULL REFERENCES NIMIKETYYPPI,
    KuvailutietoTyyppiID CHAR(4) NOT NULL REFERENCES KUVAILUTIETOTYYPPI,
    Pakollinen BOOLEAN NOT NULL
);

/*
 * Kuvailutieto on johonkin nimikkeeseen liittyvää ns. metadataa. Esimerkkeinä
 * esimerkiksi kirjan kustantaja tai elokuvan ohjaaja. Kuvailutietoon liittyy
 * aina jokin kuvailutietotyyppi. Itse tietosisältö - eli siis vaikkapa
 * kustantajan tai ohjaajan nimi - on taulun "Tieto"-attribuutissa.
 */
CREATE TABLE KUVAILUTIETO (
    NimikeID INTEGER NOT NULL REFERENCES NIMIKE,
    KuvailutietoTyyppiID CHAR(4) NOT NULL REFERENCES KUVAILUTIETOTYYPPI,
    Tieto VARCHAR(255)
);


/* 
 * Kohde on jokin fyysinen kopio jostain nimikkeestä. Kohteella on aina jokin
 * sijainti, joka ei muutu vaikka kirja olisikin lainassa.
 * "Hankittu"-attribuutti kuvaa päivämäärää, jolloin kohde on hankittu
 * kirjastoon. "Hankintahinta"-attribuutti on kohden hankintahinta euroina.
 * "Hankittu" ja "Hankintahinta" voivat olla NULL, jos ne eivät ole tiedossa.
 * "LainaAika"-attribuutti on lainan kesto päivinä tätä kohdetta lainattaessa.
 * Jos "LainaAika" on 0, kohteen katsotaan kuuluvan käsikirjastoon eikä sitä
 * voi lainata.
 */
CREATE TABLE KOHDE (
    KohdeID SERIAL PRIMARY KEY,
    NimikeID INTEGER NOT NULL REFERENCES NIMIKE,
    SijaintiID INTEGER NOT NULL REFERENCES SIJAINTI,
    Hankittu DATE,
    Hankintahinta NUMERIC(6, 2),
    LainaAika INTEGER NOT NULL
);

/*
 * Laina kuvaa yhden asiakkaan lainaustapahtumaa yhdestä kohteesta.
 * "Lainattu"-attribuutti on päivämäärä, milloin lainaus on alkanut.
 * "Palautettava"-attribuutti on päivämäärö, milloin lainaus pitäisi viimeistään
 * palauttaa. "Palautettu" on päivämäärä, milloin kohde on palautettu
 * kirjastoon tai NULL, jos kohdetta ei ole palautettu. "Karhuamismerkinnät" on
 * kertojen lukumäärä, milloin asiakasta on muistutettu palauttamaan kohde
 * kirjastoon sen ollessa myöhässä.
 */
CREATE TABLE LAINA (
    LainaID SERIAL PRIMARY KEY,
    AsiakasID INTEGER NOT NULL REFERENCES ASIAKAS,
    KohdeID INTEGER NOT NULL REFERENCES KOHDE,
    Lainattu DATE NOT NULL DEFAULT CURRENT_DATE, 
    Palautettava DATE NOT NULL,
    Palautettu DATE,
    Karhuamismerkinnat INTEGER NOT NULL DEFAULT 0
);

/*
 * Tilaus on jonkin asiakkaan varaus jollekin nimikkeelle.
 * "Paivamaara"-attribuutti on päivä, jolloin varaus on tehty. Kun varaus
 * perutaan tai se on täytetty - eli asiakas on lainannut varaamansa nimikkeen
 * - kyseinen tilaus on tarkoitus poistaa taulusta.
 */
CREATE TABLE TILAUS (
    TilausID SERIAL PRIMARY KEY,
    AsiakasID INTEGER NOT NULL REFERENCES ASIAKAS,
    NimikeID INTEGER NOT NULL REFERENCES NIMIKE,
    Paivamaara DATE NOT NULL
);
