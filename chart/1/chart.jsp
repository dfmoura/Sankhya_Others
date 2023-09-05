<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bar Chart Example</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

</head>
<body>
    <div class="container">
        <h1>Bar Chart Example</h1>
        <div class="chart">
            <%-- Generate dynamic data (you can replace this with your data) --%>
            <%
                int[] data = {30, 50, 70, 40, 60};
                String[] labels = {"Label 1", "Label 2", "Label 3", "Label 4", "Label 5"};
            %>
            <div class="bar-container">
                <%
                    for (int i = 0; i < data.length; i++) {
                        int height = data[i];
                        String label = labels[i];
                %>
                <div class="bar" style="height: <%= height %>%;"></div>
                <span class="bar-label"><%= label %></span>
                <%
                    }
                %>
            </div>
        </div>
    </div>

    <style>
                .chart {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
        }

        .bar-container {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-top: 20px;
        }

        .bar {
            width: 20px;
            background-color: #007bff;
            border-radius: 5px;
            transition: height 0.5s;
        }

        .bar-label {
            text-align: center;
            margin-top: 5px;
        }

    </style>

</body>
</html>
