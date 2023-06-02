<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"  isELIgnored ="false"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<html lang="en">
	<html>
		<head>
			<title>Card Dashboard</title>
			
			<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
			<link src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/css/bootstrap.min.js"></script>
			<link src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
			
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
				  padding: 10px;
				  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
				}

					body {
					  background-image: url("a2023.png");
					  background-repeat: no-repeat;
					  background-size: cover;
					}

				h2 {
				  margin-top: 0;
				  font-size: 60px;
				}

				p {
				  margin-bottom: 0;
				  font-size: 40px;
				}

			</style>
			<snk:load/>	

		</head>

		<body>
				<snk:query var="tgfnfeXML">
					SELECT XML FROM TGFNFE WHERE NUNOTA = :P_NUNOTA
				</snk:query>	
		
		
			<div class="dashboard">
				<c:forEach items="${tgfnfeXML.rows}" var="row">
					<div class="card">
						<h2>XML Dados</h2>
						<p><c:out value="${row.XML}" /></p>
						${row.XML}
					</div>
					</c:forEach>


			</div>
		</body>
	</html>