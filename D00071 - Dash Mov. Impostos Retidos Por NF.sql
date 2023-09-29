----multilist empresa
WITH
imp AS (SELECT
cab.nunota,imf.codimp,imf.base,imf.valor,imf.ALIQUOTA
FROM tgfimf imf
INNER JOIN tgffin fin ON imf.nufin = fin.NUFIN
INNER JOIN tgfcab cab ON fin.nunota = cab.nunota
UNION all
SELECT
imn.nunota,imn.codimp,imn.base,imn.valor,imn.ALIQUOTA
FROM tgfimn imn)
SELECT
cab.CODEMP value,
cab.CODEMP||' - '||emp.RAZAOSOCIAL label
FROM tgfcab cab
left JOIN imp ON cab.nunota = imp.NUNOTA
INNER JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
INNER JOIN tsiemp emp ON cab.CODEMP = emp.CODEMP
WHERE
IMP.VALOR > 0
GROUP BY cab.CODEMP,emp.RAZAOSOCIAL



----multilist top
WITH
imp AS (SELECT
cab.nunota,imf.codimp,imf.base,imf.valor,imf.ALIQUOTA
FROM tgfimf imf
INNER JOIN tgffin fin ON imf.nufin = fin.NUFIN
INNER JOIN tgfcab cab ON fin.nunota = cab.nunota
UNION all
SELECT
imn.nunota,imn.codimp,imn.base,imn.valor,imn.ALIQUOTA
FROM tgfimn imn)
SELECT
cab.CODTIPOPER value,
cab.CODTIPOPER||' - '||top.DESCROPER label
FROM tgfcab cab
left JOIN imp ON cab.nunota = imp.NUNOTA
INNER JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
INNER JOIN tgftop top ON cab.CODTIPOPER  = top.CODTIPOPER
WHERE
IMP.VALOR > 0
GROUP BY cab.CODTIPOPER,top.DESCROPER 



----CABECALHO
WITH
imp AS (SELECT
cab.nunota,imf.codimp,imf.base,imf.valor,imf.ALIQUOTA
FROM tgfimf imf
INNER JOIN tgffin fin ON imf.nufin = fin.NUFIN
INNER JOIN tgfcab cab ON fin.nunota = cab.nunota
UNION all
SELECT
imn.nunota,imn.codimp,imn.base,imn.valor,imn.ALIQUOTA
FROM tgfimn imn)
SELECT
cab.codemp,imp.CODIMP,imc.NOMEIMP,sum(imp.VALOR)valor
FROM tgfcab cab
left JOIN imp ON cab.nunota = imp.NUNOTA
INNER JOIN tgfimc imc ON imp.codimp = imc.CODIMP
INNER JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
WHERE
IMP.VALOR > 0
AND ((CAB.DTENTSAI >= :P_DTENTSAI.INI AND CAB.DTENTSAI <= :P_DTENTSAI.FIN)
OR (:P_DTENTSAI.INI IS NULL AND :P_DTENTSAI.FIN IS NULL))
AND CAB.CODEMP IN :P_EMPRESA
AND CAB.CODTIPOPER IN :P_TOP
GROUP by
cab.codemp,imp.CODIMP,imc.NOMEIMP
ORDER BY 2






---DETALHE

WITH
imp AS (SELECT
cab.nunota,imf.codimp,imf.base,imf.valor,imf.ALIQUOTA
FROM tgfimf imf
INNER JOIN tgffin fin ON imf.nufin = fin.NUFIN
INNER JOIN tgfcab cab ON fin.nunota = cab.nunota
UNION all
SELECT
imn.nunota,imn.codimp,imn.base,imn.valor,imn.ALIQUOTA
FROM tgfimn imn)
SELECT
cab.CODEMP,
cab.nunota,
cab.numnota,
cab.codtipoper,
cab.DTNEG,
cab.DTENTSAI,
cab.CODPARC,
par.RAZAOSOCIAL,
cab.VLRNOTA,
sum(CASE WHEN imp.CODIMP = 1 THEN imp.VALOR ELSE 0 END) "CSLL_RETIDO1",
sum(CASE WHEN imp.CODIMP = 2 THEN imp.VALOR ELSE 0 END) "IRRF_RETIDO1",
sum(CASE WHEN imp.CODIMP = 3 THEN imp.VALOR ELSE 0 END) "INSS_RETIDO1",
sum(CASE WHEN imp.CODIMP = 4 THEN imp.VALOR ELSE 0 END) "PIS_RETIDO1",
sum(CASE WHEN imp.CODIMP = 5 THEN imp.VALOR ELSE 0 END) "COFINS_RETIDO",
sum(CASE WHEN imp.CODIMP = 6 THEN imp.VALOR ELSE 0 END) "CSLL_RETIDO",
sum(CASE WHEN imp.CODIMP = 7 THEN imp.VALOR ELSE 0 END) "FUNRURAL_RETIDO",
sum(CASE WHEN imp.CODIMP = 8 THEN imp.VALOR ELSE 0 END) "GILRAT_RETIDO",
sum(CASE WHEN imp.CODIMP = 9 THEN imp.VALOR ELSE 0 END) "SENAR_RETIDO",
sum(CASE WHEN imp.CODIMP = 10 THEN imp.VALOR ELSE 0 END) "INSS_RETIDO",
sum(CASE WHEN imp.CODIMP = 11 THEN imp.VALOR ELSE 0 END) "SEST",
sum(CASE WHEN imp.CODIMP = 13 THEN imp.VALOR ELSE 0 END) "ICMS_ST_COMPRAS",
sum(CASE WHEN imp.CODIMP = 14 THEN imp.VALOR ELSE 0 END) "IOF",
sum(CASE WHEN imp.CODIMP = 15 THEN imp.VALOR ELSE 0 END) "CSRF_RETIDO",
sum(CASE WHEN imp.CODIMP = 16 THEN imp.VALOR ELSE 0 END) "IPI",
sum(CASE WHEN imp.CODIMP = 17 THEN imp.VALOR ELSE 0 END) "IRRF_RETIDO_A"
FROM tgfcab cab
left JOIN imp ON cab.nunota = imp.NUNOTA
INNER JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
WHERE
IMP.VALOR > 0

GROUP by
cab.CODEMP,
cab.codtipoper,
cab.nunota,
cab.numnota,
cab.DTNEG,
cab.DTENTSAI,
cab.CODPARC,
par.RAZAOSOCIAL,
cab.VLRNOTA,
CASE WHEN imp.CODIMP = 1 THEN imp.VALOR ELSE 0 END
ORDER BY 2

--AND (CAB.DTNEG >= TRUNC($P{P0}) AND CAB.DTNEG <= TRUNC($P{P1}))
--AND CAB.CODEMP = $P{P3}