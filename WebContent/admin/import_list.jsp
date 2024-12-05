<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Import List - Legendary Games Administration</title>
    <jsp:include page="head.jsp"/>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="content">
    <h1 align="center">Import Management</h1>
    <!-- Add Notification -->
    <jsp:directive.include file="notification.jsp"/>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <!-- Add Search -->
        <input class="form-control" id="myInput" type="text" placeholder="Search..">

        <!-- Add Import Button -->
        <form method="GET" action="new_import">
            <button type="submit" class="btn-add">+ Add Import</button>
        </form>
    </div>

    <!-- Set Page -->
    <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
    <c:set var="itemsPerPage" value="10" />
    <c:set var="totalItems" value="${listImports != null ? listImports.size() : 0}" />
    <c:set var="totalPages" value="${(totalItems / itemsPerPage) + (totalItems % itemsPerPage > 0 ? 1 : 0)}" />
    <c:set var="startIndex" value="${(currentPage - 1) * itemsPerPage}" />
    <c:set var="endIndex" value="${startIndex + itemsPerPage > totalItems ? totalItems : startIndex + itemsPerPage}" />

    <!-- Table to display the import details -->
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>User ID</th>
            <th>User Name</th>
            <th>Import Date</th>
            <th>Total Price</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="imp" items="${listImports}">
            <tr>
                <td>${imp.user.userId}</td>
                <td>${imp.user.fullName}</td> <!-- Assuming `user.username` is available -->
                <td>${imp.importDate}</td>
                <td>${imp.sumPrice}</td>
                <td>
                    <a href="import?action=view&id=${imp.importId}" class="btn btn-info btn-sm">View</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <jsp:directive.include file="page_navigation.jsp"/>
    <jsp:directive.include file="footer.jsp"/>
</div>

<!-- Confirm Delete Script -->
<script>
    function confirmDelete(importId) {
        if (confirm('Are you sure you want to delete import ID: ' + importId + '?')) {
            window.location = 'delete_import?id=' + importId;
        }
    }

    $(document).ready(function () {
        $("#myInput").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#myTable tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>
</body>
</html>
