create table order( id INT(10), idCustomer INT(10), Primary key (id), date DATE); 
alter table orders add foreign key (idCustomer) references customer (id);

create table orderProducts(idOrder INT, idProduct INT, QuantityProduct INT);
alter table orderProducts add foreign key (idOrder) references orders(id);
alter table orderProducts add foreign key (idProduct) references product(id);
Foreign key (idProduct) references product(id), 

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

 CREATE PROCEDURE `addOrderProduct`(IN paramIdOrder INT, IN paramIdProduct INT, IN paramQuantity INT)
 MODIFIES SQL DATA
    BEGIN
   insert into orderProducts (IdOrder, IdProduct, QuantityProduct) values (paramIdOrder,  paramIdProduct, paramQuantity);
    END//

delimiter //

mysqldump -u root -p masterkey shop > dump.sql
mysqldump --no-data -u root -p shop > shopNoData.sql
