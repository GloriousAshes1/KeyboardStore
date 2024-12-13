<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sales Report</title>
    <jsp:include page="head.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</head>
<body>
<jsp:directive.include file="header.jsp"/>
<div class="content" align="center">
    <h1 align="center">Sales Report</h1>

    <!-- Form to input Product ID, Start Date, End Date, and Action -->
    <form action="show_chart" method="get">
        <label for="productId">Product ID:</label>
        <input type="text" name="productId" id="productId" value="${productId != null ? productId : ''}" />

        <label for="startDate">Start Date:</label>
        <input type="text" name="startDate" id="startDate" value="${startDate != null ? startDate : ''}" />

        <label for="endDate">End Date:</label>
        <input type="text" name="endDate" id="endDate" value="${endDate != null ? endDate : ''}" />

        <br><br>
        <button type="submit" name="view">View</button>
        <button type="submit" name="export" value="true">Export to Excel</button>
    </form>

    <script>
        flatpickr("#startDate", {
            dateFormat: "d/m/Y"
        });

        flatpickr("#endDate", {
            dateFormat: "d/m/Y"
        });
    </script>
    <!-- Chart container -->
    <canvas id="salesChart" width="400" height="200"></canvas>

    <!-- Only show chart if salesData is not empty -->
    <c:if test="${not empty salesData}">
        <script>
            // Convert the salesData map to JavaScript object
            var salesData = {};
            <c:forEach var="entry" items="${salesData}">
            var date = "${entry.key}";
            salesData[date] = {};

            <c:forEach var="productEntry" items="${entry.value}">
            var productName = "${productEntry.key}";
            var salesAmount = ${productEntry.value};
            salesData[date][productName] = salesAmount;
            </c:forEach>
            </c:forEach>

            console.log("Sales Data: ", salesData); // Debugging

            // Extract labels (dates)
            var labels = Object.keys(salesData);

            // Prepare datasets for each product
            var datasets = [];
            var productColors = {};  // To store colors for products
            var colorIndex = 0;

            // Color generator function
            function generateColor() {
                var letters = '0123456789ABCDEF';
                var color = '#';
                for (var i = 0; i < 6; i++) {
                    color += letters[Math.floor(Math.random() * 16)];
                }
                return color;
            }

            // Iterate through products and dates to create datasets
            for (var date in salesData) {
                var productsOnDate = salesData[date];

                // Loop through products for this date
                for (var product in productsOnDate) {
                    // Check if this product is already in the datasets array
                    var dataset = datasets.find(d => d.label === product);

                    // If not found, create a new dataset for this product
                    if (!dataset) {
                        // Use the color generator to create unique colors
                        var color = generateColor();  // Generate a new color for the product

                        dataset = {
                            label: product,
                            data: new Array(labels.length).fill(0),  // Initialize array with zeros for all dates
                            backgroundColor: color,
                            borderColor: color,
                            borderWidth: 1
                        };
                        datasets.push(dataset);
                    }

                    // Set sales data for the current date
                    var dateIndex = labels.indexOf(date);
                    dataset.data[dateIndex] = productsOnDate[product];
                }
            }

            // Chart.js configuration for stacked bar chart
            var ctx = document.getElementById('salesChart').getContext('2d');
            var salesChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,  // Dates as labels
                    datasets: datasets  // Multiple datasets for different products
                },
                options: {
                    scales: {
                        x: {
                            title: {
                                display: true,
                                text: 'Date'
                            },
                            stacked: true  // Stack the products
                        },
                        y: {
                            title: {
                                display: true,
                                text: 'Sales Amount'
                            },
                            stacked: true  // Stack the sales amounts
                        }
                    }
                }
            });
        </script>
    </c:if>

    <!-- Print salesData in JSP -->
    <c:if test="${not empty salesData}">
        <h2>Sales Data:</h2>
        <table class="table table-hover">
            <thead class="table-primary">
            <tr>
                <th>Date</th>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Profit</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="row" items="${salesDataExcel}">
                <tr>
                    <td>${row[1]}</td> <!-- Product ID -->
                    <td>${row[2]}</td> <!-- Product Name -->
                    <td>${row[3]}</td> <!-- Quantity Sold -->
                    <td>${row[4]}</td> <!-- Profit -->
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty salesData}">
        <p>No sales data available for the selected date range.</p>
    </c:if>
</div>
</body>
</html>
