/*

 Exercicio 7

a. Excluindo todos os pedidos que forem menores que R$ 1.000,00, que não
possuam itens cadastrados e que sejam no mês de junho/2003;
b. Atualizando o preço do produto como sendo a média dos valores unitários de
venda, somente para produtos que venderam menos que 800 unidades;
c. Inserindo os fornecedores como clientes. Utilize como código o valor máximo
mais o código do fornecedor para gerar o código do novo cliente criado a partir
do fornecedor;
d. Atualizando a data de entrega do pedido como sendo a data do pedido + 30
dias para pedidos em que a diferença entre essas duas datas seja menor que
10 dias e o cliente tenha comprado menos que R$ 10.000,00.

*/

USE treinamento

--a.
DELETE FROM REQUEST WHERE VLTOTAL < 1000 AND CDREQUEST NOT IN (SELECT CDREQUEST FROM PRODUCT) AND MONTH(DTREQUEST) = 6 AND YEAR(DTREQUEST) = 2003

--b. 
UPDATE PRODUCT SET VLPRICE = (SELECT AVG(VLUNITARY) FROM PRODUCTREQUEST WHERE CDPRODUCT = PRODUCT.CDPRODUCT) WHERE QTSTOCK < 800

--c.

INSERT INTO CUSTOMER (CDCUSTOMER, NMCUSTOMER, IDFONE)
SELECT MAX(c.CDCUSTOMER) + s.CDSUPPLIER, s.NMSUPPLIER, s.IDFONE FROM SUPPLIER s
INNER JOIN CUSTOMER c ON CDSUPPLIER = CDCUSTOMER
GROUP BY s.CDSUPPLIER, s.NMSUPPLIER, s.IDFONE

--d.
UPDATE REQUEST SET DTDELIVER = DATEADD(DAY, 30, DTREQUEST) WHERE DATEDIFF(DAY, DTREQUEST, DTDELIVER) < 10 AND VLTOTAL < 10000

