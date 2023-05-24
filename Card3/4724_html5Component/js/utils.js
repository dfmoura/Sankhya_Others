function aplicaMascaraMonetaria(valor){
    if(valor == "" || valor == undefined){
        return 0;
    }
    
    return valor.toLocaleString('pt-br', {minimumFractionDigits: 2});
}

function sleep(milliseconds) {
    /* função criada para pausar um tempo informalado em MS durante o processo */
    var start = new Date().getTime();
    for (var i = 0; i < 1e7; i++) {
      if ((new Date().getTime() - start) > milliseconds){
        break;
      }
    }
}

function chamarLevel(levelId){
    var params = [];

    openLevel(levelId, params);
}

function toogleElement(element){
    var elementBody = element+'Body';

    var visivel = document.getElementById(elementBody).style.display;

    if(visivel == 'none'){
        document.getElementById(elementBody).style.display = 'block'; 
    }else if(visivel == 'block'){
        document.getElementById(elementBody).style.display = 'none';
    }
}

function getValorFaturadoVendidoReferencia(dados, ref_venda, ref_fatur){
    /* função criada para buscar o valor das vendas por referencias de venda e de faturamento
       ou seja, considera apenas as vendas que foram faturadas*/
    var valor = 0;
    
    for(var i = 0 ; i < dados.length ; i++){
        if(dados[i].REF_VENDA == ref_venda && dados[i].REF_FATUR == ref_fatur){
            return Number(dados[i].VALOR);
        }
    }
    return Number(valor);
}

function getValorFaturadoReferencia(dados, referencia){
    /* função criada para buscar todo o valor de faturamento na referência, independente da data de venda */
    var valor = 0;
    for(var i = 0 ; i < dados.length ; i++){
        if(dados[i].REF_FATUR == referencia){
            valor += Number(dados[i].VALOR);
        }
    }
    return Number(valor);
}

function getValorVendidoReferencia(dados, referencia){
    var valor = 0;

    for(var i = 0 ; i < dados.length ; i++){
        if(Number(dados[i].REF_VENDA) == referencia){
            return Number(dados[i].VALOR);
        }
    }
    return valor;
}

function f_divisao(a, b){
    var valor = 0;
    
    if(isNaN(a) || isNaN(b)){
        return Number(valor);
    }

    if(a == "" || b == ""){
        return Number(valor);
    }

    valor = a/b;

    return Number(valor);

}