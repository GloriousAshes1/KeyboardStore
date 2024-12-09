<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Sales Report</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<h1>Sales Report</h1>

<!-- Form to input Product ID, Start Date, End Date, and Action -->
<form action="show_chart" method="get">
    <label for="productId">Product ID:</label>
    <input type="text" name="productId" id="productId" />

    <label for="startDate">Start Date:</label>
    <input type="date" name="startDate" id="startDate" />

    <label for="endDate">End Date:</label>
    <input type="date" name="endDate" id="endDate" />

    <!-- Action to get specific product sales -->
    <button type="submit" name="action" value="specificProduct">View Specific Product Sales</button>

    <!-- Action to get all products sales -->
    <button type="submit" name="action" value="allProducts">View All Products Sales</button>
</form>

<!-- Chart container -->
<canvas id="salesChart" width="400" height="200"></canvas>

<!-- Only show chart if salesData is not empty -->
<c:if test="${not empty salesData}">
    <script>
        // Log the salesData to the browser console to inspect its structure
        console.log(${salesData});

        var salesData = ${salesData};
        var labels = [];
        var data = [];

        // Process sales data to extract labels (dates) and sales numbers
        for (var i = 0; i < salesData.length; i++) {
            var date = new Date(salesData[i][2]);  // Assuming the date is at index 2
            labels.push(date.toLocaleDateString());  // Format the date as a string
            data.push(salesData[i][3]);  // Assuming sales amount (subtotal) is at index 3
        }

        // Chart.js configuration
        var ctx = document.getElementById('salesChart').getContext('2d');
        var salesChart = new Chart(ctx, {
            type: 'line',  // Line chart for sales trends
            data: {
                labels: labels,  // Dates as labels
                datasets: [{
                    label: 'Sales Amount',  // Dataset label
                    data: data,  // Sales data
                    borderColor: 'rgba(75, 192, 192, 1)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    x: {
                        title: {
                            display: true,
                            text: 'Date'
                        }
                    },
                    y: {
                        title: {
                            display: true,
                            text: 'Sales Amount'
                        }
                    }
                }
            }
        });
    </script>
</c:if>

<!-- Show message if no sales data is available -->
<c:if test="${empty salesData}">
    <p>No sales data available for the selected date range.</p>
</c:if>

</body>
</html>
