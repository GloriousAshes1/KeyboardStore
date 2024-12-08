<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<title>Legendary Games Administration</title>
	<jsp:include page="head.jsp"/>
</head>
<body>
<jsp:directive.include file="header.jsp" />
<div class="content">
<div align="center">
	<hr width="60%" />
	<h2>Warehouser Dashboard</h2>
</div>
	<div align="center">
		<hr width="60%" />
		<h2 class="page-heading">Recent Sales:</h2>
		<table class="table table-hover table-striped caption-top">
			<thead class="table-primary">
			<tr>
				<th>Import Date</th>
				<th>Total Price</th>
			</tr>
			</thead>
			<c:forEach var="imp" items="${listMostRecentImport}" varStatus="status">
			<tbody id="myTable">
			<tr>
				<td>${imp.importDate}</td>
				<td>${imp.sumPrice}</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	<jsp:directive.include file="footer.jsp" />
</div>
</body>
</html>