--IDENTIFICADOR DE CODIGO

WITH CAM AS (
SELECT
	OPC.*
FROM
	TDDCAM CAM
JOIN TDDOPC OPC ON
	OPC.NUCAMPO = CAM.NUCAMPO
WHERE
	CAM.NOMETAB = 'TGFTOP'
	AND CAM.NOMECAMPO = 'ATUALEST'
ORDER BY
	OPC.ORDEM)
  SELECT
	DISTINCT
  	CAB.CODTIPOPER,
	TOP.DESCROPER,
	TOP.ATUALEST,
	CAM.OPCAO
FROM
	TGFITE ITE
INNER JOIN TGFCAB CAB ON
	ITE.NUNOTA = CAB.NUNOTA
INNER JOIN TGFTOP TOP ON
	CAB.CODTIPOPER = TOP.CODTIPOPER
INNER JOIN CAM ON
	TOP.ATUALEST = CAM.VALOR
WHERE
	TOP.ATUALEST IN ('B', 'R', 'E')
	AND ITE.ATUALESTOQUE IN (1,-1)
GROUP BY
	CAB.CODTIPOPER,
	TOP.DESCROPER,
	TOP.ATUALEST,
	CAM.OPCAO
ORDER BY
	1
