<!-- Toastr Notifications -->
<c:if test="${message != null}">
  <script>
    $(document).ready(function() {
      toastr.options = {
        closeButton: true,
        debug: false,
        newestOnTop: true,
        progressBar: true,
        positionClass: "toast-top-right",
        preventDuplicates: true,
        showDuration: "300",
        hideDuration: "1000",
        timeOut: "5000",
        extendedTimeOut: "1000",
        showEasing: "swing",
        hideEasing: "linear",
        showMethod: "fadeIn",
        hideMethod: "fadeOut"
      };

      const messageType = "${messageType}";
      const message = "${message}";

      if (messageType === "success") toastr.success(message);
      else if (messageType === "error") toastr.error(message);
      else if (messageType === "warning") toastr.warning(message);
      else if (messageType === "info") toastr.info(message);
    });
  </script>
</c:if>

