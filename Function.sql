


create function Seach (@author nvarchar(30),@theme nvarchar(30))
returns table
as
return
(
	select Books.NameBook from Authors,Books,Themes
	where Books.ID_THEME = Themes.ID_THEME
	and Books.ID_AUTHOR = Authors.ID_AUTHOR
	and Authors.FirstName = @author
	and Themes.NameTheme = @theme
)
select * from dbo.Seach('John','Programming')




create function SeachByID(@shop_id int)
returns table
as
return
(
	select Shops.ID_SHOP, Shops.NameShop,Country.NameCountry,avg(Sales.Price) as lol from Shops,Country,Sales
	where Shops.ID_COUNTRY = Country.ID_COUNTRY
	and Shops.ID_SHOP = Sales.ID_SHOP
	and Sales.DateOfSale > DATEADD(year,-1,GETDATE())
	and Shops.ID_SHOP = @shop_id
	group by Shops.ID_SHOP,Shops.NameShop,Country.NameCountry
)
select * from dbo.SeachByID(7)



create function ShowAboutShops()
returns table
as
return
(
	select  Shops.NameShop,Themes.NameTheme,sum(Sales.Quantity) as summ from Books,Shops,Sales,Themes 
	where Shops.ID_SHOP = Sales.ID_SHOP
	and Sales.ID_BOOK = Books.ID_BOOK
	and Books.ID_THEME = Themes.ID_THEME
	group by  Themes.NameTheme,Shops.NameShop
)
select * from dbo.ShowAboutShops()


create function ShowShopsInfo(@country nvarchar(20))
returns table
as
return
(
	select Shops.NameShop, sum(Sales.Quantity) as quantity, sum(Sales.Price) as all_price from Shops,Sales,Country
	where Shops.ID_SHOP = Sales.ID_SHOP
	and Shops.ID_COUNTRY = Country.ID_COUNTRY
	and Sales.DateOfSale > DATEADD(year,-1,GETDATE())
	and Country.NameCountry = @country
	group by Shops.NameShop
)
select * from dbo.ShowShopsInfo('Germany')



create function HowMuchAuthors(@country nvarchar(20))
returns table
as
return
(
	select count(Authors.ID_AUTHOR) as AllAuthors from Authors,Country
	where Country.ID_COUNTRY = Authors.ID_COUNTRY
	and Country.NameCountry = @country
)
select * from dbo.HowMuchAuthors('USA')
