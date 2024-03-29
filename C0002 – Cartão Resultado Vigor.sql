   SELECT DISTINCT
        TO_CHAR(LAN.DTMOV, 'YYYY') ANO,
        SUM(CASE WHEN LAN.TIPLANC = 'R' THEN 1 * LAN.VLRLANC WHEN LAN.TIPLANC = 'D' THEN -1 * LAN.VLRLANC END) LUCRO_LIQUIDO
    FROM 
        TCBLAN LAN
    INNER JOIN 
        TCBPLA PLA ON LAN.CODCTACTB = PLA.CODCTACTB
    WHERE 
        LPAD(PLA.CTACTB, 1) IN (3, 5)
        AND PLA.ANALITICA = 'S'
        AND LAN.CODEMP = 60
       AND TO_CHAR(LAN.DTMOV, 'MM') < TO_CHAR(SYSDATE, 'MM')
    GROUP BY
        TO_CHAR(LAN.DTMOV, 'YYYY')




SELECT DISTINCT
TO_CHAR(LAN.DTMOV,'YYYY') ANO,
TO_CHAR(LAN.DTMOV,'MM') MES,
TO_CHAR(LAN.DTMOV,'MM-YYYY') EXERCICIO,
LAG(
(TO_CHAR(LAN.DTMOV,'MM-YYYY'))
) OVER (ORDER BY TO_CHAR(LAN.DTMOV,'YYYY') ASC, TO_CHAR(LAN.DTMOV,'MM') ASC) AS EXERCICIO2,
SUM(CASE WHEN LAN.TIPLANC='R' THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D' THEN -1*LAN.VLRLANC END) LUCRO_LIQUIDO,
((SUM(CASE WHEN LAN.TIPLANC='R' THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D' THEN -1*LAN.VLRLANC END))
/
(SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (508,714) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (508,714) THEN -1*LAN.VLRLANC END)))*100 PART_PERC,
SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (508,714) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (508,714) THEN -1*LAN.VLRLANC END) FAT_BRUTO,
LAG(
(SUM(CASE WHEN LAN.TIPLANC='R' THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D' THEN -1*LAN.VLRLANC END))
) OVER (ORDER BY TO_CHAR(LAN.DTMOV,'YYYY') ASC, TO_CHAR(LAN.DTMOV,'MM') ASC) AS LUCRO_LIQUIDO_ANTERIOR
FROM TCBLAN LAN
INNER JOIN TCBPLA PLA ON LAN.CODCTACTB = PLA.CODCTACTB
WHERE 
LPAD(PLA.CTACTB,1) IN (3,5)
AND PLA.ANALITICA = 'S'
AND LAN.CODEMP = 60
GROUP BY
TO_CHAR(LAN.DTMOV,'YYYY'),
TO_CHAR(LAN.DTMOV,'MM'),
TO_CHAR(LAN.DTMOV,'MM-YYYY')
ORDER BY
1 DESC,2 DESC
FETCH FIRST 1 ROWS ONLY


   
   
   
   SELECT DISTINCT
        TO_CHAR(LAN.DTMOV, 'YYYY') ANO,
        SUM(CASE WHEN LAN.TIPLANC = 'R' THEN 1 * LAN.VLRLANC WHEN LAN.TIPLANC = 'D' THEN -1 * LAN.VLRLANC END) LUCRO_LIQUIDO
    FROM 
        TCBLAN LAN
    INNER JOIN 
        TCBPLA PLA ON LAN.CODCTACTB = PLA.CODCTACTB
    WHERE 
        LPAD(PLA.CTACTB, 1) IN (3, 5)
        AND PLA.ANALITICA = 'S'
        AND LAN.CODEMP = 60
       AND TO_CHAR(LAN.DTMOV, 'YYYY') = TO_CHAR(SYSDATE, 'YYYY')
    GROUP BY
        TO_CHAR(LAN.DTMOV, 'YYYY')
      
        
        
        
        
 
