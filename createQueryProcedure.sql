delimiter //
 CREATE PROCEDURE `selectProductByOrderId`(IN paramIdOrder INT)
    BEGIN
select o.idOrder, o.idProduct, p.name, o.QuantityProduct 
from orderProducts o, product p where (p.id = o.idProduct) and (o.idOrder = paramIdOrder);
    END//
	
CREATE PROCEDURE `selectOrderByCustomerName`(IN paramName varchar(20))
    BEGIN
select * from orders o, customer c 
where (o.idCustomer = c.id) and (c.name =paramName);

    END//
	
	CREATE PROCEDURE `selectTop3ProductInOrderSum`()
    BEGIN
SELECT  o.idProduct, p.name, sum(o.QuantityProduct) as qty
FROM orderProducts o, product p
where o.idProduct = p.id
GROUP BY o.idProduct
ORDER BY sum(o.QuantityProduct) desc
LIMIT 3;
    END//
	
	CREATE PROCEDURE `selectTop3ProductInOrderCount`()
    BEGIN
SELECT  o.idProduct, p.name, count(o.QuantityProduct) as qty
FROM orderProducts o, product p
where o.idProduct = p.id
GROUP BY o.idProduct
ORDER BY count(o.QuantityProduct) desc
LIMIT 3;
    END//
	
	CREATE PROCEDURE `selectProductByCategory`(IN paramName varchar(20))
    BEGIN
select p.name, c.name
from product p
left Join category c
on p.idCategory = c.id
where c.name = paramName;
 END//
	
	delimiter ;