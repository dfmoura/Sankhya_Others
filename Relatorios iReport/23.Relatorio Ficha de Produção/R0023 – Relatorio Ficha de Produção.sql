-- DADOS DA ORDEM DE PRODUÇÃO
SELECT
 (SELECT COUNT (APO.NUAPO)
  	FROM TPRAPO APO
          INNER JOIN TPRIATV ATV ON APO.IDIATV = ATV.IDIATV
			WHERE ATV.IDIPROC = 485) AS QTDAPO
,    (SELECT CP.NOME
	 FROM TPRWXIP IP, TPRWCP CP, TPRIPROC OP
           WHERE IP.IDIPROC =  OP.IDIPROC
           AND IP.CODWCP = CP.CODWCP
           AND OP.IDIPROC = 485) AS CT
, DHINC INCLUSAO
, DHINST INICIO
, DHTERMINO TERMINO
, OP.IDIPROC
, PRO.CODVOL
, ROUND(IPA.QTDPRODUZIR)
, ROUND(ap.qtdapontada)
, USU.NOMEUSU SOLICITANTE
, PRO.DESCRPROD PRODUTOPA
, PRO.COMPLDESC COMPLEMENTO
, PRO.CODPROD PRODUTO_ID
, CASE WHEN STATUSPROC = 'A' THEN 'Inicializada'
       WHEN STATUSPROC = 'C' THEN 'Cancelada'
       WHEN STATUSPROC = 'F' THEN 'Finalizada'
       WHEN STATUSPROC = 'R' THEN 'Não Iniciada'
       WHEN STATUSPROC = 'S' THEN 'Suspensa'
       ELSE '' END AS STATUS
, DHTERMINO
, round(DHTERMINO - DHINST) || ' Dias ' ||
round((((DHTERMINO - DHINST) * 1440) -(round((DHTERMINO - DHINST))*1440))/60) || ' Horas ' ||
round(((DHTERMINO - DHINST) * 1440) -(round((DHTERMINO - DHINST))*1440))  || ' Minutos'
PERIODO
, OP.NROLOTE LOTE
, INITCAP(PRC.DESCRABREV) DESCRPROC
, NVL(OP.NUNOTA,0) AS PEDIDO
,(SELECT SUBSTR(LOGODANFE, INSTR(LOGODANFE, '/', -1) + 1, LENGTH(LOGODANFE)) FROM TGFEMP WHERE CODEMP = OP.CODPLP) AS LOGO_EMP
FROM TPRIPROC OP, TSIUSU USU, TGFPRO PRO, TPRIPA IPA left join (
  SELECT SUM(QTDAPONTADA) AS QTDAPONTADA, CODPRODPA
  FROM TPRAPA
  WHERE NUAPO IN(SELECT (APO.NUAPO)
                    FROM TPRAPO APO
                    INNER JOIN TPRIATV ATV ON APO.IDIATV = ATV.IDIATV
                    WHERE ATV.IDIPROC = 485
                )
GROUP BY CODPRODPA
) AP ON IPA.CODPRODPA = AP.CODPRODPA, TPRPRC PRC
WHERE OP.IDIPROC = IPA.IDIPROC
AND USU.CODUSU = OP.CODUSUINC
AND PRO.CODPROD = IPA.CODPRODPA
AND PRC.IDPROC = OP.IDPROC
AND OP.IDIPROC = 485


SELECT * FROM TPRLMP WHERE IDEFX = 951


--------APONTAMENTO
SELECT DISTINCT
  PA.CODPRODPA
, PA.NUAPO
, PA.QTDAPONTADA
, PA.QTDFAT
, PRO.CODPROD
, INITCAP (PRO.DESCRPROD) DESCRPROD
, PA.QTDFATSP
, PA.CONTROLEPA
, INITCAP (USU.NOMEUSU)NOMEUSU
, APO.DHAPO AS DH
, ATV.IDIPROC AS OP

          ,(SELECT COUNT (APO.NUAPO)
          FROM TPRAPO APO
          INNER JOIN TPRIATV ATV ON APO.IDIATV = ATV.IDIATV
          WHERE ATV.IDIPROC=485) AS APO

          , ((SELECT SUM (PA.QTDFAT) FROM TPRAPA PA
              INNER JOIN TPRAPO PO ON PA.NUAPO = PO.NUAPO
              INNER JOIN TPRIATV ATV ON PO.IDIATV = ATV.IDIATV
              WHERE ATV.IDIPROC=485) +
  (SELECT SUM (PA.QTDPERDA) FROM TPRAPA PA
              INNER JOIN TPRAPO PO ON PA.NUAPO = PO.NUAPO
              INNER JOIN TPRIATV ATV ON PO.IDIATV = ATV.IDIATV
              WHERE ATV.IDIPROC = 485)) -
(SELECT QTDPRODUZIR FROM TPRIPA WHERE IDIPROC = 485) AS RESTANTE

,(SELECT SUM (PA.QTDPERDA) FROM TPRAPA PA
              INNER JOIN TPRAPO PO ON PA.NUAPO = PO.NUAPO
              INNER JOIN TPRIATV ATV ON PO.IDIATV = ATV.IDIATV
              WHERE ATV.IDIPROC = 485) AS PERDA
  FROM
    TPRAPA PA,
    TGFPRO PRO,
    TSIUSU USU,
    TPRAPO APO,
    TPRIATV ATV,
    TPREFX ATVFX
  WHERE PA.CODPRODPA = PRO.CODPROD
  AND APO.NUAPO = PA.NUAPO
  AND ATV.IDEFX = ATVFX.IDEFX
  AND APO.CODUSU = USU.CODUSU
  AND APO.IDIATV = ATV.IDIATV
  AND ATV.IDIPROC=485
ORDER BY 10


-----------------ETAPAS DE PRODUCAO
SELECT ROW_NUMBER() OVER (ORDER BY DHINICIO) SEQ,INITCAP(DESCRICAO) AS DESCRICAO, DHINICIO, DHFINAL, INITCAP (NOMEUSU) AS NOMEUSU
  FROM TPREFX FX INNER JOIN TPRIPROC OP ON (FX.IDPROC = OP.IDPROC AND DESCRICAO IS NOT NULL AND FX.TIPO = 1101)
                  LEFT JOIN TPRIATV ATV ON (ATV.IDEFX = FX.IDEFX AND ATV.IDIPROC = OP.IDIPROC)
                 LEFT JOIN TSIUSU USU ON USU.CODUSU = ATV.CODEXEC
WHERE OP.IDIPROC = 485 ORDER BY DHINICIO


SELECT * FROM TPRLMP WHERE IDEFX = 951

--- MATERIAIS ALTERNATIVOS
SELECT DISTINCT (AL.CODPRODMPALT), ATVFX.IDEFX
                        , MP.CODVOL VOLUME
                        , MP.QTDMISTURA QUANTIDADE
                        , NVL(ITE.CONTROLE, 'AUSENTE') LOTE
                        , PA.QTDPRODUZIR * AL.QTDMISTURA PREVISTO
                        , INITCAP(PROMP.DESCRPROD) MP
                        , AL.CODPRODMP
                        , AL.CODPRODMPALT
                        , AL.QTDMISTURA
		   				, INITCAP(PROAL.DESCRPROD) AL
                    FROM TPRLMP MP 
                    INNER JOIN TPREFX ATVFX ON MP.IDEFX = ATVFX.IDEFX
                    INNER JOIN TPRIATV IATV ON IATV.IDEFX = ATVFX.IDEFX
                    INNER JOIN TPRIPA PA ON PA.IDIPROC = IATV.IDIPROC
                    INNER JOIN TPRMPA AL ON MP.CODPRODMP = AL.CODPRODMP
	          		INNER JOIN TGFPRO PROAL ON PROAL.CODPROD = AL.CODPRODMPALT
                    INNER JOIN TGFPRO PROPA ON (PROPA.CODPROD = MP.CODPRODPA AND PA.CODPRODPA = PROPA.CODPROD)
                    INNER JOIN TGFPRO PROMP ON PROMP.CODPROD = MP.CODPRODMP
                    LEFT JOIN TGFCAB CAB ON CAB.IDIPROC = PA.IDIPROC AND CAB.TIPMOV = 'F'
                    LEFT JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA AND ITE.USOPROD = 'M' AND PROMP.CODPROD = ITE.CODPROD
                    WHERE PA.IDIPROC = 485
                    ORDER BY INITCAP(PROMP.DESCRPROD)

SELECT * FROM tprlmp                    

--- composicoes materia prima
SELECT DISTINCT ATVFX.IDEFX
                        , INITCAP(PROMP.DESCRPROD) MP
                        , ATVFX.DESCRICAO ETAPA
                        , MP.CODVOL VOLUME
                        , MP.QTDMISTURA * 1000 QUANTIDADE
                         , CASE WHEN MP.CODVOL = 'TN' THEN MP.QTDMISTURA * 500 ELSE 0 END AS QUANTIDADE_500
                        , CASE WHEN MP.CODVOL = 'TN' THEN MP.QTDMISTURA * 800 ELSE 0 END AS QUANTIDADE_800
                        , NVL(ITE.CONTROLE, 'Ausente') LOTE
                        , PA.QTDPRODUZIR * MP.QTDMISTURA PREVISTO
    			,(SELECT SUM(MP.QTD)
                        	 FROM TPRAMP MP
                     	 WHERE NUAPO IN(SELECT (APO.NUAPO)
                      			 FROM TPRAPO APO
                      			 INNER JOIN TPRIATV ATV ON APO.IDIATV = ATV.IDIATV
                      			 WHERE ATV.IDIPROC=485
					 AND APO.SITUACAO = 'C'
                          	 ) AND MP.CODPRODMP = PROMP.CODPROD
                    		 GROUP BY CODPRODMP) AS REALIZADOTOT

                    FROM TPRLMP MP INNER JOIN TPREFX ATVFX ON MP.IDEFX = ATVFX.IDEFX
                    INNER JOIN TPRIATV IATV ON IATV.IDEFX = ATVFX.IDEFX
                    INNER JOIN TPRIPA PA ON PA.IDIPROC = IATV.IDIPROC
                    INNER JOIN TGFPRO PROPA ON (PROPA.CODPROD = MP.CODPRODPA AND PA.CODPRODPA = PROPA.CODPROD)
                    INNER JOIN TGFPRO PROMP ON PROMP.CODPROD = MP.CODPRODMP
                    LEFT JOIN TGFCAB CAB ON CAB.IDIPROC = PA.IDIPROC AND CAB.TIPMOV = 'F'
                    LEFT JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA AND ITE.USOPROD = 'M'  AND PROMP.CODPROD = ITE.CODPROD
                    WHERE PA.IDIPROC = 485
 		AND (PROMP.USOPROD = 'M' OR PROMP.USOPROD = 'V')
                    ORDER BY INITCAP(PROMP.DESCRPROD)                    
                    
                    
---- COMPOSICOES SUBPRODUTO
SELECT DISTINCT SP.CODPRODSP, ATVFX.IDEFX
                        , INITCAP(PROSP.DESCRPROD) SP
                        , ATVFX.DESCRICAO ETAPA
                        , SP.CODVOL VOLUME
                        , SP.QTDMISTURA QUANTIDADE

			 ,(SELECT CONTROLESP
                        	 FROM TPRASP SP
                     	 WHERE NUAPO IN(SELECT (APO.NUAPO)
                      			 FROM TPRAPO APO
                      			 INNER JOIN TPRIATV ATV ON APO.IDIATV = ATV.IDIATV
                      			 WHERE ATV.IDIPROC=485)) LOTE

                        , PA.QTDPRODUZIR * SP.QTDMISTURA PREVISTO

			,(SELECT SUM(SP.QTD)
                        	 FROM TPRASP SP
                     	 WHERE NUAPO IN(SELECT (APO.NUAPO)
                      			 FROM TPRAPO APO
                      			 INNER JOIN TPRIATV ATV ON APO.IDIATV = ATV.IDIATV
                      			 WHERE ATV.IDIPROC=485
                          	 ) AND SP.CODPRODSP = PROSP.CODPROD
                    		 GROUP BY CODPRODSP) AS REALIZADOTOT

                    FROM TPRLSP SP INNER JOIN TPREFX ATVFX ON SP.IDEFX = ATVFX.IDEFX
                    INNER JOIN TPRIATV IATV ON IATV.IDEFX = ATVFX.IDEFX
                    INNER JOIN TPRIPA PA ON PA.IDIPROC = IATV.IDIPROC
                    INNER JOIN TGFPRO PROPA ON (PROPA.CODPROD = SP.CODPRODPA AND PA.CODPRODPA = PROPA.CODPROD)
                    INNER JOIN TGFPRO PROSP ON PROSP.CODPROD = SP.CODPRODSP
                    LEFT JOIN TGFCAB CAB ON CAB.IDIPROC = PA.IDIPROC AND CAB.TIPMOV IN ('V','C')
                    LEFT JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA AND ITE.USOPROD = 'M' AND PROSP.CODPROD = ITE.CODPROD
                    WHERE PA.IDIPROC = 485
                    ORDER BY INITCAP(PROSP.DESCRPROD)                    

----- COMPOSICOES DE EMBALAGEM
SELECT DISTINCT ATVFX.IDEFX
                        , INITCAP(PROMP.DESCRPROD) MP
                        , ATVFX.DESCRICAO ETAPA
                        , MP.CODVOL VOLUME
                        , MP.QTDMISTURA QUANTIDADE
                        , NVL(ITE.CONTROLE, 'Ausente') LOTE
                        , PA.QTDPRODUZIR * MP.QTDMISTURA PREVISTO
    			,(SELECT SUM(MP.QTD)
                        	 FROM TPRAMP MP
                     	 WHERE NUAPO IN(SELECT (APO.NUAPO)
                      			 FROM TPRAPO APO
                      			 INNER JOIN TPRIATV ATV ON APO.IDIATV = ATV.IDIATV
                      			 WHERE ATV.IDIPROC=485
                          	 ) AND MP.CODPRODMP = PROMP.CODPROD
                    		 GROUP BY CODPRODMP) AS REALIZADOTOT

                    FROM TPRLMP MP INNER JOIN TPREFX ATVFX ON MP.IDEFX = ATVFX.IDEFX
                    INNER JOIN TPRIATV IATV ON IATV.IDEFX = ATVFX.IDEFX
                    INNER JOIN TPRIPA PA ON PA.IDIPROC = IATV.IDIPROC
                    INNER JOIN TGFPRO PROPA ON (PROPA.CODPROD = MP.CODPRODPA AND PA.CODPRODPA = PROPA.CODPROD)
                    INNER JOIN TGFPRO PROMP ON PROMP.CODPROD = MP.CODPRODMP
                    LEFT JOIN TGFCAB CAB ON CAB.IDIPROC = PA.IDIPROC AND CAB.TIPMOV = 'F'
                    LEFT JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA AND ITE.USOPROD = 'M' AND PROMP.CODPROD = ITE.CODPROD
                    WHERE PA.IDIPROC = 485
	          AND PROMP.USOPROD = 'E'
                    ORDER BY INITCAP(PROMP.DESCRPROD)

---- COMPOSICOES PRODUCAO - COMPOSICOES MATERIA PRIMA
SELECT DISTINCT ATVFX.IDEFX
                        , INITCAP(PROMP.DESCRPROD) MP
                        , ATVFX.DESCRICAO ETAPA
                        , MP.CODVOL VOLUME
                        , MP.QTDMISTURA * 1000 QUANTIDADE
                         , CASE WHEN MP.CODVOL = 'TN' THEN MP.QTDMISTURA * 500 ELSE 0 END AS QUANTIDADE_500
                        , CASE WHEN MP.CODVOL = 'TN' THEN MP.QTDMISTURA * 800 ELSE 0 END AS QUANTIDADE_800
                        , NVL(ITE.CONTROLE, 'Ausente') LOTE
                        , PA.QTDPRODUZIR * MP.QTDMISTURA PREVISTO
    			,(SELECT SUM(MP.QTD)
                        	 FROM TPRAMP MP
                     	 WHERE NUAPO IN(SELECT (APO.NUAPO)
                      			 FROM TPRAPO APO
                      			 INNER JOIN TPRIATV ATV ON APO.IDIATV = ATV.IDIATV
                      			 WHERE ATV.IDIPROC=485
					 AND APO.SITUACAO = 'C'
                          	 ) AND MP.CODPRODMP = PROMP.CODPROD
                    		 GROUP BY CODPRODMP) AS REALIZADOTOT

                    FROM TPRLMP MP INNER JOIN TPREFX ATVFX ON MP.IDEFX = ATVFX.IDEFX
                    INNER JOIN TPRIATV IATV ON IATV.IDEFX = ATVFX.IDEFX
                    INNER JOIN TPRIPA PA ON PA.IDIPROC = IATV.IDIPROC
                    INNER JOIN TGFPRO PROPA ON (PROPA.CODPROD = MP.CODPRODPA AND PA.CODPRODPA = PROPA.CODPROD)
                    INNER JOIN TGFPRO PROMP ON PROMP.CODPROD = MP.CODPRODMP
                    LEFT JOIN TGFCAB CAB ON CAB.IDIPROC = PA.IDIPROC AND CAB.TIPMOV = 'F'
                    LEFT JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA AND ITE.USOPROD = 'M'  AND PROMP.CODPROD = ITE.CODPROD
                    WHERE PA.IDIPROC = 485
 		AND (PROMP.USOPROD = 'M' OR PROMP.USOPROD = 'V')
                    ORDER BY INITCAP(PROMP.DESCRPROD)