select * from orders o, customer c where (o.idCustomer = c.id) and (c.name ="John Koy");
select o.idOrder, o.idProduct, p.name, o.QuantityProduct from orderProducts o, product p where (p.id = o.idProduct) and (o.idOrder = 6);


SELECT  o.idProduct, p.name, sum(o.QuantityProduct) as qty
FROM orderProducts o, product p
where o.idProduct = p.id
GROUP BY o.idProduct
ORDER BY sum(o.QuantityProduct) desc
LIMIT 3;

SELECT  o.idProduct, p.name, count(o.QuantityProduct) as qty
FROM orderProducts o, product p, orders op
where (o.idProduct = p.id)and (o.idOrder = op.id) 
and (YEAR(op.date) = 2015 )AND (MONTH(op.date) = 11)
GROUP BY o.idProduct
ORDER BY count(o.QuantityProduct) desc
LIMIT 1;

CREATE PROCEDURE `countOrderTotalCost`(IN paramIdOrder INT)
select o.id, o.date, sum(p.price*oP.QuantityProduct) as summm
from orders o, product p, orderProducts oP
where  (p.id = oP.idProduct) and (o.id = oP.idOrder) and o.id=paramIdOrder;
 END//

CREATE PROCEDURE `selectPopularProductInCategory`(IN paramYear INT, IN paramMonth INT,)
    BEGIN
select nameProduct, nameCategory, qty
from (
SELECT  p.name as nameProduct, max(sum(o.QuantityProduct)) as qty, c.name as nameCategory FROM orderProducts o, product p, category c where (o.idProduct = p.id)and (c.id = p.idCategory) GROUP BY p.name ORDER BY nameCategory desc 

) 
 END//

CREATE PROCEDURE `selectPopularProductInEachCategory`()
    BEGIN
select * 
from(
SELECT p.id as idProduct, p.name as nameProduct, sum(o.QuantityProduct) as qty, c.name as nameCategory
FROM orderProducts o, product p, category c
 where (o.idProduct = p.id)and (c.id = p.idCategory) 
 GROUP BY nameProduct
 ORDER BY qty desc ) x group by nameCategory;

END//



































