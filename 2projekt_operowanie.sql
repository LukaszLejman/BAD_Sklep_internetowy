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
if OBJECT_ID('DodajEgzemplarz') IS NOT NULL drop proc DodajEgzemplarz
if OBJECT_ID('UsunietyEgzemplarz') IS NOT NULL drop trigger UsunietyEgzemplarz
if OBJECT_ID('DodajZamowienie') IS NOT NULL drop proc DodajZamowienie
if OBJECT_ID('ZmianaStatusuZamowienia') IS NOT NULL drop proc ZmianaStatusuZamowienia
if OBJECT_ID('Reklamowanie') IS NOT NULL drop proc Reklamowanie
if OBJECT_ID('ZmianaStatusuReklamacji') IS NOT NULL drop proc ZmianaStatusuReklamacji
if OBJECT_ID('CzasRealizacjiZamowienia') IS NOT NULL drop function CzasRealizacjiZamowienia
if OBJECT_ID('SumaZamowieniaa') IS NOT NULL drop function SumaZamowieniaa
go

create procedure DodajUzytkownika	--Zak�adanie konta
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
	SELECT ERROR_NUMBER() AS 'NUMER B��DU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec DodajUzytkownika 'nowyktos@wp.pl','nowehaslo123','noweimie','nowenazwisko','nowy adres 123','111222333'
GO
select * from Klient
GO

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
	SELECT ERROR_NUMBER() AS 'NUMER B��DU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec ZmienEmail 'adamnowak@wp.pl','qwerty123','nowyemail@wp.pl'
GO
select * from Klient
GO

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
	SELECT ERROR_NUMBER() AS 'NUMER B��DU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec ZmienHaslo 'jakkowalski@wp.pl','asdfg123','nowehaslo123' 
GO
select * from Klient
GO

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
	SELECT ERROR_NUMBER() AS 'NUMER B��DU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec ZmienDane 'andrzej123@wp.pl','Adam','Nowak','os. Bezdromne 22', '987321312'
GO
select * from Klient
GO

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
	SELECT ERROR_NUMBER() AS 'NUMER B��DU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec DodajProducenta'nowyproducent','nowyadres 12','nowyadresserwisu 123','tel. 123456789'
GO
select * from Producent
GO

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
	SELECT ERROR_NUMBER() AS 'NUMER B��DU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec ModyfikujProducenta 'ISM','nowyadres 123','nowy adres 1233','tel. 123123123'
GO
select * from Producent
GO

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
	SELECT ERROR_NUMBER() AS 'NUMER B��DU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec DodajProdukt 'Laptop NOWY','ISM','1000GB HDD, 12GB ram, i7 6700k, gtx980','laptopy','4000','5000'
GO
select * from Produkt
order by producent
GO

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
	SELECT ERROR_NUMBER() AS 'NUMER B��DU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec DodajEgzemplarz 1,2015,2000,'dost�pny'
GO
select * from Egzemplarz
GO

create trigger UsunietyEgzemplarz --usuwanie egzemplarzy (wycofanie ze sprzeda�y) 
on Egzemplarz
instead of delete
as
	update Egzemplarz
	set status_ = 'niedost�pny'
	where IDegzemplarz = (select IDegzemplarz from deleted)
GO
delete from Egzemplarz where IDegzemplarz=10
select * from Egzemplarz
GO

create procedure DodajZamowienie	--Dodawanie zam�wienia
 @klient int,
 @data_zlozenia date
AS
begin try
	insert into Zamowienia values
	(@klient,@data_zlozenia,NULL,'w trakcie')
end try
begin catch
	SELECT ERROR_NUMBER() AS 'NUMER B��DU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec DodajZamowienie '1','2021-12-12'
GO
select * from Zamowienia
GO

create procedure ZmianaStatusuZamowienia	--Zmiana statusu zam�wienia
 @id  int,
 @status_zamowienia varchar(15),
 @data_zrealizowania date
AS
begin try
	if @status_zamowienia ='zrealizowane'
	begin	update Zamowienia set
			data_zrealizowania=@data_zrealizowania,
			status_zamowienia=@status_zamowienia
			where IDzamowienie=@id
	end
	if @status_zamowienia ='anulowane'	
	begin	update Zamowienia set
			data_zrealizowania=@data_zrealizowania,
			status_zamowienia=@status_zamowienia
			where IDzamowienie=@id
			update Egzemplarz set
			status_='dost�pny'
			where IDegzemplarz in (select IDegzemplarz from ZamowieniaEgzemplarz where IDzamowienie=@id)
	end
end try
begin catch
	SELECT ERROR_NUMBER() AS 'NUMER B��DU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec ZmianaStatusuZamowienia 5,'zrealizowane','2021-12-13'
GO
exec ZmianaStatusuZamowienia 1,'anulowane','2021-12-13'
GO
select * from Zamowienia
GO

create procedure ZamowienieIEgzemplarz --Procedura do przypisywania egzemplarzu do zam�wienia
	@id_zam int,
	@id_egz int
as
begin try
	if 'dost�pny'=(select status_ from Egzemplarz where IDegzemplarz=@id_egz)
	begin
		if 'w trakcie'=(select status_zamowienia from Zamowienia where IDzamowienie=@id_zam)
		begin
			insert into ZamowieniaEgzemplarz values
			(@id_zam,@id_egz)
			delete from Egzemplarz where IDegzemplarz=@id_egz
		end
		else select 'B��d - nie mo�esz dodawa� egzemplarzy do anulowanych lub zrealizowanych zam�wie� ' as 'komunikat'
	end
	else select 'B��d - nie da si� zam�wi� niedost�pnych egzemplarzy ' as 'komunikat'
end try
begin catch
	select ERROR_NUMBER() as 'NUMER B��DU', ERROR_MESSAGE() as 'KOMUNIKAT'
end catch
go
exec DodajZamowienie '1','2021-12-12'
exec ZamowienieIEgzemplarz 6,30
GO
select * from ZamowieniaEgzemplarz
GO

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
	select ERROR_NUMBER() as 'NUMER B��DU', ERROR_MESSAGE() as 'KOMUNIKAT'
end catch
go
exec Reklamowanie 2,'2021-12-17','2021-12-27','odrzucone','Zalanie wod� produkt�w przez u�ytkownika.','Odrzucenie reklamacji. Ten typ uszkodzenia nie jest pokryty gwarancj�.'
GO
select * from Reklamacje
GO

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
	SELECT ERROR_NUMBER() AS 'NUMER B��DU', ERROR_MESSAGE() AS 'KOMUNIKAT'
end catch
GO
exec ZmianaStatusuReklamacji 1,'w trakcie', 'decyzja'
GO
select * from Reklamacje
GO

create function CzasRealizacjiZamowienia --funkcja licz�ca czas w jakim zosta�o zrealizowane zam�wienie
        (@a int)
        returns int
as
begin
		declare @pocz date
		set @pocz=(select data_zlozenia 
		from Zamowienia 
		where IDzamowienie=@a)
		declare @kon date
		set @kon=(select data_zrealizowania
		from Zamowienia 
		where IDzamowienie=@a)
        return DATEDIFF(DD,@pocz,@kon)
end
GO
select master.dbo.CzasRealizacjiZamowienia(3) as 'Czas realizacji w dniach'
GO

create function SumaZamowieniaa ---- oblicza ��czn� sum� zam�wienia
        (@s int)
        returns int
as
begin
	return (select SUM(cena_koncowa)
	from (Produkt a join Egzemplarz b
	on a.IDprodukt=b.produkt) join ZamowieniaEgzemplarz c on b.IDegzemplarz=c.IDEgzemplarz
	where c.IDzamowienie=@s
	group by IDzamowienie)
end
GO
select dbo.SumaZamowieniaa(1) as 'Suma zam�wienia'
GO

