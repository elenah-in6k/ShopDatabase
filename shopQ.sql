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

