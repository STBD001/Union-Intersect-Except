1. Wyświetl w jednej tabeli dane osobowe klientów i pracowników
ROZWIĄZANIE: 
SELECT
    klienci.imie_klienta AS 'imie',
    klienci.nazwisko_klienta AS 'naziwsko',
    klienci.plec AS 'piec',
    klienci.miasto_klienta AS 'miasto',
    klienci.email_klienta 'email',
    'klient' rola
FROM
    klienci
UNION
SELECT
    pracownicy.imie_pracownika,
    pracownicy.nazwisko_pracownika,
    pracownicy.miasto_pracownika,
    pracownicy.email_pracownika,
    NULL,
    'pracownik'
FROM
    pracownicy;

2. Wyświetl imiona i nazwiska klinetów, którzy wypożyczali i pracowników, któzy obsługiwali
wypożyczenia samochodu Audi A4
ROZWIĄZANIE: 
SELECT
    klienci.imie_klienta AS 'imie',
    klienci.nazwisko_klienta AS 'nazwisko',
    klienci.plec AS 'plec',
    klienci.miasto_klienta AS 'miasto',
    klienci.email_klienta AS 'email',
    'klient' AS rola
FROM
    klienci
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta = klienci.id_klienta
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia = wypozyczenia.id_wypozyczenia
INNER JOIN samochody ON samochody.id_samochodu = dane_wypozyczen.id_samochodu
WHERE
    samochody.model = 'a4'
UNION
SELECT
    pracownicy.imie_pracownika AS 'imie',
    pracownicy.nazwisko_pracownika AS 'nazwisko',
    NULL AS 'plec',
    NULL AS 'miasto',
    NULL AS 'email',
    'pracownik' AS rola
FROM
    pracownicy
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta = pracownicy.id_pracownika
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia = wypozyczenia.id_wypozyczenia
INNER JOIN samochody ON samochody.id_samochodu = dane_wypozyczen.id_samochodu
WHERE
    samochody.model = 'a4';

3. Wyświetl imiona i nazwiska klinetów, którzy wypożyczali samochody Renault Clio oraz Opel Astra 
ROZWIĄZANIE: 
SELECT
    klienci.imie_klienta,
    klienci.nazwisko_klienta
FROM
    klienci
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta = klienci.id_klienta
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia = wypozyczenia.id_wypozyczenia
INNER JOIN samochody ON samochody.id_samochodu = dane_wypozyczen.id_samochodu
WHERE
    samochody.model = 'clio'
INTERSECT
SELECT
    klienci.imie_klienta,
    klienci.nazwisko_klienta
FROM
    klienci
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta = klienci.id_klienta
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia = wypozyczenia.id_wypozyczenia
INNER JOIN samochody ON samochody.id_samochodu = dane_wypozyczen.id_samochodu
WHERE
    samochody.model = 'astra'
4. Wyświetl klientów, którzy wypożycali dwa konkretne samochody w tym samym dniu. Do zapytania
dołącz id, datę wypożyczenia oraz model auta. 
ROZWIĄZANIE: 
SELECT
    klienci.imie_klienta,
    klienci.nazwisko_klienta,
    wypozyczenia.id_wypozyczenia,
    wypozyczenia.data_wyp,
    samochody.marka
FROM
    klienci
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta = klienci.id_klienta
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia = wypozyczenia.id_wypozyczenia
INNER JOIN samochody ON samochody.id_samochodu = dane_wypozyczen.id_samochodu
WHERE
    samochody.model = 'corsa'
UNION ALL
SELECT
    klienci.imie_klienta,
    klienci.nazwisko_klienta,
    wypozyczenia.id_wypozyczenia,
    wypozyczenia.data_wyp,
    samochody.marka
FROM
    klienci
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta = klienci.id_klienta
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia = wypozyczenia.id_wypozyczenia
INNER JOIN samochody ON samochody.id_samochodu = dane_wypozyczen.id_samochodu
WHERE
    samochody.model = 'astra';

5. Wyświetl imiona i nazwiska klientów, którzy wypożyczali Forda'a Mondeo, ale nie wypożyczenia
nigdy Opla Astry 
ROZWIĄZNIE: 
SELECT
    klienci.imie_klienta,
    klienci.nazwisko_klienta
FROM
    klienci
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta = klienci.id_klienta
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia = wypozyczenia.id_wypozyczenia
INNER JOIN samochody ON samochody.id_samochodu = dane_wypozyczen.id_samochodu
WHERE
    samochody.model = 'mondeo'

EXCEPT

SELECT
    klienci.imie_klienta,
    klienci.nazwisko_klienta
FROM
    klienci
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta = klienci.id_klienta
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia = wypozyczenia.id_wypozyczenia
INNER JOIN samochody ON samochody.id_samochodu = dane_wypozyczen.id_samochodu
WHERE
    samochody.model = 'astra';
