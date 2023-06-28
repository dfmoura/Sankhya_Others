<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"  isELIgnored ="false"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="en">
	<html>
		<head>
			<title>XML</title>			
			<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
			<link src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/css/bootstrap.min.js"></script>
			<link src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
			<style>	
			</style>
			<snk:load/>	
		</head>
		<body>
				<snk:query var="tgfnfeXML">
					SELECT NUNOTA,CHAVENFE,XML FROM TGFNFE WHERE NUNOTA = :P_NUNOTA
				</snk:query>	
			<div class="dashboard">
				<c:forEach items="${tgfnfeXML.rows}" var="row">
					<textarea>
						${row.XML}
					</textarea>
				</c:forEach>
			</div>				

		</body>
	</html>