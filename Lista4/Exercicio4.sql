/*

 Exercicio 4

 a. O nome de todos os itens que já foram pedidos (fazer uma versão com
 DISTINCT e uma com GROUP BY);
 b. O nome do produto, o número de vezes que ele foi pedido e a quantidade total
 pedida;
 c. O nome do fornecedor, o total em estoque dos produtos fornecidos pelo
 fornecedor, a média de preço dos produtos fornecidos e quantos produtos ele
 fornece;
 d. O nome do cliente, seu telefone, o valor da maior compra, o valor da menor
 compra, o total comprado e a média de valor comprado, ordenado por maior
 compra decrescente;
 e. A data do pedido, o nome do cliente, quantos produtos distintos ele pediu, o
 valor total do pedido (baseado nos valores da tabela productrequest), a média
 de valores do pedido (baseado nos valores da tabela productrequest)
 ordenado pela quantidade de produtos distintos pedidos;
 f. O nome do fornecedor e quantos produtos ele fornece, para todos os
 fornecedores que fornecem mais que um produto;
 g. O nome do produto, o número de vezes que ele foi pedido e a quantidade total
 pedida para produtos que foram pedidos menos que 2 vezes;
 h. O nome do cliente, o produto, o valor gasto com o produto, quantas vezes ele
 foi pedido pelo cliente e o nome do fornecedor. Somente para produtos em
 que o cliente gastou mais de R$1.000,00, ordenado por cliente e produto.

*/

USE treinamento

--a.
SELECT p.NMPRODUCT
FROM PRODUCTREQUEST pr
INNER JOIN PRODUCT p ON pr.CDPRODUCT = p.CDPRODUCT
GROUP BY NMPRODUCT;

--b.
SELECT p.NMPRODUCT, COUNT(pr.CDPRODUCT), SUM(pr.QTAMOUNT)
FROM PRODUCTREQUEST pr
INNER JOIN PRODUCT p ON pr.CDPRODUCT = p.CDPRODUCT
GROUP BY NMPRODUCT;

--c.
SELECT s.NMSUPPLIER, SUM(p.QTSTOCK), AVG(p.VLPRICE), COUNT(p.CDPRODUCT)
FROM PRODUCT p
INNER JOIN SUPPLIER s ON p.CDSUPPLIER = s.CDSUPPLIER
GROUP BY s.NMSUPPLIER;

--d.
SELECT c.NMCUSTOMER, c.IDFONE, MAX(pr.VLUNITARY * pr.QTAMOUNT), MIN(pr.VLUNITARY * pr.QTAMOUNT), SUM(pr.VLUNITARY * pr.QTAMOUNT), AVG(pr.VLUNITARY  * pr.QTAMOUNT)
FROM PRODUCTREQUEST pr
INNER JOIN REQUEST r ON pr.CDREQUEST = r.CDREQUEST
INNER JOIN CUSTOMER c ON c.CDCUSTOMER = r.CDCUSTOMER
GROUP BY c.NMCUSTOMER, c.IDFONE
ORDER BY MAX(pr.VLUNITARY) DESC;

--e.
SELECT r.DTREQUEST, c.NMCUSTOMER, COUNT(DISTINCT pr.CDPRODUCT), SUM(pr.VLUNITARY * pr.QTAMOUNT), AVG(pr.VLUNITARY * pr.QTAMOUNT)
FROM PRODUCTREQUEST pr
INNER JOIN REQUEST r ON pr.CDREQUEST = r.CDREQUEST
INNER JOIN CUSTOMER c ON c.CDCUSTOMER = r.CDCUSTOMER
GROUP BY r.DTREQUEST, c.NMCUSTOMER
ORDER BY COUNT(DISTINCT pr.CDPRODUCT) DESC;

--f.
SELECT s.NMSUPPLIER, COUNT(p.CDPRODUCT)
FROM PRODUCT p
INNER JOIN SUPPLIER s ON p.CDSUPPLIER = s.CDSUPPLIER
GROUP BY s.NMSUPPLIER
HAVING COUNT(p.CDPRODUCT) > 1;

--g.
SELECT p.NMPRODUCT, COUNT(pr.CDPRODUCT), SUM(pr.QTAMOUNT)
FROM PRODUCTREQUEST pr
INNER JOIN PRODUCT p ON pr.CDPRODUCT = p.CDPRODUCT
GROUP BY NMPRODUCT
HAVING COUNT(pr.CDPRODUCT) < 2;

--h.
SELECT c.NMCUSTOMER, p.NMPRODUCT, SUM(pr.VLUNITARY * pr.QTAMOUNT), COUNT(pr.CDPRODUCT), s.NMSUPPLIER
FROM PRODUCTREQUEST pr
INNER JOIN REQUEST r ON pr.CDREQUEST = r.CDREQUEST
INNER JOIN CUSTOMER c ON c.CDCUSTOMER = r.CDCUSTOMER
INNER JOIN PRODUCT p ON pr.CDPRODUCT = p.CDPRODUCT
INNER JOIN SUPPLIER s ON p.CDSUPPLIER = s.CDSUPPLIER
GROUP BY c.NMCUSTOMER, p.NMPRODUCT, s.NMSUPPLIER
HAVING SUM(pr.VLUNITARY * pr.QTAMOUNT) > 1000
ORDER BY c.NMCUSTOMER, p.NMPRODUCT;

