delimiter //
/* addProduct */
drop procedure `addProduct` ;//
CREATE PROCEDURE `addProduct`(IN paramName varchar(10), IN paramIdCategory INT, IN paramPrice INT) MODIFIES SQL DATA
    BEGIN
   insert into product (name, idCategory, price) values (paramName, paramIdCategory, paramPrice);
    END//

/* addOrder */
drop procedure `addOrder` ;//
 CREATE PROCEDURE `addOrder`(IN paramIdCustomer INT, IN paramDate Date)
 MODIFIES SQL DATA
    BEGIN
   insert into orders (idCustomer, date) values (paramIdCustomer, paramDate);
    END//

/* addCustomer */
drop procedure `addCustomer` ;//
 CREATE PROCEDURE `addCustomer`(IN paramName varchar(20))
 MODIFIES SQL DATA
    BEGIN
   insert into customer (name) values (paramName);
    END//

/* addOrderProduct */
drop procedure `addOrderProduct` ;//
 CREATE PROCEDURE `addOrderProduct`(IN paramIdOrder INT, IN paramIdProduct  INT, IN paramQuantity INT)
 MODIFIES SQL DATA
    BEGIN
   insert into orderProducts (IdOrder, IdProduct, QuantityProduct) values (paramIdOrder,  paramIdProduct, paramQuantity);
    END//

/* 1 selectOrderByCustomerName*/
drop  PROCEDURE selectOrderByCustomerName;//
CREATE PROCEDURE `selectOrderByCustomerName`(IN paramName varchar(20))
    BEGIN
select * from orders o
join customer c 
on (o.idCustomer = c.id)
where  (c.name =paramName);
    END//

/* 2 selectProductByOrderId*/
drop  PROCEDURE selectProductByOrderId;//
CREATE PROCEDURE `selectProductByOrderId`(IN paramIdOrder INT)
    BEGIN
select o.idOrder, o.idProduct, p.name, o.QuantityProduct 
from orderProducts o
join product p
on (p.id = o.idProduct)
 where  (o.idOrder = paramIdOrder);
    END//

/* 3 Top 3*/	
drop  PROCEDURE `selectTop3ProductInOrderSum`;//
CREATE PROCEDURE `selectTop3ProductInOrderSum`()
    BEGIN
SELECT  o.idProduct, p.name, sum(o.QuantityProduct) as qty
FROM orderProducts o
join product p
on o.idProduct = p.id
GROUP BY o.idProduct
ORDER BY sum(o.QuantityProduct) desc
LIMIT 3;
    END//

drop  PROCEDURE `selectTop3ProductInOrderCount`;//	
CREATE PROCEDURE `selectTop3ProductInOrderCount`()
    BEGIN
SELECT  o.idProduct, p.name, count(o.QuantityProduct) as qty
FROM orderProducts o, product p
where o.idProduct = p.id
GROUP BY o.idProduct
ORDER BY count(o.QuantityProduct) desc
LIMIT 3;
    END//
	
/* 4 selectProductByCategory*/
drop PROCEDURE `selectProductByCategory`;//
CREATE PROCEDURE `selectProductByCategory`(IN paramName varchar(20))
    BEGIN
select p.name as product_name, c.name as category_name
from product p
left Join category c
on p.idCategory = c.id
where c.name = paramName;
 END//

/* 5 selectPopularProductInEachCategory */	
drop PROCEDURE `selectPopularProductInEachCategory`;//
CREATE PROCEDURE `selectPopularProductInEachCategory`()
    BEGIN
select * 
from(
SELECT p.id as idProduct, p.name as nameProduct, sum(o.QuantityProduct) as qty, c.name as nameCategory
FROM orderProducts o
join product p
on (o.idProduct = p.id)
join category c
 on (c.id = p.idCategory) 
 GROUP BY nameProduct
 ORDER BY qty desc ) x group by nameCategory;
END//

/* 6 selectPopularProductInMonth*/
drop PROCEDURE `selectPopularProductInMonth`;//
CREATE PROCEDURE `selectPopularProductInMonth`(IN paramYear INT, IN paramMonth INT)
    BEGIN
SELECT  o.idProduct, p.name, sum(o.QuantityProduct) as qty
FROM orderProducts o, product p, orders op
where (o.idProduct = p.id)and (o.idOrder = op.id) 
and (YEAR(op.date) = paramYear )AND (MONTH(op.date) = paramMonth)
GROUP BY o.idProduct
ORDER BY sum(o.QuantityProduct) desc
LIMIT 1;
 END//

/* 7 countOrderTotalCost */
drop PROCEDURE `countOrderTotalCost`;//
CREATE PROCEDURE `countOrderTotalCost`(IN paramIdOrder INT)
begin
select o.id, o.date, sum(p.price*oP.QuantityProduct*1.1) as summm
from orders o, product p, orderProducts oP
where  (p.id = oP.idProduct) and (o.id = oP.idOrder) and (o.id=paramIdOrder);  END//

/* 8 addOrderProductNew */	
drop PROCEDURE `addOrderProductNew`;//
 CREATE PROCEDURE `addOrderProductNew`(IN paramProductName varchar(20), IN paramQuantity INT)
 MODIFIES SQL DATA
    BEGIN
	DECLARE paramIdOrder INT;
	DECLARE paramIdProduct INT;
set paramIdOrder = (SELECT id FROM `orders` ORDER BY `id` DESC LIMIT 1);
set paramIdProduct = (select id from `product` where name = paramProductName);

if exists (select idOrder, idProduct from orderProducts where (idOrder = paramIdOrder) and (idProduct = paramIdProduct))
Then
update orderProducts set QuantityProduct = (QuantityProduct + paramQuantity) where (idOrder = paramIdOrder) and (idProduct = paramIdProduct);
else

 insert into orderProducts (IdOrder, IdProduct, QuantityProduct) values (paramIdOrder,  paramIdProduct, paramQuantity);
END IF;
   
    END//
delimiter ;
