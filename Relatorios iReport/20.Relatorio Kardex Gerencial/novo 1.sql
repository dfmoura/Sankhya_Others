SELECT CODPROD, CODEMP, DESCRPROD, CODVOL, CODGRUPOPROD, DESCRGRUPOPROD, ESTATUAL, ESTOQUE, CUSTO, CUSTOTOT, QTDENTRADA, VLRENTRADA, QTDSAIDA, VLRSAIDA
FROM (
SELECT PRO.CODPROD, 0 AS CODEMP, PRO.DESCRPROD, PRO.CODVOL, PRO.CODGRUPOPROD, GRU.DESCRGRUPOPROD, NVL((SELECT SUM(ESTOQUE) FROM TGFEST WHERE CODPROD = PRO.CODPROD AND CODEMP = 60),0) AS ESTATUAL,
  NVL((SELECT SUM(ESTOQUE) FROM TGFEST WHERE CODPROD = PRO.CODPROD AND CODEMP = 60),0) + NVL((SELECT SUM(ITE.QTDNEG*ITE.ATUALESTOQUE*-1)
                           FROM TGFITE ITE, TGFCAB CAB
                          WHERE  CAB.NUNOTA = ITE.NUNOTA
                            AND CAB.CODEMP = 60
                            AND CAB.DTENTSAI >= TO_DATE('01-05-2023','DD-MM-YYYY')
                            AND ITE.CODPROD = PRO.CODPROD),0) AS ESTOQUE,
NVL((SELECT MAX(CUSSEMICM) FROM TGFCUS
                  WHERE CODPROD = PRO.CODPROD
                    AND CODEMP = 60
                    AND DTATUAL = (SELECT MAX(DTATUAL)
                                     FROM TGFCUS
                                     WHERE CODPROD = PRO.CODPROD
                                       AND CODEMP = 60
                                       AND DTATUAL <= TO_DATE('01-05-2023','DD-MM-YYYY'))),0) AS CUSTO,
ROUND((NVL((SELECT SUM(ESTOQUE) FROM TGFEST WHERE CODPROD = PRO.CODPROD AND CODEMP = 60),0) + NVL((SELECT SUM(ITE.QTDNEG*ITE.ATUALESTOQUE*-1)
                          FROM TGFITE ITE, TGFCAB CAB
                         WHERE  CAB.NUNOTA = ITE.NUNOTA
                           AND CAB.CODEMP = 60
                           AND CAB.DTENTSAI >= TO_DATE('01-05-2023','DD-MM-YYYY')
                           AND ITE.CODPROD = PRO.CODPROD),0))*
        nvl((SELECT MAX(CUSSEMICM) FROM TGFCUS
                         WHERE CODPROD = PRO.CODPROD
                           AND CODEMP = 60
                           AND DTATUAL = (SELECT MAX(DTATUAL)FROM TGFCUS
                                           WHERE CODPROD = PRO.CODPROD
                                             AND CODEMP = 60
                                             AND DTATUAL < TO_DATE('01-05-2023','DD-MM-YYYY'))),0),3) AS CUSTOTOT,
NVL((SELECT SUM(ITE.QTDNEG*ITE.ATUALESTOQUE)
                           FROM TGFITE ITE, TGFCAB CAB
                          WHERE  CAB.NUNOTA = ITE.NUNOTA
                            AND CAB.CODEMP = 60
                            AND CAB.DTENTSAI >= TO_DATE('01-05-2023','DD-MM-YYYY')
                            AND CAB.DTENTSAI <= TO_DATE('31-05-2023','DD-MM-YYYY')
                            AND ITE.CODPROD = PRO.CODPROD
                            AND ITE.ATUALESTOQUE > 0
                            AND CAB.CODTIPOPER NOT IN (152, 155)),0) AS QTDENTRADA,
NVL((SELECT SUM(ITE.QTDNEG*ITE.ATUALESTOQUE*CUS.ENTRADASEMICMS)
                           FROM TGFITE ITE, TGFCAB CAB, TGFCUS CUS
                          WHERE  CAB.NUNOTA = ITE.NUNOTA
                            AND CAB.DTENTSAI >= TO_DATE('01-05-2023','DD-MM-YYYY')
                            AND CAB.DTENTSAI <= TO_DATE('31-05-2023','DD-MM-YYYY')
                            AND CAB.CODEMP = 60
                            AND ITE.CODPROD = PRO.CODPROD
                            AND ITE.CODPROD = CUS.CODPROD
                            AND CUS.CODEMP = 60
                            AND ITE.CONTROLE = CUS.CONTROLE
                            AND CUS.DTATUAL = (SELECT MAX(DTATUAL)
                                                  FROM TGFCUS
                                                 WHERE CODPROD = CUS.CODPROD
                                                  AND DTATUAL <= CAB.DTENTSAI
                                                  AND CONTROLE = ITE.CONTROLE
                                                  AND CODEMP = 60)
                            AND ITE.ATUALESTOQUE > 0
                            AND CAB.CODTIPOPER NOT IN (152, 155)),0) AS VLRENTRADA,
NVL((SELECT SUM(ITE.QTDNEG*ITE.ATUALESTOQUE*-1)
                           FROM TGFITE ITE, TGFCAB CAB
                          WHERE  CAB.NUNOTA = ITE.NUNOTA
                            AND CAB.CODEMP = 60
                            AND CAB.DTENTSAI >= TO_DATE('01-05-2023','DD-MM-YYYY')
                            AND CAB.DTENTSAI <= TO_DATE('31-05-2023','DD-MM-YYYY')
                            AND ITE.CODPROD = PRO.CODPROD
                            AND ITE.ATUALESTOQUE < 0
                            AND CAB.CODTIPOPER NOT IN (156)),0) AS QTDSAIDA,
NVL((SELECT SUM(ITE.QTDNEG*ITE.ATUALESTOQUE*CUS.CUSSEMICM*-1)
                           FROM TGFITE ITE, TGFCAB CAB, TGFCUS CUS
                          WHERE  CAB.NUNOTA = ITE.NUNOTA
                            AND CAB.DTENTSAI >= TO_DATE('01-05-2023','DD-MM-YYYY')
                            AND CAB.DTENTSAI <= TO_DATE('31-05-2023','DD-MM-YYYY')
                            AND CAB.CODEMP = 60
                            AND ITE.CODPROD = PRO.CODPROD
                            AND ITE.CODPROD = CUS.CODPROD
                            AND CUS.CODEMP = 60
                            AND ITE.CONTROLE = CUS.CONTROLE
                            AND CUS.DTATUAL = (SELECT MAX(DTATUAL)
                                                  FROM TGFCUS
                                                 WHERE CODPROD = CUS.CODPROD
                                                  AND DTATUAL <= CAB.DTENTSAI
                                                  AND CONTROLE = ITE.CONTROLE
                                                  AND CODEMP = 60)
                            AND ITE.ATUALESTOQUE < 0
                            AND CAB.CODTIPOPER NOT IN (156)),0) AS VLRSAIDA,

							
FROM TGFPRO PRO, TGFGRU GRU
WHERE PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
AND PRO.USOPROD NOT IN ('S', 'I')
AND CASE WHEN 2030000 IS NULL THEN 0 ELSE PRO.CODGRUPOPROD END = NVL(2030000,0)
AND CASE WHEN 83 IS NULL THEN 0 ELSE PRO.CODPROD END = NVL(83,0)
GROUP BY PRO.CODPROD, PRO.DESCRPROD, PRO.CODGRUPOPROD, GRU.DESCRGRUPOPROD, PRO.CODVOL)
WHERE ESTOQUE > 0
 OR QTDENTRADA > 0
 OR QTDSAIDA > 0
ORDER BY CODGRUPOPROD, CODPROD