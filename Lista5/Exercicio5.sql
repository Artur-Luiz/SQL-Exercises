USE treinamento

--a. O nome de todos os produtos e quantas vezes ele foi vendido, mesmo que não tenha sido vendido ainda;
SELECT p.NMPRODUCT, COUNT(p.NMPRODUCT) AS QTD
FROM PRODUCT p
LEFT JOIN PRODUCTREQUEST pr ON p.CDPRODUCT = pr.CDPRODUCT
GROUP BY p.NMPRODUCT

--b. O nome do fornecedor, e o número de produtos que ele fornece, mesmo que não tenha fornecido produto algum;
SELECT s.NMSUPPLIER, COUNT(s.NMSUPPLIER) AS QTD
FROM SUPPLIER s
INNER JOIN PRODUCT p ON s.CDSUPPLIER = p.CDSUPPLIER
GROUP BY s.NMSUPPLIER

--c. O nome do fornecedor, o produto e qual o total de produtos dele já vendidos. Uma linha do total por fornecedor e uma linha com o total geral;
SELECT s.NMSUPPLIER, p.NMPRODUCT, COUNT(p.NMPRODUCT) AS QTD
FROM SUPPLIER s
INNER JOIN PRODUCT p ON s.CDSUPPLIER = p.CDSUPPLIER
INNER JOIN PRODUCTREQUEST pr ON p.CDPRODUCT = pr.CDPRODUCT
GROUP BY s.NMSUPPLIER, p.NMPRODUCT
UNION
SELECT s.NMSUPPLIER, 'TOTAL', COUNT(p.NMPRODUCT) AS QTD
FROM SUPPLIER s
INNER JOIN PRODUCT p ON s.CDSUPPLIER = p.CDSUPPLIER
INNER JOIN PRODUCTREQUEST pr ON p.CDPRODUCT = pr.CDPRODUCT
GROUP BY s.NMSUPPLIER

--d. O nome do cliente, o produto e o total que o cliente já gastou com esse produto. Uma linha com o total por cliente e uma linha com o total geral;
SELECT c.NMCUSTOMER, p.NMPRODUCT, SUM(pr.QTAMOUNT) AS QTD
FROM CUSTOMER c
INNER JOIN REQUEST r ON r.CDCUSTOMER = c.CDCUSTOMER
INNER JOIN PRODUCTREQUEST pr ON pr.CDREQUEST = r.CDREQUEST
INNER JOIN PRODUCT p ON p.CDPRODUCT = pr.CDPRODUCT
GROUP BY c.NMCUSTOMER, p.NMPRODUCT
UNION
SELECT c.NMCUSTOMER, 'TOTAL', SUM(pr.QTAMOUNT) AS QTD
FROM CUSTOMER c
INNER JOIN REQUEST r ON r.CDCUSTOMER = c.CDCUSTOMER
INNER JOIN PRODUCTREQUEST pr ON pr.CDREQUEST = r.CDREQUEST
INNER JOIN PRODUCT p ON p.CDPRODUCT = pr.CDPRODUCT
GROUP BY c.NMCUSTOMER

--e. O nome e o telefone de todos os clientes que ainda não compraram produtos;
SELECT c.NMCUSTOMER, c.IDFONE
FROM CUSTOMER c
LEFT JOIN REQUEST r ON r.CDCUSTOMER = c.CDCUSTOMER
WHERE r.CDCUSTOMER IS NULL

--f. O nome e o telefone dos fornecedores que fornecem o produto ‘leite em po” ou o produto “agua mineral”;
SELECT s.NMSUPPLIER, s.IDFONE
FROM SUPPLIER s
INNER JOIN PRODUCT p ON s.CDSUPPLIER = p.CDSUPPLIER
WHERE p.NMPRODUCT IN ('leite em po', 'agua mineral')

--g. O nome e o fornecedor do produto que já foi vendido mais que 3 vezes.
SELECT p.NMPRODUCT, s.NMSUPPLIER, COUNT(p.NMPRODUCT) AS QTD
FROM PRODUCT p
INNER JOIN SUPPLIER s ON s.CDSUPPLIER = p.CDSUPPLIER
INNER JOIN PRODUCTREQUEST pr ON pr.CDPRODUCT = p.CDPRODUCT
GROUP BY p.NMPRODUCT, s.NMSUPPLIER
HAVING COUNT(p.NMPRODUCT) > 3