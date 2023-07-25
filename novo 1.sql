SELECT DISTINCT 
    cab.nunota
  , cab.numnota
  , cab.dtneg
  , cab.CODEMP
  , cab.CODPARC
  , par.RAZAOSOCIAL 
  , cab.codparc
  , cab.VLRNOTA
  , sum(ite.qtdneg)Qtdneg
  , sum(ite.qtdentregue)Qtdentregue
  , (sum(ite.qtdneg)- sum(ite.qtdentregue))QtdPendente
  FROM TGFCAB CAB
  INNER JOIN tgfpar par ON cab.CODPARC = par.CODPARC 
  inner join tgfite ite on cab.nunota = ite.nunota
  inner join tgfpro pro on ite.codprod = pro.codprod
  inner join tgfgru gru on pro.codgrupoprod = gru.codgrupoprod
  WHERE 
  CAB.CODTIPOPER IN ( 1000,1003,1013,1111,1005)
  AND CAB.PENDENTE = 'S'
  AND CAB.STATUSNOTA = 'L' --SIGNIFICA CONFIRMADA = SIM
  AND (PRO.CODGRUPOPROD IN :P_CODGRUPOPROD )
  group by
    cab.nunota
  , cab.numnota
  , cab.dtneg
  , cab.CODEMP
  , cab.CODPARC
  , par.RAZAOSOCIAL 
  , cab.codparc
  , CAB.PENDENTE
  , CAB.STATUSNOTA
  , cab.VLRNOTA
  ORDER BY 1