SET LANGUAGE polski
GO
if OBJECT_ID('ZamowienieIEgzemplarz') IS NOT NULL drop proc ZamowienieIEgzemplarz
if OBJECT_ID('DodajUzytkownika') IS NOT NULL drop proc DodajUzytkownika
if OBJECT_ID('ZmienEmail') IS NOT NULL drop proc ZmienEmail
if OBJECT_ID('ZmienHaslo') IS NOT NULL drop proc ZmienHaslo
if OBJECT_ID('ZmienDane') IS NOT NULL drop proc ZmienDane
if OBJECT_ID('DodajProducenta') IS NOT NULL drop proc DodajProducenta
if OBJECT_ID('ModyfikujProducenta') IS NOT NULL drop proc ModyfikujProducenta
if OBJECT_ID('NowaNazwaProducenta') IS NOT NULL drop proc NowaNazwaProducenta
if OBJECT_ID('DodajProdukt') IS NOT NULL drop proc DodajProdukt
if OBJECT_ID('ZmienNazweProducenta') IS NOT NULL drop trigger ZmienNazweProducenta
if OBJECT_ID('DodajEgzemplarz') IS NOT NULL drop proc DodajEgzemplarz
if OBJECT_ID('SprzedanyEgzemplarz') IS NOT NULL drop trigger SprzedanyEgzemplarz
if OBJECT_ID('DodajZamowienie') IS NOT NULL drop proc DodajZamowienie
if OBJECT_ID('ZmianaStatusuZamowienia') IS NOT NULL drop proc ZmianaStatusuZamowienia
if OBJECT_ID('Reklamowanie') IS NOT NULL drop proc Reklamowanie
if OBJECT_ID('ZmianaStatusuReklamacji') IS NOT NULL drop proc ZmianaStatusuReklamacji
if OBJECT_ID('CzasRealizacjiZamowienia') IS NOT NULL drop function CzasRealizacjiZamowienia
go

create procedure DodajUzytkownika	--Zak³adanie konta
  @email varchar(30),
  @haslo varchar(30),
  @imie varchar(30),
  @nazwisko varchar(30),
  @adres varchar(max),
  @telefon int
AS
begin try
	insert into Klient values
	(@email,@haslo,@imie,@nazwisko,@adres,@telefon)
end try
begin catch
	SELECT ERROR_NUMBER() AS 'NUMER B£ÊDU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec DodajUzytkownika 'nowyktos@wp.pl','nowehaslo123','noweimie','nowenazwisko','nowy adres 123','111222333'
GO
--select * from Klient

create procedure ZmienEmail --zmiana adresu e-mail
  @staryemail varchar(30),
  @haslo varchar(30),
  @email varchar(30)
AS
begin try
	update Klient set
	email=@email
	where email=@staryemail and haslo=@haslo
end try
begin catch
	SELECT ERROR_NUMBER() AS 'NUMER B£ÊDU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec ZmienEmail 'adamnowak@wp.pl','qwerty123','nowyemail@wp.pl'
GO
--select * from Klient

create procedure ZmienHaslo --zmiana hasla
  @email varchar(30),
  @haslo varchar(30),
  @nowehaslo varchar(30)
AS
begin try
	update Klient set
	haslo=@nowehaslo
	where haslo=@haslo and email=@email
end try
begin catch
	SELECT ERROR_NUMBER() AS 'NUMER B£ÊDU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec ZmienHaslo 'adamnowak@wp.pl','qwerty123','nowehaslo123' 
GO
--select * from Klient

create procedure ZmienDane --zmiana danych osobowych
  @email varchar(30),
  @imie varchar(30),
  @nazwisko varchar(30),
  @adres varchar(max),
  @telefon int
AS
begin try
	update Klient set
	imie=@imie,
	nazwisko=@nazwisko,
	adres=@adres,
	telefon=@telefon
	where email=@email
end try
begin catch
	SELECT ERROR_NUMBER() AS 'NUMER B£ÊDU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec ZmienDane 'adamnowak@wp.pl','Adam','Nowak','os. Bezdromne 22', '987321312'
GO
--select * from Klient

create procedure DodajProducenta	--Dodawanie producenta
 @nazwa  varchar(30),
 @adres varchar(max),
 @adres_serwisu varchar(30),
 @kontakt varchar(30)
AS
begin try
	insert into Producent values
	(@nazwa,@adres,@adres_serwisu,@kontakt)
end try
begin catch
	SELECT ERROR_NUMBER() AS 'NUMER B£ÊDU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec DodajProducenta'nowyproducent','nowyadres 12','nowyadresserwisu 123','tel. 123456789'
GO
--select * from Producent

create procedure ModyfikujProducenta	--Modyfikacja producenta
 @nazwa  varchar(30),
 @adres varchar(max),
 @adres_serwisu varchar(30),
 @kontakt varchar(30)
AS
begin try
	update Producent set
	nazwa=@nazwa,
	adres=@adres,
	adres_serwisu=@adres_serwisu,
	kontakt=@kontakt
	where nazwa=@nazwa
end try
begin catch
	SELECT ERROR_NUMBER() AS 'NUMER B£ÊDU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec ModyfikujProducenta 'ISM','nowyadres 123','nowy adres 1233','tel. 123123123'
GO
--select * from Producent
--GO

create procedure DodajProdukt	--Dodawanie produktu
 @nazwa varchar(30),
 @producent varchar(30),
 @specyfikacja varchar(max),
 @kategoria varchar(25),
 @cena_hurt float,
 @cena_koncowa float
AS
begin try
	insert into Produkt values
	(@nazwa,@producent,@specyfikacja,@kategoria,@cena_hurt,@cena_koncowa)
end try
begin catch
	SELECT ERROR_NUMBER() AS 'NUMER B£ÊDU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec DodajProdukt 'Laptop NOWY','ISM','1000GB HDD, 12GB ram, i7 6700k, gtx980','laptopy','4000','5000'
GO
--select * from Produkt
--order by producent
--GO

create procedure DodajEgzemplarz	--Dodawanie egzemplarza
 @produkt int,
 @rok_produkcji int,
 @Nr_seryjny int,
 @status_ varchar(15)
AS
begin try
	insert into Egzemplarz values
	(@produkt,@rok_produkcji,@Nr_seryjny,@status_)
end try
begin catch
	SELECT ERROR_NUMBER() AS 'NUMER B£ÊDU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec DodajEgzemplarz 1,2015,2000,'dostêpny'
GO
--select * from Egzemplarz
--GO

create trigger SprzedanyEgzemplarz --usuwanie egzemplarzy (sprzedanie, wycofanie ze sprzeda¿y) 
on Egzemplarz
instead of delete
as
	update Egzemplarz
	set status_ = 'niedostêpny'
	where IDegzemplarz in (select IDegzemplarz from deleted)
GO
--select * from Egzemplarz
--GO

create procedure DodajZamowienie	--Dodawanie zamówienia
 @klient int,
 @data_zlozenia date,
 @data_zrealizowania date,
 @status_zamowienia varchar(15)
AS
begin try
	insert into Zamowienia values
	(@klient,@data_zlozenia,@data_zrealizowania,@status_zamowienia)
end try
begin catch
	SELECT ERROR_NUMBER() AS 'NUMER B£ÊDU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec DodajZamowienie '1','2021-12-12','2021-12-13','zrealizowane'
GO
--select * from Zamowienia
--GO

create procedure ZmianaStatusuZamowienia	--Zmiana statusu zamówienia
 @id  int,
 @status_zamowienia varchar(15)
AS
begin try
	update Zamowienia set
	status_zamowienia=@status_zamowienia
	where IDzamowienie=@id
end try
begin catch
	SELECT ERROR_NUMBER() AS 'NUMER B£ÊDU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec ZmianaStatusuZamowienia 5,'w trakcie'
GO
--select * from Zamowienia
--GO

create procedure ZamowienieIEgzemplarz --Procedura do przypisywania egzemplarzu do zamoówienia
	@id_egz int,
	@id_zam int
as
begin try
	insert into ZamowieniaEgzemplarz values
	(@id_egz,@id_zam)
end try
begin catch
	select ERROR_NUMBER() as 'NUMER B£ÊDU', ERROR_MESSAGE() as 'KOMUNIKAT'
end catch
go
exec ZamowienieIEgzemplarz 2,3
GO
--select * from ZamowieniaEgzemplarz

create procedure Reklamowanie --Dodawanie reklamacji
  @zamowienie int,
  @data_zgloszenia date,
  @data_zakonczenia date,
  @status_reklamacji varchar(30),
  @opis_reklamacji varchar(max),
  @decyzja varchar(max)
as
begin try
	insert into Reklamacje values
	(@zamowienie,@data_zgloszenia,@data_zakonczenia,@status_reklamacji,@opis_reklamacji,@decyzja)
end try
begin catch
	select ERROR_NUMBER() as 'NUMER B£ÊDU', ERROR_MESSAGE() as 'KOMUNIKAT'
end catch
go
exec Reklamowanie 2,'2021-12-17','2021-12-27','odrzucone','Zalanie wod¹ produktów przez u¿ytkownika.','Odrzucenie reklamacji. Ten typ uszkodzenia nie jest pokryty gwarancj¹.'
GO
--select * from Reklamacje
--GO

create procedure ZmianaStatusuReklamacji	--Zmiana statusu reklamacji (z dodaniem opisu)
 @id  int,
 @status_reklamacji varchar(30),
 @decyzja varchar(max)
AS
begin try
	update Reklamacje set
	status_reklamacji=@status_reklamacji,
	decyzja=@decyzja
	where IDreklamacje=@id
end try
begin catch
	SELECT ERROR_NUMBER() AS 'NUMER B£ÊDU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec ZmianaStatusuReklamacji 1,'w trakcie', 'decyzja'
GO
--select * from Reklamacje
--GO

/*create function CzasRealizacjiZamowienia --funkcja
        (@a int)
        returns date
as
begin
		DATEDIFF(DD,@pocz,@kon)
		where 
        return DATEDIFF(DD,@pocz,@kon)
end*/
