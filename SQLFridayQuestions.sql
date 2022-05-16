-- Senaryomuz ; kullanıcıların uygulama aracılığı ile sisteme üye girişi yaparak, teknik servise bıraktıkları ürünün durumunu sorgulayabilecekleri
-- bir web uygulamasının veritabanı sistemini programlamanızdır. Veritabanının ihtiyaçları aşağıda belirtilmiştir.


-- Her üye aşağıdaki bilgilere sahiptir

-- Ad

-- Soyad

-- E-posta adresi

-- Üyelik şifresi

-- Sisteme giriş tarihi

-- İrtibat telefonu

-- İrtibat adresi

-- İl

-- İlçe



-- Teknik servise bırakılan her ürün, aşağıdaki bilgileri içerir:

-- Teslim alındığı tarihi,

-- Ürün arızası ile ilgili kullanıcı beyanı,

-- Ürün arızası ile ilgili teknik servis bilgileri,

-- Arıza kategorisi,

-- Teknik servis ücreti,

-- Teslim edileceği tarih

-- Arıza ile ilgilenecek teknik servis personeli bilgisi

-- Ürünün teknik servisteki aşaması


-- Her ürünün yalnızca bir arıza kategorisi vardır. Fakat bir kategori altında birden fazla ürün olabilir.

-- Bir üye, birden fazla ürünü teknik servise bırakmış olabilir


-- 1-) Tablo oluşturma ve içlerine örnek veri girişi yapılmalı,

 -- 2-) Tablolama için Normalizasyon uygulanmalı,

 -- 3-) Tablo yapısı ve tablolar arası ilişkilendirmelerinizi tamamladıktan sonra, iki tablo için 

-- aşağıdaki stored procedure’leri yazınız:

--· Ekleme (INSERT)

--· Güncelleme (UPDATE)

--· Silme (DELETE)

--· Tablonun primary key sütunu olan ID sine göre sorgu yapabilen ve veri getiren.


-- 4-) Yukarıdaki işlemler dışında, aşağıdaki işlemleri de gerçekleştiren stored procedureleri ve/veya view ları yazınız ;

--· ID’si girilen ürün, hangi aşamada?

--· ID’si girilen ürün hangi üye tarafından bırakılmış?

--· ID’si girilen üye hangi ürün/ürünleri, hangi tarihte bırakmış ve ürünün sorgu anında teknik servisin hangi aşamasında,

--· Hangi arıza kategorisinde ürünlerden kaçar adet servise geldiği günlük, aylık, yıllık olarak sorgulanabilmeli,

--· Günlük tahsilat ve ciro raporu oluşturan sorgu,

--· Teknik servis personeli, kişi bazlı, aylık performans raporu hazırlayan sorgu

Create Table Member(
   ID int PRIMARY KEY IDENTITY (1,1),
   FirstName Nvarchar(Max),
   LastName Nvarchar(Max),
   Password NVARCHAR(max)
)

Create Table MemberEmail(
   ID int PRIMARY KEY IDENTITY (1,1),
   MemberID int not null , 
   Email Nvarchar(max),
)


Create Table MemberLogin(
  ID int PRIMARY KEY IDENTITY (1,1),
  EnteryDate datetime default GETDATE(), -- Tarih kısmını varsayılan olarak al.
)

Create Table MemberContact(
    ID int PRIMARY KEY IDENTITY (1,1),
   MemberID int not null, -- Product ıd kısmı not null diyerek boş geçilmez olarak belirttik.
   PhoneNumber Nvarchar(11),
)


Create Table MemberAdress(
  ID int PRIMARY KEY IDENTITY (1,1),
  MemberID int not null,
  City Nvarchar (35),
  District Nvarchar (35),
  Adress nvarchar(30),

)

Create Table Personel (
   ID int PRIMARY KEY IDENTITY (1,1),
   FirstName Nvarchar(MAX),
   LastName Nvarchar(Max),	
)

Create Table Product(
 ID int PRIMARY KEY IDENTITY (1,1),
 MemberID int not null,
 ProcessID int ,
 DueDate datetime default GETDATE(),
)

Create Table MemberReport(
 ID int PRIMARY KEY IDENTITY (1, 1),
 ProductID int NOT NULL,
 Report NVARCHAR(MAX),
)

Create Table TechnicalReport (
 ID int PRIMARY KEY IDENTITY (1, 1),
 ProductID int NOT NULL,
 PersonnelID int NOT NULL,
 Report NVARCHAR(100),
 DeliveryDate date,
)

Create Table Record (
ID int PRIMARY KEY IDENTITY (1, 1),
ProductID int NOT NULL,
MemberID int NOT NULL,
Price money
)

Create Table Categorie(
ID int PRIMARY KEY IDENTITY (1,1),
Fault NVARCHAR(20)
)

Create Table ProductCategorie(
ProductID int NOT NULL,
CategoriID int NOT NULL
)

Create Table Process(
ID int PRIMARY KEY IDENTITY (1, 1),
Stage NVARCHAR(max)
)

delete from MemberContact where ID = 2
insert into MemberContact(MemberID,PhoneNumber) values ('8', '5342345665')
insert into MemberEmail(MemberID, Email) values ('3', 'member@gmail.com')
insert into Personel (FirstName, LastName) values ('Ali', 'Toprak')
insert into Product(MemberID) values (5)
insert into Process (Stage) values ('Tesim edildi')
insert into MemberReport (ProductID, Report) 

insert into MemberAdress(MemberID,City,District,Adress) values (2,'Erzurum','Palandöken', 'Bilmem Ne Caddesi 2/2')

insert into Categorie (Fault) values ('Klavyem Bozuk')

insert into MemberReport (ProductID,Report) values (3, 'Ekran Kaıyor')

insert into ProductCategorie (ProductID, CategoriID) values (3,2)

insert into Record (MemberID, ProductID, Price) values (3, 2, 150)

insert into TechnicalReport (ProductID, PersonnelID , Report, DeliveryDate) values (3, 1, 'Ekran değişimi gerekiyor' , '2010-06-11')


--Ürün eklendiğinde ilk servis aşamasına atayan trigger
CREATE TRIGGER trg_ProductProcess
on Product
after insert 
as
begin
update  Product set ProcessID = 1 where ID = @@IDENTITY
end


--Ekleme İşlemi
alter procedure sp_AddMember(@FirstName NVARCHAR(max), @LastName NVARCHAR(max), @Password NVARCHAR(max))
as
begin
insert into Member(FirstName, LastName, Password) values (@FirstName, @LastName, @Password)
end
select * from Member
--sp_AddMember 'Ali', 'Çelik', 'Bartın5678'
--sp_AddMember 'Bilal' ,'Köse', 'Katamonu5432'
--sp_AddMember 'Selçuk', 'Çığ', 'Ceyhan23545'
--sp_AddMember 'Rıdvan', 'Çelik', 'Yozgat3452'
--sp_AddMember 'Elif', 'Baklı', 'Bursa54543'
--sp_AddMember 'Burçin', 'Sözken', 'İzmir3221'
--sp_AddMember 'Elvan', 'Karagöz', 'Muğla3445'
--sp_AddMember 'Emre', 'Kestirmez', 'Batmanlı45543'

--Güncelleme İşlemi

create procedure sp_UpdateProcess(@ProductID int ,  @ProcessID int) -- product ve proses ıd ye güncelleme attık 
as
begin
update Product set ProcessID = @ProcessID where ID = @ProductID
end

--sp_UpdateProcess 2,2

-- silme işlemi 

create proc sp_DeleteRecord (@ID int)
as
begin
delete Record where ID = @ID
end

--sp_DeleteRecord 3


--•	ID’si girilen ürün, hangi aşamada?


create procedure sp_GetByProcessByID ( @ID int) 
as
begin
select * from Product p
inner join Process pcs on p.ProcessID = pcs.ID where p.ID = @ID
end

--sp_GetByProcessByID 3


--•	ID’si girilen ürün hangi üye tarafından bırakılmış?
create procedure sp_GetMemberByID ( @ID int) 
as
begin
select FirstName,LastName from Product p
inner join Member m on p.MemberID = m.ID where p.ID = @ID
end


--sp_GetMemberByID 1

--•	ID’si girilen üye hangi ürün/ürünleri, hangi tarihte bırakmış ve ürünün sorgu anında teknik servisin hangi aşamasında,
create procedure sp_GetProductByID (@ID int)
as
begin
select * from Product p 
inner join Process pcs on pcs.ID = p.ID
where MemberID = @ID	
end

--sp_GetProductByID 1

--•	Hangi arıza kategorisinde ürünlerden kaçar adet servise geldiği günlük, aylık, yıllık olarak sorgulanabilmeli,
--Günlük
create procedure sp_DailyCategory(@Day int)
as
begin
select c.Fault, COUNT(pc.ProductID)  from ProductCategorie pc 
inner join Categorie c on c.ID = pc.CategoriID 
inner join Product p on pc.ProductID = p.ID
where  DAY(p.DueDate) = @Day group by c.Fault
end

--sp_DailyCategory 14

--Aylık
create proc sp_MonthlyCategory(@Month int)
as
begin
select c.Fault, COUNT(pc.ProductID)  from ProductCategorie pc 
inner join Categorie c on c.ID = pc.CategoriID 
inner join Product p on pc.ProductID = p.ID
where  Month(p.DueDate) = @Month group by c.Fault
end

--sp_MonthlyCategory 5

--Yıllık
create proc sp_YearlyCategory(@Year int)
as
begin
select c.Fault, COUNT(pc.ProductID)  from ProductCategorie pc 
inner join Categorie c on c.ID = pc.CategoriID 
inner join Product p on pc.ProductID = p.ID
where  Year(p.DueDate) = @Year group by c.Fault
end

--sp_YearlyCategory 2022

--•	Günlük tahsilat ve ciro raporu oluşturan sorgu,
create proc sp_EarningsOfDay(@Day int)
as
begin
select sum(price) from Record r
inner join Product p on r.ProductID= p.ID
where  DAY(p.DueDate) = @Day 
end

--sp_EarningsOfDay 14

--•	Teknik servis personeli, kişi bazlı, aylık performans raporu hazırlayan sorgu
create view vw_PersonelPerformence
as
select PersoneLlID, COUNT(*) Jobs , MONTH() Month from TechincalReport tr group by PersonelID,MONTH()

select * from vw_PersonelPerformence