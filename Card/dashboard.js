

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">	
	page import="java.util.*"
	taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"
	taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld"
	<html>
		<head>
			<title>Card Dashboard</title>
			<link rel="stylesheet" type="text/css" href="${BASE_FOLDER}/css/parceiroCSS.css">
			<snk:load/> <!-- essa tag deve ficar nesta posição -->
				<style>
					.dashboard {
					display: flex;
					justify-content: space-around;
					align-items: center;
					height: 100vh;
					}
					.card {
					background-color: #f1f1f1;
					border-radius: 5px;
					padding: 20px;
					box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
					}
					h2 {
					margin-top: 0;
					}
					p {
					margin-bottom: 0;
					}
				</style>
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
						<c:out value="${row.NOME_PARCEIRO}" /> "
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