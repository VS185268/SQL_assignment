
--As to create the sample tables for manipulation of data
create table ITEM_SALES(Item_iD Int,Name varchar(100),Sales_Date date,Sales_price int);
insert into ITEM_SALES values(1,'Apple','2022-12-10',50);
insert into ITEM_SALES values(1,'Apple','2022-11-1',50);
insert into ITEM_SALES values(2,'Pear','2022-12-31',100);
insert into ITEM_SALES values(2,'pear','2022-12-3',100);
insert into ITEM_SALES values(3,'grapes','2022-12-10',50);





create table ITEM_DISCOUNT(Item_iD Int,Name varchar(100),discount_Price int ,Date_From date,Date_To date);
insert into ITEM_DISCOUNT values(1,'Apple',10,'2022-12-1','2022-12-31');
insert into ITEM_DISCOUNT values(2,'Pear',20,'2022-12-1','2022-12-5');



-- Query to get required table
select S.Item_iD,S.Name,
Case
	When S.Sales_Date Between D.Date_From and D.Date_To Then S.Sales_price-D.discount_Price
	else S.Sales_price
END 
as OverallPrice

	from [dbo].ITEM_SALES as S
full outer join [dbo].ITEM_DISCOUNT as D
on S.Item_ID=D.Item_iD;