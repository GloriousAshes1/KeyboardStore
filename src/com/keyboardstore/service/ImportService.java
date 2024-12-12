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
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
        listImports.sort((c1, c2) -> Integer.compare(c2.getImportId(), c1.getImportId()));

        request.setAttribute("listImports", listImports);

        if (message != null) {
            request.setAttribute("message", message);
        }

        String listPage = "import_list.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);
        dispatcher.forward(request, response);
    }

    // View details of a specific import, including the user who created it and the list of products
    public void viewImportDetail() throws ServletException, IOException {
        Integer importId = Integer.parseInt(request.getParameter("id"));

        Import imp = importDAO.get(importId);

        if (imp == null) {
            String errorMessage = "Could not find the import with ID: " + importId;
            request.setAttribute("message", errorMessage);
            listAllImports();
            return;
        }

        // Get the user and import details
        Users user = imp.getUser();
        Set<ImportDetail> importDetails = imp.getImportDetails();

        // Initialize total quantity and total price
        int totalQuantity = 0;
        float totalSumPrice = 0;

        // Iterate through import details to calculate total quantity and total price
        for (ImportDetail detail : importDetails) {
            totalQuantity += detail.getQuantity();
            totalSumPrice += detail.getQuantity() * detail.getImportPrice();
        }

        // Set attributes to be accessed in the JSP
        request.setAttribute("userId", user.getUserId());
        request.setAttribute("fullName", user.getFullName());
        request.setAttribute("importDetails", importDetails);
        request.setAttribute("totalQuantity", totalQuantity);  // Total quantity
        request.setAttribute("totalSumPrice", totalSumPrice);  // Total price

        // Forward to the detail page
        String detailPage = "import_detail.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(detailPage);
        dispatcher.forward(request, response);
    }


    // Show form to add new import
    public void showAddImportForm() throws ServletException, IOException {
        List<Product> listProduct = productDAO.listAllSortedByStock();
        request.setAttribute("listProduct", listProduct);

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        Users user = userDAO.get(userId);
        String fullName = user.getFullName();
        System.out.println("FullName: " + fullName); // Kiểm tra giá trị fullName
        request.setAttribute("fullName", fullName);
        String addPage = "import_form.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(addPage);
        dispatcher.forward(request, response);
    }


    public void addImport() throws ServletException, IOException {
        try {
            // Bắt đầu giao dịch
            importDAO.beginTransaction();

            // Tạo đối tượng Import
            Import imp = new Import();
            imp.setImportDate(new java.util.Date());

            // Lấy thông tin user từ session
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");

            Users user = userDAO.get(userId);
            if (user == null) {
                throw new ServletException("User not found.");
            }
            imp.setUser(user);

            // Lấy thông tin sản phẩm từ form
            String[] productIds = request.getParameterValues("productId");
            String[] quantities = request.getParameterValues("quantity");
            String[] importPrices = request.getParameterValues("importPrice");

            for (String s : Arrays.asList("Product IDs: " + productIds, "Quantities: " + quantities, "Import Prices: " + importPrices)) {
                System.out.println(s);
            }

            // Kiểm tra dữ liệu đầu vào
            if (productIds == null || quantities == null || importPrices == null ||
                    productIds.length != quantities.length || quantities.length != importPrices.length) {
                throw new ServletException("Product information is invalid.");
            }

            // Tạo danh sách ImportDetail
            Set<ImportDetail> importDetails = new HashSet<>();
            float totalSumPrice = 0;

            for (int i = 0; i < productIds.length; i++) {
                Integer productId = Integer.parseInt(productIds[i]);
                int quantity = Integer.parseInt(quantities[i]);
                float importPrice = Float.parseFloat(importPrices[i]);

                if (productId <= 0 || quantity <= 0 || importPrice <= 0) {
                    throw new ServletException("Invalid product data.");
                }

                Product product = productDAO.get(productId);
                if (product == null) {
                    throw new ServletException("Product not found.");
                }

                // Cập nhật thông tin sản phẩm
                float oldImportPrice = product.getImportPrice();
                int currentStock = product.getStock();
                float newImportPrice = (oldImportPrice * currentStock + importPrice * quantity) / (currentStock + quantity);
                product.setImportPrice(newImportPrice);
                product.setStock(currentStock + quantity);

                productDAO.update(product);

                // Tạo ImportDetail
                ImportDetail importDetail = new ImportDetail();
                importDetail.setProduct(product);
                importDetail.setQuantity(quantity);
                importDetail.setImportPrice(importPrice);
                importDetail.setImportEntity(imp);

                importDetails.add(importDetail);
                totalSumPrice += quantity * importPrice;
            }

            // Gắn các ImportDetail vào Import
            imp.setImportDetails(importDetails);
            imp.setSumPrice(totalSumPrice);

            // Lưu Import
            importDAO.create(imp);

            // Commit giao dịch
            importDAO.commit();

            // Thông báo thành công
            String message = "The new import has been successfully added!";
            listAllImports(message);

        } catch (Exception e) {
            // Rollback giao dịch nếu có lỗi
            importDAO.rollback();
            throw new ServletException("Failed to add import.", e);
        }
    }



    // Delete an import
    public void deleteImport() throws ServletException, IOException {
        Integer importId = Integer.parseInt(request.getParameter("id"));
        Import imp = importDAO.get(importId);

        if(imp!=null) {
            importDAO.delete(importId);

            String message = "Import ID " + importId + " has been deleted.";
            listAllImports(message);
        }
        else {
            String message = "Could not find order with ID " + importId
                    + ", or it might have been deleted by another admin.";
            listAllImports(message);
        }
    }

    // Helper method to read import information from request
    private Import readImportInfo() throws ServletException {
        // Create the Import object and set the basic details
        Import imp = new Import();
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
                importDetail.setProduct(product);
                importDetail.setQuantity(quantity);
                importDetail.setImportPrice(importPrice);
                importDetail.setImportEntity(imp); // Associate with the Import

                imp.getImportDetails().add(importDetail);  // Assuming Import has a List<ImportDetail> getImportDetails()

            } catch (NumberFormatException e) {
                throw new ServletException("Invalid format for product details (e.g., quantity or importPrice).", e);
            } catch (Exception e) {
                throw new ServletException("Error processing product with ID: " + productIds[i], e);
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
