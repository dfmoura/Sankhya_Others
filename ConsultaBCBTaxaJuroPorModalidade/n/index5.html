<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styles.css">
    <meta name="viewport" content="width=width-device=", initial-scale="1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Taxa Média de Valores - Modalidade</title>
    <snk:load/>
		<style>
		
		@import url('https://fonts.googleapis.com/css2?family=Work+Sans:wght@200;400;600;700&display=swap');

* {
  margin: 0;
  padding: 0;  
}

:root {
  font-family: 'Work Sans', sans-serif;
  --cor-principal: #66cb66;
  --branco-principal: #000000;
  --cor-fundo: #FFFFFF;
  --cor-fundo-secundaria:#4D4D4D;;
}

body {
  background: var(--cor-fundo);
}

.cabecalho {
  width: 1200;
  padding: 1% 3% 1% 3%;
  position: relative; 
}

.cabecalho::before {
  content:"" ;
  position: absolute;
  z-index: -1;
  inset: 0;
  --background-image: URL(./assets/logo-vigor.png);
  background-repeat: no-repeat;
  background-position: center;
  background-size: 40%;
  opacity: .5;
}

.logo__sankhya {
  width: 10%;
  margin-bottom: 6rem;
}

.titulo {
  display: flex;
  flex-direction: column;
  justify-content: start;
  margin-bottom: 6rem;
}

.titulo__principal {
  color: var(--branco-principal);
  font-size: 3rem; 
}

.subtitulo {
  color: #BFC4C9;
  font-size: 1.5rem; 
}

.inputs {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.modalidade label {
  color: var(--branco-principal);
  font-weight: 700;
  margin-top: 2rem; 
}

select {
  width: 50%;
  font-family:'Work Sans', sans-serif;
  font-weight: 700;
  border-radius: 3px;
  background-color: #B5E6B5;
  border: none;
  color: #000;
  padding: 0.3%;
}

.botao__fonte {
  background-color: var(--cor-principal);
  width: 30%;
  text-align: center;
  padding: 0.3%;
  border: none;
  border-radius: 3px;
  font-weight: 700;
}

.botao__fonte a {
  text-decoration: none;
  color: var(--branco-principal);
}

.botao__fonte:hover {
  background-color: var(--branco-principal);
  transform: scale(1.1);
}

.botao__fonte a:hover {
  color: var(--cor-principal);
}

main {
  margin: 0 3%;
}

table {
  border-collapse: collapse;
}

tr {
  color: var(--branco-principal);
}

tr:nth-child(even) {
  background-color: #B5E6B5;
  color: #000;  
}

th {
  border: solid 1px var(--branco-principal);
  font-size: 14px;
  background-color: #B5E6B5;
  color: #000;
}

td {
  box-sizing: border-box;
  border: solid 1px var(--branco-principal);
  font-size: 10px;
  text-align: left;
  padding: 10px;  
}

footer {
  text-align: center;
  font-size: 10px;
  color: var(--branco-principal);
  margin-bottom: 1rem;; 
}

footer img {
  width: 150px;
  margin: 1rem 0 0.5rem;
}




		
		</style>
</head>
<body>
    <header class="cabecalho"> 
            <img class="logo__sankhya" src="./logo-branco.png" alt="logo sankhya">
            <section class="titulo">
	            <h1 class="titulo__principal">Taxa média de valores</h1>
                <h2 class="subtitulo">Operações de Crédito - Por Modalidade</h2>
            </section>  
            
            <div class="inputs">    
                <div class="modalidade"> 
                    <label for="modalidade">Modalidade:</label>
                    <select id="modalidade" onchange="filterData()">
                        <option value="">All</option>
                    </select>
                </div>  
                <div class="botao__fonte">
                    <a href="https://www.bcb.gov.br/estatisticas/txjuros" target="_blank">Informações de API - Banco Central - Fonte!</a>
                </div>
            </div>
        </header>
        <main>
            <table id="data-table">
            <thead>
                <tr>
                    <th>Início Período</th>
                    <th>Fim Período</th>
                    <th>Código Segmento</th>
                    <th>Segmento</th>
                    <th>Código Modalidade</th>
                    <th>Modalidade</th>
                    <th>Posição</th>
                    <th>Instituição Financeira</th>
                    <th>Taxa Juros Ao Mês</th>
                    <th>Taxa Juros Ao Ano</th>
                    <th>CNPJ8</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
        </div>
    </main>

    <script>
        // Fetch JSON data
        fetch('https://olinda.bcb.gov.br/olinda/servico/taxaJuros/versao/v2/odata/ConsultaUnificada?$top=1000&$format=json')
            .then(response => response.json())
            .then(data => {
                const modalidades = new Set();

                // Extract unique modalidades from JSON
                data.value.forEach(item => {
                    modalidades.add(item.Modalidade);
                });

                // Populate listbox with modalidades
                const modalidadeSelect = document.getElementById('modalidade');
                modalidades.forEach(modalidade => {
                    const option = document.createElement('option');
                    option.text = modalidade;
                    modalidadeSelect.add(option);
                });

                // Populate table with all data initially
                populateTable(data.value);
            })
            .catch(error => {
                console.log('Error:', error);
            });

        // Filter data based on selected modalidade
        function filterData() {
            const selectedModalidade = document.getElementById('modalidade').value;

            fetch('https://olinda.bcb.gov.br/olinda/servico/taxaJuros/versao/v2/odata/ConsultaUnificada?$top=1000&$format=json')
                .then(response => response.json())
                .then(data => {
                    const filteredData = data.value.filter(item => item.Modalidade === selectedModalidade);
                    populateTable(filteredData);
                })
                .catch(error => {
                    console.log('Error:', error);
                });
        }

        // Populate table with data
        function populateTable(data) {
            const tableBody = document.querySelector('#data-table tbody');
            tableBody.innerHTML = '';

            data.forEach(item => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${item.InicioPeriodo}</td>
                    <td>${item.FimPeriodo}</td>
                    <td>${item.codigoSegmento}</td>
                    <td>${item.Segmento}</td>
                    <td>${item.codigoModalidade}</td>
                    <td>${item.Modalidade}</td>
                    <td>${item.Posicao}</td>
                    <td>${item.InstituicaoFinanceira}</td>
                    <td>${item.TaxaJurosAoMes}</td>
                    <td>${item.TaxaJurosAoAno}</td>
                    <td>${item.cnpj8}</td>
                `;

                tableBody.appendChild(row);
            });
        }
    </script>
    <footer>
        <img src="./logo-vigor.png">
        <p>© Vigor Fertilizantes 2023 - Diogo Moura - JS / Gabriel Franco HTML e CSS.</p>
    </footer>
</body>
</html>
