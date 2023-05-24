<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"  isELIgnored ="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<html>
	<head> 
		<snk:load/>
		<meta charset="UTF-8">

		<!-- bootstrap CSS -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
		<!-- bootstrap JS-->
		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
		
		<!-- CSS pesonalizados-->
		<link rel="stylesheet" type="text/css" href="${BASE_FOLDER}/css/mainCSS.css">

		<!-- JS personalizados-->
		<script src="${BASE_FOLDER}/js/querys.js"></script>
		<script src="${BASE_FOLDER}/js/utils.js"></script>
		<script src="${BASE_FOLDER}/js/services/faturamentoDet.js"></script>

		<script>
			function carregarDashboard(P_ANOFATUR){
				montaFaturamentoDet(P_ANOFATUR);
			}

		</script>
	</head>

	<body onload='carregarDashboard("${P_ANOFATUR}")'>
		<br><br>
		<div id='conteudo'>
			<div id="faturamentoDet">
				<div class="card text-center">
					<div id="fatDetHeader" class="card-header">
						<table style="width: 100%">
							<tr>
								<td style="width: 10%"></td>
								<td style="width: 80%"><b>Faturamento Por Unidade</b></td>
								<td style="width: 10%;"></td>
							</tr>
						</table>
					</div>
					<div id="fatDetBody" class="card-body">

					</div>
					<div class="card-footer text-muted" >
						<a onclick="chamarLevel('lvl_e48gfn')" href="#">Ver detalhamento de notas faturadas</a>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
