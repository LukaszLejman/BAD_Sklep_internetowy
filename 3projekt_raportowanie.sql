SET LANGUAGE polski
GO
if OBJECT_ID('ListaZamowienia') IS NOT NULL drop function ListaZamowienia
if OBJECT_ID('EgzemplarzeZNazw�') IS NOT NULL drop view EgzemplarzeZNazw�
if OBJECT_ID('Historia100OstatnichZam�wie�Klient�w') IS NOT NULL drop view Historia100OstatnichZam�wie�Klient�w
if OBJECT_ID('Najdrozsze3Zamowienia') IS NOT NULL drop view Najdrozsze3Zamowienia
if OBJECT_ID('Niedost�pneEgzemplarze') IS NOT NULL drop view Niedost�pneEgzemplarze
GO

create function ListaZamowienia ---funkcja tablicowa pokazuj�ca liste wybranego zam�wienia
        (@s int)
        returns table
as
	return select IDzamowienie, nazwa, cena_koncowa
	from (Produkt a join Egzemplarz b
	on a.IDprodukt=b.produkt) join ZamowieniaEgzemplarz c on b.IDegzemplarz=c.IDEgzemplarz
	where c.IDzamowienie=@s
GO
select * from ListaZamowienia(1)
GO

create view EgzemplarzeZNazw�(nazwa,producent,specyfikacja,kategoria,cena_koncowa,rok_produkcji,Nr_seryjny,status_) --- widok najdro�szych 10 egzemplarzy z nazw�
as
	select top(10) p.nazwa,p.producent,p.specyfikacja,p.kategoria,p.cena_koncowa,e.rok_produkcji,e.Nr_seryjny,status_
	from Produkt p inner join Egzemplarz e
	on p.IDprodukt=e.produkt
	order by p.cena_koncowa desc
GO
select * from EgzemplarzeZNazw�
GO

create view Historia100OstatnichZam�wie�Klient�w(email, IDzamowienie, nazwa, cena_koncowa) --- 100 sprzedanych ostatnio egzemplarzy
as
	select TOP(100) k.email, z.IDzamowienie, p.nazwa, p.cena_koncowa
	from Klient k inner join Zamowienia z
	on k.IDklient=z.klient and z.status_zamowienia='zrealizowane'
	inner join ZamowieniaEgzemplarz ze
	on z.IDzamowienie=ze.IDzamowienie
	inner join Egzemplarz e
	on ze.IDEgzemplarz=e.IDegzemplarz and e.status_='niedost�pny'
	inner join Produkt p
	on e.produkt=p.IDprodukt
	order by z.data_zrealizowania desc
	
GO
select * from Historia100OstatnichZam�wie�Klient�w
GO

create view Najdrozsze3Zamowienia(ID, SUMA) ---- 3 najdro�sze zam�wienia
as
	select top(3) z.IDzamowienie, dbo.SumaZamowieniaa(z.IDzamowienie) as suma
	from Zamowienia z
	order by suma desc
GO
select * from Najdrozsze3Zamowienia
GO

create view Niedost�pneEgzemplarze(IDegzemplarz, nazwa, status_) ---lista niedost�pnych egzemplarzy
as
	select e.IDegzemplarz, p.nazwa, e.status_
	from Egzemplarz e inner join Produkt p
	on e.produkt=p.IDprodukt and e.status_='niedost�pny'

GO
select * from Niedost�pneEgzemplarze
GO