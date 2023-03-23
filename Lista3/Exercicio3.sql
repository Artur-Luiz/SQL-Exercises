 /*
 
 Exercicio 3
 
 a. O nome do produto, o nome do fornecedor, o preço do produto, o preço com 
 10% de desconto, o preço com 20% de desconto e o preço com 30% de
 desconto para produtos cujo valor com 10% de desconto ultrapasse os 15
 reais, isso ordenado por preço e produto;
 b. O nome do produto, o nome do fornecedor, o preço do produto, o preço total
 do produto no estoque e o preço total para o dobro do estoque para produtos
 com preço total acima de 12000, ordenados por fornecedor e produto;
 c. Todas as colunas dos clientes que possuem telefone cadastrado e começam
 com a letra J, ordenado pelo nome do cliente;
 d. O nome do produto, o preço e o nome do fornecedor dos produtos que o
 fornecedor tenha no nome os caracteres ‘ica’, ordenado por fornecedor e
 preço;
 e. O nome do fornecedor, o fone do fornecedor, o nome do produto, o preço e o
 preço total do produto no estoque para produtos que comecem com a letra S,
 tendo preço acima de 50, ordenado por fornecedor e preço;
 f. O nome do cliente, o nome do produto, a data do pedido, a data de entrega, a
 quantidade pedida, o valor unitário de venda dos produtos e o valor total do
 produto pedido, cujas unidades pedidas por pedido sejam menor que 600 e a
 data do pedido seja no mês de agosto de 2003 e o produto comece com a
 letra M;
 g. O nome do cliente, o nome do produto o nome do fornecedor, a data do
 pedido, a data de entrega e o preço, somente se o fornecedor for de São Paulo
 (011) e o preço seja maior que 20 reais.

 */

USE treinamento

-- a.
SELECT p.NMPRODUCT, s.NMSUPPLIER, p.VLPRICE, p.VLPRICE * 0.9, p.VLPRICE * 0.8, p.VLPRICE * 0.7
FROM PRODUCT p
INNER JOIN SUPPLIER s ON s.CDSUPPLIER = p.CDSUPPLIER
WHERE p.VLPRICE * 0.9 > 15
ORDER BY p.VLPRICE, p.NMPRODUCT;

--b. 
SELECT p.NMPRODUCT, s.NMSUPPLIER, p.VLPRICE, p.VLPRICE * p.QTSTOCK, p.VLPRICE * p.QTSTOCK * 2
FROM PRODUCT p
INNER JOIN SUPPLIER s ON s.CDSUPPLIER = p.CDSUPPLIER
WHERE p.VLPRICE * p.QTSTOCK > 12000
ORDER BY s.NMSUPPLIER, p.NMPRODUCT;

--c.
SELECT *
FROM CUSTOMER
WHERE IDFONE IS NOT NULL AND NMCUSTOMER LIKE 'J%';

--d.
SELECT p.NMPRODUCT, p.VLPRICE, s.NMSUPPLIER
FROM PRODUCT p
INNER JOIN SUPPLIER s ON s.CDSUPPLIER = p.CDSUPPLIER
WHERE s.NMSUPPLIER LIKE '%ica%'
ORDER BY s.NMSUPPLIER, p.VLPRICE;

--e.
SELECT s.NMSUPPLIER, s.IDFONE, p.NMPRODUCT, p.VLPRICE, p.VLPRICE * p.QTSTOCK
FROM PRODUCT p
INNER JOIN SUPPLIER s ON s.CDSUPPLIER = p.CDSUPPLIER
WHERE p.NMPRODUCT LIKE 'S%' AND p.VLPRICE > 50
ORDER BY s.NMSUPPLIER, p.VLPRICE;

--f.
SELECT c.NMCUSTOMER, p.NMPRODUCT, r.DTREQUEST, r.DTDELIVER, pr.QTAMOUNT, pr.VLUNITARY, pr.VLUNITARY * pr.QTAMOUNT
FROM CUSTOMER c
INNER JOIN REQUEST r ON r.CDCUSTOMER = c.CDCUSTOMER
INNER JOIN PRODUCTREQUEST pr ON pr.CDREQUEST = r.CDREQUEST
INNER JOIN PRODUCT p ON p.CDPRODUCT = pr.CDPRODUCT
WHERE pr.QTAMOUNT < 600 AND p.NMPRODUCT LIKE 'M%' AND MONTH(r.DTREQUEST) = 8 AND YEAR(r.DTREQUEST) = 2003;

--g.
SELECT c.NMCUSTOMER, p.NMPRODUCT, s.NMSUPPLIER, r.DTREQUEST, r.DTDELIVER, p.VLPRICE
FROM CUSTOMER c
INNER JOIN REQUEST r ON r.CDCUSTOMER = c.CDCUSTOMER
INNER JOIN PRODUCTREQUEST pr ON pr.CDREQUEST = r.CDREQUEST
INNER JOIN PRODUCT p ON p.CDPRODUCT = pr.CDPRODUCT
INNER JOIN SUPPLIER s ON s.CDSUPPLIER = p.CDSUPPLIER
WHERE s.IDFONE LIKE '(011)%' AND p.VLPRICE > 20;



