
--PRODUTOS QUE FALTAM PRODUZIR CONSOLIDADO
WITH EST AS (
SELECT EST.CODPROD,SUM(EST.ESTOQUE) ESTOQUE 
FROM TGFEST EST 
inner join tgfpro pro on EST.codprod = PRO.codprod
WHERE PRO.CODGRUPOPROD IN (2030000, 2040000)
GROUP BY EST.CODPROD)
select DISTINCT 
  ite.codprod
  , pro.descrprod
  , SUM(DTP.QTD) AS QTDNEG
  , SUM(DTP.QTDENTREGUE) AS QTDENTREGUE
  , SUM(DTP.QTD-DTP.QTDENTREGUE) Pendente
  , est.estoque
  , CASE WHEN (est.estoque-SUM(DTP.QTD-DTP.QTDENTREGUE))>0 THEN 'FICARÁ SALDO' ELSE 'PRODUZIR' END STATUS
  , est.estoque-SUM(DTP.QTD-DTP.QTDENTREGUE) SALDO
from tgfcab cab 
inner join tgfven ven on cab.codvend = ven.codvend
inner join tgfite ite on ite.nunota = cab.nunota
inner join tgfpar par on par.codparc = cab.codparc
inner join tgfpro pro on pro.codprod = ite.codprod
inner join tgftop top on cab.codtipoper = top.codtipoper
INNER JOIN est ON ite.codprod = est.codprod
LEFT JOIN TGFDTP DTP ON CAB.NUNOTA = DTP.NUNOTA AND ITE.SEQUENCIA = DTP.SEQUENCIA
where 
CAB.DHTIPOPER = TOP.DHALTER
AND CAB.CODTIPOPER IN ( 1000,1003,1013,1111)
AND PRO.CODGRUPOPROD IN (2030000, 2040000)
And DTPREV >= TO_DATE('01-12-2022','DD-MM-YYYY') 
AND DTPREV <= TO_DATE('29-06-2023','DD-MM-YYYY')
AND (DTP.QTDENTREGUE-DTP.QTD) < 0
GROUP BY ite.codprod, pro.descrprod,est.estoque

--PRODUTOS QUE FALTAM PRODUZIR
WITH EST AS (
SELECT EST.CODPROD,SUM(EST.ESTOQUE) ESTOQUE 
FROM TGFEST EST 
inner join tgfpro pro on EST.codprod = PRO.codprod
WHERE PRO.CODGRUPOPROD IN (2030000, 2040000)
GROUP BY EST.CODPROD)
select DISTINCT 
  ROW_NUMBER() OVER (ORDER BY DTPREV) AS ORDEM
  , cab.dtneg
  , cab.nunota
  , cab.numnota
  , ite.codprod
  , pro.descrprod
  , DTP.DTPREV
  , DTP.QTD AS QTDNEG
  , DTP.QTDENTREGUE
  , DTP.QTDENTREGUE-DTP.QTD as Pendente
  , EST.ESTOQUE
--  , EST.ESTOQUE OVER (ORDER BY ROWNUM ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
from tgfcab cab 
inner join tgfven ven on cab.codvend = ven.codvend
inner join tgfite ite on cab.nunota = ite.nunota
inner join tgfpar par on par.codparc = cab.codparc
inner join tgfpro pro on pro.codprod = ite.codprod
inner join tgftop top on cab.codtipoper = top.codtipoper
INNER JOIN est ON ite.codprod = est.codprod
LEFT JOIN TGFDTP DTP ON CAB.NUNOTA = DTP.NUNOTA AND ITE.SEQUENCIA = DTP.SEQUENCIA
where 
CAB.DHTIPOPER = TOP.DHALTER
AND CAB.CODTIPOPER IN ( 1000,1003,1013,1111)
AND PRO.CODGRUPOPROD IN (2030000, 2040000)
And DTPREV >= TO_DATE('01-12-2022','DD-MM-YYYY') 
AND DTPREV <= TO_DATE('29-06-2023','DD-MM-YYYY')
AND (DTP.QTDENTREGUE-DTP.QTD) < 0
ORDER BY 1


---PRODUTOS ABACABADOS
WITH EST AS ( SELECT EST.CODPROD,SUM(EST.ESTOQUE) ESTOQUE FROM TGFEST EST inner join tgfpro pro on EST.codprod = PRO.codprod WHERE PRO.CODGRUPOPROD IN (2030000, 2040000) GROUP BY EST.CODPROD)
select DISTINCT 
  ite.codprod , pro.descrprod , SUM(DTP.QTD-DTP.QTDENTREGUE) Pendente , est.estoque
  , CASE WHEN (est.estoque-SUM(DTP.QTD-DTP.QTDENTREGUE))<=0 THEN (est.estoque-SUM(DTP.QTD-DTP.QTDENTREGUE)) end Produzir
  , CASE WHEN (est.estoque-SUM(DTP.QTD-DTP.QTDENTREGUE))>0 THEN (est.estoque-SUM(DTP.QTD-DTP.QTDENTREGUE)) end Saldo
from tgfcab cab 
inner join tgfven ven on cab.codvend = ven.codvend
inner join tgfite ite on ite.nunota = cab.nunota
inner join tgfpar par on par.codparc = cab.codparc
inner join tgfpro pro on pro.codprod = ite.codprod
inner join tgftop top on cab.codtipoper = top.codtipoper
INNER JOIN est ON ite.codprod = est.codprod
LEFT JOIN TGFDTP DTP ON CAB.NUNOTA = DTP.NUNOTA AND ITE.SEQUENCIA = DTP.SEQUENCIA
where 
CAB.CODTIPOPER IN ( 1000,1003,1013,1111)
AND PRO.CODGRUPOPROD IN (2030000, 2040000)
And DTPREV >= TO_DATE('01-12-2022','DD-MM-YYYY') 
AND DTPREV <= TO_DATE('29-06-2023','DD-MM-YYYY')
AND (DTP.QTDENTREGUE-DTP.QTD) < 0
GROUP BY ite.codprod, pro.descrprod,est.estoque


---PRODUTOS ABACABADOS PARA PRODUZIR
WITH 
EST AS ( SELECT EST.CODPROD,SUM(EST.ESTOQUE) ESTOQUE FROM TGFEST EST inner join tgfpro pro on EST.codprod = PRO.codprod WHERE PRO.CODGRUPOPROD IN (2030000, 2040000) GROUP BY EST.CODPROD)
PRODU AS (select DISTINCT ite.codprod , pro.descrprod
  , CASE WHEN (est.estoque-SUM(DTP.QTD-DTP.QTDENTREGUE))<=0 THEN (est.estoque-SUM(DTP.QTD-DTP.QTDENTREGUE)) ELSE 0 end Produzir
from tgfcab cab 
inner join tgfven ven on cab.codvend = ven.codvend
inner join tgfite ite on ite.nunota = cab.nunota
inner join tgfpar par on par.codparc = cab.codparc
inner join tgfpro pro on pro.codprod = ite.codprod
inner join tgftop top on cab.codtipoper = top.codtipoper
INNER JOIN est ON ite.codprod = est.codprod
LEFT JOIN TGFDTP DTP ON CAB.NUNOTA = DTP.NUNOTA AND ITE.SEQUENCIA = DTP.SEQUENCIA
where 
CAB.CODTIPOPER IN ( 1000,1003,1013,1111)
AND PRO.CODGRUPOPROD IN (2030000, 2040000)
And DTPREV >= TO_DATE('01-12-2022','DD-MM-YYYY') 
AND DTPREV <= TO_DATE('29-06-2023','DD-MM-YYYY')
AND (DTP.QTDENTREGUE-DTP.QTD) < 0
GROUP BY ite.codprod, pro.descrprod,est.estoque ORDER BY 3),
ICP AS (SELECT CODPROD,VARIACAO,CODMATPRIMA,QTDMISTURA,CODVOL FROM tgficp t1 WHERE variacao = (SELECT MAX(variacao) FROM tgficp t2 WHERE t1.codprod = t2.codprod)),







--ABERTURA_DA_RECEITA--mp--necessária-p-selecao
WITH ICP AS (SELECT CODPROD,VARIACAO,CODMATPRIMA,QTDMISTURA,CODVOL FROM tgficp t1 WHERE variacao = (SELECT MAX(variacao) FROM tgficp t2 WHERE t1.codprod = t2.codprod)),
select DISTINCT 
   ICP.CODMATPRIMA
  , PRO1.DESCRPROD
  , ICP.QTDMISTURA
  , ICP.VARIACAO
  , CASE WHEN (est.estoque-SUM(DTP.QTD-DTP.QTDENTREGUE))<=0 THEN (est.estoque-SUM(DTP.QTD-DTP.QTDENTREGUE)) end Produzir
from tgfcab cab
inner join tgfven ven on cab.codvend = ven.codvend
inner join tgfite ite on ite.nunota = cab.nunota
inner join tgfpar par on par.codparc = cab.codparc
inner join tgfpro pro on pro.codprod = ite.codprod
inner join tgftop top on cab.codtipoper = top.codtipoper
LEFT JOIN TGFDTP DTP ON CAB.NUNOTA = DTP.NUNOTA AND ITE.SEQUENCIA = DTP.SEQUENCIA
inner join ICP on ITE.CODPROD = ICP.codprod
inner join tgfpro pro1 on ICP.CODMATPRIMA = PRO1.codprod
where 
ITE.CODPROD = :A_CODPROD
AND CAB.CODTIPOPER IN ( 1000,1003,1013,1111)
AND PRO.CODGRUPOPROD IN (2030000, 2040000)
AND (DTP.QTDENTREGUE-DTP.QTD) < 0
GROUP BY
ICP.CODMATPRIMA, PRO1.DESCRPROD, ICP.QTDMISTURA, ICP.VARIACAO
ORDER BY 1










--PRODUDOS COMPRADOS QUE NAO ENTRARAM NO ESTOQUE 
WITH ICP AS (SELECT CODPROD,VARIACAO,CODMATPRIMA,QTDMISTURA,CODVOL FROM tgficp t1 WHERE variacao = (SELECT MAX(variacao) FROM tgficp t2 WHERE t1.codprod = t2.codprod))
SELECT
ite.codprod,
pro.DESCRPROD,
sum(ite.QTDNEG)
FROM tgfcab cab
INNER JOIN tgfite ite ON cab.NUNOTA = ite.nunota
INNER JOIN tgfpro pro ON ite.codprod = pro.CODPROD 
inner join ICP on ITE.CODPROD = ICP.CODMATPRIMA
WHERE cab.PENDENTE = 'S' AND cab.TIPMOV ='C'
GROUP BY ite.codprod,pro.DESCRPROD



SELECT * FROM tgfgru


--ABERTURA_DA_RECEITA--mp--necessária-p-selecao
WITH ICP AS (SELECT CODPROD,VARIACAO,CODMATPRIMA,QTDMISTURA,CODVOL FROM tgficp t1 WHERE variacao = (SELECT MAX(variacao) FROM tgficp t2 WHERE t1.codprod = t2.codprod))
select DISTINCT 
    cab.NUNOTA 
  , ite.codprod
  , ICP.CODMATPRIMA
  , PRO1.DESCRPROD
  , ICP.QTDMISTURA
  , ICP.VARIACAO
from tgfcab cab
inner join tgfven ven on cab.codvend = ven.codvend
inner join tgfite ite on ite.nunota = cab.nunota
inner join tgfpar par on par.codparc = cab.codparc
inner join tgfpro pro on pro.codprod = ite.codprod
inner join tgftop top on cab.codtipoper = top.codtipoper
LEFT JOIN TGFDTP DTP ON CAB.NUNOTA = DTP.NUNOTA AND ITE.SEQUENCIA = DTP.SEQUENCIA
inner join ICP on ITE.CODPROD = ICP.codprod
inner join tgfpro pro1 on ICP.CODMATPRIMA = PRO1.codprod
where 
CAB.DHTIPOPER = TOP.DHALTER
AND ICP.CODPROD = 2018
AND cab.NUNOTA = 10458
AND CAB.CODTIPOPER IN ( 1000,1003,1013,1111)
AND PRO.CODGRUPOPROD IN (2030000, 2040000)
AND (DTP.QTDENTREGUE-DTP.QTD) < 0
GROUP BY
cab.NUNOTA, ite.codprod, ICP.CODMATPRIMA, PRO1.DESCRPROD, ICP.QTDMISTURA,ICP.VARIACAO
ORDER BY 1,2,3



SELECT * FROM TGFFCP WHERE CODPROD = 2018 ORDER BY 1
SELECT * FROM TGFICP WHERE CODPROD = 2018 ORDER BY 1
SELECT * FROM TGFCAB WHERE CODTIPOPER IN ( 1000,1003,1013,1111)

--pegar a ultima versao do produto
SELECT * FROM tgficp t1 WHERE variacao = (SELECT MAX(variacao) FROM tgficp t2 WHERE t1.codprod = t2.codprod) AND CODPROD =2018






---VERIFICACAO DOS PRODUTOS
SELECT 
ICP.CODPROD,PRO.DESCRPROD,ICP.CODMATPRIMA,PRO1.DESCRPROD,ICP.QTDMISTURA,MAX(ICP.VARIACAO) VERSAO
FROM TGFICP ICP 
INNER JOIN TGFPRO PRO ON ICP.CODPROD = PRO.CODPROD
INNER JOIN TGFPRO PRO1 ON ICP.CODMATPRIMA = PRO1.CODPROD
GROUP BY ICP.CODPROD,PRO.DESCRPROD,ICP.CODMATPRIMA,PRO1.DESCRPROD,ICP.QTDMISTURA
ORDER BY 1


---VERIFICACAO DOS PRODUTOS - FILTRADO
SELECT 
ICP.CODPROD,PRO.DESCRPROD,ICP.CODMATPRIMA,PRO1.DESCRPROD,ICP.QTDMISTURA,MAX(ICP.VARIACAO) VERSAO
FROM TGFICP ICP 
INNER JOIN TGFPRO PRO ON ICP.CODPROD = PRO.CODPROD
INNER JOIN TGFPRO PRO1 ON ICP.CODMATPRIMA = PRO1.CODPROD
WHERE 
ICP.CODPROD = 2315
GROUP BY ICP.CODPROD,PRO.DESCRPROD,ICP.CODMATPRIMA,PRO1.DESCRPROD,ICP.QTDMISTURA
ORDER BY 1


SELECT OPC.* 
FROM TDDCAM CAM 
JOIN TDDOPC OPC ON OPC.NUCAMPO = CAM.NUCAMPO
WHERE CAM.NOMETAB='TGFICP' AND CAM.NOMECAMPO='UNIDCICLO'
ORDER BY OPC.ORDEM