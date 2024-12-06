package com.keyboardstore.service;

import com.keyboardstore.dao.ImportDAO;
import com.keyboardstore.dao.ProductDAO;
import com.keyboardstore.dao.UserDAO;
import com.keyboardstore.entity.Import;
import com.keyboardstore.entity.ImportDetail;
import com.keyboardstore.entity.Users;
import com.keyboardstore.entity.Product;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class ImportService {

    private ImportDAO importDAO;
    private ProductDAO productDAO;
    private UserDAO userDAO;
    private HttpServletRequest request;
    private HttpServletResponse response;

    public ImportService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        this.importDAO = new ImportDAO();
        this.productDAO = new ProductDAO();
        this.userDAO = new UserDAO();
    }

    public void showStock() throws ServletException, IOException {
        List<Product> listProducts = productDAO.listAllSortedByStock();

        request.setAttribute("listProducts", listProducts);

        String stockPage = "show_stock.jsp";  // JSP page to display product stock
        RequestDispatcher dispatcher = request.getRequestDispatcher(stockPage);
        dispatcher.forward(request, response);
    }

    // List all imports
    public void listAllImports() throws ServletException, IOException {
        listAllImports(null);
    }

    public void listAllImports(String message) throws ServletException, IOException {
        List<Import> listImports = importDAO.listAll();

        request.setAttribute("listImports", listImports);

        if (message != null) {
            request.setAttribute("message", message);
        }

        String listPage = "import_list.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);
        dispatcher.forward(request, response);
    }

    // View details of a specific import
    public void viewImportDetail() throws ServletException, IOException {
        Integer importId = Integer.parseInt(request.getParameter("id"));

        Import imp = importDAO.get(importId);
        request.setAttribute("import", imp);

        String detailPage = "import_detail.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(detailPage);
        dispatcher.forward(request, response);
    }

    // Show form to add new import
    public void showAddImportForm() throws ServletException, IOException {
        List<Product> listProduct = productDAO.listAllSortedByStock();
        request.setAttribute("listProduct", listProduct);
        String addPage = "import_form.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(addPage);
        dispatcher.forward(request, response);
    }

    // Add a new import
    public void addImport() throws ServletException, IOException {
        Import imp = readImportInfo();

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        Users user = userDAO.get(userId);
        System.out.println("User from session: " + user);
        imp.setUser(user);

        // Get product details from the form
        Integer productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        float importPrice = Float.parseFloat(request.getParameter("importPrice"));

        // Get the sum price from the form
        float sumPrice = 0;
        try {
            sumPrice = Float.parseFloat(request.getParameter("sumPrice"));
            if (sumPrice < 0) {
                throw new NumberFormatException("Sum price cannot be negative.");
            }
        } catch (NumberFormatException e) {
            throw new ServletException("Invalid sum price format. Please check the sum price input.");
        }

        // If sumPrice is still invalid, handle it
        if (sumPrice <= 0) {
            throw new ServletException("Invalid sum price. It cannot be zero or negative.");
        }

        Product product = productDAO.get(productId);

        // Create the import detail
        ImportDetail importDetail = new ImportDetail();
        imp.getImportDetails().add(importDetail); // Add the detail to the import

        // Set the sum price for the import
        imp.setSumPrice(sumPrice);

        // Save the import in the database
        importDAO.create(imp);

        String message = "New import has been added successfully!";
        listAllImports(message);
    }
    // Delete an import
    public void deleteImport() throws ServletException, IOException {
        Integer importId = Integer.parseInt(request.getParameter("id"));
        importDAO.delete(importId);

        String message = "Import ID " + importId + " has been deleted.";
        listAllImports(message);
    }

    // Helper method to read import information from request
    private Import readImportInfo() throws ServletException {
        // Retrieve and validate sumPrice
        float sumPrice = 0;
        try {
            sumPrice = Float.parseFloat(request.getParameter("sumPrice"));
        } catch (NumberFormatException e) {
            throw new ServletException("Invalid sum price format.");
        }

        // Create the Import object and set the basic details
        Import imp = new Import();
        imp.setSumPrice(sumPrice);
        imp.setImportDate(new java.util.Date());  // Use the current date as import date

        // Optionally, set the current user for the import
        Users user = (Users) request.getSession().getAttribute("user");
        if (user != null) {
            imp.setUser(user);  // Associate the current user with the import
        }

        // Retrieve product details from the request
        String[] productIds = request.getParameterValues("productId");
        String[] quantities = request.getParameterValues("quantity");
        String[] importPrices = request.getParameterValues("importPrice");

        // Check if all necessary fields are provided (productId, quantity, importPrice)
        if (productIds == null || quantities == null || importPrices == null ||
                productIds.length != quantities.length || quantities.length != importPrices.length) {
            throw new ServletException("Missing or invalid product details.");
        }

        // Loop through the provided product details and create ImportDetail objects
        for (int i = 0; i < productIds.length; i++) {
            try {
                // Parse product data
                int productId = Integer.parseInt(productIds[i]);
                Product product = productDAO.get(productId);  // Assuming you have a productDAO to retrieve products

                int quantity = Integer.parseInt(quantities[i]);
                float importPrice = Float.parseFloat(importPrices[i]);

                // Create the ImportDetail object and add it to the Import object
                ImportDetail importDetail = new ImportDetail();
                imp.getImportDetails().add(importDetail);  // Assuming Import has a List<ImportDetail> getImportDetails()

            } catch (NumberFormatException e) {
                throw new ServletException("Invalid format for product details (e.g., quantity or importPrice).");
            } catch (Exception e) {
                throw new ServletException("Error processing product with ID: " + productIds[i]);
            }
        }

        return imp;
    }


    // Calculate total imports sum
    public void totalImports() throws ServletException, IOException {
        Double total = importDAO.totalImports();
        request.setAttribute("totalImports", total);

        String totalPage = "frontend/total_imports.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(totalPage);
        dispatcher.forward(request, response);
    }
}
