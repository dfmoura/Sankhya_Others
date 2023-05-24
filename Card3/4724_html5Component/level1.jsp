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
		<script src="${BASE_FOLDER}/js/services/faturamento.js"></script>

		<script>
			function carregarDashboard(P_ANOFATUR){
				montaFaturamento(P_ANOFATUR);
			}

		</script>
	</head>

	<body onload='carregarDashboard("${P_ANOFATUR}")'>
		<br><br>
		<div id='conteudo'>
			<div id='faturamento'>
				<div class="card text-center">
					<div id="fatHeader" class="card-header">
						<table style="width: 100%">
							<tr>
								<td style="width: 10%"></td>
								<td style="width: 80%"><b>Faturamento Geral</b></td>
								<td style="width: 10%;">
									<div id="FatLoading" class="spinner-border" role="status" align="right">
										<span class="sr-only">Loading...</span>
									</div>
								</td>
							</tr>
						</table>
					</div>
					<div id="fatBody" class="card-body">
						<table class="table-hover" border="1" style="white-space: nowrap">
							<tr>
								<td colspan="2"></td>
								<td style="width: 6%;"><b>Jan/${P_ANOFATUR}</b></td>
								<td style="width: 6%;"><b>Fev/${P_ANOFATUR}</b></td>
								<td style="width: 6%;"><b>Mar/${P_ANOFATUR}</b></td>
								<td style="width: 6%;"><b>Abr/${P_ANOFATUR}</b></td>
								<td style="width: 6%;"><b>Mai/${P_ANOFATUR}</b></td>
								<td style="width: 6%;"><b>Jun/${P_ANOFATUR}</b></td>
								<td style="width: 6%;"><b>Jul/${P_ANOFATUR}</b></td>
								<td style="width: 6%;"><b>Ago/${P_ANOFATUR}</b></td>
								<td style="width: 6%;"><b>Set/${P_ANOFATUR}</b></td>
								<td style="width: 6%;"><b>Out/${P_ANOFATUR}</b></td>
								<td style="width: 6%;"><b>Nov/${P_ANOFATUR}</b></td>
								<td style="width: 6%;"><b>Dez/${P_ANOFATUR}</b></td>
								<td style="width: 8%;"><b>Total</b></td>
							</tr>
							<tr>
								<td rowspan="2"><b>LU/EAD</b></td>
								<td>Meta:</td>
								<td id="LU.M1"></td>
								<td id="LU.M2"></td>
								<td id="LU.M3"></td>
								<td id="LU.M4"></td>
								<td id="LU.M5"></td>
								<td id="LU.M6"></td>
								<td id="LU.M7"></td>
								<td id="LU.M8"></td>
								<td id="LU.M9"></td>
								<td id="LU.M10"></td>
								<td id="LU.M11"></td>
								<td id="LU.M12"></td>
								<td id="LU.MT"></td>
							</tr>
							<tr>
								<td>Realizado:</td>
								<td id="LU.R1"></td>
								<td id="LU.R2"></td>
								<td id="LU.R3"></td>
								<td id="LU.R4"></td>
								<td id="LU.R5"></td>
								<td id="LU.R6"></td>
								<td id="LU.R7"></td>
								<td id="LU.R8"></td>
								<td id="LU.R9"></td>
								<td id="LU.R10"></td>
								<td id="LU.R11"></td>
								<td id="LU.R12"></td>
								<td id="LU.RT"></td>
							</tr>
							<tr>
								<td rowspan="2"><b>Mensalidade</b></td>
								<td>Meta:</td>
								<td id="MENSAL.M1"></td>
								<td id="MENSAL.M2"></td>
								<td id="MENSAL.M3"></td>
								<td id="MENSAL.M4"></td>
								<td id="MENSAL.M5"></td>
								<td id="MENSAL.M6"></td>
								<td id="MENSAL.M7"></td>
								<td id="MENSAL.M8"></td>
								<td id="MENSAL.M9"></td>
								<td id="MENSAL.M10"></td>
								<td id="MENSAL.M11"></td>
								<td id="MENSAL.M12"></td>
								<td id="MENSAL.MT"></td>
							</tr>
							<tr>
								<td>Realizado:</td>
								<td id="MENSAL.R1"></td>
								<td id="MENSAL.R2"></td>
								<td id="MENSAL.R3"></td>
								<td id="MENSAL.R4"></td>
								<td id="MENSAL.R5"></td>
								<td id="MENSAL.R6"></td>
								<td id="MENSAL.R7"></td>
								<td id="MENSAL.R8"></td>
								<td id="MENSAL.R9"></td>
								<td id="MENSAL.R10"></td>
								<td id="MENSAL.R11"></td>
								<td id="MENSAL.R12"></td>
								<td id="MENSAL.RT"></td>
							</tr>
							<tr>
								<td rowspan="2"><b>Serviços</b></td>
								<td>Meta:</td>
								<td id="SERV.M1"></td>
								<td id="SERV.M2"></td>
								<td id="SERV.M3"></td>
								<td id="SERV.M4"></td>
								<td id="SERV.M5"></td>
								<td id="SERV.M6"></td>
								<td id="SERV.M7"></td>
								<td id="SERV.M8"></td>
								<td id="SERV.M9"></td>
								<td id="SERV.M10"></td>
								<td id="SERV.M11"></td>
								<td id="SERV.M12"></td>
								<td id="SERV.MT"></td>
							</tr>
							<tr>
								<td>Realizado</td>
								<td id="SERV.R1"></td>
								<td id="SERV.R2"></td>
								<td id="SERV.R3"></td>
								<td id="SERV.R4"></td>
								<td id="SERV.R5"></td>
								<td id="SERV.R6"></td>
								<td id="SERV.R7"></td>
								<td id="SERV.R8"></td>
								<td id="SERV.R9"></td>
								<td id="SERV.R10"></td>
								<td id="SERV.R11"></td>
								<td id="SERV.R12"></td>
								<td id="SERV.RT"></td>
							</tr>
						</table>
					</div>
					<div class="card-footer text-muted" >
						<a onclick="chamarLevel('lvl_cau8no')" href="#">Clique aqui para visão de unidade</a>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
