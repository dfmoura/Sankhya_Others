SELECT * FROM tgfimc


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
cab.codemp,imp.CODIMP,imc.NOMEIMP,sum(imp.VALOR)
FROM tgfcab cab
left JOIN imp ON cab.nunota = imp.NUNOTA
INNER JOIN tgfimc imc ON imp.codimp = imc.CODIMP 
INNER JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
WHERE
IMP.VALOR > 0
AND (CAB.DTNEG >= TRUNC($P{P0}) AND CAB.DTNEG <= TRUNC($P{P1}))
GROUP by
cab.codemp,imp.CODIMP,imc.NOMEIMP
ORDER BY 2








SELECT
cab.CODTIPOPER VALUE,
cab.CODTIPOPER || ' - ' || TPO.DESCROPER LABEL
FROM TGFCAB cab
inner JOIN tgfite ite ON cab.nunota = ite.nunota
INNER JOIN tgfpar par ON cab.codparc = par.codparc
INNER JOIN tgfpro pro ON ite.codprod = pro.codprod
INNER JOIN TGFTOP TPO ON CAB.CODTIPOPER = TPO.CODTIPOPER AND CAB.DHTIPOPER = TPO.DHALTER
WHERE cab.TIPMOV ='V'
GROUP BY cab.CODTIPOPER,TPO.DESCROPER
ORDER BY 2



SELECT
cab.codparc,
par.RAZAOSOCIAL
FROM TGFCAB cab
inner JOIN tgfite ite ON cab.nunota = ite.nunota
INNER JOIN tgfpar par ON cab.codparc = par.codparc
INNER JOIN tgfpro pro ON ite.codprod = pro.codprod
INNER JOIN TGFTOP TPO ON CAB.CODTIPOPER = TPO.CODTIPOPER AND CAB.DHTIPOPER = TPO.DHALTER
WHERE cab.TIPMOV ='V'
GROUP BY cab.codparc, par.RAZAOSOCIAL
ORDER BY 2





SELECT
cab.codemp,
cab.nunota,
cab.numnota,
cab.CODTIPOPER,
tpo.DESCROPER,
cab.dtneg,
cab.codparc,
par.RAZAOSOCIAL,
ite.codprod,
pro.DESCRPROD,
ite.QTDNEG,
ite.VLRUNIT,
ite.VLRTOT
FROM TGFCAB cab
inner JOIN tgfite ite ON cab.nunota = ite.nunota
INNER JOIN tgfpar par ON cab.codparc = par.codparc
INNER JOIN tgfpro pro ON ite.codprod = pro.codprod
INNER JOIN TGFTOP TPO ON CAB.CODTIPOPER = TPO.CODTIPOPER AND CAB.DHTIPOPER = TPO.DHALTER
WHERE cab.TIPMOV ='V'
ORDER BY 2
