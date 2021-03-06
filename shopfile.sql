create table order( id INT(10), idCustomer INT(10), Primary key (id), date DATE); 
alter table orders add foreign key (idCustomer) references customer (id);

create table orderProducts(idOrder INT, idProduct INT, QuantityProduct INT);
alter table orderProducts add foreign key (idOrder) references orders(id);
alter table orderProducts add foreign key (idProduct) references product(id);
Foreign key (idProduct) references product(id), 
alter table orderProducts DROP PRIMARY KEY, ADD PRIMARY KEY (idOrder, idProduct);

delimiter //

mysqldump -u root -p masterkey shop > dump.sql
mysql -u root -p shop < createQueryProcedure.sql

mysql -u root -p shop < c:\SD\addOrderProducts.sql
mysqldump --no-data -u root -p shop > shopNoData.sql

 CREATE PROCEDURE `addProduct`(IN paramName varchar(10), IN paramIdCategory INT, IN paramPrice INT) MODIFIES SQL DATA
    BEGIN
   insert into product (name, idCategory, price) values (paramName, paramIdCategory, paramPrice);
    END//


 CREATE PROCEDURE `addOrder`(IN paramIdCustomer INT, IN paramDate Date)
 MODIFIES SQL DATA
    BEGIN
   insert into orders (idCustomer, date) values (paramIdCustomer, paramDate);
    END//

 CREATE PROCEDURE `addCustomer`(IN paramName varchar(20))
 MODIFIES SQL DATA
    BEGIN
   insert into customer (name) values (paramName);
    END//

 CREATE PROCEDURE `addOrderProduct`(IN paramIdOrder INT,
									 IN paramIdProduct INT, 
									 IN paramQuantity INT)
 MODIFIES SQL DATA
    BEGIN
   insert into orderProducts (IdOrder, IdProduct, QuantityProduct) values (paramIdOrder,  paramIdProduct, paramQuantity);
    END//

alter table customer
RENAME TABLE customer TO customerCC;

alter table product change name name varchar(20) not null

alter table product change idCategory idCategory INT not null;
alter table product change price price INT not null;

alter table product change date date DATE not null;

alter table product change QuantityProduct QuantityProduct INT not null;

