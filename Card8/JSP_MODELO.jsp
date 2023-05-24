<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"  isELIgnored ="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<html>
	<head> 
		<snk:load/>

			<script>
				/*-------------------------------Metodos Nativos Dashboard------------------------*/
				//Metodo para execução de queries via JavaScript
				//executeQuery(query:String, parameters:Array, onSuccess:Function, onError:Function)

				//Metodo para abrir outras telas dentro do SankhyaW 
				//OBS: Ao abrir a tela de Parceiros (versão Flex), os dados do registro não são carregados, mas a mesma tela na versão HTML5 é aberta conforme esperado.
				//openApp(resourceID:String, params:Object)

				//Metodo para abrir outro nivel dentro do dashboard
				//openLevel(nivel:String, params:Object)

				//Metodo para atualizar componente detalhe
				//refreshDetails(componentID:String, params:Object)

				//Metodo para abrir paginas externas ao SankhyaW 
				//openPage(page:String, params:Object)

				//Exemplo de formato do argumento "params": {CODPARC: parseInt('${CODPARC}')}

				/*-------------------------------DHTESTE : Data/Hora-------------------------------*/
				//var arr = [{value:"${DHTESTE}", type:"D"}];
				//var query1 = "SELECT * FROM TGFPAR WHERE DTALTER >= ?";


				/*-------------------------------DTALTER : Data------------------------------------*/
				//var arr = [{value:"${DTALTER}", type:"D"}];
				//var query1 = "SELECT * FROM TGFPAR WHERE DTALTER >= ?";
				

				/*-------------------------------MULTSQLTESTE : multiList:Text---------------------*/
				//**quando nenhum item é selecionado, serão enviados todos os registros, então para utilizacao fixa na query, este parametro e obrigatorio
				//var arr = [{value:"${MULTSQLTESTE}", type:"IN"}];
				//var query1 = 'SELECT * FROM TGFPAR WHERE CODPARC IN (?)';
				//var query1 = 'SELECT * FROM TGFPAR WHERE CODPARC NOT IN (?)';

				/*-------------------------------PERTESTE: Periodo---------------------------------*/
				//var query1 = "SELECT * FROM TGFPAR WHERE DTALTER >= ? AND DTALTER <= ?";
				//var arr = [{value: "${PERTESTE.INI}", type:"D"}, {value: "${PERTESTE.FIN}", type:"D"}];


				/*-------------------------------CODPARC : Entidade/Tabela-------------------------*/
				//var arr = [{value:"${CODPARC}", type:"I"}];
				//var query1 = "SELECT * FROM TGFPAR WHERE CODPARC = ?";


				/*-------------------------------RAZAOSOCIAL : Texto-------------------------------*/
				//var arr = [{value:"${RAZAOSOCIAL}", type:"S"}];
				//var query1 = "SELECT * FROM TGFPAR WHERE RAZAOSOCIAL = ?";


				/*-------------------------------SINGSQLTESTE : singleList:Text--------------------*/
				//var arr = [{value:"${SINGSQLTESTE}", type:"I"}];
				//var query1 = "SELECT * FROM TGFPAR WHERE CODPARC = ?";
				

				/*-------------------EXEMPLO DE CONSTRUCAO DE GRADES COM QUERIES INDEPENDENTES E COM CONSTRUÇÃO DINAMICA-------------------*/

				var query1 = "SELECT TO_CHAR(DTALTER,'DD/MON/YYYY') AS DTALTER, CODPARC, NOMEPARC, RAZAOSOCIAL, TIPPESSOA FROM TGFPAR WHERE CODPARC IN (?) ";
				
				//multiList:Text
				var arr=[{value:"${MULTSQLTESTE}", type:"IN"}];
				
				//Data/Hora
				if("${DHTESTE}" != ""){
					query1 += " AND DTALTER >= ? ";
					arr.push({value:"${DHTESTE}", type:"D"});
				}
				
				//Data
				if("${DTALTER}" != ""){
					query1 += " AND DTALTER >= ? ";
					arr.push({value:"${DTALTER}", type:"D"});
				}
				
				//Periodo início
				if("${PERTESTE.INI}" != ""){
					query1 += " AND DTALTER >= ?  ";
					arr.push({value: "${PERTESTE.INI}", type:"D"});
				}

				//Periodo final
				if("${PERTESTE.FIN}" != ""){
					query1 += " AND DTALTER <= ? ";
					arr.push({value: "${PERTESTE.FIN}", type:"D"});
				}

				//Entidade/Tabela
				if("${CODPARC}" != ""){
					query1 += " AND CODPARC = ? ";
					arr.push({value:"${CODPARC}", type:"I"});
				}
				
				//Texto
				if("${RAZAOSOCIAL}" != ""){
					query1 += " AND RAZAOSOCIAL = ? ";
					arr.push({value:"${RAZAOSOCIAL}", type:"S"});
				}

				//singleList:Text (Recebe valor vazio quando não possui opções. Recebe valor 0 quando possui opções, mas nenhuma é selecionada)
				if("${SINGSQLTESTE}" != "0" && "${SINGSQLTESTE}" != ""){
					query1 += "  AND  CODPARC = ? ";
					arr.push({value:"${SINGSQLTESTE}", type:"I"});
				}

				query1 += " ORDER BY CODPARC ASC  ";

				//A função executeQuery retorna como resultado uma string em formato JSON, com a seguinte estrutura:
				//[{"COLUNA1":"VALOR","COLUNA2":"VALOR"},{"COLUNA1":"VALOR","COLUNA2":"VALOR"}]
				executeQuery(query1,arr,function(value){
					var dadosTabela = JSON.parse(value);
					if(dadosTabela.length > 0){
						var colunasTabela = Object.keys(dadosTabela[0]);
						var nroColunas = colunasTabela.length;
						var table = document.getElementById("tabelaParceiros");

						montaHeaderTable(table, colunasTabela);

						for (var k in dadosTabela) {
							var row = table.insertRow(-1);
							
							for (var j in dadosTabela[k]) {
								row.insertCell(-1).innerHTML = dadosTabela[k][j];
							}
						
							row.insertCell(-1).innerHTML = "<button type='button' onclick='mostraDetalhesContato("+dadosTabela[k]["CODPARC"]+")'>Contatos</button>";

						}
						document.getElementById("tabelaParceiros").style.visibility = "visible";
					}
				},function(value){
					alert(value);
				});

				function mostraDetalhesContato(codigoParceiro){
					var arr2 = [{value:codigoParceiro, type:"I"}];
					var query2 = "SELECT CODPARC, CODCONTATO, NOMECONTATO, CARGO, TELEFONE FROM TGFCTT WHERE CODPARC = ?";

					//A função executeQuery retorna como resultado uma string em formato JSON, com a seguinte estrutura:
					//[{"COLUNA1":"VALOR","COLUNA2":"VALOR"},{"COLUNA1":"VALOR","COLUNA2":"VALOR"}]
					executeQuery(query2,arr2,function(value){
						//limpa tabela
						document.getElementById("tabelaContatos").innerHTML="";

						var dadosTabela = JSON.parse(value);
						if(dadosTabela.length > 0){
							var colunasTabela = Object.keys(dadosTabela[0]);
							var table = document.getElementById("tabelaContatos");

							montaHeaderTable(table, colunasTabela);

							for (var k in dadosTabela) {
								var row = table.insertRow(-1);
								
								for (var j in dadosTabela[k]) {
									row.insertCell(-1).innerHTML = dadosTabela[k][j];
								}
							}

							document.getElementById("tabelaContatos").style.visibility = "visible";
						}
					},function(value){
						alert(value);
					});
				}

				function montaHeaderTable(table, columns){
					var header = table.createTHead();
					var rowHeader = header.insertRow(0);

					var qtdColunas = columns.length;

					for(var i = 0; i < qtdColunas; i++){
						var cell = rowHeader.insertCell(-1);
						cell.innerHTML = "<b>" + columns[i] + "</b>";
					}
				}
			</script> 
			<style>
				.tabelaParceiros {
					height: 70%;
					width: 100%;
					overflow:scroll;
				}

				.tabelaContatos {
					height: 30%;
					width: 100%;
					overflow:scroll;
				}

			</style>		
			
	</head>
	<body>
		<div style="height:650px;">
			<div class="tabelaParceiros">
				<table id="tabelaParceiros" border="1" style="visibility: hidden;"></table>
				</div>
				<br>
				<div class="tabelaContatos">
					<table id="tabelaContatos" border="1" style="visibility: hidden;"></table>
				</div>	
			</div>
	</body>
</html>
