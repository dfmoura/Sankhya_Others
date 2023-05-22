<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"  isELIgnored ="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>

<!DOCTYPE html>
<html lang="en">
	<html>
		<head>				
			<title>Card Dashboard</title>
			<link rel="stylesheet" type="text/css" href="${BASE_FOLDER}styles.css">
			<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
			<link src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.js"></script>
			<link src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
			<snk:load/>	
		</head>
		<body>
			<snk:query var="parceiros">
				SELECT RAZAOSOCIAL AS NOME_PARCEIRO FROM TGFPAR  WHERE ROWNUM = 1
			</snk:query>			
			<div class="dashboard">			
				<c:forEach items="${parceiros.rows}" var="row">
					<div class="card">
						<h2>Card 1</h2>
						<c:out value="${row.NOME_PARCEIRO}" />
					</div>
				</c:forEach>
				<div class="card">
					<h2>Card 2</h2>
				<p>Dados no cartão 2</p>
				</div>
				<div class="card">
					<h2>Card 3</h2>
					<p>Dados no cartão 3</p>
				</div>
				<div class="card">
					<h2>Card 4</h2>
					<p>Dados no cartão 4</p>
				</div>
			</div>
		</body>
	</html>