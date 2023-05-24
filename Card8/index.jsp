<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"  isELIgnored ="false"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
    <title>Web Page with JavaScript</title>
    <style>
        /* Add your CSS styles here */
    </style>
	
			<snk:load/>
	
</head>
<body>

	<i class="fa-light fa-corn"></i>
	
    <h1>Data from Table</h1>
    <table id="data-table">
        <thead>
            <tr>
                <th>Column 1</th>
                <th>Column 2</th>
                <th>Column 3</th>
            </tr>
        </thead>
        <tbody>
            <!-- Table rows will be added dynamically using JavaScript -->
        </tbody>
    </table>

    <script>
        // Convert Java code to JavaScript
        var url = "https://cepea.esalq.usp.br/br/widgetproduto.js.php?fonte=arial&tamanho=10&largura=400px&corfundo=dbd6b2&cortexto=333333&corlinha=ede7bf&id_indicador%5B%5D=77";

        // Send a GET request to the URL and retrieve the web page content
        fetch(url)
            .then(response => response.text())
            .then(data => {
                // Create a temporary element to parse the HTML content
                var tempElement = document.createElement('div');
                tempElement.innerHTML = data;

                // Find the table on the page (if it exists)
                var table = tempElement.querySelector('table');

                if (table) {
                    var tableBody = document.querySelector('#data-table tbody');

                    // Iterate over the rows of the table and extract the data from the third column
                    var rows = table.querySelectorAll('tr');

                    rows.forEach(row => {
                        var cells = row.querySelectorAll('td');
                        if (cells.length >= 3) {
                            var firstColumnData = cells[0].textContent;
                            var secondColumnData = cells[1].textContent;
                            var thirdColumnData = cells[2].textContent;

                            // Create a new row in the HTML table
                            var newRow = document.createElement('tr');
                            newRow.innerHTML = '<td>' + firstColumnData + '</td><td>' + secondColumnData + '</td><td>' + thirdColumnData + '</td>';

                            // Append the new row to the table body
                            tableBody.appendChild(newRow);
                        }
                    });
                } else {
                    console.log("No table found on the webpage.");
                }
            })
            .catch(error => console.error(error));
    </script>
</body>
</html>
