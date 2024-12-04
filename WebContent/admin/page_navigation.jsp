<!-- Page navigaiton -->
<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
      <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    <c:forEach var="i" begin="1" end="${totalPages}">
      <li class="page-item ${i == currentPage ? 'active' : ''}">
        <a class="page-link" href="?page=${i}">${i}</a>
      </li>
    </c:forEach>
    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
      <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>