select cab.codparc 
      , PAR.RAZAOSOCIAL 
      , cab.dtneg
      , cab.nunota
      , cab.numnota
      , ite.codprod
      , ite.vlrtot
      , ite.vlrunit
	  , cab.vlrnota
	  , (((CASE WHEN CAB.TIPMOV = 'D' THEN ITE.QTDNEG * -1 WHEN CAB.TIPMOV = 'V' THEN ITE.QTDNEG END) /TTLQTDE) * CAB.VLRNOTA) AS VLR_PROP_PROD
      , pro.descrprod
      , ite.qtdneg
      , ITE.QTDENTREGUE
      , ite.qtdentregue-ite.qtdneg as Pendente
      , (ite.qtdneg-ite.qtdentregue)*ite.vlrunit as Vlr_Pendente
      , cab.codtipoper
      , top.descroper
      , pro.codgrupoprod
      , VEN.APELIDO
	  , 
      , (NVL(ITE.QTDNEG, 0)- NVL((
                                 SELECT  SUM(NVL(ITEDEST.QTDNEG,0))
                                 FROM TGFITE ITE2 
                                 JOIN TGFVAR VAR ON VAR.NUNOTAORIG = ITE2.NUNOTA AND VAR.SEQUENCIAORIG = ITE2.SEQUENCIA
                                 JOIN TGFITE ITEDEST ON ITEDEST.NUNOTA = VAR.NUNOTA  AND ITEDEST.SEQUENCIA = VAR.SEQUENCIA 
                                 JOIN TGFCAB CABDEST ON CABDEST.NUNOTA = ITEDEST.NUNOTA
                                 WHERE ITE2.NUNOTA = ITE.NUNOTA
                                 AND ITE2.SEQUENCIA = ITE.SEQUENCIA
                                 AND NVL(CABDEST.STATUSNOTA,'A') = 'L'),0)) AS QTDPENDENTE
from tgfcab cab
INNER JOIN TGFVEN VEN ON VEN.CODVEND = CAB.CODVEND
inner join tgfven ven on cab.codvend = ven.codvend
inner join tgfite ite on ite.nunota = cab.nunota
inner join tgfpar par on par.codparc = cab.codparc
inner join tgfpro pro on pro.codprod = ite.codprod
inner join tgftop top on cab.codtipoper = top.codtipoper
where cab.dtneg between :PERIODO.INI and :PERIODO.FIN
and cab.tipmov IN ('P','V')
AND CAB.CODTIPOPER IN ( 1000,1013,1111,1003)
and CAB.DHTIPOPER = TOP.DHALTER
AND PRO.CODGRUPOPROD IN (2030000, 2040000)
--and ((par.codparc = :CODPARC )OR (:CODPARC is NULL))
--and ((cab.codtipoper = :CODTOP) OR (:CODTOP is NULL))
and top.grupo in :GRUPO
AND ((CASE WHEN NVL(ITE.QTDNEG, 0)- NVL((
                                 SELECT  SUM(NVL(ITEDEST.QTDNEG,0))
                                 FROM TGFITE ITE2 
                                 JOIN TGFVAR VAR ON VAR.NUNOTAORIG = ITE2.NUNOTA AND VAR.SEQUENCIAORIG = ITE2.SEQUENCIA
                                 JOIN TGFITE ITEDEST ON ITEDEST.NUNOTA = VAR.NUNOTA  AND ITEDEST.SEQUENCIA = VAR.SEQUENCIA 
                                 JOIN TGFCAB CABDEST ON CABDEST.NUNOTA = ITEDEST.NUNOTA
                                 WHERE ITE2.NUNOTA = ITE.NUNOTA
                                 AND ITE2.SEQUENCIA = ITE.SEQUENCIA
                                 AND NVL(CABDEST.STATUSNOTA,'A') = 'L'),0) = 0 THEN 'N' WHEN NVL(ITE.QTDNEG, 0)- NVL((
                                 SELECT  SUM(NVL(ITEDEST.QTDNEG,0))
                                 FROM TGFITE ITE2 
                                 JOIN TGFVAR VAR ON VAR.NUNOTAORIG = ITE2.NUNOTA AND VAR.SEQUENCIAORIG = ITE2.SEQUENCIA
                                 JOIN TGFITE ITEDEST ON ITEDEST.NUNOTA = VAR.NUNOTA  AND ITEDEST.SEQUENCIA = VAR.SEQUENCIA 
                                 JOIN TGFCAB CABDEST ON CABDEST.NUNOTA = ITEDEST.NUNOTA
                                 WHERE ITE2.NUNOTA = ITE.NUNOTA
                                 AND ITE2.SEQUENCIA = ITE.SEQUENCIA
--                                 AND NVL(CABDEST.STATUSNOTA,'A') = 'L'),0) <> 0 THEN 'S' ELSE 'A' END ) = :P_PENDENTE OR :P_PENDENTE = 'A')
--and (ven.codvend =:VENDEDOR OR :VENDEDOR IS NULL)
and cab.statusnota ='L'