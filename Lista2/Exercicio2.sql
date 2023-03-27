USE treinamento;

-- a. O nome e telefone de todos os clientes em que o telefone começa com o dígito 4;
SELECT NMCUSTOMER, IDFONE FROM CUSTOMER WHERE IDFONE LIKE '4%';

-- b. Todas as colunas dos clientes que não possuem telefone cadastrado;
SELECT * FROM CUSTOMER WHERE IDFONE IS NULL;

-- c. O nome e o telefone dos fornecedores em que o DDD não foi cadastrado;
SELECT NMSUPPLIER, IDFONE FROM SUPPLIER WHERE IDFONE NOT LIKE '%-%';

-- d. O nome, quantidade em estoque e o preço com desconto de 10% dos produtos que tem mais de 2000 unidades em estoque;
SELECT NMPRODUCT, QTSTOCK, VLPRICE * 0.9 FROM PRODUCT WHERE QTSTOCK > 2000;

-- e. O nome e o preço dos produtos com preço entre 10 e 20 reais;
SELECT NMPRODUCT, VLPRICE FROM PRODUCT WHERE VLPRICE BETWEEN 10 AND 20;

-- f. O nome do produto, o preço e o preço total do estoque dos produtos com preço acima de 50 reais;
SELECT NMPRODUCT, VLPRICE, VLPRICE * QTSTOCK
FROM PRODUCT
WHERE VLPRICE > 50;

-- g. O nome do produto, o nome do fornecedor e o telefone do fornecedor dos produtos com preço acima de 20 reais e que tenham mais de 1500 unidades em estoque;
SELECT p.NMPRODUCT, s.NMSUPPLIER, s.IDFONE
FROM PRODUCT p, SUPPLIER s
WHERE p.CDSUPPLIER = s.CDSUPPLIER AND p.VLPRICE > 20 AND p.QTSTOCK > 1500;

-- h. O nome do cliente, a data do pedido e o valor total do pedido para pedidos feitos entre junho e julho de 2003;
SELECT c.NMCUSTOMER, R.DTDELIVER, R.VLTOTAL
FROM CUSTOMER c, REQUEST R
WHERE c.CDCUSTOMER = R.CDCUSTOMER AND R.DTDELIVER BETWEEN '2003-06-01' AND '2003-07-31';

-- i. O nome do cliente, o nome do produto, a data do pedido, a quantidade pedida, o valor unitário de venda dos produtos e o valor total do produto pedido, cujas unidades pedidas por pedido seja maior que 500.
SELECT c.NMCUSTOMER, p.NMPRODUCT, r.DTREQUEST, pr.QTAMOUNT, pr.VLUNITARY, pr.QTAMOUNT * pr.VLUNITARY AS VLTOTAL
FROM CUSTOMER c, PRODUCT p, REQUEST r, PRODUCTREQUEST pr
WHERE c.CDCUSTOMER = r.CDCUSTOMER AND p.CDPRODUCT = pr.CDPRODUCT AND r.CDREQUEST = pr.CDREQUEST AND pr.QTAMOUNT > 500;