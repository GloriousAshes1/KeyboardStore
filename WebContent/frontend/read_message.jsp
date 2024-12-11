<%@ page import="java.io.BufferedReader, java.io.FileReader, java.util.HashMap, java.util.Map" %>

<%
  Map<String, String> errorMessages = new HashMap<>();
  try {
    BufferedReader br = new BufferedReader(new FileReader(config.getServletContext().getRealPath("/frontend/error.csv")));
    String line;
    br.readLine(); // Skip the first line
    while ((line = br.readLine()) != null) {
      String[] parts = line.split(",");
      errorMessages.put(parts[0].trim(), parts[1].trim());
    }
    br.close();
  } catch (Exception e) {
    System.err.println("Error reading file: " + e.getMessage());
  }
  application.setAttribute("errorMessages", errorMessages);
%>

<%!
  class ErrorMessageUtil {
    public String getErrorMessage(String code, ServletContext application) {
      Map<String, String> errorMessages = (Map<String, String>) application.getAttribute("errorMessages");
      return errorMessages.get(code);
    }
  }
%>