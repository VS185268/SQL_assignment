create or alter procedure UpdateOrCreate(@data Tabletype readonly)
as 
begin
	declare @i int=1 ,@len int;
	select @len=Count(*) from @data
	while @i<=@len
	begin 
		if exists(select empid from Employees where empid=(select id from @data where slnum=@i))
			begin 
			update Employees set Employees.empname=(select name from @data where slnum=@i),Employees.salary=(select sal from @data where slnum=@i)
			where Employees.empid=(select id from @data where slnum=@i)
			end
		else 
			begin insert into Employees(empid,empname,salary) 
			select id,name,sal from @data
		end
		set @i=@i+1;
	end
end
---inserting data into the tables
declare @obj as Tabletype
insert into @obj values(1,'saiteja',143738)
insert into @obj values(2,'aish',93987)
insert into @obj values(3,'Yash',80755)
insert into @obj values(4,'akhila',20020)
insert into @Obj values(5,'Abhiram',22138)
exec UpdateOrCreate @obj
select * from Employees;

--inserting data into the tables
declare @obj2 as Tabletype
insert into @obj2 values(1,'saiteja',10)
insert into @obj2 values(2,'aish',123)
exec UpdateOrCreate @obj2
select * from Employees;

-- for inserting null values at empid and empname the we get an error that error is handled by using try catch blocks
begin try 
declare @obj3 as Tabletype
insert into @obj3 values(1,null,10)
exec UpdateOrCreate @obj3
select * from Employees;
end try
begin catch 
print 'The error message:'+Error_message();
print error_line();
print error_number();
print 'Error occured procedure:'+error_procedure();
end catch






--for creating the Employees 
create table Employees(empid int not null,empname varchar(20) not null,salary int);
--drop table Employees;
-- for creating the tabletype
create type Tabletype as table
(id int,name varchar(20),sal int,slnum int identity(1,1));






