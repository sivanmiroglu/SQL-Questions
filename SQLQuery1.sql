--Öğrenci => Ad, Soyad, No, EMail, Telefon, DogumTarih
--Eğitmen => Ad, Soyad
--Bölüm => Ad, Kurulus Tarih
-- Fakulte => Ad

--Not: Bir bölüm sadece bir fakülteye aittir.
-- Bir eğitmen aynı anda iki bölüme ait olabilir.
-- Bir öğrencinin sadece bir bölümü vardır.

--Sorgular
-- Öğrenci Ad, Soyad, Bölüm Ad, Fakülte Ad
-- Eğitmen Ad, Bölüm Ad
-- Fen Fakültesindeki EĞİTMENLERİ LİSTELE
-- Fakülte ekleyen bir store procedure yaz
-- Herhangi bir fakülte eklendiğinde ekrana 'Yeni bir fakülte eklendi!' yazsın (TRIGGER)
-- Bölüm ID, Ad, Fakülte Ad isimli 3 kolonu olan bir VIEW yaz

Create table  Student (
ID int PRIMARY KEY IDENTITY(1,1),
FirstName nvarchar(25),
LastName nvarchar(25),
StundentNumber nvarchar(10),
EMail nvarchar (20),
Number nvarchar (11),
BirthDay date,
DeparmentID  int NOT NULL
)

CREATE TABLE Academician (
ID int PRIMARY KEY IDENTITY(1,1),
FirstName nvarchar(25),
LastName nvarchar(25)
)

CREATE TABLE Department (
ID int PRIMARY KEY IDENTITY(1,1),
DepartmentName nvarchar (30),
PublishDate date,
FacultyID int NOT NULL
)

CREATE TABLE Faculty
(
ID int PRIMARY KEY IDENTITY(1,1),
FacultyName nvarchar (25),
)

create TABLE AcademicianDepartment (
ID int PRIMARY KEY IDENTITY(1,1),
AcademicianID int,
DepartmentID int

)

insert into AcademicianDepartment(AcademicianID,DepartmentID) values(1,2)

insert into Student(FirstName,LastName,StundentNumber,DeparmentID) values ('Burak','Kızılhan',1232,1)

insert into Student(FirstName,LastName,StundentNumber,DeparmentID) values ('Ahmet','Cayar',1432,2)

insert into Student(FirstName,LastName,StundentNumber,DeparmentID) values ('Mahmut','Aynacı',1764,3)

insert into Academician(FirstName,LastName) values('İlber','Ortaylı')

insert into Academician(FirstName,LastName) values('Cem','Kurt')

insert into Academician(FirstName,LastName) values('Can','Özcan')

insert into Department(DepartmentName,PublishDate,FacultyID) values('Park ve Bahçeler Müdürlüğü','1992',1)

insert into Department(DepartmentName,PublishDate,FacultyID) values('Rehberlik','1999',2)

insert into Department(DepartmentName,PublishDate,FacultyID) values('Fen','2021',3)

insert into Department(DepartmentName,PublishDate,FacultyID) values('Fizik','2021',7)

insert into Faculty(FacultyName) values('Çevrecilik')

insert into Faculty(FacultyName) values('Fen')

insert into Faculty(FacultyName) values('Okuma')

insert into AcademicianDepartment(AcademicianID,DepartmentID) values(3,4)


-- Öğrenci Ad, Soyad, Bölüm Ad, Fakülte Ad
select s.FirstName,s.LastName,d.DepartmentName,f.FacultyName from Student s 
inner join Department d on s.DeparmentID = d.ID
inner join Faculty f on f.ID  = d.FacultyID 

-- Eğitmen Ad, Bölüm Ad
select a.FirstName ,d.DepartmentName  from Academician a 
inner join AcademicianDepartment ad on ad.AcademicianID = a.ID
inner join Department d on d.ID = ad.DepartmentID

-- Fen Fakültesindeki EĞİTMENLERİ LİSTELE
select f.FacultyName,a.ID, a.FirstName,a.LastName from AcademicianDepartment ad
inner join Academician a on a.ID = ad.AcademicianID 
inner join Department d on d.ID = ad.DepartmentID
inner join Faculty f on f.ID = d.FacultyID where f.FacultyName like '%Fen%'

-- Fakülte ekleyen bir store procedure yaz
CREATE PROCEDURE sp_AddFaculty(@Name nvarchar(25))
as
begin 
insert into Faculty (FacultyName) values (@Name)
end

sp_AddFaculty 'Hayvanları Koruma'

-- Herhangi bir fakülte eklendiğinde ekrana 'Yeni bir fakülte eklendi!' yazsın (TRIGGER)

create trigger trg_add__faculty
on Faculty 
after insert
as
begin
print ('Yeni bir fakülte eklendi!')
end

-- Bölüm ID, Ad, Fakülte Ad isimli 3 kolonu olan bir VIEW yaz

create view vw_DepartmentandFaculty1
as
select d.ID,d.DepartmentName,f.FacultyName from Department d 
inner join Faculty f on f.ID = d.FacultyID 

select * from vw_DepartmentandFaculty