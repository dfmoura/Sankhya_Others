SELECT * FROM tgfcot
SELECT * FROM tgfmopc
SELECT * FROM tgfitc ITC
SELECT * FROM tgfcce 

---resumo geral prazo de envio e recebimento cotação
SELECT 
COUNT(ITC.DTCOLETAPRECO - ITC.DTENVIOCOT)QTD,
AVG(ITC.DTCOLETAPRECO - ITC.DTENVIOCOT)PRAZO
FROM tgfitc ITC
INNER JOIN TGFPAR PAR ON ITC.CODPARC = PAR.CODPARC
INNER JOIN TGFPRO PRO ON ITC.CODPROD = PRO.CODPROD 
INNER JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
INNER JOIN TGFCOT COT ON ITC.NUMCOTACAO = COT.NUMCOTACAO 
WHERE
(ITC.DTENVIOCOT IS NOT NULL AND ITC.DTCOLETAPRECO IS NOT NULL)
AND COT.CODUSURESP IN :P_COMPRADOR
AND COT.CODEMP IN :P_CODEMP
AND ((ITC.DTENVIOCOT >= :P_PERIODO.INI AND ITC.DTENVIOCOT <= :P_PERIODO.FIN)
  OR (:P_PERIODO.INI IS NULL AND :P_PERIODO.FIN IS NULL))


---resumo prazo de envio e recebimento cotação por grupo de produto
SELECT
PRO.CODGRUPOPROD, 
GRU.DESCRGRUPOPROD,
COUNT(ITC.DTCOLETAPRECO - ITC.DTENVIOCOT)QTD,
AVG(ITC.DTCOLETAPRECO - ITC.DTENVIOCOT)PRAZO
FROM tgfitc ITC
INNER JOIN TGFPAR PAR ON ITC.CODPARC = PAR.CODPARC
INNER JOIN TGFPRO PRO ON ITC.CODPROD = PRO.CODPROD 
INNER JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
INNER JOIN TGFCOT COT ON ITC.NUMCOTACAO = COT.NUMCOTACAO 
WHERE
(ITC.DTENVIOCOT IS NOT NULL AND ITC.DTCOLETAPRECO IS NOT NULL)
AND COT.CODUSURESP IN :P_COMPRADOR
AND COT.CODEMP IN :P_CODEMP
AND ((ITC.DTENVIOCOT >= :P_PERIODO.INI AND ITC.DTENVIOCOT <= :P_PERIODO.FIN)
  OR (:P_PERIODO.INI IS NULL AND :P_PERIODO.FIN IS NULL))
GROUP BY PRO.CODGRUPOPROD,GRU.DESCRGRUPOPROD



---resumo prazo de envio e recebimento cotação detalhado
SELECT 
	COT.CODUSURESP|| ' - '|| USU.NOMEUSU RESPONSAVEL,
    ITC.NUMCOTACAO,
    ITC.DTENVIOCOT,
    ITC.DTCOLETAPRECO,
    ITC.DTCOLETAPRECO - ITC.DTENVIOCOT PRAZO,
    ITC.TIPOCOLPRECO,
    ITC.CODPARC,
    PAR.RAZAOSOCIAL,
    ITC.CODPROD,
    PRO.DESCRPROD,
	pro.codgrupoprod,
	GRU.DESCRGRUPOPROD
FROM tgfitc ITC
INNER JOIN TGFPAR PAR ON ITC.CODPARC = PAR.CODPARC
INNER JOIN TGFPRO PRO ON ITC.CODPROD = PRO.CODPROD
INNER JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
INNER JOIN TGFCOT COT ON ITC.NUMCOTACAO = COT.NUMCOTACAO 
INNER JOIN TSIUSU USU ON COT.CODUSUREQ = USU.CODUSU
WHERE
(ITC.DTENVIOCOT IS NOT NULL AND ITC.DTCOLETAPRECO IS NOT NULL)
AND pro.codgrupoprod = :A_CODGRUPOPROD
AND COT.CODUSURESP IN :P_COMPRADOR
AND COT.CODEMP IN :P_CODEMP
AND ((ITC.DTENVIOCOT >= :P_PERIODO.INI AND ITC.DTENVIOCOT <= :P_PERIODO.FIN)
  OR (:P_PERIODO.INI IS NULL AND :P_PERIODO.FIN IS NULL))
order by 1


---resumo prazo de envio e recebimento cotação abertura dos itens
SELECT 
CAB.NUMCOTACAO,
CAB.NUNOTA,
CAB.TIPMOV,
CAB.VLRNOTA 
FROM TGFCAB CAB
WHERE
(CAB.NUMCOTACAO IS NOT NULL)
AND CAB.TIPMOV = 'O'
AND CAB.NUMCOTACAO = :A_NUMCOTACAO




  --    (:apply_filter = 0 OR (ITC.DTENVIOCOT IS NOT NULL AND ITC.DTCOLETAPRECO IS NOT NULL));


   
   