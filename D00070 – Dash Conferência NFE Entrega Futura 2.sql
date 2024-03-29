

WITH ITE AS (
    SELECT NUNOTA, SUM(QTDNEG) QTDNEG1, SUM(VLRTOT) VLRTOT
    FROM TGFITE
    GROUP BY NUNOTA
)
SELECT DISTINCT
    CAB.NUNOTA AS NUNOTAORIG,
    1 AS NUNOTA1,
    CAB.CODTIPOPER,
    TOP.DESCROPER,
    CAB.NUMNOTA,
    CAB.CODPARC,
    PAR.RAZAOSOCIAL,
    CAB.DTNEG,
    CAB.DTMOV,
    ITE.QTDNEG1,
    ITE.VLRTOT,
    CAB.VLRNOTA,
    CAB.VLRFRETE,
    CAB.BASEICMS,
    CAB.VLRICMS
FROM TGFCAB CAB
INNER JOIN TGFTOP TOP ON CAB.CODTIPOPER = TOP.CODTIPOPER
INNER JOIN ITE ON CAB.NUNOTA = ITE.NUNOTA
INNER JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
WHERE CAB.CODTIPOPER = 1111
ORDER BY 1,2
AND ((CAB.DTNEG >= $P{P_DTNEG1} AND CAB.DTNEG <= $P{P_DTNEG2})  OR ($P{P_DTNEG1} IS NULL OR $P{P_DTNEG2} IS NULL))
AND (CAB.CODPARC = $P{P_PARCEIRO}  OR $P{P_PARCEIRO} IS NULL)
AND (CAB.NUNOTA = $P{P_NUNOTA} OR $P{P_NUNOTA} IS NULL)
AND (CAB.NUMNOTA = $P{P_NUMNOTA} OR $P{P_NUMNOTA} IS NULL)



WITH TES AS (
    SELECT DISTINCT NUNOTAORIG,NUNOTA
    FROM TGFVAR
    GROUP BY NUNOTAORIG,NUNOTA
)
, ITE AS (
    SELECT NUNOTA, SUM(QTDNEG) QTDNEG1, SUM(VLRTOT) VLRTOT
    FROM TGFITE
    GROUP BY NUNOTA
)
SELECT DISTINCT
    TES.NUNOTAORIG AS NUNOTAORIG,
    CAB.NUNOTA AS NUNOTA1,
    CAB.CODTIPOPER,
    TOP.DESCROPER,
    CAB.NUMNOTA,
    CAB.CODPARC,
    PAR.RAZAOSOCIAL,
    CAB.DTNEG,
    CAB.DTMOV,
    CASE WHEN CAB.CODTIPOPER = 1112 THEN ITE.QTDNEG1 ELSE 0 END QTDNEG1,
    CASE WHEN CAB.CODTIPOPER = 1112 THEN ITE.VLRTOT ELSE 0 END VLRTOT,
    CASE WHEN CAB.CODTIPOPER = 1112 THEN CAB.VLRNOTA ELSE 0 END VLRNOTA,
    CASE WHEN CAB.CODTIPOPER = 1112 THEN CAB.VLRFRETE ELSE 0 END VLRFRETE,
    CAB.BASEICMS,
    CAB.VLRICMS
FROM TGFCAB CAB
INNER JOIN TES ON CAB.NUNOTA = TES.NUNOTA
INNER JOIN TGFTOP TOP ON CAB.CODTIPOPER = TOP.CODTIPOPER
INNER JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
INNER JOIN ITE ON CAB.NUNOTA = ITE.NUNOTA
WHERE CAB.CODTIPOPER IN (1112)
ORDER BY 1,2

AND ((CAB.DTNEG >= $P{P_DTNEG1} AND CAB.DTNEG <= $P{P_DTNEG2})  OR ($P{P_DTNEG1} IS NULL OR $P{P_DTNEG2} IS NULL))
AND (CAB.CODPARC = $P{P_PARCEIRO}  OR $P{P_PARCEIRO} IS NULL)
AND (TES.NUNOTAORIG = $P{P_NUNOTA} OR $P{P_NUNOTA} IS NULL)
AND (CAB.NUMNOTA = $P{P_NUMNOTA} OR $P{P_NUMNOTA} IS NULL)

AND ((CAB.DTNEG >= $P{P_DTNEG1} AND CAB.DTNEG <= $P{P_DTNEG2})  OR ($P{P_DTNEG1} IS NULL OR $P{P_DTNEG2} IS NULL))
AND (CAB.CODPARC = $P{P_PARCEIRO}  OR $P{P_PARCEIRO} IS NULL)
AND (CAB.NUNOTA = $P{P_NUNOTA} OR $P{P_NUNOTA} IS NULL)
AND (CAB.NUMNOTA = $P{P_NUMNOTA} OR $P{P_NUMNOTA} IS NULL)


WITH ITE AS (
    SELECT NUNOTA, SUM(QTDNEG) QTDNEG1, SUM(VLRTOT) VLRTOT
    FROM TGFITE
    GROUP BY NUNOTA
),
TES AS (
    SELECT DISTINCT NUNOTAORIG,NUNOTA
    FROM TGFVAR
    GROUP BY NUNOTAORIG,NUNOTA
)
SELECT DISTINCT
    CAB.NUNOTA AS NUNOTAORIG,
    1 AS NUNOTA1,
    CAB.CODTIPOPER,
    TOP.DESCROPER,
    CAB.NUMNOTA,
    CAB.CODPARC,
    PAR.RAZAOSOCIAL,
    CAB.DTNEG,
    CAB.DTMOV,
    ITE.QTDNEG1,
    ITE.VLRTOT,
    CAB.VLRNOTA,
    CAB.VLRFRETE,
    CAB.BASEICMS,
    CAB.VLRICMS
FROM TGFCAB CAB
INNER JOIN TGFTOP TOP ON CAB.CODTIPOPER = TOP.CODTIPOPER
INNER JOIN ITE ON CAB.NUNOTA = ITE.NUNOTA
INNER JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
WHERE CAB.CODTIPOPER = 1111

UNION ALL

SELECT DISTINCT
    TES.NUNOTAORIG AS NUNOTAORIG,
    CAB.NUNOTA AS NUNOTA1,
    CAB.CODTIPOPER,
    TOP.DESCROPER,
    CAB.NUMNOTA,
    CAB.CODPARC,
    PAR.RAZAOSOCIAL,
    CAB.DTNEG,
    CAB.DTMOV,
    CASE WHEN CAB.CODTIPOPER = 1112 THEN ITE.QTDNEG1 ELSE 0 END QTDNEG1,
    CASE WHEN CAB.CODTIPOPER = 1112 THEN ITE.VLRTOT ELSE 0 END VLRTOT,
    CASE WHEN CAB.CODTIPOPER = 1112 THEN CAB.VLRNOTA ELSE 0 END VLRNOTA,
    CASE WHEN CAB.CODTIPOPER = 1112 THEN CAB.VLRFRETE ELSE 0 END VLRFRETE,
    CAB.BASEICMS,
    CAB.VLRICMS
FROM TGFCAB CAB
INNER JOIN TES ON CAB.NUNOTA = TES.NUNOTA
INNER JOIN TGFTOP TOP ON CAB.CODTIPOPER = TOP.CODTIPOPER
INNER JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
INNER JOIN ITE ON CAB.NUNOTA = ITE.NUNOTA
WHERE CAB.CODTIPOPER IN (1112)
ORDER BY 1,2

AND ((CAB.DTNEG >= $P{P_DTNEG1} AND CAB.DTNEG <= $P{P_DTNEG2})  OR ($P{P_DTNEG1} IS NULL OR $P{P_DTNEG2} IS NULL))
AND (CAB.CODPARC = $P{P_PARCEIRO}  OR $P{P_PARCEIRO} IS NULL)
AND (TES.NUNOTAORIG = $P{P_NUNOTA} OR $P{P_NUNOTA} IS NULL)
AND (CAB.NUMNOTA = $P{P_NUMNOTA} OR $P{P_NUMNOTA} IS NULL)