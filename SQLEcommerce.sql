-- ETicaret Veritabanı
-- Ürünün kendine ait 5 kolonu olacak
-- ÜRünün birden fazla kategorisi olabilir.
-- Her kategorinin üst veya alt kategorisi olabilir.
-- Kullanıcıların en az 4 kolonu olacak.
-- Kullanıcılar ürünleri favoriye ekleyebilecek. ( Favori tablosu )
-- Kullanıcılar siteden bir veya birden fazla ürün alabilir. (Sipariş, sipariş detay tabloları)
-- Şehir ve ilçe tabloları olacak. siparişin ilçe id si olacak **

-- Kullanıcıların en az 4 kolonu olacak.

Create Table Customer(
ID int PRIMARY KEY IDENTITY (1,1),
CustomerName Nvarchar (max),
Surname Nvarchar (max),
CustomerAddress  Nvarchar(20),
GivenDate Datetime
)

-- Ürünün kendine ait 5 kolonu olacak

Create Table Product (
ID int PRIMARY KEY IDENTITY (1,1),
ProductName nvarchar (max),
UnitPrice Money NOT NULL, -- Fiyat olarak belirtilmek zorunda boş geçilemez.
UnitStock int not null, 
ProductionPlace nvarchar (max)
)

-- Kategori eklendi
Create Table Category
(
    ID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(max) NOT NULL,
    Description NVARCHAR(max) NOT NULL,
    BebyCategory INT
)

-- Ürünler ve  Kategori tablosu her ürünün bir kategorisi olabilir
Create Table ProductCategory (
ProductID int,
CategoryID int
)

-- Kullanıcılar ürünleri favoriye ekleyebilecek. ( Favori tablosu )

Create table Favorite (
CustomerID int,
ProductID int
)


-- Ürün Sepeti 
Create Table ProductCart (
ID int PRIMARY KEY IDENTITY (1,1),
ProductID int,
Quantity int
)

Create Table Orderlist (
ID int PRIMARY KEY IDENTITY (1,1),
ProductCartID int,
CategoryName nvarchar(max),

TotalPrice money
)

-- Şehir ve ilçe tabloları olacak. siparişin ilçe id si olacak **
Create Table City
(
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(20) NOT NULL,
    CountryID INT NOT NULL
)


Create Table District (
ID int PRIMARY KEY IDENTITY (1,1),
DistrictName NVARCHAR (12),
)
