SET LANGUAGE polski
GO
IF OBJECT_ID('Reklamacje', 'U') IS NOT NULL drop table Reklamacje
IF OBJECT_ID('ZamowieniaEgzemplarz', 'U') IS NOT NULL drop table ZamowieniaEgzemplarz
IF OBJECT_ID('Egzemplarz', 'U') IS NOT NULL drop table Egzemplarz
IF OBJECT_ID('Zamowienia', 'U') IS NOT NULL drop table Zamowienia
IF OBJECT_ID('Klient', 'U') IS NOT NULL drop table Klient
IF OBJECT_ID('Produkt', 'U') IS NOT NULL drop table Produkt
IF OBJECT_ID('Producent', 'U') IS NOT NULL drop table Producent
go

create table Producent
(IDproducent int IDENTITY(1,1) primary key,
 nazwa  varchar(30) unique,
 adres varchar(max),
 adres_serwisu varchar(30),
 kontakt varchar(30));

create table Produkt
(IDprodukt int IDENTITY(1,1) primary key,
 nazwa varchar(30),
 producent varchar(30) references Producent(nazwa),
 specyfikacja varchar(max),
 kategoria varchar(25) check (kategoria in ('komputery stacjonarne','laptopy','podzespoly','akcesoria')),
 cena_hurt float,
 cena_koncowa float);

 create table Egzemplarz
(IDegzemplarz int IDENTITY(1,1) primary key,
 produkt int references Produkt(IDprodukt),
 rok_produkcji int,
 Nr_seryjny int,
 status_ varchar(15) check (status_ in ('dostêpny','niedostêpny')),
 );

 create table Klient
 (IDklient int IDENTITY(1,1) primary key,
  email varchar(30) unique,
  haslo varchar(30),
  imie varchar(30),
  nazwisko varchar(30),
  adres varchar(max),
  telefon int,
 );

create table Zamowienia
(IDzamowienie int IDENTITY(1,1) primary key,
klient int references Klient(IDklient),
data_zlozenia date,
data_zrealizowania date,
status_zamowienia varchar(15) check (status_zamowienia in('w trakcie','zrealizowane','anulowane')),

);

 create table ZamowieniaEgzemplarz
 (IDzamowienie int references Zamowienia(IDzamowienie),
 IDEgzemplarz int references Egzemplarz(IDegzemplarz),
 primary key(IDzamowienie, IDEgzemplarz)
 );

 create table Reklamacje
 (IDreklamacje int IDENTITY(1,1) primary key,
  zamowienie int references Zamowienia(IDzamowienie),
  data_zgloszenia date,
  data_zakonczenia date,
  status_reklamacji varchar(30) check (status_reklamacji in('w trakcie','odrzucone','zaakceptowane')),
  opis_reklamacji varchar(max),
  decyzja varchar(max)
 );

 insert into Klient values 
 ('adamnowak@wp.pl', 'qwerty123', 'Adam', 'Nowak', 'os. Zwyciêstwa 11/12131, Poznañ', '123456789'),
 ('jakkowalski@wp.pl', 'asdfg123', 'Jan', 'Kowalski', 'os. PrzyjaŸni 12/113, Poznañ', '123456788'),
 ('andrzej123@wp.pl', 'blablabla', 'Andrzej', 'Kowalski', 'ul. Uliczna 12, Poznañ', '123456777'),
 ('lukaszlukasz@wp.pl', 'asdfg123', '£ukasz', 'Grabowski', 'ul. Koñcowa 3, Poznañ', '223456788')

 insert into Producent values
 ('ISM','ul. Krzakowa 1/2, Poznañ','ul. Krzakowa 1/3, Poznañ','997997997'),
 ('susA','ul. Polna 2/2, Poznañ','ul. Polna 1/3, Poznañ','222222222'),
 ('ovoneL','ul.Umultowska 3/33, Poznañ','ul.Umultowska 3/33, Poznañ','333333333'),
 ('spilihP','ul. Zwyczajna 32/1, Poznañ','ul. Zwyczajna 1/3, Poznañ','111111111')

 insert into Produkt values
 ('Laptop Y-21','ISM','500GB HDD, 6GB ram, i7 6700k, gtx950','laptopy','2222','3333'),
 ('Laptop Y-22','ISM','500GB HDD, 12GB ram, i7 6700k, gtx950','laptopy','2500','3500'),
 ('Laptop Y-23','ISM','1000GB HDD, 12GB ram, i7 6700k, gtx980','laptopy','4000','5000'),
 ('Laptop X22','ovoneL','1000GB HDD, 16GB ram, i7 7700k, gtx1080','laptopy','8000','9000'),
 ('Laptop X23','ovoneL','1000GB SSD, 16GB ram, i7 7700k, gtx1080','laptopy','9000','10000'),
 ('Laptop X24','ovoneL','1000GB SSD, 32GB ram, i7 7700k, gtx1080','laptopy','11000','12000'),
 ('Laptop Z2','susA','1000GB HDD, 16GB ram, i7 7700k, gtx1080','laptopy','8000','9000'),
 ('Laptop Z3','susA','1000GB SSD, 16GB ram, i7 7700k, gtx1080','laptopy','9000','10000'),
 ('Laptop Z4','susA','1000GB SSD, 32GB ram, i7 7700k, gtx1080','laptopy','11000','12000'),
 ('S³uchawki ABC-312','spilihP','2m, USB, Na g³owê, 32 mm','laptopy','200','300'),
 ('S³uchawki ABC-313','spilihP','3m, USB, Na g³owê, 32 mm','laptopy','222','333'),
 ('S³uchawki ABC-314','spilihP','2m, USB, Na g³owê, 32 mm','laptopy','50','100')

 insert into Egzemplarz values
 ('1','2017','1000','dostêpny'),
 ('1','2017','1001','dostêpny'),
 ('1','2017','1002','dostêpny'),
 ('2','2017','1003','dostêpny'),
 ('2','2017','1004','dostêpny'),
 ('2','2017','1005','dostêpny'),
 ('3','2017','1006','dostêpny'),
 ('3','2017','1007','dostêpny'),
 ('3','2017','1008','dostêpny'),
 ('4','2017','1009','dostêpny'),
 ('4','2017','1010','dostêpny'),
 ('4','2017','1011','dostêpny'),
 ('5','2017','1012','dostêpny'),
 ('5','2017','1013','dostêpny'),
 ('5','2017','1014','dostêpny'),
 ('6','2017','1015','dostêpny'),
 ('6','2017','1016','dostêpny'),
 ('6','2017','1017','dostêpny'),
 ('7','2017','1018','dostêpny'),
 ('7','2017','1019','dostêpny'),
 ('7','2017','1020','dostêpny'),
 ('8','2017','1021','dostêpny'),
 ('8','2017','1022','dostêpny'),
 ('8','2017','1023','dostêpny'),
 ('9','2017','1024','dostêpny'),
 ('9','2017','1025','dostêpny'),
 ('9','2017','1026','dostêpny'),
 ('10','2017','1027','dostêpny'),
 ('10','2017','1028','dostêpny'),
 ('10','2017','1029','dostêpny'),
 ('11','2017','1030','dostêpny'),
 ('11','2017','1031','dostêpny'),
 ('11','2017','1032','dostêpny'),
 ('12','2017','1033','dostêpny'),
 ('12','2017','1034','dostêpny'),
 ('12','2017','1035','dostêpny')

 insert into Zamowienia values
 ('1','2021-12-12','2021-12-13','zrealizowane'),
 ('2','2021-12-12','2021-12-13','zrealizowane'),
 ('3','2021-12-12','2021-12-13','zrealizowane'),
 ('2','2021-12-12','2021-12-13','zrealizowane')

 insert into ZamowieniaEgzemplarz values
 ('1','1'),
 ('1','4'),
 ('1','7'),
 ('2','11'),
 ('2','22'),
 ('2','23'),
 ('2','25')

 insert into Reklamacje values
 ('1','2021-12-17','2021-12-27','odrzucone','Zalanie wod¹ produktów przez u¿ytkownika.','Odrzucenie reklamacji. Ten typ uszkodzenia nie jest pokryty gwarancj¹.')

 select * from Klient
 select * from Producent
 select * from Produkt
 select * from Egzemplarz
 select * from Zamowienia
 select * from ZamowieniaEgzemplarz
 select * from Reklamacje
