,


--PONTO DE EQUILIBRIO

--REC OPER LIQ
(

((SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (508,714) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (508,714) THEN -1*LAN.VLRLANC END))+
(SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (534,539,544,551) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (534,539,544,551) THEN -1*LAN.VLRLANC END)))+

--CPV
(SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (551) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (551) THEN -1*LAN.VLRLANC END)) -

--CUSTO FIXO MEDIO - (ULTIMOS 3 MESES)
(CASE WHEN TO_CHAR(LAN.DTMOV,'MM-YYYY') = TO_CHAR(SYSDATE,'MM-YYYY') 
THEN 
--CUSTO FIXO PARCIAL
(((LAG(
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END),1) OVER (ORDER BY TO_CHAR(LAN.DTMOV,'YYYY') ASC, TO_CHAR(LAN.DTMOV,'MM') ASC)*-1)+
(LAG(
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END),2) OVER (ORDER BY TO_CHAR(LAN.DTMOV,'YYYY') ASC, TO_CHAR(LAN.DTMOV,'MM') ASC)*-1)+
(LAG(
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END),3) OVER (ORDER BY TO_CHAR(LAN.DTMOV,'YYYY') ASC, TO_CHAR(LAN.DTMOV,'MM') ASC)*-1))/3*-1) 
ELSE
--CUSTO FIXO FECHADO
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END)
END)


) AS PONTO_EQUI,


((((SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (508,714) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (508,714) THEN -1*LAN.VLRLANC END))+
(SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (534,539,544,551) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (534,539,544,551) THEN -1*LAN.VLRLANC END)))+
(SUM(CASE WHEN LAN.TIPLANC='R' AND PLA.CODCTACTB IN (551) THEN 1*LAN.VLRLANC WHEN LAN.TIPLANC='D'AND PLA.CODCTACTB IN (551) THEN -1*LAN.VLRLANC END))) /


--CUSTO FIXO MEDIO - (ULTIMOS 3 MESES)
(CASE WHEN TO_CHAR(LAN.DTMOV,'MM-YYYY') = TO_CHAR(SYSDATE,'MM-YYYY') 
THEN 
--CUSTO FIXO PARCIAL
(((LAG(
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END),1) OVER (ORDER BY TO_CHAR(LAN.DTMOV,'YYYY') ASC, TO_CHAR(LAN.DTMOV,'MM') ASC)*-1)+
(LAG(
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END),2) OVER (ORDER BY TO_CHAR(LAN.DTMOV,'YYYY') ASC, TO_CHAR(LAN.DTMOV,'MM') ASC)*-1)+
(LAG(
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END),3) OVER (ORDER BY TO_CHAR(LAN.DTMOV,'YYYY') ASC, TO_CHAR(LAN.DTMOV,'MM') ASC)*-1))/3*-1) 
ELSE
--CUSTO FIXO FECHADO
SUM(CASE 
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='R' THEN 1*LAN.VLRLANC
WHEN (PLA.CODCTACTB NOT IN (458, 508, 714, 522, 534, 536, 537, 539, 541, 544, 545, 546, 551,599, 601, 603, 715, 716, 718, 721,757,758,759))
AND LAN.TIPLANC='D' THEN -1*LAN.VLRLANC 
END)
END)


*-1*100) PERC_PE

