
WITH
DTPREV AS (select DISTINCT CAB.NUNOTA, CAB.DTNEG,
case when min(dtp.dtprev) is null then cab.dtneg else min(dtp.dtprev) end dtprev
from tgfDTP DTP
LEFT JOIN TGFCAB CAB ON DTP.NUNOTA = CAB.NUNOTA
GROUP BY CAB.NUNOTA, CAB.DTNEG),
DTPREV1 AS (SELECT var.NUNOTA, min(dtp.DTPREV)DTPREV 
FROM tgfvar var
INNER JOIN tgfdtp dtp ON var.NUNOTAORIG = dtp.nunota
GROUP BY var.NUNOTA,var.NUNOTAORIG)
SELECT DISTINCT 
    cab.dtneg
  , CASE WHEN DTPREV.DTPREV IS NULL THEN DTPREV1.DTPREV ELSE DTPREV.DTPREV END AS DTPREV
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
  , ite.vlrunit
  , ite.vlrunit*(ite.qtdneg - ite.qtdentregue) vlrpend
  FROM TGFCAB CAB
  INNER JOIN tgfpar par ON cab.CODPARC = par.CODPARC 
  INNER JOIN tgfite ite on cab.nunota = ite.nunota
  inner join tgftop top on cab.codtipoper = top.codtipoper
  inner join tgfpro pro on ite.codprod = pro.codprod
  inner join tgfgru gru on pro.codgrupoprod = gru.codgrupoprod
  inner join tgfven ven on cab.codvend = ven.codvend
  left join DTPREV on cab.nunota = dtprev.nunota
  LEFT JOIN DTPREV1 on cab.nunota = DTPREV1.nunota
  WHERE  
  CAB.CODTIPOPER IN (1000,1003,1013,1111,1005)
  AND CAB.PENDENTE = 'S'
  AND CAB.STATUSNOTA = 'L'
  AND (CAB.CODVEND IN :P_CODVEND)
  AND (PRO.CODGRUPOPROD IN :P_CODGRUPOPROD)
  AND ((CAB.DTNEG >= :P_PERIODO.INI AND CAB.DTNEG <= :P_PERIODO.FIN)
  OR (:P_PERIODO.INI IS NULL AND :P_PERIODO.FIN IS NULL))
    AND ((DTPREV1.DTPREV >= :P_PERIODO1.INI AND DTPREV1.DTPREV <= :P_PERIODO1.FIN)
  OR (:P_PERIODO1.INI IS NULL AND :P_PERIODO1.FIN IS NULL))
 
  ORDER BY 6