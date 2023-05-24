/*Este arquivo contem as consultas bases para fornecer dados ao indicador

Observações:
    1 - Os parametros devem ser acrescentado a query conforme necessidade do indicador
    2 - As clausulas que vem depois do WHERE também devem ser acrescentadas depois (GROUP BY, ORDER BY, HAVING)
*/ 
var SQL_FATURAMENTO =
    "SELECT TO_CHAR(A.REFERENCIA,'DD/MM/YYYY') AS DATA, "+
    "       TO_CHAR(A.REFERENCIA,'MM') AS REFERENCIA, "+
    "       SUM(A.R_LU_EAD) AS R_LU_EAD, "+
    "       SUM(A.R_MENSAL) AS R_MENSAL, "+
    "       SUM(A.R_SERV) AS R_SERV, "+
    "       SUM(A.M_LU_EAD) AS M_LU_EAD, "+
    "       SUM(A.M_MENSAL) AS M_MENSAL, "+
    "       SUM(A.M_SERV) AS M_SERV "+
    "  FROM ( "+
    "        SELECT FAT.DTFATUR AS REFERENCIA, "+
    "               SUM(CASE WHEN TRUNC(FAT.CODNAT, -2) IN (110100, 110300, 110600, 110700, 110800, 110900) THEN FAT.VALOR ELSE 0 END) AS R_LU_EAD, "+
    "               SUM(CASE WHEN TRUNC(FAT.CODNAT, -2) IN (110200) THEN FAT.VALOR ELSE 0 END) AS R_MENSAL, "+
    "               SUM(CASE WHEN TRUNC(FAT.CODNAT, -2) IN (110400, 110500) THEN FAT.VALOR ELSE 0 END) AS R_SERV, "+
    "               0 AS M_LU_EAD, "+
    "               0 AS M_MENSAL, "+
    "               0 AS M_SERV "+
    "          FROM CND_FATURAMENTO FAT "+
    "         WHERE 1=1 "+
    "           AND (FAT.CODEMP = 10 OR FAT.CODEMP <> 10 AND FAT.NROUNICOBP = 24 OR FAT.CODEMP <> 10 AND FAT.STATUS NOT IN ('R','P','O')) "+
    "         GROUP BY FAT.DTFATUR "+
    "  "+
    "   UNION ALL "+
    "  "+
    "  SELECT POC.REFERENCIA, "+
    "         0 AS R_LU_EAD, "+
    "         0 AS R_MENSAL, "+
    "         0 AS R_SER, "+
    "         SUM(CASE WHEN POC.CODCENCUS = 10001000 AND PLA.CTACTB IN ('3.1.1.01.00001','3.1.1.01.00005','3.1.1.01.00003','3.1.1.01.00010','3.1.1.01.00006','3.1.1.01.00008','3.1.1.01.00009') "+
    "                  THEN NVL(POC.REC_BRUT_MC, 0) "+
    "                  ELSE 0 "+
    "             END) AS M_LU_EAD, "+
    "         SUM(CASE WHEN POC.CODCENCUS = 10001000 AND PLA.CTACTB IN ('3.1.1.01.00002') "+
    "                  THEN NVL(POC.REC_BRUT_MC, 0) "+
    "                  ELSE 0 "+
    "             END) AS M_MENSAL, "+
    "         SUM(CASE WHEN (POC.CODCENCUS = 10001000 OR POC.NROUNICOBP <> 24) AND PLA.CTACTB IN ('3.1.1.01.00007','3.1.1.01.00004') "+
    "                  THEN NVL(POC.REC_BRUT_MC, 0) "+
    "                  ELSE 0 "+
    "             END)  AS M_SERV "+
    "    FROM CND_POC1 POC "+
    "         RIGHT JOIN TCBPLA PLA ON PLA.CTACTB = POC.CTACTB "+
    "   WHERE 1=1 "+
    "     AND POC.TIPO = 'MD' "+
    "   GROUP BY POC.REFERENCIA "+
    "   ) A"+
    " WHERE 1=1 "
;

var GROUP_FATURAMENTO =
    " GROUP BY TO_CHAR(A.REFERENCIA,'DD/MM/YYYY'), "+
    "          TO_CHAR(A.REFERENCIA,'MM') "
;

var ORDER_FATURAMENTO =
    " ORDER BY REFERENCIA ";


var SQL_FATURAMENTO_DET = 
    "SELECT TO_CHAR(FAT.DTFATUR,'DD/MM/YYYY') AS DATA, "+
    "       TO_CHAR(FAT.DTFATUR,'MM') AS REFERENCIA, "+
    "       FAT.DTFATUR AS ORDEM, "+
    "       CUS.DESCRCENCUS, "+
    "       CASE WHEN UNI.STATUS = 'E' THEN 'UNID_PROPRIA' "+
    "            WHEN UNI.STATUS IN ('R','P') THEN 'UNID_TERCEIRA' "+
    "            WHEN UNI.STATUS = 'O' AND UNI.NROUNICO = 24 THEN 'CENTRAL' "+
    "       END AS CATEGORIA, "+
    "       SUM(FAT.VALOR) AS VALOR "+
    "  FROM CND_FATURAMENTO FAT "+
    "       INNER JOIN TSICUS CUS ON CUS.CODCENCUS = FAT.CODCENCUS "+
    "       INNER JOIN AD_UNIDADESBPS UNI ON UNI.NROUNICO = FAT.NROUNICOBP "+
    " WHERE 1=1 "+
    "   AND (FAT.CODEMP = 10 OR FAT.CODEMP <> 10 AND FAT.NROUNICOBP = 24 OR FAT.CODEMP <> 10 AND FAT.STATUS NOT IN ('R','P','O')) "+
    "   AND TRUNC(FAT.CODNAT, -2) IN (110100, 110200, 110300, 110400, 110500, 110600, 110700, 110800, 110900) ";

var GROUP_FATURAMENTO_DET = 
    "GROUP BY TO_CHAR(FAT.DTFATUR,'DD/MM/YYYY'), "+
    "         TO_CHAR(FAT.DTFATUR,'MM'), "+
    "         FAT.DTFATUR, "+
    "         CUS.DESCRCENCUS, "+
    "         CASE WHEN UNI.STATUS = 'E' THEN 'UNID_PROPRIA' "+
    "              WHEN UNI.STATUS IN ('R','P') THEN 'UNID_TERCEIRA' "+
    "              WHEN UNI.STATUS = 'O' AND UNI.NROUNICO = 24 THEN 'CENTRAL' "+
    "         END ";

var ORDER_FATURAMENTO_DET =
    " ORDER BY FAT.DTFATUR, REFERENCIA, CUS.DESCRCENCUS ";