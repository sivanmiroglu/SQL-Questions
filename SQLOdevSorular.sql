
-- ÖDEV SORULAR * 

--1) ürünleri ada göre sırala

select * from Products order by ProductName

--2) ürünleri ada göre tersten sırala

select * from Products order by ProductName desc

--3) ürün fiyatı 20 den büyük ve categoryid si 3 olan ürünleri fiyata göre sırala

select * from Products where UnitPrice > 20 and CategoryID = 3

--4) en pahalı 5 ürünü getir

select top 5 * from Products order by UnitPrice desc

--5) En pahalı ürünümün fiyatı

select top 1 * from Products order by UnitPrice desc

--6) En ucuz ürünümün fiyatı

select top 1 * from Products order by UnitPrice 

--7) En ucuz ürünümün KDV li fiyatı nedir?

select top 1 UnitPrice*1.18 from Products order by UnitPrice

--8) 1996 yılındaki siparişleri getir

select * from Orders where YEAR(OrderDate) = 1996

--9) 1997 yılının Mart ayının siparişlerini getir

select * from Orders where Year(OrderDate) = 1997 and MONTH(OrderDate) = 3

--10) ShipCity - 1997 yılında Londra'ya kaç adet sipariş gitti?

select * from Orders where YEAR(OrderDate) = 1997 and ShipCity='London'

--11) ProductID si 5 olan ürünün kategori adı nedir

select  c.CategoryName from Products as p
inner join Categories as c
on p.ProductID = c.ID
where ProductID =5


--12) Ürün adı ve ürünün kategorisinin adı

select p.ProductName, c.CategoryName from Products as p 
inner join Categories as c 
on p.ProductID = c.ID

--13) Ürünün adı, kategorisinin adı ve tedarikçisinin adı

select p.ProductName ,c.CategoryName, s.ContactName  from Products as p 
inner join Categories as c on p.CategoryID= c.ID 
inner join Suppliers as s on s.SupplierID = p.SupplierID
 
--14) Siparişi alan personelin adı,soyadı, sipariş tarihi. Sıralama sipariş tarihine göre

select FirstName, LastName, o.OrderDate  from Employees as e 
inner join Orders o on e.EmployeeID = o.EmployeeID  order by OrderDate

--15) Son 5 siparişimin ortalama fiyatı nedir? (sepet toplamı ortalaması)

 select TOP 5  AVG(od.Quantity * od.UnitPrice) Toplam   from [Order Details] as od 
 inner join Orders o on  od.OrderID = o.OrderID   group by od.OrderID  order by od.OrderID desc

--16) Ocak ayında satılan ürünlerimin adı ve kategorisinin adı ve toplam satış miktarı nedir?

select p.ProductName, c.CategoryName, od.Quantity from Products as p 
inner join Categories as c on c.ID = p.CategoryID 
inner join [Order Details] as od on od.ProductID = p.ProductID
inner join Orders as ord on ord.OrderID = od.OrderID  where MONTH(OrderDate) = 01

select SUM( od.Quantity) from Products as p 
inner join Categories as c on c.ID = p.CategoryID 
inner join [Order Details] as od on od.ProductID = p.ProductID
inner join Orders as ord on ord.OrderID = od.OrderID  where MONTH(OrderDate) = 01 -- ürünlerin adı ve toplam satış miktarı listele.

--17) Hangi personelim hangi personelime rapor veriyor?

select es.EmployeeID , e.LastName , e.FirstName from Employees e
inner join Employees es on e.EmployeeID = es.ReportsTo

--18) Hangi ülkeden kaç müşterimiz var (distinc ve count kullanılacak)

 select DISTINCT country, COUNT(*) as Count from Customers group by Country

--19) Ortalama satış miktarımın üzerindeki satışlarım nelerdir? (order details tablosu)

select * from [Order Details] where  Quantity > (select  avg(Quantity) from  [Order Details])

--20) En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı (4 tablo birleşimi)

select top 1 ProductName, CategoryName, ContactName from Products p 
inner join [Order Details] od on od.ProductID = p.ProductID 
inner join Categories c on c.ID = p.CategoryID 
inner join Suppliers s on s.SupplierID = p.SupplierID order by od.Quantity desc

--21) 10248 numaralı siparişi alan çalışanın adı ve soyadı ve orderid

select e.FirstName, e.LastName ,o.OrderID from Employees e 
inner join orders o on o.EmployeeID = e.EmployeeID
where o.OrderID = 10248

--22) 1996 yılında, 5 numaralı ID ye sahip çalışanım kaç adet sipariş aldı?
	
select SUM(Quantity) SiparisAdedi from [Order Details] od 
inner join orders o on o.OrderID = od.OrderID
inner join Employees e on e.EmployeeID = o.EmployeeID
inner join Products p on p.ProductID = od.ProductID
where YEAR(o.OrderDate) = 1996 and e.EmployeeID =5

--23) 1997 yılında kim ne kadar sipariş geçti (EmployeeID, Count)

select e.EmployeeID ,SUM(Quantity) SiparisAdedi from [Order Details] od 
inner join orders o on o.OrderID = od.OrderID
inner join Employees e on e.EmployeeID = o.EmployeeID
inner join Products p on p.ProductID = od.ProductID
where YEAR(o.OrderDate) = 1997 group by e.EmployeeID

--24) 10248 numaralı siparişin ürünlerinin adları ve sipariş miktarı

select p.ProductName , od.Quantity from Products p 
inner join [Order Details] od on od.ProductID = p.ProductID
where od.OrderID = 10248

--25) 10248 numaralı siparişin toplam fiyatı

select SUM(UnitPrice * Quantity) from Orders o 
inner join  [Order Details] od
on  o.OrderID = od.OrderID where o.OrderID = 10248

--26) 1996 yılında cirom

select SUM(UnitPrice * Quantity) from [Order Details] od inner join
Orders o
on o.OrderID = od.OrderID where YEAR(o.OrderDate) = 1996

--27) 1996 yılında en çok ciro yapan employeeID

select top 1 e.EmployeeID ,SUM(od.UnitPrice * od.Quantity) Ciro from [Order Details] od
inner join Orders o
on o.OrderID = od.OrderID
inner join Employees e
on e.EmployeeID = o.EmployeeID
where YEAR(o.OrderDate) = 1996 group by e.EmployeeID  order by ciro desc

--28) 1997 Mart ayındaki siparişlerimin ortalama fiyatı nedir?

select AVG(od.UnitPrice * od.Quantity) from [Order Details] od 
inner join orders o on o.OrderID = od.OrderID
inner join Products p on p.ProductID = od.ProductID
where YEAR(o.OrderDate) = 1997 and MONTH(o.OrderDate) = 03

--29) 1997 yılındaki aylık satışları sırala. Ocak - 500 gibi toplamda 12 satır olacak

select MONTH(o.OrderDate) Ay, sum(od.UnitPrice * od.Quantity) Satis from [Order Details] od 
inner join Orders o on o.OrderID = od.OrderID 
where YEAR(o.OrderDate) = 1997 Group by MONTH(o.OrderDate) order by (MONTH(o.OrderDate))


--30) En değerli MÜŞTERİMİN adı ve soyadı (orders,orderdetails,customers)

select c.ContactName , sum(od.UnitPrice * od.Quantity) Tutar  from Customers c 
inner join Orders o on o.CustomerID = c.CustomerID 
inner join [Order Details] od on od.OrderID = o.OrderID 
group by c.ContactName order by Tutar desc