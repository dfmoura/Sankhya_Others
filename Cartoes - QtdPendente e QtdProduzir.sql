--- CARTOES



---AGRUPAMENTO ITEM - QTDPENDENTE
------------------------------------------------------------------------
WITH 
EST AS (SELECT EST.CODPROD,SUM(EST.ESTOQUE)ESTOQUE FROM TGFEST EST GROUP BY EST.CODPROD),
ANDA AS (Select IPA.codprodpa,sum(IPA.qtdproduzir)op_andamento from TPRIPROC roc 
inner join TPRIPA IPA on roc.idiproc = ipa.idiproc
where statusproc = 'A' group by IPA.codprodpa ORDER BY 1)
SELECT DISTINCT 
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
AND CAB.STATUSNOTA = 'L' --SIGNIFICA CONFIRMADA = SIM
AND gru.codgrupoprod = 2040000


---AGRUPAMENTO ITEM - A_PRODUZIR
------------------------------------------------------------------------
WITH 
EST AS (SELECT EST.CODPROD,SUM(EST.ESTOQUE)ESTOQUE FROM TGFEST EST GROUP BY EST.CODPROD),
ANDA AS (Select IPA.codprodpa,sum(IPA.qtdproduzir)op_andamento from TPRIPROC roc 
inner join TPRIPA IPA on roc.idiproc = ipa.idiproc
where statusproc = 'A' group by IPA.codprodpa ORDER BY 1)
SELECT DISTINCT 
sum((CASE
WHEN (((CASE WHEN EST.ESTOQUE IS NULL THEN 0 ELSE EST.ESTOQUE END)-SUM(ITE.QTDNEG-ITE.QTDENTREGUE)))<=0 THEN (((CASE WHEN EST.ESTOQUE IS NULL THEN 0 ELSE EST.ESTOQUE END)-SUM(ITE.QTDNEG-ITE.QTDENTREGUE))) ELSE 0 END)) A_PRODUZIR
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
AND CAB.STATUSNOTA = 'L' --SIGNIFICA CONFIRMADA = SIM
AND gru.codgrupoprod = 2030000
GROUP BY
(CASE WHEN EST.ESTOQUE IS NULL THEN 0 ELSE EST.ESTOQUE END),
(CASE WHEN ANDA.op_andamento IS NULL THEN 0 ELSE ANDA.op_andamento END)
ORDER BY 1