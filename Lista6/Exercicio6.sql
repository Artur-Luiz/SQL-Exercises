/*

 Exercicio 7 

1. Faça um script:
    a. Excluindo todos os clientes que não compraram nada ainda;
    b. Excluindo todos os fornecedores que não forneceram nenhum produto;
    c. Atualizando o valor de venda pelo preço original do produto;
    d. Acrescentando a tabela do fornecedor o campo dsstatus (10);
    e. Atualizando o status do fornecedor para ‘INATIVO’ nos fornecedores que não
    forneceram nenhum produto.
    f. Faça o script que atualize o campo endereço do cliente para
    ‘DESCONHECIDO’ onde o endereço for NULO.
    g. Faça o script que insira todos os produtos em todos os pedidos. Quantidade
    10 e preço original do produto.


2. Faça as seguintes consultas:
    a. Todos os produtos comprados por cliente (nome), com o número de vezes que
    foi comprado, a quantidade total comprada e o valor total já pago por aquele
    produto;
    b. O número de pedidos e o total comprado por cliente (nome) no ano de 2003;
    c. O nome do fornecedor, seu telefone, o nome do produto, seu preço e a
    quantidade em estoque, o fornecedor deve aparecer mesmo que não tenha
    nenhum produto;
    d. O nome do cliente, a data do pedido e o valor total, o cliente deve aparecer
    mesmo que não tenha feito nenhum pedido.

*/

USE treinamento

--1a.
DELETE FROM CUSTOMER
WHERE CDCUSTOMER NOT IN (SELECT CDCUSTOMER FROM REQUEST)

--1b.
DELETE FROM SUPPLIER
WHERE CDSUPPLIER NOT IN (SELECT CDSUPPLIER FROM PRODUCT)

--1c.
UPDATE PRODUCTREQUEST
SET VLUNITARY = p.VLPRICE
FROM PRODUCT p
WHERE PRODUCTREQUEST.CDPRODUCT = p.CDPRODUCT

--1d.
ALTER TABLE SUPPLIER
ADD DSSTATUS VARCHAR(10)

--1e.
UPDATE SUPPLIER
SET DSSTATUS = 'INATIVO'
WHERE CDSUPPLIER NOT IN (SELECT CDSUPPLIER FROM PRODUCT)

--1f.
UPDATE CUSTOMER
SET NMADRESS = 'DESCONHECIDO'
WHERE NMADRESS IS NULL

--1g.
INSERT INTO PRODUCTREQUEST (CDPRODUCT, CDREQUEST, VLUNITARY, QTAMOUNT) 
SELECT CDPRODUCT, CDREQUEST, VLPRICE, 10
FROM PRODUCT p
CROSS JOIN REQUEST r

-----------------------------------------------------------------------------------------

--2a.
SELECT c.NMCUSTOMER, p.NMPRODUCT, COUNT(*) AS QTAMOUNT, SUM(qtamount) AS QTTOTAL, SUM(qtamount * vlunitary) AS VLTOTAL
FROM CUSTOMER c
INNER JOIN REQUEST r ON c.CDCUSTOMER = r.CDCUSTOMER
INNER JOIN PRODUCTREQUEST pr ON r.CDREQUEST = pr.CDREQUEST
INNER JOIN PRODUCT p ON pr.CDPRODUCT = p.CDPRODUCT
GROUP BY c.NMCUSTOMER, p.NMPRODUCT

--2b.
SELECT c.NMCUSTOMER, COUNT(*) AS QTAMOUNT, SUM(qtamount) AS QTTOTAL
FROM CUSTOMER c
INNER JOIN REQUEST r ON c.CDCUSTOMER = r.CDCUSTOMER
INNER JOIN PRODUCTREQUEST pr ON r.CDREQUEST = pr.CDREQUEST
WHERE YEAR(r.DTREQUEST) = 2003
GROUP BY c.NMCUSTOMER

--2c.
SELECT s.NMSUPPLIER, s.IDFONE, p.NMPRODUCT, p.VLPRICE, p.QTSTOCK
FROM SUPPLIER s
LEFT JOIN PRODUCT p ON s.CDSUPPLIER = p.CDSUPPLIER

--2d.
SELECT c.NMCUSTOMER, r.DTREQUEST, SUM(QTAMOUNT * VLUNITARY) AS VLTOTAL
FROM CUSTOMER c
LEFT JOIN REQUEST r ON c.CDCUSTOMER = r.CDCUSTOMER
LEFT JOIN PRODUCTREQUEST pr ON r.CDREQUEST = pr.CDREQUEST
GROUP BY c.NMCUSTOMER, r.DTREQUEST



