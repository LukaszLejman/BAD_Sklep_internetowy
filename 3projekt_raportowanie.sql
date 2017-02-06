SET LANGUAGE polski
GO
if OBJECT_ID('SumaZamowienia') IS NOT NULL drop function SumaZamowienia
if OBJECT_ID('ListaZamowienia') IS NOT NULL drop function ListaZamowienia
GO

create function SumaZamowienia
        (@s int)
        returns table
as
	return select SUM(cena_koncowa) as suma, IDzamowienie
	from (Produkt a join Egzemplarz b
	on a.IDprodukt=b.produkt) join ZamowieniaEgzemplarz c on b.IDegzemplarz=c.IDEgzemplarz
	where c.IDzamowienie=@s
	group by IDzamowienie
GO
select * from SumaZamowienia(1)
GO

create function ListaZamowienia
        (@s int)
        returns table
as
	return select IDzamowienie, cena_koncowa
	from (Produkt a join Egzemplarz b
	on a.IDprodukt=b.produkt) join ZamowieniaEgzemplarz c on b.IDegzemplarz=c.IDEgzemplarz
	where c.IDzamowienie=@s
GO
select * from ListaZamowienia(1)
GO