DROP DATABASE rentacar;

CREATE DATABASE rentacar;

USE rentacar;

-- Customer Table (Kupac)
CREATE TABLE Kupac (
    ID_kupca INT AUTO_INCREMENT PRIMARY KEY,
    Ime VARCHAR(50) NOT NULL,
    Prezime VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Telefon VARCHAR(20) NOT NULL,
    Adresa VARCHAR(255) NOT NULL,
    Datum_rođenja DATE NOT NULL,
    Datum_registracije DATE NOT NULL
);

-- Employee Table (Zaposlenik)
CREATE TABLE Zaposlenik (
    ID_zaposlenika INT AUTO_INCREMENT PRIMARY KEY,
    Ime VARCHAR(50) NOT NULL,
    Prezime VARCHAR(50) NOT NULL,
    Pozicija VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Telefon VARCHAR(20) NOT NULL,
    Datum_zapošljavanja DATE NOT NULL
);

-- Vehicle Table (Vozilo)
CREATE TABLE Vozilo (
    ID_vozila INT AUTO_INCREMENT PRIMARY KEY,
    Marka VARCHAR(50) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Godište INT NOT NULL,
    Registracijski_broj VARCHAR(20) UNIQUE NOT NULL,
    Status ENUM('Dostupno', 'U najmu', 'Servisirano') NOT NULL,
    Cijena_po_danu DECIMAL(10, 2) NOT NULL,
    Tip_vozila VARCHAR(50) NOT NULL
);
-- Insurance Table (Osiguranje)
CREATE TABLE Osiguranje (
    ID_osiguranja INT AUTO_INCREMENT PRIMARY KEY,
    Naziv VARCHAR(50) NOT NULL,
    Cijena_po_danu DECIMAL(10, 2) NOT NULL,
    Opis VARCHAR(255)
);
-- Reservation Table (Rezervacija)
CREATE TABLE Rezervacija (
    ID_rezervacije INT AUTO_INCREMENT PRIMARY KEY,
    ID_kupca INT,
    ID_vozila INT,
    ID_zaposlenika INT,
    ID_osiguranja INT,
    Datum_početka DATE NOT NULL,
    Datum_završetka DATE NOT NULL,
    Ukupna_cijena DECIMAL(10, 2) NOT NULL,
    Status_rezervacije ENUM('Aktivna', 'Završena', 'Otkazana') NOT NULL,
    FOREIGN KEY (ID_kupca) REFERENCES Kupac(ID_kupca),
    FOREIGN KEY (ID_vozila) REFERENCES Vozilo(ID_vozila),
    FOREIGN KEY (ID_zaposlenika) REFERENCES Zaposlenik(ID_zaposlenika),
    FOREIGN KEY (ID_osiguranja) REFERENCES Osiguranje(ID_osiguranja)
);


-- Additional Service Table (Dodatna_usluga)
CREATE TABLE Dodatna_usluga (
    ID_usluge INT AUTO_INCREMENT PRIMARY KEY,
    Naziv_usluge VARCHAR(50) NOT NULL,
    Opis VARCHAR(255),
    Cijena DECIMAL(10, 2) NOT NULL
);

-- Reservation Service Table (Rezervacija_usluga)
CREATE TABLE Rezervacija_usluga (
    ID_rezervacije INT,
    ID_usluge INT,
    FOREIGN KEY (ID_rezervacije) REFERENCES Rezervacija(ID_rezervacije),
    FOREIGN KEY (ID_usluge) REFERENCES Dodatna_usluga(ID_usluge),
    PRIMARY KEY (ID_rezervacije, ID_usluge)
);

-- Payment Table (Plaćanje)
CREATE TABLE Plaćanje (
    ID_plaćanja INT AUTO_INCREMENT PRIMARY KEY,
    ID_rezervacije INT,
    Iznos DECIMAL(10, 2) NOT NULL,
    Datum_plaćanja DATE NOT NULL,
    Način_plaćanja ENUM('Kartica', 'Gotovina', 'Bankovni transfer') NOT NULL,
    Status_plaćanja ENUM('Uplaćeno', 'Na čekanju', 'Odbijeno') NOT NULL,
    FOREIGN KEY (ID_rezervacije) REFERENCES Rezervacija(ID_rezervacije)
);

-- Vehicle Maintenance Table (Održavanje_vozila)
CREATE TABLE Održavanje_vozila (
    ID_održavanja INT AUTO_INCREMENT PRIMARY KEY,
    ID_vozila INT,
    Datum_servisa DATE NOT NULL,
    Opis_servisa VARCHAR(255),
    Cijena_servisa DECIMAL(10, 2),
    FOREIGN KEY (ID_vozila) REFERENCES Vozilo(ID_vozila)
);

-- Customer Reviews Table (Recenzije_kupaca)
CREATE TABLE Recenzije_kupaca (
    ID_recenzije INT AUTO_INCREMENT PRIMARY KEY,
    ID_kupca INT,
    ID_vozila INT,
    Ocjena INT NOT NULL,
    Komentar VARCHAR(255),
    Datum_recenzije DATE NOT NULL,
    FOREIGN KEY (ID_kupca) REFERENCES Kupac(ID_kupca),
    FOREIGN KEY (ID_vozila) REFERENCES Vozilo(ID_vozila)
);



-- INSERT --

INSERT INTO Kupac (Ime, Prezime, Email, Telefon, Adresa, Datum_rođenja, Datum_registracije)
VALUES 
('Ivan', 'Horvat', 'ivan.horvat@mail.com', '0911234567', 'Ulica 1, Zagreb', '1985-03-20', '2023-01-15'),
('Ana', 'Kovačić', 'ana.kovacic@mail.com', '0987654321', 'Ulica 2, Split', '1990-05-12', '2023-02-10'),
('Marko', 'Novak', 'marko.novak@mail.com', '0996543210', 'Ulica 3, Rijeka', '1983-09-25', '2023-03-05'),
('Petra', 'Matić', 'petra.matic@mail.com', '0912345678', 'Ulica 30, Dubrovnik', '1995-12-01', '2023-08-21'),
('Tomislav', 'Radić', 'tomislav.radic@mail.com', '0922345678', 'Ulica 4, Osijek', '1988-11-17', '2023-05-14'),
('Marija', 'Jurić', 'marija.juric@mail.com', '0915556667', 'Ulica 5, Zadar', '1992-07-20', '2023-06-30'),
('Ante', 'Filipović', 'ante.filipovic@mail.com', '0911239999', 'Ulica 6, Pula', '1987-02-15', '2023-03-28'),
('Ivana', 'Babić', 'ivana.babic@mail.com', '0981234567', 'Ulica 7, Varaždin', '1993-04-10', '2023-05-10'),
('Nikola', 'Lovrić', 'nikola.lovric@mail.com', '0959991234', 'Ulica 8, Šibenik', '1991-06-18', '2023-07-05'),
('Iva', 'Tomić', 'iva.tomic@mail.com', '0914567890', 'Ulica 9, Karlovac', '1989-10-01', '2023-04-15'),
('Luka', 'Vuković', 'luka.vukovic@mail.com', '0927654321', 'Ulica 10, Vukovar', '1990-03-22', '2023-06-01'),
('Tina', 'Bogdanović', 'tina.bogdanovic@mail.com', '0912345555', 'Ulica 11, Bjelovar', '1985-05-05', '2023-07-15'),
('Goran', 'Šarić', 'goran.saric@mail.com', '0919876543', 'Ulica 12, Sisak', '1992-09-25', '2023-01-10'),
('Martina', 'Klarić', 'martina.klaric@mail.com', '0955551234', 'Ulica 13, Knin', '1994-02-13', '2023-02-25'),
('Davor', 'Miletić', 'davor.miletic@mail.com', '0915678765', 'Ulica 14, Krapina', '1983-11-11', '2023-03-01'),
('Sara', 'Barišić', 'sara.barisic@mail.com', '0912233445', 'Ulica 15, Virovitica', '1995-07-21', '2023-06-15'),
('Marin', 'Vidović', 'marin.vidovic@mail.com', '0923232323', 'Ulica 16, Opatija', '1989-08-08', '2023-02-28'),
('Josipa', 'Zelić', 'josipa.zelic@mail.com', '0913334445', 'Ulica 17, Čakovec', '1993-05-11', '2023-04-20'),
('Krešimir', 'Jakšić', 'kresimir.jaksic@mail.com', '0981112222', 'Ulica 18, Imotski', '1986-01-05', '2023-07-03'),
('Maja', 'Milić', 'maja.milic@mail.com', '0954445556', 'Ulica 19, Samobor', '1991-12-13', '2023-08-01'),
('Kristina', 'Rogić', 'kristina.rogic@mail.com', '0918765432', 'Ulica 20, Sinj', '1988-04-08', '2023-05-07'),
('Vlado', 'Zubčić', 'vlado.zubcic@mail.com', '0919990001', 'Ulica 21, Zaprešić', '1985-06-06', '2023-03-15'),
('Monika', 'Galić', 'monika.galic@mail.com', '0925556677', 'Ulica 22, Našice', '1992-09-09', '2023-06-10'),
('Damir', 'Varga', 'damir.varga@mail.com', '0988889999', 'Ulica 23, Trogir', '1989-11-02', '2023-07-11'),
('Mateja', 'Radoš', 'mateja.rados@mail.com', '0919998887', 'Ulica 24, Požega', '1993-03-15', '2023-08-04'),
('Stipe', 'Ribić', 'stipe.ribic@mail.com', '0914442221', 'Ulica 25, Makarska', '1990-01-07', '2023-05-18'),
('Marija', 'Opačić', 'marija.opacic@mail.com', '0982345678', 'Ulica 26, Čakovec', '1986-07-12', '2023-04-22'),
('Boris', 'Kožul', 'boris.kozul@mail.com', '0911235555', 'Ulica 27, Križevci', '1988-08-23', '2023-06-29'),
('Sandra', 'Kostelić', 'sandra.kostelic@mail.com', '0913322110', 'Ulica 28, Ludbreg', '1991-05-01', '2023-07-20'),
('Dino', 'Mikulić', 'dino.mikulic@mail.com', '0952233445', 'Ulica 29, Poreč', '1989-12-09', '2023-08-19'),
('Anita', 'Raić', 'anita.raic@mail.com', '0913216547', 'Ulica 30, Omiš', '1994-10-22', '2023-05-30');


INSERT INTO Vozilo (Marka, Model, Godište, Registracijski_broj, Status, Cijena_po_danu, Tip_vozila)
VALUES 
('Volkswagen', 'Golf', 2020, 'ZG1234AB', 'Dostupno', 45.00, 'Kompakt'),
('Opel', 'Astra', 2019, 'ST9876CD', 'U najmu', 40.00, 'Kompakt'),
('Toyota', 'Yaris', 2018, 'RI5643EF', 'Dostupno', 35.00, 'Gradski'),
('BMW', 'X5', 2022, 'DU1122GH', 'Servisirano', 120.00, 'SUV'),
('Renault', 'Clio', 2017, 'OS2345IJ', 'Dostupno', 30.00, 'Gradski'),
('Peugeot', '208', 2019, 'ZD6789KL', 'U najmu', 37.00, 'Kompakt'),
('Ford', 'Fiesta', 2016, 'PU3456MN', 'Dostupno', 32.00, 'Gradski'),
('Skoda', 'Octavia', 2021, 'VK5678OP', 'Servisirano', 50.00, 'Limuzina'),
('Mercedes', 'C-Klasa', 2020, 'ZG9999QR', 'Dostupno', 100.00, 'Limuzina'),
('Audi', 'A4', 2018, 'SB1234ST', 'U najmu', 85.00, 'Limuzina'),
('Hyundai', 'i30', 2019, 'VU4321UV', 'Dostupno', 45.00, 'Kompakt'),
('Mazda', 'CX-5', 2022, 'RI3456WX', 'Dostupno', 90.00, 'SUV'),
('Kia', 'Sportage', 2020, 'ST6789YZ', 'U najmu', 75.00, 'SUV'),
('Nissan', 'Qashqai', 2021, 'DU5678AC', 'Servisirano', 80.00, 'SUV'),
('Honda', 'Civic', 2017, 'ZG1234BC', 'Dostupno', 40.00, 'Kompakt'),
('Citroen', 'C3', 2018, 'PU2345DE', 'Dostupno', 33.00, 'Gradski'),
('Seat', 'Leon', 2019, 'ZD3456FG', 'U najmu', 47.00, 'Kompakt'),
('Dacia', 'Duster', 2021, 'RI4567HI', 'Dostupno', 60.00, 'SUV'),
('Suzuki', 'Vitara', 2020, 'OS6789JK', 'Dostupno', 55.00, 'SUV'),
('Tesla', 'Model 3', 2022, 'DU7890LM', 'U najmu', 150.00, 'Električni'),
('Volkswagen', 'Passat', 2019, 'ZG1234NO', 'Dostupno', 80.00, 'Limuzina'),
('Jeep', 'Compass', 2021, 'ST2345PQ', 'Servisirano', 100.00, 'SUV'),
('Renault', 'Megane', 2018, 'RI3456RS', 'U najmu', 50.00, 'Limuzina'),
('BMW', '3 Series', 2021, 'ZG5678TU', 'Dostupno', 120.00, 'Limuzina'),
('Ford', 'Kuga', 2019, 'SB6789VW', 'Dostupno', 70.00, 'SUV'),
('Toyota', 'Corolla', 2020, 'ZD8901XY', 'U najmu', 65.00, 'Limuzina'),
('Volvo', 'XC40', 2022, 'PU1234YZ', 'Dostupno', 140.00, 'SUV'),
('Audi', 'Q5', 2021, 'DU5678AB', 'Dostupno', 130.00, 'SUV'),
('Mercedes', 'GLC', 2020, 'ZG6789CD', 'Servisirano', 125.00, 'SUV'),
('Volkswagen', 'Tiguan', 2018, 'RI7890EF', 'Dostupno', 110.00, 'SUV');

INSERT INTO Zaposlenik (Ime, Prezime, Pozicija, Email, Telefon, Datum_zapošljavanja)
VALUES 
('Luka', 'Perić', 'Menadžer', 'luka.peric@mail.com', '0911111111', '2020-01-10'),
('Sara', 'Lukić', 'Agent', 'sara.lukic@mail.com', '0912222222', '2021-03-20'),
('Toni', 'Barišić', 'Mehaničar', 'toni.barisic@mail.com', '0913333333', '2021-05-15'),
('Nina', 'Kovač', 'Administrativni radnik', 'nina.kovac@mail.com', '0914444444', '2022-02-10'),
('Ivan', 'Milić', 'Agent', 'ivan.milic@mail.com', '0915555555', '2021-08-08'),
('Marija', 'Marković', 'Mehaničar', 'marija.markovic@mail.com', '0916666666', '2022-04-22'),
('Petar', 'Lovrić', 'Agent', 'petar.lovric@mail.com', '0917777777', '2023-01-05'),
('Ivana', 'Božić', 'Menadžer', 'ivana.bozic@mail.com', '0918888888', '2020-05-01'),
('Ana', 'Vuković', 'Mehaničar', 'ana.vukovic@mail.com', '0919999999', '2021-09-17'),
('Goran', 'Nikolić', 'Agent', 'goran.nikolic@mail.com', '0911111222', '2022-12-25'),
('Martina', 'Tomić', 'Agent', 'martina.tomic@mail.com', '0912222111', '2023-04-10'),
('Davor', 'Radić', 'Administrativni radnik', 'davor.radic@mail.com', '0913333222', '2022-05-19'),
('Klara', 'Horvat', 'Agent', 'klara.horvat@mail.com', '0914444333', '2021-07-07'),
('Maja', 'Kralj', 'Mehaničar', 'maja.kralj@mail.com', '0915555444', '2023-02-02'),
('Josip', 'Kovačić', 'Administrativni radnik', 'josip.kovacic@mail.com', '0916666555', '2022-09-09'),
('Nikolina', 'Matić', 'Agent', 'nikolina.matic@mail.com', '0917777666', '2021-11-11'),
('Mateo', 'Filipović', 'Mehaničar', 'mateo.filipovic@mail.com', '0918888777', '2020-03-15'),
('Marina', 'Jurić', 'Administrativni radnik', 'marina.juric@mail.com', '0919999888', '2022-06-28'),
('Branko', 'Novak', 'Menadžer', 'branko.novak@mail.com', '0911111999', '2020-11-11'),
('Katarina', 'Varga', 'Agent', 'katarina.varga@mail.com', '0912222000', '2021-12-10'),
('Lana', 'Bogdanović', 'Mehaničar', 'lana.bogdanovic@mail.com', '0913333000', '2022-07-15'),
('Igor', 'Šarić', 'Agent', 'igor.saric@mail.com', '0914444000', '2021-06-06'),
('Petra', 'Klarić', 'Administrativni radnik', 'petra.klaric@mail.com', '0915555000', '2023-03-25'),
('Hrvoje', 'Perić', 'Mehaničar', 'hrvoje.peric@mail.com', '0916666000', '2021-04-04'),
('Ines', 'Miletić', 'Menadžer', 'ines.miletic@mail.com', '0917777000', '2022-10-01'),
('Stjepan', 'Jakšić', 'Agent', 'stjepan.jaksic@mail.com', '0918888000', '2021-02-05'),
('Nika', 'Klarić', 'Administrativni radnik', 'nika.klaric@mail.com', '0919999000', '2020-12-20'),
('Domagoj', 'Barišić', 'Agent', 'domagoj.barisic@mail.com', '0910000111', '2023-05-05'),
('Lea', 'Vidić', 'Mehaničar', 'lea.vidic@mail.com', '0910000222', '2022-01-18'),
('Mislav', 'Lovrić', 'Administrativni radnik', 'mislav.lovric@mail.com', '0910000333', '2021-04-25');

INSERT INTO Osiguranje (Naziv, Cijena_po_danu, Opis)
VALUES 
('Osnovno osiguranje', 5.00, 'Osnovno pokriće šteta na vozilu'),
('Kasko osiguranje', 10.00, 'Široko pokriće šteta i krađe'),
('Putno osiguranje', 3.00, 'Osiguranje putnika tijekom najma'),
('Premium osiguranje', 20.00, 'Najšire osiguranje sa svim pokrićima'),
('Osiguranje od krađe', 15.00, 'Osiguranje za zaštitu od krađe vozila'),
('Osiguranje za gume', 6.00, 'Pokriće za oštećenja guma'),
('Osiguranje stakla', 8.00, 'Pokriće za oštećenje prozora i stakala'),
('Putničko osiguranje', 7.00, 'Osiguranje svih putnika u vozilu'),
('Osiguranje osobnih stvari', 5.00, 'Osiguranje osobnih stvari u vozilu'),
('Hitno osiguranje', 25.00, 'Osiguranje za hitne slučajeve na putu'),
('Električno vozilo osiguranje', 12.00, 'Osiguranje za električna vozila'),
('Dugoročno osiguranje', 50.00, 'Osiguranje za dugotrajne najmove'),
('Kratkoročno osiguranje', 2.00, 'Osiguranje za kratke najmove'),
('Osiguranje luksuznih vozila', 35.00, 'Pokriće za luksuzna vozila'),
('Osiguranje od nezgode', 15.00, 'Osiguranje od nesreća'),
('Osiguranje na moru', 20.00, 'Osiguranje za vozila korištena u morskom prijevozu'),
('Osiguranje sportskih vozila', 25.00, 'Osiguranje za sportska vozila'),
('Osiguranje za rent-a-car', 10.00, 'Osiguranje za vozila za najam'),
('Osiguranje za motocikle', 8.00, 'Pokriće za najam motocikala'),
('Osiguranje za duga putovanja', 30.00, 'Osiguranje za dugačka putovanja'),
('Osiguranje karoserije', 15.00, 'Pokriće za oštećenje karoserije vozila'),
('Osiguranje za kućne ljubimce', 5.00, 'Osiguranje za kućne ljubimce u vozilu'),
('Osiguranje za elektroničke uređaje', 10.00, 'Osiguranje za uređaje u vozilu'),
('Zimsko osiguranje', 7.00, 'Osiguranje za vozila u zimskim uvjetima'),
('Osiguranje automatskog mjenjača', 5.00, 'Pokriće za štete na automatskom mjenjaču'),
('Osiguranje prtljažnog prostora', 4.00, 'Osiguranje za prtljažni prostor vozila'),
('Osiguranje sjedala', 3.00, 'Osiguranje za sjedala vozila'),
('Ekološko osiguranje', 12.00, 'Osiguranje za ekološka vozila'),
('Ekspresno osiguranje', 50.00, 'Brzo i povoljno osiguranje'),
('Luksuzno osiguranje', 40.00, 'Najviša razina luksuznog osiguranja');

INSERT INTO Rezervacija (ID_kupca, ID_vozila, ID_zaposlenika, Datum_početka, Datum_završetka, Ukupna_cijena, Status_rezervacije, ID_osiguranja)
VALUES 
(1, 1, 1, '2023-05-01', '2023-05-10', 450.00, 'Završena', 1),
(2, 2, 1, '2023-06-15', '2023-06-18', 120.00, 'Aktivna', 2),
(3, 3, 1, '2023-07-01', '2023-07-05', 175.00, 'Otkazana', 3),
(4, 4, 2, '2023-04-10', '2023-04-17', 840.00, 'Završena', 4),
(5, 5, 2, '2023-03-21', '2023-03-28', 210.00, 'Aktivna', 5),
(6, 6, 2, '2023-06-11', '2023-06-13', 74.00, 'Završena', 6),
(7, 7, 2, '2023-02-01', '2023-02-07', 196.00, 'Otkazana', 7),
(8, 8, 2, '2023-08-05', '2023-08-10', 300.00, 'Završena', 8),
(9, 9, 2, '2023-04-22', '2023-04-29', 700.00, 'Aktivna', 9),
(10, 10, 3, '2023-05-13', '2023-05-17', 340.00, 'Aktivna', 10),
(11, 11, 3, '2023-07-08', '2023-07-12', 225.00, 'Otkazana', 11),
(12, 12, 3, '2023-03-30', '2023-04-03', 180.00, 'Završena', 12),
(13, 13, 3, '2023-05-05', '2023-05-10', 450.00, 'Završena', 13),
(14, 14, 3, '2023-06-10', '2023-06-15', 375.00, 'Aktivna', 14),
(15, 15, 3, '2023-08-01', '2023-08-05', 175.00, 'Završena', 15),
(16, 16, 3, '2023-04-15', '2023-04-20', 330.00, 'Aktivna', 16),
(17, 17, 4, '2023-07-18', '2023-07-22', 235.00, 'Aktivna', 17),
(18, 18, 4, '2023-03-10', '2023-03-15', 300.00, 'Završena', 18),
(19, 19, 4, '2023-02-22', '2023-02-25', 90.00, 'Aktivna', 19),
(20, 20, 4, '2023-04-05', '2023-04-12', 560.00, 'Završena', 20),
(21, 21, 5, '2023-01-18', '2023-01-22', 600.00, 'Završena', 21),
(22, 22, 5, '2023-08-15', '2023-08-20', 500.00, 'Aktivna', 22),
(23, 23, 5, '2023-06-05', '2023-06-10', 325.00, 'Otkazana', 23),
(24, 24, 5, '2023-05-20', '2023-05-27', 875.00, 'Završena', 24),
(25, 25, 5, '2023-03-25', '2023-03-30', 660.00, 'Aktivna', 25),
(26, 26, 5, '2023-02-10', '2023-02-13', 160.00, 'Završena', 26),
(27, 27, 5, '2023-04-30', '2023-05-05', 275.00, 'Aktivna', 27),
(28, 28, 5, '2023-07-20', '2023-07-25', 375.00, 'Aktivna', 28),
(29, 29, 5, '2023-06-15', '2023-06-18', 360.00, 'Završena', 29),
(30, 30, 5, '2023-08-21', '2023-08-30', 900.00, 'Aktivna', 30);


INSERT INTO Dodatna_usluga (Naziv_usluge, Opis, Cijena)
VALUES 
('GPS Navigacija', 'Dodatna GPS navigacija u vozilu', 5.00),
('Dječja sjedalica', 'Sigurnosna sjedalica za djecu', 3.00),
('Puno osiguranje', 'Potpuna pokrivenost osiguranjem', 15.00),
('Zamjena vozila', 'Besplatna zamjena vozila u slučaju kvara', 10.00),
('Dodatni vozač', 'Mogućnost dodavanja drugog vozača', 8.00),
('Bez ograničenja kilometraže', 'Najam bez ograničenja kilometraže', 20.00),
('WiFi u vozilu', 'Mobilni internet u vozilu', 7.00),
('Express povrat vozila', 'Brzi povrat vozila bez čekanja', 12.00),
('Krovni prtljažnik', 'Dodatni prtljažnik na krovu vozila', 6.00),
('Sportska oprema', 'Pribor za sportove, uključujući nosače za bicikle', 10.00),
('Dodatni punjač za auto', 'Punjač za električna vozila', 5.00),
('Zimske gume', 'Specijalne gume za zimske uvjete', 3.00),
('Karta autocesta', 'Karta s informacijama o cestovnim rutama i naplatama', 2.00),
('Zaštita od krađe', 'Osiguranje protiv krađe vozila', 18.00),
('Putno osiguranje', 'Osiguranje putnika tijekom najma', 7.00),
('Osiguranje za gume i stakla', 'Osiguranje od štete na gumama i staklima', 6.00),
('Navigacija s glazbenim sustavom', 'Glazbena navigacija s dodatnim funkcijama', 5.00),
('Električni romobil', 'Dodatak za električni romobil', 12.00),
('Kreditna opcija najma', 'Kredit za produženje najma', 10.00),
('Komplet za hitnu pomoć', 'Komplet za hitne situacije na putu', 3.00),
('Ručni radarski detektor', 'Detektor radara u vozilu', 8.00),
('Senzor za parkiranje', 'Dodatni senzor za parkiranje', 7.00),
('Električna sjedala', 'Udobna električna sjedala', 10.00),
('Potpuna dezinfekcija vozila', 'Dezinfekcija vozila', 20.00),
('Punjač za telefon', 'USB punjač za mobilni telefon', 2.00),
('Benzin do punog rezervoara', 'Vozilo s punim rezervoarom', 45.00),
('Pomoć na cesti', 'Brza usluga pomoći na cesti', 15.00),
('Automatski prijenos', 'Vozilo s automatskim prijenosom', 5.00),
('Privatni vozač', 'Mogućnost najma privatnog vozača', 50.00),
('Lux dodatak', 'Najam vozila sa luksuznim dodatcima', 30.00);

INSERT INTO Rezervacija_usluga (ID_rezervacije, ID_usluge)
VALUES 
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5), 
(3, 6), (3, 7),
(4, 8), (4, 9),
(5, 10), (5, 11),
(6, 12), (6, 13),
(7, 14), (7, 15),
(8, 16), (8, 17),
(9, 18), (9, 19),
(10, 20), (10, 21),
(11, 22), (11, 23),
(12, 24), (12, 25),
(13, 26), (13, 27),
(14, 28), (14, 29),
(15, 30);

INSERT INTO Plaćanje (ID_rezervacije, Iznos, Datum_plaćanja, Način_plaćanja, Status_plaćanja)
VALUES 
(1, 450.00, '2023-05-01', 'Kartica', 'Uplaćeno'),
(2, 120.00, '2023-06-15', 'Gotovina', 'Na čekanju'),
(3, 175.00, '2023-07-01', 'Kartica', 'Odbijeno'),
(4, 840.00, '2023-04-10', 'Kartica', 'Uplaćeno'),
(5, 210.00, '2023-03-21', 'Gotovina', 'Na čekanju'),
(6, 74.00, '2023-06-11', 'Kartica', 'Uplaćeno'),
(7, 196.00, '2023-02-01', 'Bankovni transfer', 'Odbijeno'),
(8, 300.00, '2023-08-05', 'Kartica', 'Uplaćeno'),
(9, 700.00, '2023-04-22', 'Gotovina', 'Na čekanju'),
(10, 340.00, '2023-05-13', 'Bankovni transfer', 'Uplaćeno'),
(11, 225.00, '2023-07-08', 'Kartica', 'Odbijeno'),
(12, 180.00, '2023-03-30', 'Kartica', 'Uplaćeno'),
(13, 450.00, '2023-05-05', 'Gotovina', 'Na čekanju'),
(14, 375.00, '2023-06-10', 'Bankovni transfer', 'Uplaćeno'),
(15, 175.00, '2023-08-01', 'Kartica', 'Odbijeno'),
(16, 330.00, '2023-04-15', 'Kartica', 'Uplaćeno'),
(17, 235.00, '2023-07-18', 'Gotovina', 'Na čekanju'),
(18, 300.00, '2023-03-10', 'Kartica', 'Uplaćeno'),
(19, 90.00, '2023-02-22', 'Gotovina', 'Na čekanju'),
(20, 560.00, '2023-04-05', 'Bankovni transfer', 'Uplaćeno'),
(21, 600.00, '2023-01-18', 'Gotovina', 'Na čekanju'),
(22, 500.00, '2023-08-15', 'Kartica', 'Uplaćeno'),
(23, 325.00, '2023-06-05', 'Bankovni transfer', 'Odbijeno'),
(24, 875.00, '2023-05-20', 'Kartica', 'Uplaćeno'),
(25, 660.00, '2023-03-25', 'Gotovina', 'Na čekanju'),
(26, 160.00, '2023-02-10', 'Kartica', 'Uplaćeno'),
(27, 275.00, '2023-04-30', 'Bankovni transfer', 'Uplaćeno'),
(28, 375.00, '2023-07-20', 'Gotovina', 'Na čekanju'),
(29, 360.00, '2023-06-15', 'Bankovni transfer', 'Uplaćeno'),
(30, 900.00, '2023-08-21', 'Kartica', 'Uplaćeno');

INSERT INTO Održavanje_vozila (ID_vozila, Datum_servisa, Opis_servisa, Cijena_servisa)
VALUES 
(1, '2023-04-01', 'Zamjena ulja i filtera', 100.00),
(2, '2023-05-15', 'Popravak kočnica', 200.00),
(3, '2023-06-20', 'Servis motora', 300.00),
(4, '2023-07-05', 'Zamjena guma', 150.00),
(5, '2023-08-10', 'Zamjena svjećica', 120.00),
(6, '2023-03-25', 'Servis mjenjača', 500.00),
(7, '2023-02-14', 'Zamjena kočionih diskova', 250.00),
(8, '2023-01-30', 'Servis klima uređaja', 180.00),
(9, '2023-04-18', 'Popravak ispušnog sustava', 400.00),
(10, '2023-05-02', 'Servis ovjesa', 350.00),
(11, '2023-06-10', 'Zamjena remena', 140.00),
(12, '2023-07-22', 'Veliki servis', 600.00),
(13, '2023-08-03', 'Servis turbopunjača', 800.00),
(14, '2023-03-15', 'Zamjena hladnjaka', 220.00),
(15, '2023-04-10', 'Servis električnog sustava', 270.00),
(16, '2023-05-05', 'Popravak upravljačkog mehanizma', 320.00),
(17, '2023-06-25', 'Popravak elektronske kontrolne jedinice', 450.00),
(18, '2023-07-12', 'Zamjena amortizera', 350.00),
(19, '2023-08-17', 'Popravak automatskog mjenjača', 650.00),
(20, '2023-01-25', 'Servis gorivnog sustava', 300.00),
(21, '2023-02-18', 'Popravak sustava za ubrizgavanje', 550.00),
(22, '2023-03-28', 'Zamjena filtera zraka', 110.00),
(23, '2023-04-09', 'Popravak servo upravljača', 200.00),
(24, '2023-05-18', 'Zamjena sustava hlađenja', 400.00),
(25, '2023-06-05', 'Popravak zračnog ovjesa', 500.00),
(26, '2023-07-20', 'Servis grijanja', 130.00),
(27, '2023-08-29', 'Zamjena kočionih pločica', 180.00),
(28, '2023-04-14', 'Popravak krovnog otvora', 250.00),
(29, '2023-05-29', 'Zamjena sustava za pranje stakla', 100.00),
(30, '2023-06-12', 'Servis stražnjeg diferencijala', 450.00);

INSERT INTO Recenzije_kupaca (ID_kupca, ID_vozila, Ocjena, Komentar, Datum_recenzije)
VALUES 
(1, 1, 5, 'Odlično iskustvo, auto je bio u odličnom stanju!', '2023-05-12'),
(2, 2, 4, 'Dobar auto, ali malo prljav.', '2023-06-20'),
(3, 3, 2, 'Vozilo je imalo problema s motorom.', '2023-07-07'),
(4, 4, 5, 'Odlična vožnja, vrlo udobno!', '2023-04-19'),
(5, 5, 3, 'Auto je imao sitne ogrebotine.', '2023-03-29'),
(6, 6, 5, 'Vrlo ugodno iskustvo!', '2023-06-11'),
(7, 7, 4, 'Zadovoljan, ali mogao bi biti čišći.', '2023-02-03'),
(8, 8, 5, 'Super auto, brz i pouzdan.', '2023-08-06'),
(9, 9, 2, 'Puno problema s kočnicama.', '2023-04-24'),
(10, 10, 4, 'Dobar auto, ali klima nije radila.', '2023-05-14'),
(11, 11, 1, 'Vozilo se stalno kvarilo.', '2023-07-09'),
(12, 12, 5, 'Odličan auto i odlična usluga!', '2023-03-31'),
(13, 13, 3, 'Mogao je biti u boljem stanju.', '2023-05-07'),
(14, 14, 5, 'Vrhunsko iskustvo!', '2023-06-12'),
(15, 15, 4, 'Dobro, ali ne baš ono što sam očekivao.', '2023-08-03'),
(16, 16, 5, 'Super vozilo, preporučujem!', '2023-04-17'),
(17, 17, 2, 'Vozilo je bilo prljavo.', '2023-07-19'),
(18, 18, 4, 'Udobno vozilo, sve u redu.', '2023-03-12'),
(19, 19, 3, 'Prosječno iskustvo.', '2023-02-24'),
(20, 20, 5, 'Savršeno iskustvo, preporučujem!', '2023-04-07'),
(21, 21, 4, 'Dobar auto, ali malo skupo.', '2023-01-20'),
(22, 22, 2, 'Imali smo problema s elektronikom.', '2023-08-17'),
(23, 23, 5, 'Sve je bilo savršeno!', '2023-06-07'),
(24, 24, 3, 'Nije bilo loše, ali moglo je biti bolje.', '2023-05-22'),
(25, 25, 4, 'Solidno iskustvo, auto je bio dobar.', '2023-03-27'),
(26, 26, 5, 'Odlična usluga i auto.', '2023-02-12'),
(27, 27, 4, 'Dobro vozilo, sve u redu.', '2023-04-01'),
(28, 28, 5, 'Perfektno!', '2023-07-21'),
(29, 29, 2, 'Auto je imao problema s klimom.', '2023-06-17'),
(30, 30, 5, 'Sve je bilo u savršenom redu, preporučujem!', '2023-08-31');


-- Okidači
-- 1. Okidač za ažuriranje statusa vozila kada se izvrši rezervacija
DELIMITER //

CREATE TRIGGER trg_after_reservation_insert
AFTER INSERT ON Rezervacija
FOR EACH ROW
BEGIN
    UPDATE Vozilo
    SET Status = 'U najmu'
    WHERE ID_vozila = NEW.ID_vozila;
END;

//
DELIMITER ;

-- 2. Okidač za ažuriranje statusa vozila kada je rezervacija dovršena
DELIMITER //
CREATE TRIGGER trg_after_reservation_update
AFTER UPDATE ON Rezervacija
FOR EACH ROW
BEGIN
    IF NEW.Status_rezervacije = 'Završena' THEN
        UPDATE Vozilo
        SET Status = 'Dostupno'
        WHERE ID_vozila = NEW.ID_vozila;
    END IF;
END;

//
DELIMITER ;


-- 3. Okidač za ažuriranje ukupne cijene rezervacije nakon umetanja
DELIMITER //

CREATE TRIGGER trg_before_reservation_insert
BEFORE INSERT ON Rezervacija
FOR EACH ROW
BEGIN
    DECLARE daily_rate DECIMAL(10,2);
    DECLARE days INT;

    SELECT Cijena_po_danu INTO daily_rate 
    FROM Vozilo 
    WHERE ID_vozila = NEW.ID_vozila;
    SET days = DATEDIFF(NEW.Datum_završetka, NEW.Datum_početka);

    SET NEW.Ukupna_cijena = daily_rate * days;
END;

//
DELIMITER ;

-- 4. Okidač za bilježenje ažuriranja održavanja

DELIMITER //

CREATE TRIGGER trg_after_maintenance_insert
AFTER INSERT ON Održavanje_vozila
FOR EACH ROW
BEGIN
    INSERT INTO Log_održavanje (ID_vozila, Datum_servisa, Opis_servisa, Cijena_servisa, Datum_unosa)
    VALUES (NEW.ID_vozila, NEW.Datum_servisa, NEW.Opis_servisa, NEW.Cijena_servisa, NOW());
END;

//

DELIMITER ;


-- 5. Okidač za sprječavanje duplikata e-pošte u tablici Kupac

DELIMITER //

CREATE TRIGGER trg_before_insert_kupac
BEFORE INSERT ON Kupac
FOR EACH ROW
BEGIN
    DECLARE email_count INT;

    SELECT COUNT(*) INTO email_count FROM Kupac WHERE Email = NEW.Email;

    IF email_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Dupli email detektiran!';
    END IF;
END;

//

DELIMITER ;

-- Procedure

-- 1. Procedura koji uzima ID vozila i vraća njegov status dostupnosti
DELIMITER //
CREATE PROCEDURE GetVehicleAvailability(IN vehicle_id INT)
BEGIN
    SELECT Status FROM Vozilo WHERE ID_vozila = vehicle_id;
END //
DELIMITER ;

-- 2. Procedura za izradu nove rezervacije

DELIMITER //
CREATE PROCEDURE CreateReservation(
    IN kupac_id INT, 
    IN vozilo_id INT, 
    IN datum_početka DATE, 
    IN datum_završetka DATE
)
BEGIN
    DECLARE daily_rate DECIMAL(10, 2);
    DECLARE total_price DECIMAL(10, 2);
    DECLARE num_days INT;

    SELECT Cijena_po_danu INTO daily_rate FROM Vozilo WHERE ID_vozila = vozilo_id;

    SET num_days = DATEDIFF(datum_završetka, datum_početka);
    SET total_price = daily_rate * num_days;

    INSERT INTO Rezervacija (ID_kupca, ID_vozila, Datum_početka, Datum_završetka, Ukupna_cijena, Status_rezervacije)
    VALUES (kupac_id, vozilo_id, datum_početka, datum_završetka, total_price, 'Aktivna');
    
    UPDATE Vozilo SET Status = 'U najmu' WHERE ID_vozila = vozilo_id;
END //
DELIMITER ;


-- 3. Postupak za dobivanje povijesti najma od strane korisnika
DELIMITER //
CREATE PROCEDURE GetCustomerRentalHistory(IN kupac_id INT)
BEGIN
    SELECT r.ID_rezervacije, v.Marka, v.Model, r.Datum_početka, r.Datum_završetka, r.Ukupna_cijena, r.Status_rezervacije
    FROM Rezervacija r
    INNER JOIN Vozilo v ON r.ID_vozila = v.ID_vozila
    WHERE r.ID_kupca = kupac_id;
END //
DELIMITER ;

-- Transakcija
-- Transakcija za stvaranje rezervacije i atomsku obradu plaćanja. Ako bilo što ne uspije, cijela se operacija vraća unatrag.
DELIMITER //
CREATE PROCEDURE CreateReservationWithPayment(
    IN kupac_id INT, 
    IN vozilo_id INT, 
    IN datum_početka DATE, 
    IN datum_završetka DATE, 
    IN iznos DECIMAL(10, 2), 
    IN datum_plaćanja DATE, 
    IN način_plaćanja ENUM('Kartica', 'Gotovina', 'Bankovni transfer')
)
BEGIN
    DECLARE total_price DECIMAL(10,2);
    DECLARE num_days INT;
    DECLARE daily_rate DECIMAL(10,2);
    DECLARE reservation_id INT;

    -- Start transaction
    START TRANSACTION;
    SELECT Cijena_po_danu INTO daily_rate FROM Vozilo WHERE ID_vozila = vozilo_id;
    SET num_days = DATEDIFF(datum_završetka, datum_početka);
    SET total_price = daily_rate * num_days;

    INSERT INTO Rezervacija (ID_kupca, ID_vozila, Datum_početka, Datum_završetka, Ukupna_cijena, Status_rezervacije)
    VALUES (kupac_id, vozilo_id, datum_početka, datum_završetka, total_price, 'Aktivna');
    
    SET reservation_id = LAST_INSERT_ID();

    INSERT INTO Plaćanje (ID_rezervacije, Iznos, Datum_plaćanja, Način_plaćanja, Status_plaćanja)
    VALUES (reservation_id, iznos, datum_plaćanja, način_plaćanja, 'Uplaćeno');

    COMMIT;

    -- Update vehicle status
    UPDATE Vozilo SET Status = 'U najmu' WHERE ID_vozila = vozilo_id;

END //
DELIMITER ;