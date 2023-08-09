



SELECT DISTINCT
    SUM(
        CASE
            WHEN CAB.CODTIPOPER IN (1200, 1201, 1215, 1216, 1217) THEN CAB.VLRNOTA * -1
            WHEN CAB.CODTIPOPER IN (1100, 1112, 1152, 1105, 1153) THEN CAB.VLRNOTA
        END
    ) VLRNOTA
FROM TGFCAB CAB
INNER JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA
INNER JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD
INNER JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
WHERE 
    CAB.CODTIPOPER IN (1100, 1112, 1152, 1200, 1201, 1215, 1216, 1217, 1105, 1153)
    AND CAB.STATUSNOTA = 'L'
    AND EXTRACT(YEAR FROM CAB.DTNEG) = EXTRACT(YEAR FROM SYSDATE);



-- FATURAMENTO POR MES ANO CORRENTE   
SELECT DISTINCT
    to_char(cab.dtneg,'YYYY-MM') AS ANO_MES,
	to_char(cab.dtneg,'YYYY')ANO,
	to_char(cab.dtneg,'MM')MES,
	SUM(
        CASE
            WHEN CAB.CODTIPOPER IN (1200, 1201, 1215, 1216, 1217) THEN CAB.VLRNOTA * -1
            WHEN CAB.CODTIPOPER IN (1100, 1112, 1152, 1105, 1153) THEN CAB.VLRNOTA
        END
    ) VLRNOTA
FROM TGFCAB CAB
INNER JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA
INNER JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD
INNER JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
WHERE 
    CAB.CODTIPOPER IN (1100, 1112, 1152, 1200, 1201, 1215, 1216, 1217, 1105, 1153)
    AND CAB.STATUSNOTA = 'L'
    AND EXTRACT(YEAR FROM CAB.DTNEG) = EXTRACT(YEAR FROM SYSDATE)
	GROUP BY to_char(cab.dtneg,'YYYY-MM'),to_char(cab.dtneg,'YYYY'),to_char(cab.dtneg,'MM')
	ORDER BY 2,3
   

	
	
SELECT DISTINCT
SUM(CASE
WHEN CAB.CODTIPOPER IN (1200,1201,1215,1216,1217) THEN CAB.VLRNOTA * -1
WHEN CAB.CODTIPOPER IN (1100,1112,1152,1105,1153) THEN CAB.VLRNOTA ELSE 0 END)FAT,
SUM (
CASE 
wHEN GRU.DESCRGRUPOPROD = 'COMPOSTO ORGANICO' AND CAB.CODTIPOPER IN (1200,1201,1215,1216,1217) THEN CAB.VLRNOTA * -1
WHEN GRU.DESCRGRUPOPROD = 'COMPOSTO ORGANICO' AND CAB.CODTIPOPER IN (1100,1112,1152,1105,1153) THEN CAB.VLRNOTA ELSE 0 END) AS COMP_ORGAN,
SUM (
CASE 
wHEN GRU.DESCRGRUPOPROD = 'SERVICOS PRESTADOS' AND CAB.CODTIPOPER IN (1200,1201,1215,1216,1217) THEN CAB.VLRNOTA * -1
WHEN GRU.DESCRGRUPOPROD = 'SERVICOS PRESTADOS' AND CAB.CODTIPOPER IN (1100,1112,1152,1105,1153) THEN CAB.VLRNOTA ELSE 0 END) AS SERV_PREST,
SUM (
CASE 
wHEN GRU.DESCRGRUPOPROD = 'FERTILIZANTES' AND CAB.CODTIPOPER IN (1200,1201,1215,1216,1217) THEN CAB.VLRNOTA * -1
WHEN GRU.DESCRGRUPOPROD = 'FERTILIZANTES' AND CAB.CODTIPOPER IN (1100,1112,1152,1105,1153) THEN CAB.VLRNOTA ELSE 0 END) AS FERT,

SUM (
CASE 
wHEN GRU.DESCRGRUPOPROD = 'SERVICO DESTINACAO RESIDUO' AND CAB.CODTIPOPER IN (1200,1201,1215,1216,1217) THEN CAB.VLRNOTA * -1
WHEN GRU.DESCRGRUPOPROD = 'SERVICO DESTINACAO RESIDUO' AND CAB.CODTIPOPER IN (1100,1112,1152,1105,1153) THEN CAB.VLRNOTA ELSE 0 END) AS SERV_DEST_RES

FROM TGFCAB CAB
INNER JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA
INNER JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD
INNER JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
INNER JOIN TGFVEN VEN ON CAB.CODVEND = VEN.CODVEND
WHERE 
TO_CHAR(CAB.DTNEG, 'YYYY-MM') = TO_CHAR(ADD_MONTHS(SYSDATE, 0), 'YYYY-MM')
AND CAB.CODEMP = 60
AND CAB.CODTIPOPER  IN (1100,1112,1152,1200,1201,1215,1216,1217,1105,1153)
AND CAB.STATUSNOTA = 'L'	
	
	
	
	
	
-- FATURAMENTO POR VENDEDOR ANO CORRENTE   
SELECT DISTINCT
	VEN.APELIDO,
	SUM(
        CASE
            WHEN CAB.CODTIPOPER IN (1200, 1201, 1215, 1216, 1217) THEN CAB.VLRNOTA * -1
            WHEN CAB.CODTIPOPER IN (1100, 1112, 1152, 1105, 1153) THEN CAB.VLRNOTA
        END
    ) VLRNOTA
FROM TGFCAB CAB
INNER JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA
INNER JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD
INNER JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
INNER JOIN TGFVEN VEN ON CAB.CODVEND = VEN.CODVEND
WHERE 
    CAB.CODTIPOPER IN (1100, 1112, 1152, 1200, 1201, 1215, 1216, 1217, 1105, 1153)
    AND CAB.STATUSNOTA = 'L'
    AND EXTRACT(YEAR FROM CAB.DTNEG) = EXTRACT(YEAR FROM SYSDATE)
	GROUP BY VEN.APELIDO
	ORDER BY 2 DESC
	
	
	


SELECT DISTINCT
SUM(CASE
WHEN CAB.CODTIPOPER IN (1200,1201,1215,1216,1217) THEN CAB.VLRNOTA * -1
WHEN CAB.CODTIPOPER IN (1100,1112,1152,1105,1153) THEN CAB.VLRNOTA END) VLRNOTA
FROM TGFCAB CAB
INNER JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA
INNER JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD
INNER JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
INNER JOIN (SELECT ITE.NUNOTA, SUM(QTDNEG) AS TTLQTDE
FROM TGFITE ITE GROUP BY ITE.NUNOTA) ITE2 ON ITE.NUNOTA = ITE2.NUNOTA
INNER JOIN TGFVEN VEN ON CAB.CODVEND = VEN.CODVEND
AND CAB.CODTIPOPER  IN (1100,1112,1152,1200,1201,1215,1216,1217,1105,1153)
AND CAB.STATUSNOTA = 'L'



SELECT DISTINCT
to_char(cab.dtneg,'YYYY-MM') AS ANO_MES,
to_char(cab.dtneg,'YYYY')ANO,
to_char(cab.dtneg,'MM')MES
FROM TGFCAB CAB
INNER JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA
INNER JOIN TSIEMP EMP ON CAB.CODEMP = EMP.CODEMP
INNER JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
INNER JOIN TGFTOP TOP ON CAB.CODTIPOPER = TOP.CODTIPOPER
INNER JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD
INNER JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
INNER JOIN TSICID CID ON PAR.CODCID = CID.CODCID
INNER JOIN TSIUFS UFS ON CID.UF = UFS.CODUF
INNER JOIN (SELECT ITE.NUNOTA, SUM(QTDNEG) AS TTLQTDE
FROM TGFITE ITE GROUP BY ITE.NUNOTA) ITE2 ON ITE.NUNOTA = ITE2.NUNOTA
INNER JOIN TGFVEN VEN ON CAB.CODVEND = VEN.CODVEND
AND CAB.CODTIPOPER  IN (1100,1112,1152,1200,1201,1215,1216,1217,1105,1153)
AND CAB.STATUSNOTA = 'L'
GROUP BY to_char(cab.dtneg,'YYYY-MM'),to_char(cab.dtneg,'YYYY'),to_char(cab.dtneg,'MM')
ORDER BY to_char(cab.dtneg,'YYYY'),to_char(cab.dtneg,'MM')



-- PERIODO
SELECT DISTINCT
to_char(cab.dtneg,'YYYY-MM') AS VALUE,
to_char(cab.dtneg,'YYYY-MM') AS LABEL,
to_char(cab.dtneg,'YYYY')ANO,
to_char(cab.dtneg,'MM')MES
FROM TGFCAB CAB
INNER JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA
INNER JOIN TSIEMP EMP ON CAB.CODEMP = EMP.CODEMP
INNER JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
INNER JOIN TGFTOP TOP ON CAB.CODTIPOPER = TOP.CODTIPOPER
INNER JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD
INNER JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
INNER JOIN TSICID CID ON PAR.CODCID = CID.CODCID
INNER JOIN TSIUFS UFS ON CID.UF = UFS.CODUF
INNER JOIN (SELECT ITE.NUNOTA, SUM(QTDNEG) AS TTLQTDE
FROM TGFITE ITE GROUP BY ITE.NUNOTA) ITE2 ON ITE.NUNOTA = ITE2.NUNOTA
INNER JOIN TGFVEN VEN ON CAB.CODVEND = VEN.CODVEND
AND CAB.CODTIPOPER  IN (1100,1112,1152,1200,1201,1215,1216,1217,1105,1153)
AND CAB.STATUSNOTA = 'L'
GROUP BY to_char(cab.dtneg,'YYYY-MM'),to_char(cab.dtneg,'YYYY'),to_char(cab.dtneg,'MM')
ORDER BY to_char(cab.dtneg,'YYYY'),to_char(cab.dtneg,'MM')



--vendedores
SELECT DISTINCT 
   ven.apelido
  FROM TGFCAB CAB
  INNER JOIN tgfpar par ON cab.CODPARC = par.CODPARC 
  INNER JOIN tgfite ite on cab.nunota = ite.nunota
  inner join tgftop top on cab.codtipoper = top.codtipoper
  inner join tgfpro pro on ite.codprod = pro.codprod
  inner join tgfgru gru on pro.codgrupoprod = gru.codgrupoprod
  inner join tgfven ven on cab.codvend = ven.codvend
  WHERE  
  CAB.CODTIPOPER IN ( 1000,1003,1013,1111,1005)
  AND CAB.PENDENTE = 'S'
  AND CAB.STATUSNOTA = 'L'
GROUP BY ven.apelido
INTERSECT 
SELECT DISTINCT
VEN.APELIDO
FROM TGFCAB CAB
INNER JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA
INNER JOIN TSIEMP EMP ON CAB.CODEMP = EMP.CODEMP
INNER JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
INNER JOIN TGFTOP TOP ON CAB.CODTIPOPER = TOP.CODTIPOPER
INNER JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD
INNER JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
INNER JOIN TSICID CID ON PAR.CODCID = CID.CODCID
INNER JOIN TSIUFS UFS ON CID.UF = UFS.CODUF
INNER JOIN (SELECT ITE.NUNOTA, SUM(QTDNEG) AS TTLQTDE
FROM TGFITE ITE GROUP BY ITE.NUNOTA) ITE2 ON ITE.NUNOTA = ITE2.NUNOTA
INNER JOIN TGFVEN VEN ON CAB.CODVEND = VEN.CODVEND
AND CAB.CODTIPOPER  IN (1100,1112,1152,1200,1201,1215,1216,1217,1105,1153)
AND CAB.STATUSNOTA = 'L'


SELECT * 
FROM TGFVEN


WITH G AS (SELECT CODVEND,APELIDO FROM TGFVEN )
SELECT
VEN.CODVEND,
VEN.TIPVEND,
VEN.APELIDO,
VEN.CODGER,
G.APELIDO A
FROM TGFVEN VEN
INNER JOIN G ON VEN.CODGER = G.CODVEND
WHERE VEN.CODEMP = 60


WITH G AS (SELECT CODVEND,APELIDO FROM TGFVEN )
SELECT
VEN.CODGER,
G.APELIDO A
FROM TGFVEN VEN
INNER JOIN G ON VEN.CODGER = G.CODVEND
WHERE VEN.CODEMP = 60
GROUP BY VEN.CODGER, G.APELIDO




SELECT OPC.* 
FROM TDDCAM CAM 
JOIN TDDOPC OPC ON OPC.NUCAMPO = CAM.NUCAMPO
WHERE CAM.NOMETAB='TGFVEN' AND CAM.NOMECAMPO='TIPVEND'
ORDER BY OPC.ORDEM

SELECT OPC.* 
FROM TDDCAM CAM 
JOIN TDDOPC OPC ON OPC.NUCAMPO = CAM.NUCAMPO
WHERE CAM.NOMETAB='TGFVEN' AND CAM.NOMECAMPO='TIPCALC'
ORDER BY OPC.ORDEM



--pedidos a entregar
SELECT DISTINCT 
    cab.dtneg
  , cab.CODEMP
  , cab.CODPARC
  , par.RAZAOSOCIAL 
  , cab.nunota
  , cab.numnota
  , cab.codparc
  , CAB.PENDENTE
  , CAB.STATUSNOTA
  , cab.codtipoper
  , top.descroper
  , ite.codprod
  , pro.descrprod
  , ite.qtdneg - ite.qtdentregue qtdpend
  , ven.apelido
  FROM TGFCAB CAB
  INNER JOIN tgfpar par ON cab.CODPARC = par.CODPARC 
  INNER JOIN tgfite ite on cab.nunota = ite.nunota
  inner join tgftop top on cab.codtipoper = top.codtipoper
  inner join tgfpro pro on ite.codprod = pro.codprod
  inner join tgfgru gru on pro.codgrupoprod = gru.codgrupoprod
  inner join tgfven ven on cab.codvend = ven.codvend
  WHERE  
  CAB.CODTIPOPER IN ( 1000,1003,1013,1111,1005)
  AND CAB.PENDENTE = 'S'
  AND CAB.STATUSNOTA = 'L'
  ORDER BY 5

  
  
--Faturamento
SELECT DISTINCT
CAB.CODTIPOPER TOPS,
TOP.DESCROPER DESCRTOP,
(CASE
WHEN (UFS.UF = 'MG') THEN TOP.CODCFO_SAIDA
WHEN (UFS.UF <> 'MG') THEN TOP.CODCFO_SAIDA_FORA
END) AS "CFOP",
UFS.UF,
CAB.NUNOTA,
CAB.NUMNOTA,
ITE.SEQUENCIA,
CAB.DTFATUR,
CAB.DTENTSAI,
CAB.DTMOV DTMOV,
CAB.DTNEG,
CAB.CODEMP,
EMP.RAZAOSOCIAL "EMPRESA",
CAB.CODPARC,
PAR.CGC_CPF,
PAR.RAZAOSOCIAL "PARCEIRO",
CAB.TIPMOV,
ITE.CODPROD,
PRO.DESCRPROD,
GRU.DESCRGRUPOPROD,
PRO.USOPROD,
ITE.CODTRIB,
PRO.NCM,
PRO.CODVOL,
VEN.APELIDO,
(CASE
WHEN CAB.CODTIPOPER IN (1200,1201,1215,1216,1217) THEN ITE.QTDNEG * -1
WHEN CAB.CODTIPOPER IN (1100,1112,1152,1105,1153) THEN ITE.QTDNEG END) AS QTDNEG,
TTLQTDE,
ITE.VLRUNIT,
(CASE
WHEN CAB.CODTIPOPER IN (1200,1201,1215,1216,1217) THEN ITE.VLRTOT * -1
WHEN CAB.CODTIPOPER IN (1100,1112,1152,1105,1153) THEN ITE.VLRTOT END) AS VLRTOT,
(CASE WHEN (TTLQTDE = 0) THEN 0 ELSE (
((CASE
WHEN CAB.CODTIPOPER IN (1200,1201,1215,1216,1217) THEN ITE.QTDNEG * -1
WHEN CAB.CODTIPOPER IN (1100,1112,1152,1105,1153) THEN ITE.QTDNEG END)/TTLQTDE) )END) AS PART_PERC_QTD_NO_PROD,
(CASE WHEN (TTLQTDE = 0) THEN 0 ELSE (
(((CASE
WHEN CAB.CODTIPOPER IN (1200,1201,1215,1216,1217) THEN ITE.QTDNEG * -1
WHEN CAB.CODTIPOPER IN (1100,1112,1152,1105,1153) THEN ITE.QTDNEG END) /TTLQTDE) * CAB.VLRNOTA) )END) AS VLR_PROP_PROD,
CAB.VLRFRETE,
CAB.ISSRETIDO,
(CAB.VLRISS * 
(CASE WHEN (TTLQTDE = 0) THEN 0 ELSE (
((CASE
WHEN CAB.CODTIPOPER IN (1200,1201,1215,1216,1217) THEN ITE.QTDNEG * -1
WHEN CAB.CODTIPOPER IN (1100,1112,1152,1105,1153) THEN ITE.QTDNEG END)/TTLQTDE) )END)) AS VLRISS,

CASE WHEN CAB.ISSRETIDO = 'S' THEN 
(CAB.VLRISS * 
(CASE WHEN (TTLQTDE = 0) THEN 0 ELSE (
((CASE
WHEN CAB.CODTIPOPER IN (1200,1201,1215,1216,1217) THEN ITE.QTDNEG * -1
WHEN CAB.CODTIPOPER IN (1100,1112,1152,1105,1153) THEN ITE.QTDNEG END)/TTLQTDE) )END))+
(CASE WHEN (TTLQTDE = 0) THEN 0 ELSE (
(((CASE
WHEN CAB.CODTIPOPER IN (1200,1201,1215,1216,1217) THEN ITE.QTDNEG * -1
WHEN CAB.CODTIPOPER IN (1100,1112,1152,1105,1153) THEN ITE.QTDNEG END) /TTLQTDE) * CAB.VLRNOTA) )END) 
ELSE 
(CASE WHEN (TTLQTDE = 0) THEN 0 ELSE (
(((CASE
WHEN CAB.CODTIPOPER IN (1200,1201,1215,1216,1217) THEN ITE.QTDNEG * -1
WHEN CAB.CODTIPOPER IN (1100,1112,1152,1105,1153) THEN ITE.QTDNEG END) /TTLQTDE) * CAB.VLRNOTA) )END) 
END VLR_PROP_PROD_COM_ISS
FROM TGFCAB CAB
INNER JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA
INNER JOIN TSIEMP EMP ON CAB.CODEMP = EMP.CODEMP
INNER JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
INNER JOIN TGFTOP TOP ON CAB.CODTIPOPER = TOP.CODTIPOPER
INNER JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD
INNER JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
INNER JOIN TSICID CID ON PAR.CODCID = CID.CODCID
INNER JOIN TSIUFS UFS ON CID.UF = UFS.CODUF
INNER JOIN (SELECT ITE.NUNOTA, SUM(QTDNEG) AS TTLQTDE
FROM TGFITE ITE GROUP BY ITE.NUNOTA) ITE2 ON ITE.NUNOTA = ITE2.NUNOTA
INNER JOIN TGFVEN VEN ON CAB.CODVEND = VEN.CODVEND
AND CAB.CODTIPOPER  IN (1100,1112,1152,1200,1201,1215,1216,1217,1105,1153)
AND CAB.STATUSNOTA = 'L'
ORDER BY 8,5,7




SELECT DISTINCT
SUM((CASE WHEN (TTLQTDE = 0) THEN 0 ELSE (
(((CASE
WHEN CAB.CODTIPOPER IN (1200,1201,1215,1216,1217) THEN ITE.QTDNEG * -1
WHEN CAB.CODTIPOPER IN (1100,1112,1152,1105,1153) THEN ITE.QTDNEG END) /TTLQTDE) * CAB.VLRNOTA) )END)) AS VLR_PROP_PROD
FROM TGFCAB CAB
INNER JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA
INNER JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD
INNER JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
INNER JOIN (SELECT ITE.NUNOTA, SUM(QTDNEG) AS TTLQTDE
FROM TGFITE ITE GROUP BY ITE.NUNOTA) ITE2 ON ITE.NUNOTA = ITE2.NUNOTA
INNER JOIN TGFVEN VEN ON CAB.CODVEND = VEN.CODVEND
AND CAB.CODTIPOPER  IN (1100,1112,1152,1200,1201,1215,1216,1217,1105,1153)
AND CAB.STATUSNOTA = 'L'
WHERE to_char(cab.dtneg,'YYYY-MM') IN :P_PERIODO



----carteira
SELECT DISTINCT 
  (sum(ite.qtdneg) - sum(ite.qtdentregue))QtdPendente,
  sum((ite.qtdneg - ite.qtdentregue)*ite.VLRUNIT)  VLRPendente
  FROM TGFCAB CAB
  INNER JOIN tgfpar par ON cab.CODPARC = par.CODPARC 
  inner join tgfite ite on cab.nunota = ite.nunota
  inner join tgfpro pro on ite.codprod = pro.codprod
  inner join tgfgru gru on pro.codgrupoprod = gru.codgrupoprod
  INNER JOIN TGFVEN ven ON cab.codvend = ven.CODVEND
  WHERE
  cab.codemp = 60
  AND CAB.CODTIPOPER IN ( 1000,1003,1013,1111,1005)
  AND CAB.PENDENTE = 'S'
  AND CAB.STATUSNOTA = 'L'

  
--carteira por periodo
SELECT DISTINCT
  to_char(cab.dtneg,'YYYY-MM') AS ANO_MES,
  to_char(cab.dtneg,'YYYY')ANO,
  to_char(cab.dtneg,'MM')MES,
  (sum(ite.qtdneg) - sum(ite.qtdentregue))QtdPendente,
  sum((ite.qtdneg - ite.qtdentregue)*ite.VLRUNIT)  VLRPendente
  FROM TGFCAB CAB
  INNER JOIN tgfpar par ON cab.CODPARC = par.CODPARC 
  inner join tgfite ite on cab.nunota = ite.nunota
  inner join tgfpro pro on ite.codprod = pro.codprod
  inner join tgfgru gru on pro.codgrupoprod = gru.codgrupoprod
  INNER JOIN TGFVEN ven ON cab.codvend = ven.CODVEND
  WHERE
  cab.codemp = 60
  AND CAB.CODTIPOPER IN ( 1000,1003,1013,1111,1005)
  AND CAB.PENDENTE = 'S'
  AND CAB.STATUSNOTA = 'L'
  GROUP BY 
  to_char(cab.dtneg,'YYYY-MM'),
  to_char(cab.dtneg,'YYYY'),
  to_char(cab.dtneg,'MM')
  ORDER BY 2,3
  
  
--carteira por periodo
SELECT DISTINCT
  to_char(cab.dtneg,'YYYY-MM') AS ANO_MES,
  to_char(cab.dtneg,'YYYY')ANO,
  to_char(cab.dtneg,'MM')MES,
  (sum(ite.qtdneg) - sum(ite.qtdentregue))QtdPendente,
  sum((ite.qtdneg - ite.qtdentregue)*ite.VLRUNIT)  VLRPendente
  FROM TGFCAB CAB
  INNER JOIN tgfpar par ON cab.CODPARC = par.CODPARC 
  inner join tgfite ite on cab.nunota = ite.nunota
  inner join tgfpro pro on ite.codprod = pro.codprod
  inner join tgfgru gru on pro.codgrupoprod = gru.codgrupoprod
  INNER JOIN TGFVEN ven ON cab.codvend = ven.CODVEND
  WHERE
  cab.codemp = 60
  AND CAB.CODTIPOPER IN ( 1000,1003,1013,1111,1005)
  AND CAB.PENDENTE = 'S'
  AND CAB.STATUSNOTA = 'L'
  GROUP BY 
  to_char(cab.dtneg,'YYYY-MM'),
  to_char(cab.dtneg,'YYYY'),
  to_char(cab.dtneg,'MM')
  ORDER BY 2,3
  
  
  VEN.APELIDO,
  
  --carteira por vendedor
SELECT DISTINCT
  VEN.APELIDO,
  (sum(ite.qtdneg) - sum(ite.qtdentregue))QtdPendente,
  sum((ite.qtdneg - ite.qtdentregue)*ite.VLRUNIT)  VLRPendente
  FROM TGFCAB CAB
  INNER JOIN tgfpar par ON cab.CODPARC = par.CODPARC 
  inner join tgfite ite on cab.nunota = ite.nunota
  inner join tgfpro pro on ite.codprod = pro.codprod
  inner join tgfgru gru on pro.codgrupoprod = gru.codgrupoprod
  INNER JOIN TGFVEN ven ON cab.codvend = ven.CODVEND
  WHERE
  cab.codemp = 60
  AND CAB.CODTIPOPER IN ( 1000,1003,1013,1111,1005)
  AND CAB.PENDENTE = 'S'
  AND CAB.STATUSNOTA = 'L'
  GROUP BY 
  VEN.APELIDO
  ORDER BY 1
  
---mapa faturamento  
  	SELECT 
		    SUM(
        CASE
            WHEN CAB.CODTIPOPER IN (1200, 1201, 1215, 1216, 1217) THEN CAB.VLRNOTA * -1
            WHEN CAB.CODTIPOPER IN (1100, 1112, 1152, 1105, 1153) THEN CAB.VLRNOTA
        END
    ) VLRNOTA
		, UFS.UF
		, UFS.DESCRICAO
	  FROM  TGFCAB CAB
	  JOIN  TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
	  JOIN  TSICID CID ON PAR.CODCID = CID.CODCID
	  JOIN  TSIUFS UFS ON CID.UF = UFS.CODUF
	 WHERE  
	   CAB.CODEMP IN (60)
	   AND CAB.CODTIPOPER IN (1100, 1112, 1152, 1200, 1201, 1215, 1216, 1217, 1105, 1153)
        AND CAB.STATUSNOTA = 'L'
        AND EXTRACT(YEAR FROM CAB.DTNEG) = EXTRACT(YEAR FROM SYSDATE)
  GROUP BY  UFS.UF 	,  UFS.DESCRICAO