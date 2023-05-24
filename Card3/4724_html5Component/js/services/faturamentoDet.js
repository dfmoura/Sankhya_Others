function getValorDet(dados, ref, categoria, cr){
    var valor = 0;

    for(var i = 0 ; i < dados.length ; i++){
        if(Number(dados[i].REFERENCIA) == ref && dados[i].DESCRCENCUS == cr && dados[i].CATEGORIA == categoria){
            if(dados[i].VALOR == "" || dados[i].VALOR == undefined){
                valor += 0;
            }
            
            valor += Number(dados[i].VALOR);
        }
    }

    return Number(valor);
}

function getValorTotalReferenciaCrDet(dados, ref, categoria){
    var valor = 0;
    
    for(var i = 0 ; i < dados.length ; i++){
        if(Number(dados[i].REFERENCIA) == ref && dados[i].CATEGORIA == categoria){
            if(dados[i].VALOR == "" || dados[i].VALOR == undefined){
                valor += 0;
            }

            valor += Number(dados[i].VALOR);
        }
    }

    return Number(valor);
}

function getValorTotalReferenciaDet(dados, ref, categoria){
    var valor = 0;
    
    for(var i = 0 ; i < dados.length ; i++){
        if(Number(dados[i].REFERENCIA) == ref){
            if(dados[i].VALOR == "" || dados[i].VALOR == undefined){
                valor += 0;
            }

            valor += Number(dados[i].VALOR);
        }
    }

    return Number(valor);
}

function toggleCrFilhos(categoria){
    var elementos = document.getElementsByClassName(categoria);
    console.log(elementos);

    for(var i = 0 ; i < elementos.length ; i++){
        var classes = [];
        
        for(var j = 0 ; j < elementos[i].classList.length ; j++){
            classes.push(elementos[i].classList[j]);
        }

        if(classes.includes('ocultarLinha')){
            elementos[i].classList.remove('ocultarLinha');
        }else{
            elementos[i].classList.add('ocultarLinha');
        };
    }
}

function escreveTabelaFaturamentoDet(dados, crUnidPropria, crUnidTerceira, crUnidMatriz, P_ANOFATUR){
    var valorTotalCategoria = 0;
    var valorTotalFinal = 0;

    var html = '<table class="table-hover" border="1" style="white-space: nowrap">';
        html += '<tr><td colspan="14" style="text-align:center"><b>' + P_ANOFATUR + '</b></td></tr>';
        html += '<tr>'+
                    '<td></td>'+
                    '<td style="width: 7%"><b>Janeiro</b></td>'+
                    '<td style="width: 7%"><b>Fevereiro</b></td>'+
                    '<td style="width: 7%"><b>Marco</b></td>'+
                    '<td style="width: 7%"><b>Abril</b></td>'+
                    '<td style="width: 7%"><b>Maio</b></td>'+
                    '<td style="width: 7%"><b>Junho</b></td>'+
                    '<td style="width: 7%"><b>Julho</b></td>'+
                    '<td style="width: 7%"><b>Agosto</b></td>'+
                    '<td style="width: 7%"><b>Setembro</b></td>'+
                    '<td style="width: 7%"><b>Outubro</b></td>'+
                    '<td style="width: 7%"><b>Novembro</b></td>'+
                    '<td style="width: 7%"><b>Dezembro</b></td>'+
                    '<td style="width: 7%"><b>Total</b></td>'+
                '</tr>';

        /*---------------------------------------- cr unidade propria/filial ---------------------------------------------*/
        /* linha total - inicio */
        html += '<tr onclick="toggleCrFilhos(\'unid_prop_filhos\')" style="cursor: pointer;"><td style="text-align: left"><b>FILIAL</b></td>';
        for(var ref = 1 ; ref <= 12 ; ref ++){
            html += '<td style="text-align: right">';
            html += '<b>'+aplicaMascaraMonetaria(getValorTotalReferenciaCrDet(dados, ref, 'UNID_PROPRIA'))+'</b>';
            html += '</td>';

            valorTotalCategoria += getValorTotalReferenciaCrDet(dados, ref, 'UNID_PROPRIA');
        }
        html += '<td style="text-align: right"><b>'+aplicaMascaraMonetaria(valorTotalCategoria) +'</b></td>'
        html += '</tr>';
        valorTotalCategoria = 0;
        /* linha total - fim */

        /* linhas CR's filhos - inicio */
        for(var crPropria = 1 ; crPropria < crUnidPropria.length ; crPropria++){
            var valorAcum = 0;
            html += '<tr class="unid_prop_filhos ocultarLinha"><td style="text-align: left">'+crUnidPropria[crPropria]+'</td>';

            for(var ref = 1 ; ref <= 12 ; ref ++){
                html += '<td style="text-align: right">';
                html += aplicaMascaraMonetaria(getValorDet(dados, ref, 'UNID_PROPRIA', crUnidPropria[crPropria]));
                html += '</td>';

                valorAcum += getValorDet(dados, ref, 'UNID_PROPRIA', crUnidPropria[crPropria]);
            }
            html += '<td style="text-align: right"><b>'+ aplicaMascaraMonetaria(valorAcum) +'<b></td>';
            html += '</tr>';
        }
        /* linhas CR's filhos - fim */
        /*-------------------------------------- cr unidade propria/filial ---------------------------------------------*/

        /*--------------------------------------- cr unidade terceira/BP -----------------------------------------------*/
        /* linha total - inicio */
        html += '<tr onclick="toggleCrFilhos(\'unid_terceira_filhos\')" style="cursor: pointer;"><td style="text-align: left"><b>BP\'S TERCEIRO</b></td>';
        for(var ref = 1 ; ref <= 12 ; ref ++){
            html += '<td style="text-align: right">';
            html += '<b>'+aplicaMascaraMonetaria(getValorTotalReferenciaCrDet(dados, ref, 'UNID_TERCEIRA'))+'</b>';
            html += '</td>';

            valorTotalCategoria += getValorTotalReferenciaCrDet(dados, ref, 'UNID_TERCEIRA');
        }
        html += '<td style="text-align: right"><b>'+aplicaMascaraMonetaria(valorTotalCategoria) +'</b></td>'
        html += '</tr>';
        valorTotalCategoria = 0;
        /* linha total - fim */

        /* linhas CR's terceiro/BP - inicio*/
        for(var crTerceira = 1 ; crTerceira < crUnidTerceira.length ; crTerceira++){
            var valorAcum = 0;
            html += '<tr class="unid_terceira_filhos ocultarLinha"><td style="text-align: left">'+crUnidTerceira[crTerceira]+'</td>';

            for(var ref = 1 ; ref <= 12 ; ref ++){
                html += '<td style="text-align: right">';
                html += aplicaMascaraMonetaria(getValorDet(dados, ref, 'UNID_TERCEIRA', crUnidTerceira[crTerceira]));
                html += '</td>';

                valorAcum += getValorDet(dados, ref, 'UNID_TERCEIRA', crUnidTerceira[crTerceira]);
            }
            html += '<td style="text-align: right"><b>'+ aplicaMascaraMonetaria(valorAcum) +'</b></td>';
            html += '</tr>';
        }
        /* linhas CR's terceiro/BP - fim*/
        /*------------------------------------------- cr unidade matriz -----------------------------------------------*/
        /* linha total - inicio */
        html += '<tr onclick="toggleCrFilhos(\'matriz_filhos\')" style="cursor: pointer;"><td style="text-align: left"><b>CENTRAL</b></td>';
        for(var ref = 1 ; ref <= 12 ; ref ++){
            html += '<td style="text-align: right">';
            html += '<b>'+aplicaMascaraMonetaria(getValorTotalReferenciaCrDet(dados, ref, 'CENTRAL'))+'</b>';
            html += '</td>';

            valorTotalCategoria += getValorTotalReferenciaCrDet(dados, ref, 'CENTRAL');
        }
        html += '<td style="text-align: right"><b>'+aplicaMascaraMonetaria(valorTotalCategoria) +'</b></td>'
        html += '</tr>';
        valorTotalCategoria = 0;
        /* linha total - fim */

        /* linhas Matriz - inicio */
        for(var crMatriz = 1 ; crMatriz < crUnidMatriz.length ; crMatriz++){
            var valorAcum = 0;
            html += '<tr class="matriz_filhos ocultarLinha"><td style="text-align: left">'+crUnidMatriz[crMatriz]+'</td>';

            for(var ref = 1 ; ref <= 12 ; ref ++){
                html += '<td style="text-align: right">';
                html += aplicaMascaraMonetaria(getValorDet(dados, ref, 'CENTRAL', crUnidMatriz[crMatriz]));
                html += '</td>';

                valorAcum += getValorDet(dados, ref, 'CENTRAL', crUnidMatriz[crMatriz]);
            }
            html += '<td style="text-align: right"><b>'+ aplicaMascaraMonetaria(valorAcum) +'</b></td>';
            html += '</tr>';
        }
        /* linhas Matriz - fim */
        /*------------------------------------------- cr unidade matriz -----------------------------------------------*/
        /*----------------------------------------- totalizador da tabela ---------------------------------------------*/
         /* linha total - inicio */
         html += '<tr><td style="text-align: left"><b>TOTAL</b></td>';
         for(var ref = 1 ; ref <= 12 ; ref ++){
             html += '<td style="text-align: right">';
             html += '<b>'+aplicaMascaraMonetaria(getValorTotalReferenciaDet(dados, ref, 'CENTRAL'))+'</b>';
             html += '</td>';
 
             valorTotalFinal += getValorTotalReferenciaDet(dados, ref, 'CENTRAL');
         }
         html += '<td style="text-align: right"><b>'+aplicaMascaraMonetaria(valorTotalFinal) +'</b></td>'
         html += '</tr>';
         /* linha total - fim */
        /*----------------------------------------- totalizador da tabela ---------------------------------------------*/
    html += '</table>';
   
    document.getElementById('fatDetBody').innerHTML = html;
}

function montaFaturamentoDet(P_ANOFATUR){
    var query = SQL_FATURAMENTO_DET;
    var arr=[{value:"", type:"IN"}]; //OBRIGATORIO PARA FUNCIONAR

    if(P_ANOFATUR != ""){
        query += " AND EXTRACT(YEAR FROM FAT.DTFATUR) = ? ";
        arr.push({value: P_ANOFATUR, type:"I"});
    }

    query += GROUP_FATURAMENTO_DET + ORDER_FATURAMENTO_DET; 

    executeQuery(query,arr,function(value){
        var dados = JSON.parse(value);

        var crUnidPropria_aux = [], crUnidTerceira_aux = [], ctUnidMatriz_aux = [];
        

        for(var i = 0 ; i < dados.length ; i++){
            if(dados[i].CATEGORIA == 'UNID_PROPRIA'){
                crUnidPropria_aux.push(dados[i].DESCRCENCUS);
            }
            if(dados[i].CATEGORIA == 'UNID_TERCEIRA'){
                crUnidTerceira_aux.push(dados[i].DESCRCENCUS);
            }
            if(dados[i].CATEGORIA == 'CENTRAL'){
                ctUnidMatriz_aux.push(dados[i].DESCRCENCUS);
            }
        }

        /* remove elementos duplicados */
        var crUnidPropria = [...new Set(crUnidPropria_aux)];
        var crUnidTerceira = [...new Set(crUnidTerceira_aux)];
        var ctUnidMatriz = [... new Set(ctUnidMatriz_aux)];

        escreveTabelaFaturamentoDet(dados, crUnidPropria, crUnidTerceira, ctUnidMatriz, P_ANOFATUR);

    },function(value){
        alert(value);
    });
}