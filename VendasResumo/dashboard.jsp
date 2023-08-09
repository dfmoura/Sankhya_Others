<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Card Dashboard</title>
    <link rel="stylesheet" type="text/css" href="${BASE_FOLDER}styles.css">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/css/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <snk:load/>
</head>

<body>
<snk:query var="faturamento">
    SELECT DISTINCT
    to_char(cab.dtneg, 'YYYY-MM') AS ANO_MES,
    SUM(
    CASE
        WHEN CAB.CODTIPOPER IN (1200, 1201, 1215, 1216, 1217) THEN CAB.VLRNOTA * -1
        WHEN CAB.CODTIPOPER IN (1100, 1112, 1152, 1105, 1153) THEN CAB.VLRNOTA
    END
    ) VLRNOTA
    FROM TGFCAB CAB
    INNER JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA
    INNER JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD
    INNER JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
    WHERE
    CAB.CODTIPOPER IN (1100, 1112, 1152, 1200, 1201, 1215, 1216, 1217, 1105, 1153)
    AND CAB.STATUSNOTA = 'L'
    AND EXTRACT(YEAR FROM CAB.DTNEG) = EXTRACT(YEAR FROM SYSDATE)
    GROUP BY to_char(cab.dtneg, 'YYYY-MM')
    ORDER BY 1
</snk:query>

<table border="0.2">
    <tr>
        <th>Ano / Mês</th>
        <th>Faturamento</th>
    </tr>
    <c:forEach items="${faturamento.rows}" var="row">
        <tr>
            <td>${row.ANO_MES}</td>
			<td><fmt:formatNumber value="${row.VLRNOTA}" pattern="#,##0.00" /></td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
