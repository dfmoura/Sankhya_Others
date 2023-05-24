function mostrarLoadingFaturamento(){
    document.getElementById('FatLoading').style.display = 'inline-flex';
}

function ocultarLoadingFaturamento(){
    document.getElementById('FatLoading').style.display = 'none';
}

function mostrarTabelaFatAcum(){
    document.getElementById('fatBody').style.display = 'block';
}

function ocultarTabelaFatAcum(){
    document.getElementById('fatBody').style.display = 'none';
}

function getValor(dados, natureza, tipo, referencia){    
    if(referencia > dados.length){
        return 0;
    }else{
        if(natureza == 'LU' && tipo == 'M'){
            return Number(dados[referencia-1].M_LU_EAD);
        }

        if(natureza == 'LU' && tipo == 'R'){
            return Number(dados[referencia-1].R_LU_EAD);
        }

        if(natureza == 'MENSAL' && tipo == 'M'){
            return Number(dados[referencia-1].M_MENSAL);
        }

        if(natureza == 'MENSAL' && tipo == 'R'){
            return Number(dados[referencia-1].R_MENSAL);
        }

        if(natureza == 'SERV' && tipo == 'M'){
            return Number(dados[referencia-1].M_SERV);
        }

        if(natureza == 'SERV' && tipo == 'R'){
            return Number(dados[referencia-1].R_SERV);
        } 
    }
}

function escreveResultados(dados, natureza, tipo){
    var valorAcum = 0;

    for(var i = 1 ; i <= 13 ; i++){
        
        if(i < 13){
            var elementId = natureza+'.'+tipo+i;
            var element = document.getElementById(elementId);
            
            var valor = 0;

            valor = getValor(dados, natureza, tipo, i);
            valorAcum += valor;

            element.innerHTML = aplicaMascaraMonetaria(valor);
        }
        else if (i = 13){
            document.getElementById(natureza+'.'+tipo+'T').innerHTML = '<b>'+aplicaMascaraMonetaria(valorAcum)+'</b>'; 
        }
    }
}

function montaFaturamento(P_ANOFATUR){
    mostrarLoadingFaturamento();

    var query = SQL_FATURAMENTO;
    var arr=[{value:"", type:"IN"}]; //OBRIGATORIO PARA FUNCIONAR

    if(P_ANOFATUR != ""){
        query += " AND EXTRACT(YEAR FROM A.REFERENCIA) = ? ";
        arr.push({value: P_ANOFATUR, type:"I"});
    }

    query += GROUP_FATURAMENTO + ORDER_FATURAMENTO; 

    executeQuery(query,arr,function(value){
        var dados = JSON.parse(value);

        escreveResultados(dados, 'LU', 'M');
        escreveResultados(dados, 'LU', 'R');
        escreveResultados(dados, 'MENSAL', 'M');
        escreveResultados(dados, 'MENSAL', 'R');
        escreveResultados(dados, 'SERV', 'M');
        escreveResultados(dados, 'SERV', 'R');

        mostrarTabelaFatAcum();
        ocultarLoadingFaturamento();
    },function(value){
        alert(value);
    });
}