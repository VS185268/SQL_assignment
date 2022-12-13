create table TLHierarchy(Eid int primary key identity,
 name nvarchar(50),
 Mid int foreign key references TLHierarchy(Eid))

Insert into TLHierarchy values ('John', NULL)
Insert into TLHierarchy values ('Mark', NULL)
Insert into TLHierarchy values ('Steve', NULL)
Insert into TLHierarchy values ('Tom', NULL)
Insert into TLHierarchy values ('Lara', NULL)
Insert into TLHierarchy values ('Simon', NULL)
Insert into TLHierarchy values ('David', NULL)
Insert into TLHierarchy values ('Ben', NULL)
Insert into TLHierarchy values ('Stacy', NULL)
Insert into TLHierarchy values ('Sam', NULL)


Update TLHierarchy Set Mid = 8 Where name IN ('Mark', 'Steve', 'Lara')
Update TLHierarchy Set Mid = 2 Where name IN ('Stacy', 'Simon')
Update TLHierarchy Set Mid = 3 Where name IN ('Tom')
Update TLHierarchy Set Mid = 5 Where name IN ('John', 'Sam')
Update TLHierarchy Set Mid = 4 Where name IN ('David')
--Here we are writing the query for getting the organizational hierarchy 
-- here the hierarchial query can be written by using the Common Table Expressions(CTE)
Declare @EID int
Set @EID=7;
With EmployeeCTE(Eid,name,Mid) as
( select Eid,name,Mid from TLHierarchy where Eid=@EID
union all
 select TLHierarchy.Eid,TLHierarchy.Name as name,TLHierarchy.Mid
 from TLHierarchy
 join EmployeeCTE on TLHierarchy.Eid=EmployeeCTE.Mid
)
Select E1.Name, ISNULL(E2.Name, 'No Boss') as ManagerName
From EmployeeCTE E1
LEFT Join EmployeeCTE E2
ON E1.Mid = E2.Eid