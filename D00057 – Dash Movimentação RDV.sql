SELECT
    cab.codemp,
    TO_CHAR(cab.dtneg, 'YYYY') AS ANO,
    TO_CHAR(cab.dtneg, 'MM') AS MES,
    TO_CHAR(cab.dtneg, 'MM-YYYY') AS MES_ANO,
    SUM(cab.vlrnota) AS VLRNOTA
FROM tgfcab cab 
INNER JOIN tgfpar par ON cab.codparc = par.codparc
WHERE cab.CODTIPOPER IN (258) 
    AND cab.codemp = 60 
    AND TO_CHAR(CAB.DTNEG, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM')
GROUP BY
    cab.codemp,
    TO_CHAR(cab.dtneg, 'YYYY'),
    TO_CHAR(cab.dtneg, 'MM'),
    TO_CHAR(cab.dtneg, 'MM-YYYY')
ORDER BY 2, 3;




SELECT
    cab.codemp,
    TO_CHAR(cab.dtneg, 'YYYY') AS ANO,
    TO_CHAR(cab.dtneg, 'MM') AS MES,
    TO_CHAR(cab.dtneg, 'MM-YYYY') AS MES_ANO,
    SUM(cab.vlrnota) AS VLRNOTA,
    ROUND(
         100*(SUM(cab.vlrnota) - LAG(SUM(cab.vlrnota), 1) OVER (PARTITION BY cab.codemp ORDER BY TO_DATE(TO_CHAR(cab.dtneg, 'MM-YYYY'), 'MM-YYYY'))) /
        LAG(SUM(cab.vlrnota), 1) OVER (PARTITION BY cab.codemp ORDER BY TO_DATE(TO_CHAR(cab.dtneg, 'MM-YYYY'), 'MM-YYYY')),
        2) AS VARIACAO_PERC
FROM tgfcab cab 
INNER JOIN tgfpar par ON cab.codparc = par.codparc
WHERE 
cab.CODTIPOPER IN (258) 
AND cab.codemp = 60
AND EXTRACT(MONTH FROM cab.dtneg) = EXTRACT(MONTH FROM SYSDATE)
AND EXTRACT(YEAR FROM cab.dtneg) = EXTRACT(YEAR FROM SYSDATE)
GROUP BY
    cab.codemp,
    TO_CHAR(cab.dtneg, 'YYYY'),
    TO_CHAR(cab.dtneg, 'MM'),
    TO_CHAR(cab.dtneg, 'MM-YYYY')
ORDER BY 2, 3



SELECT
    cab.codemp,
    TO_CHAR(cab.dtneg, 'YYYY') AS ANO,
    TO_CHAR(cab.dtneg, 'MM') AS MES,
    TO_CHAR(cab.dtneg, 'MM-YYYY') AS MES_ANO,
    SUM(cab.vlrnota) AS VLRNOTA,
    LAG(SUM(cab.vlrnota)) OVER (PARTITION BY cab.codemp ORDER BY TO_CHAR(cab.dtneg, 'YYYY'), TO_CHAR(cab.dtneg, 'MM')) AS VLRNOTA_LAST_MONTH,
    (SUM(cab.vlrnota) - LAG(SUM(cab.vlrnota)) OVER (PARTITION BY cab.codemp ORDER BY TO_CHAR(cab.dtneg, 'YYYY'), TO_CHAR(cab.dtneg, 'MM'))) AS VARIATION
    
FROM
    tgfcab cab
INNER JOIN
    tgfpar par ON cab.codparc = par.codparc
WHERE
    cab.CODTIPOPER IN (258) AND cab.codemp = 60
GROUP BY
    cab.codemp,
    TO_CHAR(cab.dtneg, 'YYYY'),
    TO_CHAR(cab.dtneg, 'MM'),
    TO_CHAR(cab.dtneg, 'MM-YYYY')
ORDER BY
    cab.codemp,
    TO_CHAR(cab.dtneg, 'YYYY'),
    TO_CHAR(cab.dtneg, 'MM')



SELECT distinct 
cab.codemp,
TO_CHAR( cab.dtneg, 'YYYY')ANO,
TO_CHAR( cab.dtneg, 'MM')MES,
TO_CHAR( cab.dtneg, 'MM-YYYY')MES_ANO,
sum(cab.vlrnota)VLRNOTA
FROM tgfcab cab 
INNER JOIN tgfpar par ON cab.codparc = par.codparc
WHERE cab.CODTIPOPER IN (258) AND cab.codemp = 60
GROUP BY
cab.codemp,
TO_CHAR( cab.dtneg, 'YYYY'),
TO_CHAR( cab.dtneg, 'MM'),
TO_CHAR( cab.dtneg, 'MM-YYYY')
ORDER BY 2,3


SELECT distinct 
cab.codemp,
par.RAZAOSOCIAL,
sum(cab.vlrnota)VLRNOTA
FROM tgfcab cab 
INNER JOIN tgfpar par ON cab.codparc = par.codparc
WHERE cab.CODTIPOPER IN (258) AND cab.codemp = 60
GROUP BY
cab.codemp,
par.RAZAOSOCIAL
ORDER BY 2



SELECT distinct 
cab.codemp,
cab.nunota,
cab.numnota,
TO_CHAR( cab.dtneg, 'MM-YYYY')MesAno,
cab.dtneg,
cab.codparc,
par.razaosocial,
cab.vlrnota
FROM tgfcab cab 
INNER JOIN tgfpar par ON cab.codparc = par.codparc
WHERE cab.CODTIPOPER IN (258) AND cab.codemp = 60 and TO_CHAR( cab.dtneg, 'MM-YYYY') = :A_MES_ANO
ORDER BY 4
