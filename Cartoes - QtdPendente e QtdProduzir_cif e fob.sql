-- PRODUTOS PENDENTE OU A ENTREGAR

---AGRUPAMENTO ITEM
------------------------------------------------------------------------
WITH 
EST AS (SELECT EST.CODPROD,SUM(EST.ESTOQUE)ESTOQUE FROM TGFEST EST GROUP BY EST.CODPROD),
ANDA AS (Select IPA.codprodpa,sum(IPA.qtdproduzir)op_andamento from TPRIPROC roc 
inner join TPRIPA IPA on roc.idiproc = ipa.idiproc
where statusproc = 'A' group by IPA.codprodpa ORDER BY 1)
SELECT DISTINCT 
CAB.CIF_FOB,
gru.codgrupoprod,
GRU.DESCRGRUPOPROD,
SUM((ITE.QTDNEG-ITE.QTDENTREGUE))QTDPENDENTE
FROM TGFCAB CAB
INNER JOIN tgfpar par ON cab.CODPARC = par.CODPARC 
INNER JOIN tgfite ite ON cab.nunota = ite.nunota
INNER JOIN tgfpro pro ON ite.codprod = pro.codprod
inner join tgfgru gru on pro.codgrupoprod = gru.codgrupoprod
LEFT JOIN EST ON ITE.CODPROD = EST.CODPROD
LEFT JOIN ANDA ON ITE.CODPROD = ANDA.CODPRODPA
WHERE 
CAB.CODTIPOPER IN ( 1000,1003,1013,1111,1005)
AND CAB.PENDENTE = 'S'
AND CAB.STATUSNOTA = 'L'
AND gru.codgrupoprod = 2040000
AND CAB.CIF_FOB = 'C'
GROUP BY CAB.CIF_FOB,gru.codgrupoprod,GRU.DESCRGRUPOPROD

---AGRUPAMENTO ITEM
------------------------------------------------------------------------
WITH 
EST AS (SELECT EST.CODPROD,SUM(EST.ESTOQUE)ESTOQUE FROM TGFEST EST GROUP BY EST.CODPROD),
ANDA AS (Select IPA.codprodpa,sum(IPA.qtdproduzir)op_andamento from TPRIPROC roc 
inner join TPRIPA IPA on roc.idiproc = ipa.idiproc
where statusproc = 'A' group by IPA.codprodpa ORDER BY 1)
SELECT DISTINCT 
CAB.CIF_FOB,
gru.codgrupoprod,
GRU.DESCRGRUPOPROD,
SUM((ITE.QTDNEG-ITE.QTDENTREGUE))QTDPENDENTE
FROM TGFCAB CAB
INNER JOIN tgfpar par ON cab.CODPARC = par.CODPARC 
INNER JOIN tgfite ite ON cab.nunota = ite.nunota
INNER JOIN tgfpro pro ON ite.codprod = pro.codprod
inner join tgfgru gru on pro.codgrupoprod = gru.codgrupoprod
LEFT JOIN EST ON ITE.CODPROD = EST.CODPROD
LEFT JOIN ANDA ON ITE.CODPROD = ANDA.CODPRODPA
WHERE 
CAB.CODTIPOPER IN ( 1000,1003,1013,1111,1005)
AND CAB.PENDENTE = 'S'
AND CAB.STATUSNOTA = 'L'
AND gru.codgrupoprod = 2040000
AND CAB.CIF_FOB = 'F'
GROUP BY CAB.CIF_FOB,gru.codgrupoprod,GRU.DESCRGRUPOPROD


2030000
SELECT * FROM TGFGRU t 


---AGRUPAMENTO ITEM
------------------------------------------------------------------------
WITH 
EST AS (SELECT EST.CODPROD,SUM(EST.ESTOQUE)ESTOQUE FROM TGFEST EST GROUP BY EST.CODPROD),
ANDA AS (Select IPA.codprodpa,sum(IPA.qtdproduzir)op_andamento from TPRIPROC roc 
inner join TPRIPA IPA on roc.idiproc = ipa.idiproc
where statusproc = 'A' group by IPA.codprodpa ORDER BY 1)
SELECT DISTINCT 
CAB.CIF_FOB,
gru.codgrupoprod,
GRU.DESCRGRUPOPROD,
SUM((ITE.QTDNEG-ITE.QTDENTREGUE))QTDPENDENTE
FROM TGFCAB CAB
INNER JOIN tgfpar par ON cab.CODPARC = par.CODPARC 
INNER JOIN tgfite ite ON cab.nunota = ite.nunota
INNER JOIN tgfpro pro ON ite.codprod = pro.codprod
inner join tgfgru gru on pro.codgrupoprod = gru.codgrupoprod
LEFT JOIN EST ON ITE.CODPROD = EST.CODPROD
LEFT JOIN ANDA ON ITE.CODPROD = ANDA.CODPRODPA
WHERE 
CAB.CODTIPOPER IN ( 1000,1003,1013,1111,1005)
AND CAB.PENDENTE = 'S'
AND CAB.STATUSNOTA = 'L'
AND gru.codgrupoprod = 2030000
AND CAB.CIF_FOB = 'C'
GROUP BY CAB.CIF_FOB,gru.codgrupoprod,GRU.DESCRGRUPOPROD

---AGRUPAMENTO ITEM
------------------------------------------------------------------------
WITH 
EST AS (SELECT EST.CODPROD,SUM(EST.ESTOQUE)ESTOQUE FROM TGFEST EST GROUP BY EST.CODPROD),
ANDA AS (Select IPA.codprodpa,sum(IPA.qtdproduzir)op_andamento from TPRIPROC roc 
inner join TPRIPA IPA on roc.idiproc = ipa.idiproc
where statusproc = 'A' group by IPA.codprodpa ORDER BY 1)
SELECT DISTINCT 
CAB.CIF_FOB,
gru.codgrupoprod,
GRU.DESCRGRUPOPROD,
SUM((ITE.QTDNEG-ITE.QTDENTREGUE))QTDPENDENTE
FROM TGFCAB CAB
INNER JOIN tgfpar par ON cab.CODPARC = par.CODPARC 
INNER JOIN tgfite ite ON cab.nunota = ite.nunota
INNER JOIN tgfpro pro ON ite.codprod = pro.codprod
inner join tgfgru gru on pro.codgrupoprod = gru.codgrupoprod
LEFT JOIN EST ON ITE.CODPROD = EST.CODPROD
LEFT JOIN ANDA ON ITE.CODPROD = ANDA.CODPRODPA
WHERE 
CAB.CODTIPOPER IN ( 1000,1003,1013,1111,1005)
AND CAB.PENDENTE = 'S'
AND CAB.STATUSNOTA = 'L'
AND gru.codgrupoprod = 2030000
AND CAB.CIF_FOB = 'F'
GROUP BY CAB.CIF_FOB,gru.codgrupoprod,GRU.DESCRGRUPOPROD
